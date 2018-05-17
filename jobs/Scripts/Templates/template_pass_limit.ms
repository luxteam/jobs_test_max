
function prerender test_list = (
    
    renderers.current = Radeon_ProRender()
    renderers.current.passLimit = test_list[3]

    if ({resolution_y} != 0 and {resolution_x} != 0) do (
        renderHeight = {resolution_y}
        renderWidth = {resolution_x}
    )
    
    rpr_render "jpg" test_list[1] test_list[2]
)

function main sf = (
    
    list_tests = #(
        #("MAX_RS_PS_001", "[\"Pass Limit: 1\"]", 1),
        #("MAX_RS_PS_002", "[\"Pass Limit: 100\"]", 100),
        #("MAX_RS_PS_003", "[\"Pass Limit: 500\"]", 500),
        #("MAX_RS_PS_004", "[\"Pass Limit: 1000\"]", 1000),
        #("MAX_RS_PS_005", "[\"Pass Limit: 5000\"]", 5000),
        #("MAX_RS_PS_006", "[\"Pass Limit: 10000\"]", 10000),
        #("MAX_RS_PS_007", "[\"Pass Limit: 1\"]", 1),
        #("MAX_RS_PS_008", "[\"Pass Limit: 100\"]", 100),
        #("MAX_RS_PS_009", "[\"Pass Limit: 500\"]", 500),
        #("MAX_RS_PS_010", "[\"Pass Limit: 1000\"]", 1000),
        #("MAX_RS_PS_011", "[\"Pass Limit: 5000\"]", 5000),
        #("MAX_RS_PS_012", "[\"Pass Limit: 10000\"]", 10000),
        #("MAX_RS_PS_013", "[\"Pass Limit: 1\"]", 1),
        #("MAX_RS_PS_014", "[\"Pass Limit: 100\"]", 100),
        #("MAX_RS_PS_015", "[\"Pass Limit: 500\"]", 500),
        #("MAX_RS_PS_016", "[\"Pass Limit: 1000\"]", 1000),
        #("MAX_RS_PS_017", "[\"Pass Limit: 5000\"]", 5000),
        #("MAX_RS_PS_018", "[\"Pass Limit: 10000\"]", 10000)
    )

    filesToRender = #(
        {scene_list}
    )
    
    for fi=1 to filesToRender.count do (
        assetsFile = "{res_path}" + "\\" + filesToRender[fi]
        loadMaxFile assetsFile useFileUnits:true quiet:true
			
        if (sf != 1) (
            create_failed_report list_tests[sf-1][1] list_tests[$sf-1][2] "failed"
        )	

        if (filesToRender[fi] == "base_scene.max") do (
            for sf=1 to 6 do (
                prerender list_tests[sf]
            )
        ) 

		if (filesToRender[fi] == "ironman.max") do (
            for sf=7 to 12 do (
                prerender list_tests[sf]
            )
        )  

		if (filesToRender[fi] == "default.max") do (
            for sf=13 to list_tests.count do (
                prerender list_tests[sf]
            )
        ) 
       
    )
)

main()
resetMaxFile #noPrompt
quitMax #noPrompt
