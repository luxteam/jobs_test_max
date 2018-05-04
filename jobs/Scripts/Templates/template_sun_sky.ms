
function prerender test_case type_sun_sky param1 param2 location script_info = (
    
    renderers.current = Radeon_ProRender()
    renderers.current.passLimit = {pass_limit}
    if ({resolution_y} != 0 and {resolution_x} != 0) do (
        renderHeight = {resolution_y}
        renderWidth = {resolution_x}
    )

    renderers.current.backgroundOverride = True
    renderers.current.backgroundType = 1

    renderers.current.backgroundSkyType = type_sun_sky

    if (type_sun_sky == 0) then (
    	renderers.current.backgroundSkyAzimuth = param1
    	renderers.current.backgroundSkyAltitude = param2
    ) else if (type_sun_sky == 1) then (
    	if (location == "Moscow") then (
    		renderers.current.backgroundSkyTimezone = 3
    		renderers.current.backgroundSkyLatitude = 55.752
    		renderers.current.backgroundSkyLongitude = 37.616
    	)
    	if (location == "Canberra") then (
    		renderers.current.backgroundSkyTimezone = 11
    		renderers.current.backgroundSkyLatitude = -35.283
    		renderers.current.backgroundSkyLongitude = 149.128
    	)
    	if (location == "Miami_Beach") then (
    		renderers.current.backgroundSkyTimezone = -5
    		renderers.current.backgroundSkyLatitude = 25.791
    		renderers.current.backgroundSkyLongitude = -80.13
    	)
    	renderers.current.backgroundSkyHours = param1
		renderers.current.backgroundSkyMinutes = param2
    )
			
    rpr_render "jpg" test_case script_info
)

function main = (
    
    filesToRender = #(
        {scene_list}
    )
    
    for fi=1 to filesToRender.count do (
        assetsFile = "{res_path}" + "\\" + filesToRender[fi]
        loadMaxFile assetsFile useFileUnits:true quiet:true

        prerender "MAX_RS_SS_001" 0 0 0 "None" "[\"Sun&Sky System: Analytical sky\", \"Azimuth: 0\", \"Altitude: 0\"]"
        prerender "MAX_RS_SS_002" 0 0 45 "None" "[\"Sun&Sky System: Analytical sky\", \"Azimuth: 0\", \"Altitude: 45\"]"
        prerender "MAX_RS_SS_003" 0 0 90 "None" "[\"Sun&Sky System: Analytical sky\", \"Azimuth: 0\", \"Altitude: 90\"]"
        prerender "MAX_RS_SS_004" 0 90 0 "None" "[\"Sun&Sky System: Analytical sky\", \"Azimuth: 90\", \"Altitude: 0\"]"
        prerender "MAX_RS_SS_005" 0 90 45 "None" "[\"Sun&Sky System: Analytical sky\", \"Azimuth: 90\", \"Altitude: 45\"]"
        prerender "MAX_RS_SS_006" 0 90 90 "None" "[\"Sun&Sky System: Analytical sky\", \"Azimuth: 90\", \"Altitude: 90\"]"
        prerender "MAX_RS_SS_007" 0 180 0 "None" "[\"Sun&Sky System: Analytical sky\", \"Azimuth: 180\", \"Altitude: 0\"]"
        prerender "MAX_RS_SS_008" 0 180 45 "None" "[\"Sun&Sky System: Analytical sky\", \"Azimuth: 180\", \"Altitude: 45\"]"
        prerender "MAX_RS_SS_009" 0 180 90 "None" "[\"Sun&Sky System: Analytical sky\", \"Azimuth: 180\", \"Altitude: 90\"]"
        prerender "MAX_RS_SS_010" 0 270 0 "None" "[\"Sun&Sky System: Analytical sky\", \"Azimuth: 270\", \"Altitude: 0\"]"
        prerender "MAX_RS_SS_011" 0 270 45 "None" "[\"Sun&Sky System: Analytical sky\", \"Azimuth: 270\", \"Altitude: 45\"]"
        prerender "MAX_RS_SS_012" 0 270 90 "None" "[\"Sun&Sky System: Analytical sky\", \"Azimuth: 270\", \"Altitude: 90\"]"
        prerender "MAX_RS_SS_013" 0 360 0 "None" "[\"Sun&Sky System: Analytical sky\", \"Azimuth: 360\", \"Altitude: 0\"]"
        prerender "MAX_RS_SS_014" 0 360 45 "None" "[\"Sun&Sky System: Analytical sky\", \"Azimuth: 360\", \"Altitude: 45\"]"
        prerender "MAX_RS_SS_015" 0 360 90 "None" "[\"Sun&Sky System: Analytical sky\", \"Azimuth: 360\", \"Altitude: 90\"]"

        prerender "MAX_RS_SS_016" 1 0 0 "Moscow" "[\"Sun&Sky System: Date, Time and Location\", \"Location: Moscow\", \"Hour: 0\"]"
        prerender "MAX_RS_SS_017" 1 6 0 "Moscow" "[\"Sun&Sky System: Date, Time and Location\", \"Location: Moscow\", \"Hour: 6\"]"
        prerender "MAX_RS_SS_018" 1 12 0 "Moscow" "[\"Sun&Sky System: Date, Time and Location\", \"Location: Moscow\", \"Hour: 12\"]"
        prerender "MAX_RS_SS_019" 1 18 0 "Moscow" "[\"Sun&Sky System: Date, Time and Location\", \"Location: Moscow\", \"Hour: 18\"]"
        prerender "MAX_RS_SS_020" 1 24 0 "Moscow" "[\"Sun&Sky System: Date, Time and Location\", \"Location: Moscow\", \"Hour: 24\"]"

        prerender "MAX_RS_SS_021" 1 0 0 "Miami_Beach" "[\"Sun&Sky System: Date, Time and Location\", \"Location: Miami Beach\", \"Hour: 0\"]"
        prerender "MAX_RS_SS_022" 1 12 0 "Miami_Beach" "[\"Sun&Sky System: Date, Time and Location\", \"Location: Miami Beach\", \"Hour: 12\"]"
        prerender "MAX_RS_SS_023" 1 24 0 "Miami_Beach" "[\"Sun&Sky System: Date, Time and Location\", \"Location: Miami Beach\", \"Hour: 24\"]"

        prerender "MAX_RS_SS_024" 1 0 0 "Canberra" "[\"Sun&Sky System: Date, Time and Location\", \"Location: Canberra\", \"Hour: 0\"]"
        prerender "MAX_RS_SS_025" 1 12 0 "Canberra" "[\"Sun&Sky System: Date, Time and Location\", \"Location: Canberra\", \"Hour: 12\"]"
        prerender "MAX_RS_SS_026" 1 24 0 "Canberra" "[\"Sun&Sky System: Date, Time and Location\", \"Location: Canberra\", \"Hour: 24\"]"
 
    )
)

main()
resetMaxFile #noPrompt
quitMax #noPrompt
