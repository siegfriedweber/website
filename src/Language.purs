module Language
    ( LANGUAGE
    , Language(..)
    , getDisplayLanguage
    , languageCode
    ) where

import Prelude
import Control.Monad.Eff (kind Effect, Eff)
import Control.Monad.Except (runExcept)
import Data.Array (catMaybes, fromFoldable, head)
import Data.Either (Either, either, fromRight)
import Data.Maybe (Maybe(Just, Nothing), fromMaybe)
import Data.Foldable (fold)
import Data.Foreign (Foreign, readArray, readString)
import Data.String (take)
import Data.String.Regex (Regex, regex, test)
import Data.String.Regex.Flags (noFlags)
import Data.Traversable (traverse)
import Partial.Unsafe (unsafePartial)

data Language = De | En

defaultLanguage :: Language
defaultLanguage = En

languageCode :: Language -> String
languageCode De = "de"
languageCode En = "en"

getDisplayLanguage :: forall e. Eff (language :: LANGUAGE | e) Language
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

foreign import data LANGUAGE :: Effect

readLanguages :: forall e. Eff (language :: LANGUAGE | e) (Array String)
readLanguages = readForeignStringArray <$> navigatorLanguages

foreign import navigatorLanguages :: forall e. Eff (language :: LANGUAGE | e) Foreign

readLanguage :: forall e. Eff (language :: LANGUAGE | e) (Maybe String)
readLanguage = readForeignString <$> navigatorLanguage

foreign import navigatorLanguage :: forall e. Eff (language :: LANGUAGE | e) Foreign

readUserLanguage :: forall e. Eff (language :: LANGUAGE | e) (Maybe String)
readUserLanguage = readForeignString <$> navigatorUserLanguage

foreign import navigatorUserLanguage :: forall e. Eff (language :: LANGUAGE | e) Foreign

readForeignString :: Foreign -> Maybe String
readForeignString = readString >>> runExcept >>> eitherToMaybe
  where
    eitherToMaybe :: forall a b. Either a b -> Maybe b
    eitherToMaybe = either (const Nothing) Just

readForeignStringArray :: Foreign -> Array String
readForeignStringArray = (readArray >=> traverse readString)
                     >>> runExcept
                     >>> fold

