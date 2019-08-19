import qualified Data.ByteString.Lazy as BS
import           Development.Shake
import           Development.Shake.Command
import           Development.Shake.FilePath
import           Development.Shake.Util
import           Text.Jasmine (minifyFile)

main :: IO ()
main = shakeArgs shakeOptions { shakeFiles = "build" } $ do
    want [ "dist" ]

    phony "clean" $ do
        removeDirectory ".spago"
        removeDirectory "build"
        removeDirectory "dist"
        removeDirectory "output"

    phony "dist" $ do
        need [ "dist/index.html" ]

    phony "publish" $ do
        need [ "dist/index.html" ]
        cmd_ Shell "scp -r dist/* siegfriedweber:~/website/"

    "//*.min.js" %> \out -> do
        let js = replaceExtension (dropExtension out) "js"
        need [ js ]
        liftIO $ minifyFile js >>= BS.writeFile out

    "build/index.js" %> \out -> do
        purs <- getDirectoryFiles "" [ "src//*.purs" ]
        need purs
        cmd_ "spago bundle-app --to build/index.js"

    "dist//*" %> \out -> do
        need [ "build/index.min.js" ]
        assets <- getDirectoryFiles "assets" [ "//*" ]
        sequence $ copyFileFromTo "assets" "dist" <$> assets
        copyFileFromTo "build" "dist" "index.min.js"

removeDirectory :: FilePath -> Action ()
removeDirectory path = removeFilesAfter path [ "//" ]

copyFileFromTo :: FilePath -> FilePath -> FilePath -> Action ()
copyFileFromTo srcPath dstPath file =
    copyFileChanged (srcPath </> file) (dstPath </> file)

