
function prerender test_case image_format script_info = (
    
    renderers.current = Radeon_ProRender()
    renderers.current.passLimit = {pass_limit}
    if ({resolution_y} != 0 and {resolution_x} != 0) do (
        renderHeight = {resolution_y}
        renderWidth = {resolution_x}
    )

    rpr_render image_format test_case script_info
)

function main = (
    
    filesToRender = #(
        {scene_list}
    )
    
    for fi=1 to filesToRender.count do (
        assetsFile = "{res_path}" + "\\" + filesToRender[fi]
        loadMaxFile assetsFile useFileUnits:true quiet:true

        prerender "MAX_RS_IF_001" "avi" "[\"Image Format: avi\"]"
        prerender "MAX_RS_IF_002" "bmp" "[\"Image Format: bmp\"]"
        prerender "MAX_RS_IF_003" "cin" "[\"Image Format: cin\"]"
        prerender "MAX_RS_IF_004" "eps" "[\"Image Format: eps\"]"
        prerender "MAX_RS_IF_005" "ps" "[\"Image Format: ps\"]"
        prerender "MAX_RS_IF_006" "exr" "[\"Image Format: exr\"]"
        prerender "MAX_RS_IF_007" "fxr" "[\"Image Format: fxr\"]"
        prerender "MAX_RS_IF_008" "hdr" "[\"Image Format: hdr\"]"
        prerender "MAX_RS_IF_009" "pic" "[\"Image Format: pic\"]"
        prerender "MAX_RS_IF_010" "jpg" "[\"Image Format: jpg\"]"
        prerender "MAX_RS_IF_011" "jpe" "[\"Image Format: jpe\"]"
        prerender "MAX_RS_IF_012" "jpeg" "[\"Image Format: jpeg\"]"
        prerender "MAX_RS_IF_013" "png" "[\"Image Format: png\"]"
        --prerender "MAX_RS_IF_014" "mov" "[\"Image Format: mov\"]"
        prerender "MAX_RS_IF_015" "rgb" "[\"Image Format: rgb\"]"
        prerender "MAX_RS_IF_016" "rgba" "[\"Image Format: rgba\"]"
        prerender "MAX_RS_IF_017" "sgi" "[\"Image Format: sgi\"]"
        prerender "MAX_RS_IF_018" "int" "[\"Image Format: int\"]"
        prerender "MAX_RS_IF_019" "inta" "[\"Image Format: inta\"]"
        prerender "MAX_RS_IF_020" "bw" "[\"Image Format: bw\"]"
        prerender "MAX_RS_IF_021" "rla" "[\"Image Format: rla\"]"
        prerender "MAX_RS_IF_022" "rpf" "[\"Image Format: rpf\"]"
        prerender "MAX_RS_IF_023" "tga" "[\"Image Format: tga\"]"
        prerender "MAX_RS_IF_024" "vda" "[\"Image Format: vda\"]"
        prerender "MAX_RS_IF_025" "icb" "[\"Image Format: icb\"]"
        prerender "MAX_RS_IF_026" "vst" "[\"Image Format: vst\"]"
        prerender "MAX_RS_IF_027" "tif" "[\"Image Format: tif\"]"
        prerender "MAX_RS_IF_028" "tiff" "[\"Image Format: tiff\"]"
        --prerender "MAX_RS_IF_029" "dds" "[\"Image Format: dds\"]"

    )
)

main()
resetMaxFile #noPrompt
quitMax #noPrompt
