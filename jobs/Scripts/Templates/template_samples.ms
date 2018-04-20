
function prerender test_case pass_limit script_info = (
    
    renderers.current = Radeon_ProRender()
    renderers.current.passLimit = pass_limit
    if ({resolution_y} != 0 and {resolution_x} != 0) do (
        renderHeight = {resolution_y}
        renderWidth = {resolution_x}
    )
    
    rpr_render "jpg" test_case  script_info
)

function main = (
    
    filesToRender = #(
        {scene_list}
    )
    
    for fi=1 to filesToRender.count do (
        assetsFile = "{res_path}" + "\\" + filesToRender[fi]
        loadMaxFile assetsFile quiet:true

        if (filesToRender[fi] == "RPR Diffuse Material Wood.max") do (
            prerender "MAX_RS_PS_001" 1 "[\"Iterations: 1\"]"
            prerender "MAX_RS_PS_002" 100 "[\"Iterations: 100\"]"
            prerender "MAX_RS_PS_003" 500 "[\"Iterations: 500\"]"
            prerender "MAX_RS_PS_004" 1000 "[\"Iterations: 1000\"]"
            prerender "MAX_RS_PS_005" 5000 "[\"Iterations: 5000\"]"
            prerender "MAX_RS_PS_006" 10000 "[\"Iterations: 10000\"]"
        ) 
       
    )
)

main()
resetMaxFile #noPrompt
quitMax #noPrompt