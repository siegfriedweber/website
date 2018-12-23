module Language
    ( Language(..)
    , getDisplayLanguage
    , languageCode
    ) where

import Prelude
import Control.Monad.Except (runExcept)
import Data.Array (catMaybes, fromFoldable, head)
import Data.Either (Either, either, fromRight)
import Data.Foldable (fold)
import Data.Maybe (Maybe(Just, Nothing), fromMaybe)
import Data.String (take)
import Data.String.Regex (Regex, regex, test)
import Data.String.Regex.Flags (noFlags)
import Data.Traversable (traverse)
import Effect (Effect)
import Foreign (Foreign, readArray, readString)
import Partial.Unsafe (unsafePartial)

data Language = De | En

defaultLanguage :: Language
defaultLanguage = En

languageCode :: Language -> String
languageCode De = "de"
languageCode En = "en"

getDisplayLanguage :: Effect Language
getDisplayLanguage = do
    languages <- readLanguages
    language <- readLanguage
    userLanguage <- readUserLanguage
    pure $ selectSupportedLanguage $ languages <> fromFoldable language <> fromFoldable userLanguage
  where
    selectSupportedLanguage :: Array String -> Language
    selectSupportedLanguage = map (extractLanguageCode >=> toSupportedLanguage)
                          >>> catMaybes
                          >>> head
                          >>> fromMaybe defaultLanguage

    toSupportedLanguage :: String -> Maybe Language
    toSupportedLanguage "de" = Just De
    toSupportedLanguage "en" = Just En
    toSupportedLanguage _    = Nothing

    extractLanguageCode :: String -> Maybe String
    extractLanguageCode s | test twoLetterCodeRegex s = Just $ take 2 s
                          | otherwise                 = Nothing

    twoLetterCodeRegex :: Regex
    twoLetterCodeRegex = unsafePartial $ fromRight $
        regex "^[a-z][a-z](?:\\-\\w+)*$" noFlags

readLanguages :: Effect (Array String)
readLanguages = readForeignStringArray <$> navigatorLanguages

foreign import navigatorLanguages :: Effect Foreign

readLanguage :: Effect (Maybe String)
readLanguage = readForeignString <$> navigatorLanguage

foreign import navigatorLanguage :: Effect Foreign

readUserLanguage :: Effect (Maybe String)
readUserLanguage = readForeignString <$> navigatorUserLanguage

foreign import navigatorUserLanguage :: Effect Foreign

readForeignString :: Foreign -> Maybe String
readForeignString = readString >>> runExcept >>> eitherToMaybe
  where
    eitherToMaybe :: forall a b. Either a b -> Maybe b
    eitherToMaybe = either (const Nothing) Just

readForeignStringArray :: Foreign -> Array String
readForeignStringArray = (readArray >=> traverse readString)
                     >>> runExcept
                     >>> fold

