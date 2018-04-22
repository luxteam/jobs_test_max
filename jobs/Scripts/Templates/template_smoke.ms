
function prerender test_case pass_limit script_info = (
    
    renderers.current = Radeon_ProRender()
    renderers.current.passLimit = pass_limit
    if ({resolution_y} != 0 and {resolution_x} != 0) do (
        renderHeight = {resolution_y}
        renderWidth = {resolution_x}
    )

    rpr_render "jpg" test_case script_info
)

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


function main = (
    
    filesToRender = #(
        {scene_list}
    )
    
    for fi=1 to filesToRender.count do (
        assetsFile = "{res_path}" + "\\" + filesToRender[fi]
        loadMaxFile assetsFile quiet:true

        if (filesToRender[fi] == "default.max") then (
            prerender "MAX_SM_003" 50 "[\"Render empty scene\", \"Pass Limit: 50\"]" 
        ) else if (filesToRender[fi] == "rpr_default.max") then (

            prerender "MAX_SM_005" 50 "[\"Render empty scene with RPR parameters\", \"Pass Limit: 50\"]" 

            import_fbx()
            prerender "MAX_SM_006" 50 "[\"Import FBX\", \"Pass Limit: 50\"]" 

            import_obj()
            prerender "MAX_SM_007" 50 "[\"Import OBJ\", \"Pass Limit: 50\"]" 

            test_Uber2()
            prerender "MAX_SM_010" 50 "[\"Testing Uber material\", \"Pass Limit: 50\"]" 

            test_base_light()
            prerender "MAX_SM_011" 50 "[\"Testing base light\", \"Pass Limit: 50\"]" 

            --test_IES() 
            --prerender "MAX_SM_012" 50 "[\"Testing IES light\", \"Pass Limit: 50\"]" 

            test_Sun_Sky()
            prerender "MAX_SM_013" 50 "[\"Testing Sun and Sky System\", \"Pass Limit: 50\"]" 

            test_IBL_on()
            prerender "MAX_SM_014" 50 "[\"Testing IBL\", \"Pass Limit: 50\"]" 

            test_IBL_hdr()
            prerender "MAX_SM_015" 50 "[\"Testing IBL with hdr\", \"Pass Limit: 50\"]" 

            test_IBL_exr()
            prerender "MAX_SM_016" 50 "[\"Testing IBL with exr\", \"Pass Limit: 50\"]" 

            prerender "MAX_SM_017" 1 "[\"Iteration test\", \"Pass Limit: 1\"]" 
            prerender "MAX_SM_018" 30 "[\"Iteration test\", \"Pass Limit: 30\"]" 
            prerender "MAX_SM_019" 100 "[\"Iteration test\", \"Pass Limit: 100\"]" 
            prerender "MAX_SM_020" 500 "[\"Iteration test\", \"Pass Limit: 500\"]" 
            prerender "MAX_SM_021" 1000 "[\"Iteration test\", \"Pass Limit: 1000\"]" 


        )
    )
)

main()
resetMaxFile #noPrompt
quitMax #noPrompt
