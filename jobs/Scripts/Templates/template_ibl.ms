
function prerender test_list = (
    
    renderers.current = Radeon_ProRender()
    renderers.current.passLimit = {pass_limit}
    if ({resolution_y} != 0 and {resolution_x} != 0) do (
        renderHeight = {resolution_y}
        renderWidth = {resolution_x}
    )

    renderers.current.backgroundOverride = True
    renderers.current.backgroundType = 0

    renderers.current.backgroundIntensity = test_list[3]
    if (test_list[4] == "color") then (
    	renderers.current.useBackgroundMap = False
    ) else if (test_list[4] == "hdr") then (
    	renderers.current.useBackgroundMap = True
    	hdr_path = "{res_path}" + "\\res\\Hdri\\Tropical_Beach_3k.hdr"
    	hdr = bitmaptexture filename:hdr_path
    	renderers.current.backgroundMap = hdr
    ) else if (test_list[4] == "exr") then (
    	renderers.current.useBackgroundMap = True
    	exr_path = "{res_path}" + "\\res\\Hdri\\over_the_clouds.exr"
    	exr = bitmaptexture filename:exr_path
    	renderers.current.backgroundMap = exr
    )

    rpr_render "jpg" test_list[1] test_list[2]
)

function main sf = (
    
    list_tests = #(
       #("MAX_RS_IBL_001", "[\"Type: Color\", \"Intensity: 0\"]", 0, "color"),
       #("MAX_RS_IBL_002", "[\"Type: Color\", \"Intensity: 1\"]", 1, "color"),
       #("MAX_RS_IBL_003", "[\"Type: Color\", \"Intensity: 2\"]", 2, "color"),
       #("MAX_RS_IBL_004", "[\"Type: Color\", \"Intensity: 3\"]", 3, "color"),
       #("MAX_RS_IBL_005", "[\"Type: Color\", \"Intensity: 5\"]", 5, "color"),
       #("MAX_RS_IBL_006", "[\"Type: Color\", \"Intensity: 7\"]", 7, "color"),
       #("MAX_RS_IBL_007", "[\"Type: Color\", \"Intensity: 10\"]", 10, "color"), 

       #("MAX_RS_IBL_008", "[\"Type: IBL with hdr map\", \"Intensity: 0\"]", 0, "hdr"),
       #("MAX_RS_IBL_009", "[\"Type: IBL with hdr map\", \"Intensity: 1\"]", 1, "hdr"),
       #("MAX_RS_IBL_010", "[\"Type: IBL with hdr map\", \"Intensity: 2\"]", 2, "hdr"),
       #("MAX_RS_IBL_011", "[\"Type: IBL with hdr map\", \"Intensity: 3\"]", 3, "hdr"),
       #("MAX_RS_IBL_012", "[\"Type: IBL with hdr map\", \"Intensity: 5\"]", 5, "hdr"),
       #("MAX_RS_IBL_013", "[\"Type: IBL with hdr map\", \"Intensity: 7\"]", 7, "hdr"), 
       #("MAX_RS_IBL_014", "[\"Type: IBL with hdr map\", \"Intensity: 10\"]", 10, "hdr"),

       #("MAX_RS_IBL_015", "[\"Type: IBL with exr map\", \"Intensity: 0\"]", 0, "exr"), 
       #("MAX_RS_IBL_016", "[\"Type: IBL with exr map\", \"Intensity: 1\"]", 1, "exr"), 
       #("MAX_RS_IBL_017", "[\"Type: IBL with exr map\", \"Intensity: 2\"]", 2, "exr"), 
       #("MAX_RS_IBL_018", "[\"Type: IBL with exr map\", \"Intensity: 3\"]", 3, "exr"), 
       #("MAX_RS_IBL_019", "[\"Type: IBL with exr map\", \"Intensity: 5\"]", 5, "exr"), 
       #("MAX_RS_IBL_020", "[\"Type: IBL with exr map\", \"Intensity: 7\"]", 7, "exr"), 
       #("MAX_RS_IBL_021", "[\"Type: IBL with exr map\", \"Intensity: 10\"]", 10, "exr")
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
        
        for sf=1 to list_tests.count do (
            prerender list_tests[sf]
        )

    )
)

main()
resetMaxFile #noPrompt
quitMax #noPrompt
