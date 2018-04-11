
function config test_name mode samples = (
    
    renderers.current = Radeon_ProRender()
    renderers.current.passLimit = {pass_limit}

    renderers.current.renderMode = mode
    renderers.current.aaSampleCount = samples

    img_name = test_name + "_" + mode as string + "_" + samples as string
    save_render img_name
)

function main = (
    
    filesToRender = #(
        {scene_list}
    )
    
    for fi=1 to filesToRender.count do (
        assetsFile = "{res_path}" + "\\" + filesToRender[fi]
        loadMaxFile assetsFile quiet:true

        config filesToRender[fi] 1 1
        config filesToRender[fi] 1 5
        config filesToRender[fi] 1 15
        config filesToRender[fi] 1 23
        config filesToRender[fi] 1 32
        config filesToRender[fi] 2 1
        config filesToRender[fi] 2 5
        config filesToRender[fi] 2 15
        config filesToRender[fi] 2 23
        config filesToRender[fi] 2 32
        config filesToRender[fi] 3 1
        config filesToRender[fi] 3 5
        config filesToRender[fi] 3 15
        config filesToRender[fi] 3 23
        config filesToRender[fi] 3 32
        config filesToRender[fi] 4 1
        config filesToRender[fi] 4 5
        config filesToRender[fi] 4 15
        config filesToRender[fi] 4 23
        config filesToRender[fi] 4 32
        config filesToRender[fi] 5 1
        config filesToRender[fi] 5 5
        config filesToRender[fi] 5 15
        config filesToRender[fi] 5 23
        config filesToRender[fi] 5 32
        config filesToRender[fi] 6 1
        config filesToRender[fi] 6 5
        config filesToRender[fi] 6 15
        config filesToRender[fi] 6 23
        config filesToRender[fi] 6 32
       
    )
)

main()
--resetMaxFile #noPrompt
quitMax #noPrompt
