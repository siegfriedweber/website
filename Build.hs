import Development.Shake
import Development.Shake.Command
import Development.Shake.FilePath
import Development.Shake.Util

main :: IO ()
main = shakeArgs shakeOptions { shakeFiles = "build" } $ do
    want [ "dist" ]

    phony "clean" $ do
        removeDirectory "bower_components"
        removeDirectory "build"
        removeDirectory "dist"
        removeDirectory "node_modules"
        removeDirectory "output"

    phony "dist" $ do
        need [ "dist/index.html" ]

    phony "publish" $ do
        need [ "dist/index.html" ]
        cmd_ Shell "scp -r dist/* siegfriedweber:~/website/"

    "build/main.js" %> \out -> do
        purs <- getDirectoryFiles "" [ "src//*.purs" ]
        need $ "bower_components/purescript-halogen/bower.json"
                : "node_modules/pulp/pulp.js"
                : purs
        cmd_ "node node_modules/pulp/pulp.js browserify --optimise --to" out

    "dist//*" %> \out -> do
        need [ "build/main.js" ]
        assets <- getDirectoryFiles "assets" [ "//*" ]
        sequence $ copyFileFromTo "assets" "dist" <$> assets
        copyFileFromTo "build" "dist" "main.js"

    "bower_components//*" %> \out -> do
        need [ "bower.json" ]
        cmd_ "bower install --force"

    "node_modules//*" %> \out -> do
        need [ "package.json" ]
        cmd_ "npm install"

removeDirectory :: FilePath -> Action ()
removeDirectory path = removeFilesAfter path [ "//" ]

copyFileFromTo :: FilePath -> FilePath -> FilePath -> Action ()
copyFileFromTo srcPath dstPath file =
    copyFileChanged (srcPath </> file) (dstPath </> file)

