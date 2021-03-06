{-
Copyright 2012 liquid_amber

This file is part of PicasaDB.

PicasaDB is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

PicasaDB is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with PicasaDB.  If not, see <http://www.gnu.org/licenses/>.
-}

import Data.Word
import Data.DateTime
import Data.PicasaDB
import Data.PicasaDB.Reader
import Control.Monad ((>=>), (<=<))
import qualified Data.Binary.Get as G
import qualified Data.ByteString as B
import qualified Data.ByteString.Lazy as BL
import qualified Data.Text.Lazy as TL
import qualified Data.Text.Lazy.Encoding as E
import System.Environment (getArgs)
import Text.Printf

-- x y z 
-- f = \x y -> showHex x (' ' : y)
-- f = flip g
-- g = \y x -> flip showHex (' ' : y) x
--   = flip showHex . (' ' :)

readThumbsIndex :: FilePath -> IO [ThumbIndexEntry]
readThumbsIndex = return . G.runGet (getThumbIndexDB) <=< BL.readFile


main = do
  args <- getArgs
  mapM_ (readThumbsIndex >=> mapM_ (putStrLn . showTSV)) args
