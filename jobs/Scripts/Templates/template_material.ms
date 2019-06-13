

function main = (
    cases = caseList.get_data()
    cases = cases["cases"]

    for i=1 to cases.count do (
        if (cases[i]["status"] != "active") do continue
        
        caseList.setCaseStatus i "progress"
        
        assetFile = "{res_path}\\{package_name}\\" + cases[i]["scene_name"]
        loadMaxFile assetFile useFileUnits:true quiet:true
        image_format = "jpg"

        renderers.current = Radeon_ProRender()

        -- import .mat
        library = loadTempMaterialLibrary cases[i]["library_path"]
        m = getProperty library cases[i]["property"]
        
        -- set material on shaderball
        $Probe00.material = m
        $Probe01.material = m
        $Probe02.material = m

        -- start production render
        rpr_render image_format cases[i]["name"] cases[i]["script_info"]

        caseList.setCaseStatus i "done"
    )
)

main()
resetMaxFile #noPrompt
quitMax #noPrompt
