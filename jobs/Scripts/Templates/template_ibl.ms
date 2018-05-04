
function prerender test_case intensity map script_info = (
    
    renderers.current = Radeon_ProRender()
    renderers.current.passLimit = {pass_limit}
    if ({resolution_y} != 0 and {resolution_x} != 0) do (
        renderHeight = {resolution_y}
        renderWidth = {resolution_x}
    )

    renderers.current.backgroundOverride = True
    renderers.current.backgroundType = 0

    renderers.current.backgroundIntensity = intensity
    if (map == "color") then (
    	renderers.current.useBackgroundMap = False
    ) else if (map == "hdr") then (
    	renderers.current.useBackgroundMap = True
    	hdr_path = "{res_path}" + "\\res\\Hdri\\Tropical_Beach_3k.hdr"
    	hdr = bitmaptexture filename:hdr_path
    	renderers.current.backgroundMap = hdr
    ) else if (map == "exr") then (
    	renderers.current.useBackgroundMap = True
    	exr_path = "{res_path}" + "\\res\\Hdri\\over_the_clouds.exr"
    	exr = bitmaptexture filename:exr_path
    	renderers.current.backgroundMap = exr
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

        prerender "MAX_RS_IBL_001" 0 "color" "[\"Type: Color\", \"Intensity: 0\"]"
        prerender "MAX_RS_IBL_002" 1 "color" "[\"Type: Color\", \"Intensity: 1\"]"
        prerender "MAX_RS_IBL_003" 2 "color" "[\"Type: Color\", \"Intensity: 2\"]"
        prerender "MAX_RS_IBL_004" 3 "color" "[\"Type: Color\", \"Intensity: 3\"]"
        prerender "MAX_RS_IBL_005" 5 "color" "[\"Type: Color\", \"Intensity: 5\"]"
        prerender "MAX_RS_IBL_006" 7 "color" "[\"Type: Color\", \"Intensity: 7\"]"
        prerender "MAX_RS_IBL_007" 10 "color" "[\"Type: Color\", \"Intensity: 10\"]"

        prerender "MAX_RS_IBL_008" 0 "hdr" "[\"Type: IBL with hdr map\", \"Intensity: 0\"]"
        prerender "MAX_RS_IBL_009" 1 "hdr" "[\"Type: IBL with hdr map\", \"Intensity: 1\"]"
        prerender "MAX_RS_IBL_010" 2 "hdr" "[\"Type: IBL with hdr map\", \"Intensity: 2\"]"
        prerender "MAX_RS_IBL_011" 3 "hdr" "[\"Type: IBL with hdr map\", \"Intensity: 3\"]"
        prerender "MAX_RS_IBL_012" 5 "hdr" "[\"Type: IBL with hdr map\", \"Intensity: 5\"]"
        prerender "MAX_RS_IBL_013" 7 "hdr" "[\"Type: IBL with hdr map\", \"Intensity: 7\"]"
        prerender "MAX_RS_IBL_014" 10 "hdr" "[\"Type: IBL with hdr map\", \"Intensity: 10\"]"

        prerender "MAX_RS_IBL_015" 0 "exr" "[\"Type: IBL with exr map\", \"Intensity: 0\"]"
        prerender "MAX_RS_IBL_016" 1 "exr" "[\"Type: IBL with exr map\", \"Intensity: 1\"]"
        prerender "MAX_RS_IBL_017" 2 "exr" "[\"Type: IBL with exr map\", \"Intensity: 2\"]"
        prerender "MAX_RS_IBL_018" 3 "exr" "[\"Type: IBL with exr map\", \"Intensity: 3\"]"
        prerender "MAX_RS_IBL_019" 5 "exr" "[\"Type: IBL with exr map\", \"Intensity: 5\"]"
        prerender "MAX_RS_IBL_020" 7 "exr" "[\"Type: IBL with exr map\", \"Intensity: 7\"]"
        prerender "MAX_RS_IBL_021" 10 "exr" "[\"Type: IBL with exr map\", \"Intensity: 10\"]"


       
    )
)

main()
resetMaxFile #noPrompt
quitMax #noPrompt
