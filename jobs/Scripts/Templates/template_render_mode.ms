
function prerender test_case mode = (
    
    renderers.current = Radeon_ProRender()
    renderers.current.passLimit = {pass_limit}

    renderers.current.renderMode = mode

    rpr_render "jpg" test_case
)

function main = (
    
    filesToRender = #(
        {scene_list}
    )
    
    for fi=1 to filesToRender.count do (
        assetsFile = "{res_path}" + "\\" + "MAX_RS_AA_001"
        loadMaxFile assetsFile quiet:true

        prerender "MAX_RS_RM_001" 1
        prerender "MAX_RS_RM_002" 2
        prerender "MAX_RS_RM_003" 3
        prerender "MAX_RS_RM_004" 4
        prerender "MAX_RS_RM_005" 5
        prerender "MAX_RS_RM_006" 6
        prerender "MAX_RS_RM_007" 7
        prerender "MAX_RS_RM_008" 8 
        prerender "MAX_RS_RM_009" 9 
       
    )
)

main()
resetMaxFile #noPrompt
quitMax #noPrompt
