
function config test_name mode = (
    
    renderers.current = Radeon_ProRender()
    renderers.current.passLimit = {pass_limit}

    renderers.current.renderMode = mode

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

        config filesToRender[fi] 1
        config filesToRender[fi] 2
        config filesToRender[fi] 3
        config filesToRender[fi] 4
        config filesToRender[fi] 5
        config filesToRender[fi] 6
        config filesToRender[fi] 7
        config filesToRender[fi] 8 
        config filesToRender[fi] 9 
       
    )
)

main()
resetMaxFile #noPrompt
quitMax #noPrompt
