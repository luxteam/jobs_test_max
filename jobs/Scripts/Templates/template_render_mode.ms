
function prerender test_list = (
    
    renderers.current = Radeon_ProRender()
    renderers.current.passLimit = {pass_limit}

    if ({resolution_y} != 0 and {resolution_x} != 0) do (
        renderHeight = {resolution_y}
        renderWidth = {resolution_x}
    )

    renderers.current.renderMode = test_list[3]

    rpr_render "jpg" test_list[1] test_list[2]
)

function main = (
    
    list_tests = #(
        #("MAX_RS_RM_001", "[\"Render mode: Global Illumination\"]", 1),
        #("MAX_RS_RM_002", "[\"Render mode: Direct\"]", 2),
        #("MAX_RS_RM_003", "[\"Render mode: Direct no shadow\"]", 3),
        #("MAX_RS_RM_004", "[\"Render mode: Wireframe\"]", 4),
        #("MAX_RS_RM_005", "[\"Render mode: Material index\"]", 5),
        #("MAX_RS_RM_006", "[\"Render mode: Position\"]", 6),
        #("MAX_RS_RM_007", "[\"Render mode: Normal\"]", 7),
        #("MAX_RS_RM_008", "[\"Render mode: Tex coords\"]", 8),
        #("MAX_RS_RM_009", "[\"Render mode: Ambient Occlusion\"]", 9)
    )

    filesToRender = #(
        {scene_list}
    )
    
    for fi=1 to filesToRender.count do (
        assetsFile = "{res_path}" + "\\" + filesToRender[fi]
        loadMaxFile assetsFile useFileUnits:true quiet:true

        for sf=1 to list_tests.count do (
                prerender list_tests[sf]
        )
       
    )
)

main()
resetMaxFile #noPrompt
quitMax #noPrompt
