

function main = (
    cases = caseList.get_data()
    cases = cases["cases"]

    for i=1 to cases.count do (
        if (cases[i]["status"] != "active") do continue
        
        caseList.setCaseStatus i "progress"
        
        assetFile = "{res_path}\\{package_name}\\" + cases[i]["scene_name"]
        loadMaxFile assetFile useFileUnits:true quiet:true
        image_format = "jpg"

        -- render settings
        renderers.current = Radeon_ProRender()
        rendTimeType = 4
        rendPickupFrames = cases[i]["frame_number"]

        renderers.current.enableMotionblur = true
        renderers.current.motionblurScale = cases[i]["scale"]

        -- import .mat

        -- start production render
        rpr_render image_format cases[i]["name"] cases[i]["script_info"]

        caseList.setCaseStatus i "done"
    )
)

main()
resetMaxFile #noPrompt
quitMax #noPrompt
