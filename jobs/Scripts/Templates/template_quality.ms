
function prerender test_case quality script_info = (
    
    renderers.current = Radeon_ProRender()
    renderers.current.passLimit = {pass_limit}
    if ({resolution_y} != 0 and {resolution_x} != 0) do (
        renderHeight = {resolution_y}
        renderWidth = {resolution_x}
    )

    renderers.current.qualityPreset = quality

    rpr_render "jpg" test_case  script_info
)

function main = (
    
    filesToRender = #(
        {scene_list}
    )
    
    for fi=1 to filesToRender.count do (
        assetsFile = "{res_path}" + "\\" + filesToRender[fi]
        loadMaxFile assetsFile quiet:true

        prerender "MAX_RS_QP_001" 1 "[\"Quality preset: Low\"]"
        prerender "MAX_RS_QP_002" 2 "[\"Quality preset: Medium\"]"
        prerender "MAX_RS_QP_003" 3 "[\"Quality preset: High\"]"
       
    )
)

main()
resetMaxFile #noPrompt
quitMax #noPrompt
