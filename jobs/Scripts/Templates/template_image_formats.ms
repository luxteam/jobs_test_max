

function main = (
    cases = caseList.get_data()
    cases = cases["cases"]

    for i=1 to cases.count do (
        if (cases[i]["status"] != "active") do continue
        
        caseList.setCaseStatus i "progress"
        
        assetFile = "{res_path}\\{package_name}\\" + cases[i]["scene_name"]
        loadMaxFile assetFile useFileUnits:true quiet:true
        -- render settings
        rpr_render cases[i]["format"] cases[i]["name"] cases[i]["script_info"]

        if cases[i]["format"] != "jpg" do (
            path = "{work_dir}" + "Color\\" + cases[i]["name"] + ".jpg"
            deleteFile path
        )

        caseList.setCaseStatus i "done"
    )
)

main()
resetMaxFile #noPrompt
quitMax #noPrompt
