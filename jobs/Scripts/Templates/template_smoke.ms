function prerender test_case pass_limit script_info image_format = (
    renderers.current = Radeon_ProRender()
    renderers.current.passLimit = pass_limit

    if ({resolution_y} != 0 and {resolution_x} != 0) do (
        renderHeight = {resolution_y}
        renderWidth = {resolution_x}
    )

    rpr_render image_format test_case script_info
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
    hdr_path = "{res_path}" + "\\res\\Hdri\\startup.hdr"
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


function main = (
    filesToRender = #({scene_list})
    cases = caseList.get_data()
    cases = cases["cases"]
    
    for i=1 to cases.count do (
        if (findItem filesToRender cases[i]["scene_name"] == 0) or (cases[i]["status"] != "active") do continue 
        
        caseList.setCaseStatus i "progress"

        assetFile = "{res_path}\\" + cases[i]["scene_name"]
        loadMaxFile assetFile useFileUnits:true quiet:true
        image_format = "jpg"
        
        -- TODO: MAX_SM_016
        -- WARNING: MAX_013 & MAX_015 - created scens tope_mapping.max and quality_preset_medium.max

        status = true
        case cases[i]["name"] of (
            "MAX_SM_003": (
                status = (importfile ("{res_path}\\res\\park_bench1.fbx") #noPrompt using:FBXIMP)
            )
            "MAX_SM_004": (
                status = (importfile ("{res_path}\\res\\example.obj") #noPrompt using:OBJIMP)
            )
            "MAX_SM_006": (
                status = test_IBL_hdr()
            )
            "MAX_SM_007": (
                status = test_IBL_exr()
            )
            "MAX_SM_008": (
                status = test_Sun_Sky()
            )
            "MAX_SM_009": (
                light = ies_light()
                light.Profile = "1.IES"   
            )
            "MAX_SM_010": (
                renderers.current.samplesMax = 1
                renderers.current.adaptiveNoiseThreshold = 0
            )
            "MAX_SM_011": (
                renderers.current.samplesMax = 100
                renderers.current.adaptiveNoiseThreshold = 0
            )
            "MAX_SM_012": (
                renderers.current.samplesMax = 500
                renderers.current.adaptiveNoiseThreshold = 0
            )
            "MAX_SM_013": (
                renderers.current.overrideTonemap = false
                renderers.current.tonemapOperator = 1
            )
            "MAX_SM_014": (
                renderers.current.enableRenderStamp = true
            )
            "MAX_SM_017": (
                renderWidth = 1280
                renderHeight = 720
            )
            "MAX_SM_018": (
                renderWidth = 1500
                renderHeight = 1125
            )
            "MAX_SM_019": (
                image_format = "png"
            )
            "MAX_SM_020": (
                image_format = "jpg"
            )
            "MAX_SM_021": (
                renderers.current.enableDenoiser = true
                renderers.current.denoiserType = 1
            )
            "MAX_SM_022": (
                renderers.current.enableDenoiser = true
                renderers.current.denoiserType = 2
            )
            "MAX_SM_023": (
                renderers.current.enableDenoiser = true
                renderers.current.denoiserType = 3
            )
            "MAX_SM_024": (
                light = Free_Light()
                light.pos = [500, 1730, 40]
                light.intensity = 60
                delete $RPREnv001
                renderers.current.samplesMax = 500
                renderers.current.adaptiveNoiseThreshold = 0
            )


            default: print "simple test case"
        )

        if cases[i]["pass_limit"] == 0 then (
            withoutRender cases[i]["name"] cases[i]["script_info"] status
        ) else (
            prerender cases[i]["name"] cases[i]["pass_limit"] cases[i]["script_info"] image_format
        )

        caseList.setCaseStatus i "done"
    )

)

main()

resetMaxFile #noPrompt
quitMax #noPrompt
