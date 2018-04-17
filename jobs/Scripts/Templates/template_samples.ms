
function prerender test_case pass_limit = (
    
    renderers.current = Radeon_ProRender()
    renderers.current.passLimit = pass_limit
    
    rpr_render "jpg" test_case
)

function main = (
    
    filesToRender = #(
        {scene_list}
    )
    
    for fi=1 to filesToRender.count do (
        assetsFile = "{res_path}" + "\\" + filesToRender[fi]
        loadMaxFile assetsFile quiet:true

        if (filesToRender[fi] == "RPR Diffuse Material Wood.max") do (
            prerender "MAX_RS_PS_001" 1
            prerender "MAX_RS_PS_002" 100
            prerender "MAX_RS_PS_003" 500
            prerender "MAX_RS_PS_004" 1000
            prerender "MAX_RS_PS_005" 5000
            prerender "MAX_RS_PS_006" 10000
        ) 
       
    )
)

main()
resetMaxFile #noPrompt
quitMax #noPrompt