import Control.Monad ((>=>))
import Data.PicasaDB
import Data.PicasaDB.Reader
import qualified Data.ByteString.Lazy as BL
import qualified Data.Binary.Get as G
import System.Environment (getArgs)

readPMPDBFile :: FilePath -> IO (PMPDB)
readPMPDBFile f = return . G.runGet parsePMPDB  =<< BL.readFile f

main = do
  args <- getArgs
  mapM_ (readPMPDBFile >=> print) args
