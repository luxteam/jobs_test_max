

function setImageFilter type = (
    case type of (
        "Box": t = 1
        "Triangle": t = 2 
        "Gaussian": t = 3
        "Mitchell": t = 4
        "Lanczos": t = 5
        "Blackmanharris": t = 6
    )
    renderers.current.imageFilter = t

)


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
        renderers.current.timeLimit=0

        setImageFilter cases[i]["type"]
        renderers.current.imageFilterSize = cases[i]["size"] 

        rpr_render image_format cases[i]["name"] cases[i]["script_info"]

        caseList.setCaseStatus i "done"
    )
)

main()
resetMaxFile #noPrompt
quitMax #noPrompt
