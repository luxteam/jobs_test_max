function prerender test_case pass_limit script_info = (
    -- change status in case
    -- python.Execute "read_json('rem.json', 'Smoke')"

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
--     select $Default/.../*
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


function switchStatus test_case status = (
    execute_string = StringStream ""
    format "switch_case_status(\"%\", \"%\")" test_case status to:execute_string
    python.Execute (execute_string as String)
)


-- function main = (
    
--     for caseToRender in tmp do (
        
--         if (findItem filesToRender caseToRender[#scene_name]) == 0  or (caseToRender[#status] != "active") do continue

--         asset_file = "{res_path}\\" + caseToRender[#scene_name]
--         loadMaxFile asset_file useFileUnits:true quiet:true

--         switchStatus caseToRender[#name] "progress"
        
--         if caseToRender[#name] == "MAX_SM_003" do (
--             import_fbx()
--         )
        
--         if caseToRender[#name] == "MAX_SM_004" do (
--             import_obj()
--         )

--         prerender caseToRender[#name] caseToRender[#pass_limit] caseToRender[#script_info]

--         switchStatus caseToRender[#name] "done"
        
--         )
--     )


function main = (
    filesToRender = #({scene_list})
    cases = caseList.get()
    cases = cases["cases"]
    
    for i=1 to cases.count do (
        if (findItem filesToRender cases[i]["scene_name"] == 0) or (cases[i]["status"] != "active") do continue 
        
        caseList.setCaseStatus i "progress"

        assetFile = "{res_path}\\" + cases[i]["scene_name"]
        loadMaxFile assetFile useFileUnits:true quiet:true

        case cases[i]["name"] of (
            "MAX_SM_003": (
                import_fbx()
            )
            "MAX_SM_004": (
                import_obj()
            )
            default: print "simple test case"
        )

        prerender cases[i]["name"] cases[i]["pass_limit"] cases[i]["script_info"]

        caseList.setCaseStatus i "done"
    )

)
--     else if (filesToRender[fi] == "rpr_default.max") then (

--             prerender "MAX_SM_005" 50 "[\"Render empty scene with RPR parameters\", \"Pass Limit: 50\"]" 
--             import_fbx()
--             prerender "MAX_SM_006" 50 "[\"Import FBX\", \"Pass Limit: 50\"]" 

--             import_obj()
--             prerender "MAX_SM_007" 50 "[\"Import OBJ\", \"Pass Limit: 50\"]" 

--             test_Uber2()
--             prerender "MAX_SM_010" 50 "[\"Testing Uber material\", \"Pass Limit: 50\"]" 

--             test_base_light()
--             prerender "MAX_SM_011" 50 "[\"Testing base light\", \"Pass Limit: 50\"]" 

--             test_IES() 
--             prerender "MAX_SM_012" 50 "[\"Testing IES light\", \"Pass Limit: 50\"]" 

--             test_Sun_Sky()
--             prerender "MAX_SM_013" 50 "[\"Testing Sun and Sky System\", \"Pass Limit: 50\"]" 

--             test_IBL_on()
--             prerender "MAX_SM_014" 50 "[\"Testing IBL\", \"Pass Limit: 50\"]" 

--             test_IBL_hdr()
--             prerender "MAX_SM_015" 50 "[\"Testing IBL with hdr\", \"Pass Limit: 50\"]" 

--             test_IBL_exr()
--             prerender "MAX_SM_016" 50 "[\"Testing IBL with exr\", \"Pass Limit: 50\"]" 

--             prerender "MAX_SM_017" 1 "[\"Iteration test\", \"Pass Limit: 1\"]" 

--             prerender "MAX_SM_018" 30 "[\"Iteration test\", \"Pass Limit: 30\"]" 
--             prerender "MAX_SM_019" 100 "[\"Iteration test\", \"Pass Limit: 100\"]" 
--             prerender "MAX_SM_020" 500 "[\"Iteration test\", \"Pass Limit: 500\"]" 
--             prerender "MAX_SM_021" 1000 "[\"Iteration test\", \"Pass Limit: 1000\"]" 


--         ) 
--     )
-- )


main()

resetMaxFile #noPrompt
quitMax #noPrompt
