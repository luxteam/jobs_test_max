
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

        prerender "MAX_RS_PS_001" 100
        prerender "MAX_RS_PS_002" 500
        prerender "MAX_RS_PS_003" 1000
        prerender "MAX_RS_PS_004" 5000
        prerender "MAX_RS_PS_005" 10000
       
    )
)

main()
resetMaxFile #noPrompt
quitMax #noPrompt