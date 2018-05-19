
function prerender test_list = (
    
    renderers.current = Radeon_ProRender()
    renderers.current.passLimit = {pass_limit}

    if ({resolution_y} != 0 and {resolution_x} != 0) do (
        renderHeight = {resolution_y}
        renderWidth = {resolution_x}
    )

    renderers.current.backgroundOverride = True
    renderers.current.backgroundType = 1

    renderers.current.backgroundSkyType = test_list[3]

    if (test_list[3] == 0) then (

    	renderers.current.backgroundSkyAzimuth = test_list[4]
    	renderers.current.backgroundSkyAltitude = test_list[5]

    ) else if (test_list[3] == 1) then (

    	if (test_list[6] == "Moscow") then (

    		renderers.current.backgroundSkyTimezone = 3
    		renderers.current.backgroundSkyLatitude = 55.752
    		renderers.current.backgroundSkyLongitude = 37.616

    	)
    	if (test_list[6] == "Canberra") then (

    		renderers.current.backgroundSkyTimezone = 11
    		renderers.current.backgroundSkyLatitude = -35.283
    		renderers.current.backgroundSkyLongitude = 149.128

    	)
    	if (test_list[6] == "Miami_Beach") then (

    		renderers.current.backgroundSkyTimezone = -5
    		renderers.current.backgroundSkyLatitude = 25.791
    		renderers.current.backgroundSkyLongitude = -80.13

    	)

    	renderers.current.backgroundSkyHours = test_list[4]
		renderers.current.backgroundSkyMinutes = test_list[5]
    )
			
    rpr_render "jpg" test_list[1] test_list[2]
)

function main = (
    
    sf = {start_from}

    list_tests = #(
        #("MAX_RS_SS_001", "[\"Sun&Sky System: Analytical sky\", \"Azimuth: 0\", \"Altitude: 0\"]", 0, 0, 0, "None"), 
        #("MAX_RS_SS_002", "[\"Sun&Sky System: Analytical sky\", \"Azimuth: 0\", \"Altitude: 45\"]", 0, 0, 45, "None"),
        #("MAX_RS_SS_003", "[\"Sun&Sky System: Analytical sky\", \"Azimuth: 0\", \"Altitude: 90\"]", 0, 0, 90, "None"),
        #("MAX_RS_SS_004", "[\"Sun&Sky System: Analytical sky\", \"Azimuth: 90\", \"Altitude: 0\"]", 0, 90 ,0 ",None"),
        #("MAX_RS_SS_005", "[\"Sun&Sky System: Analytical sky\", \"Azimuth: 90\", \"Altitude: 45\"]", 0, 90, 45, "None"),
        #("MAX_RS_SS_006", "[\"Sun&Sky System: Analytical sky\", \"Azimuth: 90\", \"Altitude: 90\"]", 0, 90, 90, "None"),
        #("MAX_RS_SS_007", "[\"Sun&Sky System: Analytical sky\", \"Azimuth: 180\", \"Altitude: 0\"]", 0, 180, 0, "None"),
        #("MAX_RS_SS_008", "[\"Sun&Sky System: Analytical sky\", \"Azimuth: 180\", \"Altitude: 45\"]", 0, 180, 45, "None"),
        #("MAX_RS_SS_009", "[\"Sun&Sky System: Analytical sky\", \"Azimuth: 180\", \"Altitude: 90\"]", 0, 180, 90, "None"),
        #("MAX_RS_SS_010", "[\"Sun&Sky System: Analytical sky\", \"Azimuth: 270\", \"Altitude: 0\"]", 0, 270, 0, "None"),
        #("MAX_RS_SS_011", "[\"Sun&Sky System: Analytical sky\", \"Azimuth: 270\", \"Altitude: 45\"]", 0, 270, 45, "None"),
        #("MAX_RS_SS_012", "[\"Sun&Sky System: Analytical sky\", \"Azimuth: 270\", \"Altitude: 90\"]", 0, 270, 90, "None"),
        #("MAX_RS_SS_013", "[\"Sun&Sky System: Analytical sky\", \"Azimuth: 360\", \"Altitude: 0\"]", 0, 360, 0, "None"),
        #("MAX_RS_SS_014", "[\"Sun&Sky System: Analytical sky\", \"Azimuth: 360\", \"Altitude: 45\"]", 0, 360, 45, "None"),
        #("MAX_RS_SS_015", "[\"Sun&Sky System: Analytical sky\", \"Azimuth: 360\", \"Altitude: 90\"]", 0, 360, 90, "None"),

        #("MAX_RS_SS_016", "[\"Sun&Sky System: Date, Time and Location\", \"Location: Moscow\", \"Hour: 0\"]", 1, 0, 0, "Moscow"),
        #("MAX_RS_SS_017", "[\"Sun&Sky System: Date, Time and Location\", \"Location: Moscow\", \"Hour: 6\"]", 1, 6, 0, "Moscow"),
        #("MAX_RS_SS_018", "[\"Sun&Sky System: Date, Time and Location\", \"Location: Moscow\", \"Hour: 12\"]", 1, 12, 0, "Moscow"),
        #("MAX_RS_SS_019", "[\"Sun&Sky System: Date, Time and Location\", \"Location: Moscow\", \"Hour: 18\"]", 1, 18, 0, "Moscow"),
        #("MAX_RS_SS_020", "[\"Sun&Sky System: Date, Time and Location\", \"Location: Moscow\", \"Hour: 24\"]", 1, 24, 0, "Moscow"),

        #("MAX_RS_SS_021", "[\"Sun&Sky System: Date, Time and Location\", \"Location: Miami Beach\", \"Hour: 0\"]", 1, 0, 0, "Miami_Beach"),
        #("MAX_RS_SS_022", "[\"Sun&Sky System: Date, Time and Location\", \"Location: Miami Beach\", \"Hour: 12\"]", 1, 12, 0, "Miami_Beach"),
        #("MAX_RS_SS_023", "[\"Sun&Sky System: Date, Time and Location\", \"Location: Miami Beach\", \"Hour: 24\"]", 1, 24, 0, "Miami_Beach"),

        #("MAX_RS_SS_024", "[\"Sun&Sky System: Date, Time and Location\", \"Location: Canberra\", \"Hour: 0\"]", 1, 0, 0, "Canberra"),
        #("MAX_RS_SS_025", "[\"Sun&Sky System: Date, Time and Location\", \"Location: Canberra\", \"Hour: 12\"]", 1, 12, 0, "Canberra"),
        #("MAX_RS_SS_026", "[\"Sun&Sky System: Date, Time and Location\", \"Location: Canberra\", \"Hour: 24\"]", 1, 24, 0, "Canberra")
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
