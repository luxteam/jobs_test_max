
function prerender test_case image_format = (
    
    renderers.current = Radeon_ProRender()
    renderers.current.passLimit = {pass_limit}
    renderHeight = {resolution_y}
    renderWidth = {resolution_x}

    rpr_render image_format test_case
)

function main = (
    
    filesToRender = #(
        {scene_list}
    )
    
    for fi=1 to filesToRender.count do (
        assetsFile = "{res_path}" + "\\" + filesToRender[fi]
        loadMaxFile assetsFile quiet:true

        prerender "MAX_RS_IF_001" "avi"
        prerender "MAX_RS_IF_002" "bmp"
        prerender "MAX_RS_IF_003" "cin"
        prerender "MAX_RS_IF_004" "eps"
        prerender "MAX_RS_IF_005" "ps"
        prerender "MAX_RS_IF_006" "exr"
        prerender "MAX_RS_IF_007" "fxr"
        prerender "MAX_RS_IF_008" "hdr"
        prerender "MAX_RS_IF_009" "pic"
        prerender "MAX_RS_IF_010" "jpg"
        prerender "MAX_RS_IF_011" "jpe"
        prerender "MAX_RS_IF_012" "jpeg"
        prerender "MAX_RS_IF_013" "png"
        --prerender "MAX_RS_IF_014" "mov"
        prerender "MAX_RS_IF_015" "rgb"
        prerender "MAX_RS_IF_016" "rgba"
        prerender "MAX_RS_IF_017" "sgi"
        prerender "MAX_RS_IF_018" "int"
        prerender "MAX_RS_IF_019" "inta"
        prerender "MAX_RS_IF_020" "bw"
        prerender "MAX_RS_IF_021" "rla"
        prerender "MAX_RS_IF_022" "rpf"
        prerender "MAX_RS_IF_023" "tga"
        prerender "MAX_RS_IF_024" "vda"
        prerender "MAX_RS_IF_025" "icb"
        prerender "MAX_RS_IF_026" "vst"
        prerender "MAX_RS_IF_027" "tif"
        prerender "MAX_RS_IF_028" "tiff"
        prerender "MAX_RS_IF_029" "dds"

    )
)

main()
resetMaxFile #noPrompt
quitMax #noPrompt
