
function prerender test_case intensity map = (
    
    renderers.current = Radeon_ProRender()
    renderers.current.passLimit = {pass_limit}

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

    rpr_render "jpg" test_case
)

function main = (
    
    filesToRender = #(
        {scene_list}
    )
    
    for fi=1 to filesToRender.count do (
        assetsFile = "{res_path}" + "\\" + filesToRender[fi]
        loadMaxFile assetsFile quiet:true

        prerender "MAX_RS_IBL_001" 0 "color"
        prerender "MAX_RS_IBL_002" 1 "color"
        prerender "MAX_RS_IBL_003" 2 "color"
        prerender "MAX_RS_IBL_004" 3 "color"
        prerender "MAX_RS_IBL_005" 5 "color"
        prerender "MAX_RS_IBL_006" 7 "color"
        prerender "MAX_RS_IBL_007" 10 "color"

        prerender "MAX_RS_IBL_008" 0 "hdr"
        prerender "MAX_RS_IBL_009" 1 "hdr"
        prerender "MAX_RS_IBL_010" 2 "hdr"
        prerender "MAX_RS_IBL_011" 3 "hdr"
        prerender "MAX_RS_IBL_012" 5 "hdr"
        prerender "MAX_RS_IBL_013" 7 "hdr"
        prerender "MAX_RS_IBL_014" 10 "hdr"

        prerender "MAX_RS_IBL_015" 0 "exr"
        prerender "MAX_RS_IBL_016" 1 "exr"
        prerender "MAX_RS_IBL_017" 2 "exr"
        prerender "MAX_RS_IBL_018" 3 "exr"
        prerender "MAX_RS_IBL_019" 5 "exr"
        prerender "MAX_RS_IBL_020" 7 "exr"
        prerender "MAX_RS_IBL_021" 10 "exr"


       
    )
)

main()
resetMaxFile #noPrompt
quitMax #noPrompt
