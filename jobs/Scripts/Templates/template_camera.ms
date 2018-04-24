
function prerender test_case camera_type script_info = (
    
    renderers.current = Radeon_ProRender()
    renderers.current.passLimit = {pass_limit}
    if ({resolution_y} != 0 and {resolution_x} != 0) do (
        renderHeight = {resolution_y}
        renderWidth = {resolution_x}
    )

    renderers.current.cameraType = camera_type
    rpr_render "jpg" test_case script_info
)

function main = (
    
    filesToRender = #(
        {scene_list}
    )
    
    for fi=1 to filesToRender.count do (
        assetsFile = "{res_path}" + "\\" + filesToRender[fi]
        loadMaxFile assetsFile quiet:true

        prerender "MAX_RS_CAM_001" 1 "[\"RPR Camera Type: Spherical panorama\"]"
        prerender "MAX_RS_CAM_002" 2 "[\"RPR Camera Type: Stereo spherical panorama\"]"
        prerender "MAX_RS_CAM_003" 3 "[\"RPR Camera Type: Cubemap\"]"
        prerender "MAX_RS_CAM_004" 4 "[\"RPR Camera Type: Stereo cubemap\"]"
       
    )
)

main()
resetMaxFile #noPrompt
quitMax #noPrompt
