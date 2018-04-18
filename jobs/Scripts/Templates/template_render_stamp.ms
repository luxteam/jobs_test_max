
function prerender test_case render_stamp = (
    
    renderers.current = Radeon_ProRender()
    renderers.current.passLimit = {pass_limit}
    renderHeight = {resolution_y}
    renderWidth = {resolution_x}

    renderers.current.enableRenderStamp = True
    renderers.current.renderStamp = render_stamp

    rpr_render "jpg" test_case
)

function main = (
    
    filesToRender = #(
        {scene_list}
    )
    
    for fi=1 to filesToRender.count do (
        assetsFile = "{res_path}" + "\\" + filesToRender[fi]
        loadMaxFile assetsFile quiet:true

        prerender "MAX_RS_RS_001" "Radeon ProRender for 3Ds Max %b | %h | Time: %pt | Passes: %pp | Objects: %so | Lights: %sl"
        prerender "MAX_RS_RS_002" "Radeon ProRender for 3Ds Max %b | CPU %c | GPU %g | Render mode %r | Render device %h"
        prerender "MAX_RS_RS_003" "Radeon ProRender for 3Ds Max %b | Computer name %i | Current date %d"
       
    )
)

main()
resetMaxFile #noPrompt
quitMax #noPrompt