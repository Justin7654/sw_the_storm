--- Developed using LifeBoatAPI - Stormworks Lua plugin for VSCode - https://code.visualstudio.com/download (search "Stormworks Lua with LifeboatAPI" extension)
--- If you have any issues, please report them here: https://github.com/nameouschangey/STORMWORKS_VSCodeExtension/issues - by Nameous Changey

-- Callbacks for handling the build process
-- Allows for running external processes, or customising the build output to how you prefer
-- Recommend using LifeBoatAPI.Tools.FileSystemUtils to simplify life

-- Note: THIS FILE IS NOT SANDBOXED. DO NOT REQUIRE CODE FROM LIBRARIES YOU DO NOT 100% TRUST.
require("LifeBoatAPI.Tools.Build.Builder")

--- Runs when the build process is triggered, before any file has been built
--- Provides an opportunity for any code-generation etc.
---@param builder Builder           builder object that will be used to build each file
---@param params MinimizerParams    params that the build process usees to control minification settings
---@param workspaceRoot Filepath    filepath to the root folder of the project
function onLBBuildStarted(builder, params, workspaceRoot)

    -- avoid building 90% of the project, because we only want this one file to be built
    --uilder.filter = "main"
end

--- Runs just before each file is built
---@param builder Builder           builder object that will be used to build each file
---@param params MinimizerParams    params that the build process usees to control minification settings
---@param workspaceRoot Filepath    filepath to the root folder of the project
---@param name string               "require"-style name of the script that's about to be built
---@param inputFile Filepath        filepath to the file that is about to be built
function onLBBuildFileStarted(builder, params, workspaceRoot, name, inputFile)
    
end

--- Runs after each file has been combined and minimized
--- Provides a chance to use the output, e.g. sending files into vehicle XML or similar
---@param builder Builder           builder object that will be used to build each file
---@param params MinimizerParams    params that the build process usees to control minification settings
---@param workspaceRoot Filepath    filepath to the root folder of the project
---@param name string               "require"-style name of the script that's been built
---@param inputFile Filepath        filepath to the file that was just built
---@param outputFile Filepath       filepath to the output minimized file
---@param combinedText string       text generated by the require-resolution process (pre-minified)
---@param minimizedText string      final text output by the process, ready to go in game (post-minified)
function onLBBuildFileComplete(builder, params, workspaceRoot, name, inputFile, outputFile, originalText, combinedText, minimizedText)
end

--- Runs after the build process has finished for this project 
--- Provides a chance to do any final build steps, such as moving files around
---@param builder Builder           builder object that will be used to build each file
---@param params MinimizerParams    params that the build process usees to control minification settings
---@param workspaceRoot Filepath    filepath to the root folder of the project
function onLBBuildComplete(builder, params, workspaceRoot)
    print("Build Success")
    print("See the /out/release/ folder for your minimized code")

    -- example: copy output to the game/addon folder
    require("LifeBoatAPI.Tools.Utils.Filepath")
    require("LifeBoatAPI.Tools.Utils.FileSystemUtils")

    local scriptToCopy = "script.lua"
    local addonName = "TheStorm"
    local username = "justi"

    local inputPath = workspaceRoot:add([[/_build/out/release/]] .. scriptToCopy)
    local outputPath = LifeBoatAPI.Tools.Filepath:new([[C:\Users\]] .. username .. [[\AppData\Roaming\Stormworks\data\missions\]].. addonName ..[[\script.lua]])

    -- uncomment this once path setup correctly above
    LifeBoatAPI.Tools.FileSystemUtils.copyFile(inputPath, outputPath)
end