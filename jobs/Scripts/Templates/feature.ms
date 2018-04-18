
function prerender test_name = (
    
    renderers.current = Radeon_ProRender()
    renderers.current.passLimit = {pass_limit}
    renderHeight = {resolution_y}
    renderWidth = {resolution_x}

    rpr_render "jpg" test_name 
)

function main = (
    
    filesToRender = #(
        {scene_list}
    )
    
    for fi=1 to filesToRender.count do (
        assetsFile = "{res_path}" + "\\" + filesToRender[fi]
        loadMaxFile assetsFile quiet:true

        prerender filesToRender[fi]
    )
)

main()
resetMaxFile #noPrompt
quitMax #noPrompt
