
function prerender test_list = (
    
    renderers.current = Radeon_ProRender()
    renderers.current.passLimit = {pass_limit}
    
    if ({resolution_y} != 0 and {resolution_x} != 0) do (
        renderHeight = {resolution_y}
        renderWidth = {resolution_x}
    )

    renderers.current.qualityPreset = test_list[3]

    rpr_render "jpg" test_list[1]  test_list[2]
)

function main = (
    
    sf = {start_from}

    list_tests = #(
        #("MAX_RS_QP_001", "[\"Quality preset: Low\"]", 1),
        #("MAX_RS_QP_002", "[\"Quality preset: Medium\"]", 2),
        #("MAX_RS_QP_003", "[\"Quality preset: High\"]", 3)
    )

    filesToRender = #(
        {scene_list}
    )
    
    for fi=1 to filesToRender.count do (
        assetsFile = "{res_path}" + "\\" + filesToRender[fi]
        loadMaxFile assetsFile useFileUnits:true quiet:true

        if (sf != 1) do (
            create_failed_report list_tests[sf][1] list_tests[sf][2] "failed"
            sf += 1
        )

        for i=sf to list_tests.count do (
            prerender list_tests[i]
        )
       
    )
)

main()
resetMaxFile #noPrompt
quitMax #noPrompt
