

function main = (
    cases = caseList.get_data()
    cases = cases["cases"]
    
    for i=1 to bi.len(cases) do (
        if (cases[i]["status"] != "active") do continue
        caseList.setCaseStatus i "progress"
        
        assetFile = "{res_path}\\{package_name}\\" + cases[i]["scene_name"]
        loadMaxFile assetFile useFileUnits:true quiet:true
        image_format = "jpg"

        renderers.current = Radeon_ProRender()
        if ({resolution_y} != 0 and {resolution_x} != 0) do (
            renderHeight = {resolution_y}
            renderWidth = {resolution_x}
        )
        renderers.current.samplesMax = {pass_limit}
        renderers.current.iterations = {SPU}
        renderers.current.adaptiveNoiseThreshold = {threshold}
        params = bi.list(cases[i]["parameters"].keys())

        

        l = getObjectFromName cases[i]["parameters"]["unhide"]
        unhide l

        for j=1 to bi.len(params) do (
            if params[j] == "unhide" do continue

            val = cases[i]["parameters"][params[j]]

            if params[j] == "type" do (
                val = val as name
            )

            if params[j] == "color" do val = getColor val["r"] val["g"] val["b"]

            l = getObjectFromName cases[i]["parameters"]["unhide"]
            setProperty l params[j] val
        )

        rpr_render image_format cases[i]["case"] cases[i]["script_info"]

        caseList.setCaseStatus i "done"
    )
)


main()
resetMaxFile #noPrompt
quitMax #noPrompt