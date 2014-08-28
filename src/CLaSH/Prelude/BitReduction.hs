{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE MagicHash        #-}

module CLaSH.Prelude.BitReduction where

import GHC.TypeLits                   (KnownNat)

import CLaSH.Class.BitConvert         (BitConvert (..))
import CLaSH.Sized.Internal.BitVector (Bit, reduceAnd#, reduceOr#, reduceXor#)

{-# INLINE reduceAnd #-}
-- | Are all bits set to '1'?
--
-- >>> pack (-2 :: Signed 6)
-- 111110
-- >>> reduceAnd (-2 :: Signed 6)
-- 0
-- >>> pack (-1 :: Signed 6)
-- 111111
-- >>> reduceAnd (-1 :: Signed 6)
-- 1
reduceAnd :: (BitConvert a, KnownNat (BitSize a)) => a -> Bit
reduceAnd v = reduceAnd# (pack v)

{-# INLINE reduceOr #-}
-- | Is there at least one bit set to '1'?
--
-- >>> pack (5 :: Signed 6)
-- 000101
-- >>> reduceOr (5 :: Signed 6)
-- 1
-- >>> pack (0 :: Signed 6)
-- 000000
-- >>> reduceOr (0 :: Signed 6)
-- 0
reduceOr :: BitConvert a => a -> Bit
reduceOr v = reduceOr# (pack v)

{-# INLINE reduceXor #-}
-- | Is the number of bits set to '1' uneven?
--
-- >>> pack (5 :: Signed 6)
-- 000101
-- >>> reduceXor (5 :: Signed 6)
-- 0
-- >>> pack (28 :: Signed 6)
-- 011100
-- >>> reduceXor (28 :: Signed 6)
-- 1
-- >>> pack (-5 :: Signed 6)
-- 111011
-- >>> reduceXor (-5 :: Signed 6)
-- 1
reduceXor :: BitConvert a => a -> Bit
reduceXor v = reduceXor# (pack v)