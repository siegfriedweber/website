module Language
    ( LANGUAGE
    , Language(..)
    , getUserLanguage
    , languageCode
    , selectSupportedLanguage
    ) where

import Prelude
import Control.Monad.Eff (Eff)
import Control.Monad.Except (runExcept)
import Data.Either (Either, either, fromRight)
import Data.Maybe (Maybe(Just, Nothing))
import Data.Foreign (Foreign, readString)
import Data.String (take)
import Data.String.Regex (Regex, regex, test)
import Data.String.Regex.Flags (noFlags)
import Partial.Unsafe (unsafePartial)

data Language = De | En

languageCode :: Language -> String
languageCode De = "de"
languageCode En = "en"

selectSupportedLanguage :: Maybe String -> Language
selectSupportedLanguage (Just "de") = De
selectSupportedLanguage _           = En

foreign import data LANGUAGE :: !

foreign import userLanguage :: forall e. Eff (language :: LANGUAGE | e) Foreign

getUserLanguage :: forall e. Eff (language :: LANGUAGE | e) (Maybe String)
getUserLanguage = (read >=> extractLanguageCode) <$> userLanguage
  where
    extractLanguageCode :: String -> Maybe String
    extractLanguageCode s | test twoLetterCodeRegex s = Just $ take 2 s
                          | otherwise                 = Nothing

    twoLetterCodeRegex :: Regex
    twoLetterCodeRegex = unsafePartial $ fromRight $
        regex "^[a-z][a-z](?:\\-\\w+)*$" noFlags

    read :: Foreign -> Maybe String
    read = eitherToMaybe <<< runExcept <<< readString

    eitherToMaybe :: forall a b. Either a b -> Maybe b
    eitherToMaybe = either (const Nothing) Just

