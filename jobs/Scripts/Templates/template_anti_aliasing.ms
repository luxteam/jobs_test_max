
function prerender test_case filter samples = (
    
    renderers.current = Radeon_ProRender()
    renderers.current.passLimit = {pass_limit}

    renderHeight = {resolution_y}
    renderWidth = {resolution_x}
    
    renderers.current.imageFilter = filter
    renderers.current.aaSampleCount = samples

    rpr_render "jpg" test_case
)

function main = (
    
    filesToRender = #(
        {scene_list}
    )
    
    for fi=1 to filesToRender.count do (
        assetsFile = "{res_path}" + "\\" + filesToRender[fi]
        loadMaxFile assetsFile quiet:true

        prerender "MAX_RS_AA_001" 1 1
        prerender "MAX_RS_AA_002" 1 5
        prerender "MAX_RS_AA_003" 1 15
        prerender "MAX_RS_AA_004" 1 23
        prerender "MAX_RS_AA_005" 1 32

        prerender "MAX_RS_AA_006" 2 1
        prerender "MAX_RS_AA_007" 2 5
        prerender "MAX_RS_AA_008" 2 15
        prerender "MAX_RS_AA_009" 2 23
        prerender "MAX_RS_AA_010" 2 32

        prerender "MAX_RS_AA_011" 3 1
        prerender "MAX_RS_AA_012" 3 5
        prerender "MAX_RS_AA_013" 3 15
        prerender "MAX_RS_AA_014" 3 23
        prerender "MAX_RS_AA_015" 3 32

        prerender "MAX_RS_AA_016" 4 1
        prerender "MAX_RS_AA_017" 4 5
        prerender "MAX_RS_AA_018" 4 15
        prerender "MAX_RS_AA_019" 4 23
        prerender "MAX_RS_AA_020" 4 32

        prerender "MAX_RS_AA_021" 5 1
        prerender "MAX_RS_AA_022" 5 5
        prerender "MAX_RS_AA_023" 5 15
        prerender "MAX_RS_AA_024" 5 23
        prerender "MAX_RS_AA_025" 5 32

        prerender "MAX_RS_AA_026" 6 1
        prerender "MAX_RS_AA_027" 6 5
        prerender "MAX_RS_AA_028" 6 15
        prerender "MAX_RS_AA_029" 6 23
        prerender "MAX_RS_AA_030" 6 32
       
    )
)

main()
resetMaxFile #noPrompt
quitMax #noPrompt
