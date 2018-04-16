
function prerender test_case quality = (
    
    renderers.current = Radeon_ProRender()
    renderers.current.passLimit = {pass_limit}

    renderers.current.qualityPreset = quality

    rpr_render "jpg" test_case
)

function main = (
    
    filesToRender = #(
        {scene_list}
    )
    
    for fi=1 to filesToRender.count do (
        assetsFile = "{res_path}" + "\\" + filesToRender[fi]
        loadMaxFile assetsFile quiet:true

        prerender "MAX_RS_QP_001" 1
        prerender "MAX_RS_QP_002" 2
        prerender "MAX_RS_QP_003" 3
       
    )
)

main()
resetMaxFile #noPrompt
quitMax #noPrompt
