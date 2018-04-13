
function prerender test_case camera_type = (
    
    renderers.current = Radeon_ProRender()
    renderers.current.passLimit = {pass_limit}

    renderers.current.cameraType = camera_type

    rpr_render test_case
)

function main = (
    
    filesToRender = #(
        {scene_list}
    )
    
    for fi=1 to filesToRender.count do (
        assetsFile = "{res_path}" + "\\" + filesToRender[fi]
        loadMaxFile assetsFile quiet:true

        prerender "MAX_RS_CAM_001" 1
        prerender "MAX_RS_CAM_002" 2
        prerender "MAX_RS_CAM_003" 3
        prerender "MAX_RS_CAM_004" 4
       
    )
)

main()
resetMaxFile #noPrompt
quitMax #noPrompt
