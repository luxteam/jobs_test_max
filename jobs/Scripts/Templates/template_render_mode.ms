
function prerender test_case mode script_info = (
    
    renderers.current = Radeon_ProRender()
    renderers.current.passLimit = {pass_limit}
    if ({resolution_y} != 0 and {resolution_x} != 0) do (
        renderHeight = {resolution_y}
        renderWidth = {resolution_x}
    )

    renderers.current.renderMode = mode

    rpr_render "jpg" test_case script_info
)

function main = (
    
    filesToRender = #(
        {scene_list}
    )
    
    for fi=1 to filesToRender.count do (
        assetsFile = "{res_path}" + "\\" + filesToRender[fi]
        loadMaxFile assetsFile quiet:true

        prerender "MAX_RS_RM_001" 1 "[\"Render mode: Global Illumination\"]"
        prerender "MAX_RS_RM_002" 2 "[\"Render mode: Direct\"]"
        prerender "MAX_RS_RM_003" 3 "[\"Render mode: Direct no shadow\"]"
        prerender "MAX_RS_RM_004" 4 "[\"Render mode: Wireframe\"]"
        prerender "MAX_RS_RM_005" 5 "[\"Render mode: Material index\"]"
        prerender "MAX_RS_RM_006" 6 "[\"Render mode: Position\"]"
        prerender "MAX_RS_RM_007" 7 "[\"Render mode: Normal\"]"
        prerender "MAX_RS_RM_008" 8 "[\"Render mode: Tex coords\"]"
        prerender "MAX_RS_RM_009" 9 "[\"Render mode: Ambient Occlusion\"]"
       
    )
)

main()
resetMaxFile #noPrompt
quitMax #noPrompt
