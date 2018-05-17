
function prerender test_list = (
    
    renderers.current = Radeon_ProRender()
    renderers.current.passLimit = {pass_limit}

    if ({resolution_y} != 0 and {resolution_x} != 0) do (
        renderHeight = {resolution_y}
        renderWidth = {resolution_x}
    )

    rpr_render test_list[3] test_list[1] test_list[2]

    copyFile ("{work_dir}/Color/" + test_list[1] + ".jpg") ("{work_dir}" + "/../../../../jobs/Tests/pass.jpg")
)

function main = (
    
    list_tests = #(
        #("MAX_RS_IF_001", "[\"Image Format: avi\"]", "avi"),
        #("MAX_RS_IF_002", "[\"Image Format: bmp\"]", "bmp"),
        #("MAX_RS_IF_003", "[\"Image Format: cin\"]", "cin"),
        #("MAX_RS_IF_004", "[\"Image Format: eps\"]", "eps"),
        #("MAX_RS_IF_005", "[\"Image Format: ps\"]", "ps"),
        #("MAX_RS_IF_006", "[\"Image Format: exr\"]", "exr"),
        #("MAX_RS_IF_007", "[\"Image Format: fxr\"]", "fxr"),
        #("MAX_RS_IF_008", "[\"Image Format: hdr\"]", "hdr"),
        #("MAX_RS_IF_009", "[\"Image Format: pic\"]", "pic"),
        #("MAX_RS_IF_010", "[\"Image Format: jpg\"]", "jpg"),
        #("MAX_RS_IF_011", "[\"Image Format: jpe\"]", "jpe"),
        #("MAX_RS_IF_012", "[\"Image Format: jpeg\"]", "jpeg"),
        #("MAX_RS_IF_013", "[\"Image Format: png\"]", "png"),
        #("MAX_RS_IF_014", "[\"Image Format: mov\"]", "mov"),
        #("MAX_RS_IF_015", "[\"Image Format: rgb\"]", "rgb"),
        #("MAX_RS_IF_016", "[\"Image Format: rgba\"]", "rgba"),
        #("MAX_RS_IF_017", "[\"Image Format: sgi\"]", "sgi"),
        #("MAX_RS_IF_018", "[\"Image Format: int\"]", "int"),
        #("MAX_RS_IF_019", "[\"Image Format: inta\"]", "inta"),
        #("MAX_RS_IF_020", "[\"Image Format: bw\"]", "bw"),
        #("MAX_RS_IF_021", "[\"Image Format: rla\"]", "rla"),
        #("MAX_RS_IF_022", "[\"Image Format: rpf\"]", "rpf"),
        #("MAX_RS_IF_023", "[\"Image Format: tga\"]", "tga"),
        #("MAX_RS_IF_024", "[\"Image Format: vda\"]", "vda"),
        #("MAX_RS_IF_025", "[\"Image Format: icb\"]", "icb"),
        #("MAX_RS_IF_026", "[\"Image Format: vst\"]", "vst"),
        #("MAX_RS_IF_027", "[\"Image Format: tif\"]", "tif"),
        #("MAX_RS_IF_028", "[\"Image Format: tiff\"]", "tiff"),
        #("MAX_RS_IF_029", "[\"Image Format: dds\"]", "dds")
    )

    filesToRender = #(
        {scene_list}
    )
    
    for fi=1 to filesToRender.count do (
        assetsFile = "{res_path}" + "\\" + filesToRender[fi]
        loadMaxFile assetsFile useFileUnits:true quiet:true

        for sf=1 to list_tests.count do (
            prerender list_tests[sf]
        )

    )
)

main()
resetMaxFile #noPrompt
quitMax #noPrompt
