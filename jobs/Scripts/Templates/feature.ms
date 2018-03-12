
function config test_name = (
    
    renderers.current = Radeon_ProRender()
    renderers.current.passLimit = {pass_limit}

    save_render(test_name)
)

function main = (
    
    filesToRender = #(
        {scene_list}
    )
    
    for fi=1 to filesToRender.count do (
        assetsFile = "{res_path}" + "\\" + filesToRender[fi]
        loadMaxFile assetsFile quiet:true

        config(filesToRender[fi])
    )
)

main()
--resetMaxFile #noPrompt
quitMax #noPrompt
