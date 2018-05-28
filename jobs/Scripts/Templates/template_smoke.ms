
function import_fbx = (
    importfile ("{res_path}" + "\\res\\park_bench1.fbx") #noPrompt using:FBXIMP
)

function import_obj = (
    select $Default/.../*
    delete selection
    importfile ("{res_path}" + "\\res\\example.obj") #noPrompt using:OBJIMP
)

function test_Uber2 = (
    meditMaterials[1] = RPR_Uber_Material()
    meditMaterials[1].diffuseColor = color 163 178 1
    p0 = getnodebyname "default" exact:true
    if (p0 == undefined) do (p0 = getnodebyname "shader_ball" exact:true)
    p0.material = meditMaterials[1]
)

function test_Sun_Sky = (
    renderers.current.backgroundOverride = True
    renderers.current.backgroundType = 1
)

function test_IBL_on = (
    renderers.current.backgroundOverride = True
    renderers.current.backgroundType = 0
)

function test_IBL_hdr = (
    renderers.current.backgroundOverride = True
    renderers.current.backgroundType = 0
    renderers.current.useBackgroundMap = True
    hdr_path = "{res_path}" + "\\res\\Hdri\\Tropical_Beach_3k.hdr"
    hdr = bitmaptexture filename:hdr_path
    renderers.current.backgroundMap = hdr
)

function test_IBL_exr = (
    renderers.current.backgroundOverride = True
    renderers.current.backgroundType = 0
    renderers.current.useBackgroundMap = True
    exr_path = "{res_path}" + "\\res\\Hdri\\over_the_clouds.exr"
    exr = bitmaptexture filename:exr_path
    renderers.current.backgroundMap = exr
)

function test_base_light = (
    myLight = Omnilight()
    myLight.pos = [0,0,10]
)

function test_IES = (
    select $Omni001
    delete selection
    ies_light = RPRIESLight()
    ies_light.pos = [0,0,10]
    ies_light.profile = "2.ies"
)

function prerender test_list = (
    
    renderers.current = Radeon_ProRender()
    renderers.current.passLimit = test_list[3]

    if ({resolution_y} != 0 and {resolution_x} != 0) do (
        renderHeight = {resolution_y}
        renderWidth = {resolution_x}
    )

    case test_list[1] of (

        "MAX_SM_006": import_fbx()
        "MAX_SM_007": import_obj()
        "MAX_SM_010": test_Uber2()
        "MAX_SM_011": test_base_light()
        --"MAX_SM_012": test_IES()
        "MAX_SM_013": test_Sun_Sky()
        "MAX_SM_014": test_IBL_on()
        "MAX_SM_015": test_IBL_hdr()
        "MAX_SM_016": test_IBL_exr()
    )

    rpr_render "jpg" test_list[1] test_list[2]

    if (test_list[1] == "MAX_SM_001" or test_list[1] == "MAX_SM_002" or test_list[1] == "MAX_SM_004" or test_list[1] == "MAX_SM_008" or test_list[1] == "MAX_SM_009") do (
        copyFile ("{work_dir}" + "\\..\\..\\..\\..\\jobs\\Tests\\pass.jpg") ("{work_dir}\\Color\\" + test_list[1] + ".jpg") 
    )

)

function main = (

    sf = {start_from}

    list_tests = #(
        #("MAX_SM_001", "[\"Install RPR\"]", 1),
        #("MAX_SM_002", "[\"Open empty scene\"]", 1),
        #("MAX_SM_003", "[\"Render empty scene\", \"Pass Limit: 50\"]", 50),
        #("MAX_SM_004", "[\"Open rpr empty scene\"]", 1),
        #("MAX_SM_005", "[\"Render empty scene with RPR parameters\", \"Pass Limit: 50\"]", 50),
        #("MAX_SM_006", "[\"Import FBX\", \"Pass Limit: 50\"]", 50),
        #("MAX_SM_007", "[\"Import OBJ\", \"Pass Limit: 50\"]", 50),
        #("MAX_SM_008", "[\"Open Mat edit\"]", 1),
        #("MAX_SM_009", "[\"Create an Uber material\"]", 1),
        #("MAX_SM_010", "[\"Assign Uber material\", \"Pass Limit: 50\"]", 50),
        #("MAX_SM_011", "[\"Testing base light\", \"Pass Limit: 50\"]", 50),
        #("MAX_SM_012", "[\"Testing IES light\", \"Pass Limit: 50\"]", 50),
        #("MAX_SM_013", "[\"Testing Sun and Sky System\", \"Pass Limit: 50\"]", 50),
        #("MAX_SM_014", "[\"Testing IBL\", \"Pass Limit: 50\"]", 50),
        #("MAX_SM_015", "[\"Testing IBL with hdr\", \"Pass Limit: 50\"]", 50),
        #("MAX_SM_016", "[\"Testing IBL with exr\", \"Pass Limit: 50\"]", 50),
        #("MAX_SM_017", "[\"Pass Limit test\", \"Pass Limit: 1\"]", 1),
        #("MAX_SM_018", "[\"Pass Limit test\", \"Pass Limit: 30\"]", 30),
        #("MAX_SM_019", "[\"Pass Limit test\", \"Pass Limit: 100\"]", 100),
        #("MAX_SM_020", "[\"Pass Limit test\", \"Pass Limit: 500\"]", 500),
        #("MAX_SM_021", "[\"Pass Limit test\", \"Pass Limit: 1000\"]", 1000)
    )

    filesToRender = #(
        {scene_list}
    )
    
    for fi=1 to filesToRender.count do (
        assetsFile = "{res_path}" + "\\" + filesToRender[fi]
        loadMaxFile assetsFile useFileUnits:true quiet:true

        if (sf != 1) do (
            create_failed_report list_tests[sf][1] list_tests[sf][2] "failed"
            sf += 1
            for i=sf to list_tests.count do (
                create_failed_report list_tests[i][1] list_tests[i][2] "skipped"
            )
            resetMaxFile #noPrompt
            quitMax #noPrompt
        )

        if (filesToRender[fi] == "default.max") then (

            for i=1 to 3 do (
                prerender list_tests[i]
            )

        ) else if (filesToRender[fi] == "rpr_default.max") then (

            for i=4 to list_tests.count do (
                prerender list_tests[i]
            )

        )
    )
)

main()
resetMaxFile #noPrompt
quitMax #noPrompt
