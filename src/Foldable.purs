module Foldable
    ( intersperse
    ) where

import Prelude
import Data.Foldable (class Foldable, intercalate)

intersperse :: forall a f
             . Foldable f
            => Applicative f
            => Monoid (f a)
            => a -> f a -> f a
intersperse sep = intercalate (pure sep) <<< map pure

