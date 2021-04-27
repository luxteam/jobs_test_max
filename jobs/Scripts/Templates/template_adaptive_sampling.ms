

function main = (
    cases = caseList.get_data()

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
        for j=1 to bi.len(params) do setProperty renderers.current params[j] cases[i]["parameters"][params[j]]

        rpr_render image_format cases[i]["case"] cases[i]["script_info"]
        caseList.setCaseStatus i "done"
    )
)


main()
resetMaxFile #noPrompt
quitMax #noPrompt
