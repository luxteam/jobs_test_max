

FBX_ASSET_PATH = "{res_path}\\{package_name}\\sourceimages\\smoke_03.fbx"
OBJ_ASSET_PATH = "{res_path}\\{package_name}\\sourceimages\\smoke_04.obj"
HDR_ASSET_PATH = "{res_path}\\{package_name}\\sourceimages\\startup.hdr"
EXR_ASSET_PATH = "{res_path}\\{package_name}\\sourceimages\\over_the_clouds.exr"
MATLIB_PATH = "C:\\ProgramData\\RadeonProRender\\MaterialLibrary\\Max\\RPR_CarPaints.mat"


function switchStatus test_case status = (
    execute_string = StringStream ""
    format "switch_case_status(\"%\", \"%\")" test_case status to:execute_string
    python.Execute (execute_string as String)
)


function main = (
    cases = caseList.get_data()
    cases = cases["cases"]
    
    -- MAX_SM_001 and MAX_002
    try (
        renderers.current = Radeon_ProRender()
        status_init = true
    ) catch (
        getCurrentException()
        status_init = false
    )

    withoutRender "MAX_SM_001" (bi.List(#("Installing with default settings"))) true
    withoutRender "MAX_SM_002" (bi.List(#("Change renderer from default to RPR"))) status_init
    
    if not status_init do return false

    for i=1 to cases.count do (
        if (cases[i]["status"] != "active") do continue 
       
        caseList.setCaseStatus i "progress"

        assetFile = "{res_path}\\{package_name}\\" + cases[i]["scene_name"]
        loadMaxFile assetFile useFileUnits:true quiet:true
        image_format = "jpg"

        if ({resolution_y} != 0 and {resolution_x} != 0) do (
            renderHeight = {resolution_y}
            renderWidth = {resolution_x}
        )



        case cases[i]["name"] of (
            "MAX_SM_003": (
                renderers.current = Radeon_ProRender()
                status = (importfile (FBX_ASSET_PATH) #noPrompt using:FBXIMP)
            )
            "MAX_SM_004": (
                renderers.current = Radeon_ProRender()
                status = (importfile (OBJ_ASSET_PATH) #noPrompt using:OBJIMP)
            )
            "MAX_SM_006": (
                hdr = bitmaptexture filename:HDR_ASSET_PATH
                renderers.current.backgroundMap = hdr
            )
            "MAX_SM_007": (
                exr = bitmaptexture filename:EXR_ASSET_PATH
                renderers.current.backgroundMap = exr
            )
            "MAX_SM_008": (
                renderers.current.backgroundOverride = True
                renderers.current.backgroundType = 1
            )
            "MAX_SM_009": (
                light = ies_light()
                light.Profile = "1.IES"  
            )
            "MAX_SM_010": (
                renderers.current.adaptiveNoiseThreshold = 0
            )
            "MAX_SM_011": (
                renderers.current.adaptiveNoiseThreshold = 0
            )
            "MAX_SM_012": (
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
                l = Free_Light()
                l.pos = [500, -1730, 40]
                l.intensity = 60
                delete $RPREnv001
                renderers.current.adaptiveNoiseThreshold = 0
            )
            "MAX_SM_025": (
                l = Physical_Light()
                l.pos = [500, -1730, 40]
                l.UnitsType = 1
                delete $RPREnv001
                renderers.current.adaptiveNoiseThreshold = 0
            )
            "MAX_SM_026": (
                lib = loadTempMaterialLibrary MATLIB_PATH
                cpm = lib.Car_Paint_Metallic____RPR_Uber_Material
                for obj in Geometry do (
                    if obj.name != "Cove_UntitledFBXASC046013" do (
                        obj.material = cpm
                    )
                )
            )
            "MAX_SM_027": (
                for obj in Geometry do (
                    if obj.name != "Cove_UntitledFBXASC046013" do (
                        obj.material = RPR_PBR_Material()
                        obj.material.BaseColor = [26, 67, 128]
                        obj.material.MetalnessMul = 0.1
                    )
                )
            )
            "MAX_SM_028": (
                for obj in Geometry do (
                    if obj.name != "Cove_UntitledFBXASC046013" do (
                        obj.material = RPR_Uber_Material()
                        obj.material.DiffuseColor = [255, 128, 128]
                        obj.material.ReflectionEnable = true
                    )
                )
            )
            -- MAX_SM_29 -> instances.max
            "MAX_SM_030": (
                l1 = Physical_Light()
                l1.pos = [500, -1780, 80]
                l1.UnitsType = 1

                l2 = Physical_Light()
                l2.pos = [500, -1730, 40]
                l2.UnitsType = 1

                l3 = Physical_Light()
                l3.pos = [500, -1710, 10]
                l3.UnitsType = 1

                delete $RPREnv001
            )

            "MAX_SM_031": (
                obj = $Cove_UntitledFBXASC046013
                obj.material = RPR_Shadow_Catcher_Material()
            )
            "MAX_SM_032": (
                for obj in Geometry do (
                    if obj.name != "Cove_UntitledFBXASC046013" do (
                        obj.material = RPR_Uber_Material()
                        obj.material.DiffuseColor = [255, 128, 128]
                        obj.material.SssEnable = true
                    )
                )
            )
            -- MAX_SM_34 -> anti-aliasing.max
            "MAX_SM_035": (
                sliderTime = 1f
            )

            default: print "simple test case"
        )
        
        -- -1 = take maxSamples in scene
        --  0 = case without rendering 
        --  N = with rendering

        if cases[i]["pass_limit"] == 0 then (
            withoutRender cases[i]["name"] cases[i]["script_info"] status
        ) else if cases[i]["pass_limit"] == -1 then (
            rpr_render image_format cases[i]["name"] cases[i]["script_info"]
        ) else (
            renderers.current.samplesMax = cases[i]["pass_limit"]
            rpr_render image_format cases[i]["name"] cases[i]["script_info"]
        )

        -- png ext.
        if image_format == "png" do (
            if (existFile ("{work_dir}Color\\" + cases[i]["name"] + ".png")) do (
                -- delete <test_case>.jpg like filed
                path_case_img = "{work_dir}Color\\" + cases[i]["name"] + ".jpg"
                deleteFile path_case_img
                
                -- save <test_case>.jpg like passed
                path_passed_img = "{work_dir}..\\..\\..\\..\\jobs\\Tests\\pass.jpg"
                copyFile path_passed_img path_case_img
            )

        )

        caseList.setCaseStatus i "done"
    )

    return true

)

main()
resetMaxFile #noPrompt
quitMax #noPrompt
