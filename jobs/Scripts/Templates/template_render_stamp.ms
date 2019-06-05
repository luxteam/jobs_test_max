

function setRenderStamp stamp = (
    renderers.current.renderStamp = stamp
)

function main = (
    cases = caseList.get_data()
    cases = cases["cases"]
    
    for i=1 to cases.count do (
        if (cases[i]["status"] != "active") do continue
        
        caseList.setCaseStatus i "progress"

        assetFile = "{res_path}\\{package_name}\\" + cases[i]["scene_name"]
        loadMaxFile assetFile useFileUnits:true quiet:true
        image_format = "jpg"
        
        renderers.current.enableRenderStamp = true
        case cases[i]["name"] of (
            "MAX_RS_RS_002": setRenderStamp "Radeon ProRender for 3ds Max 2019 %b | CPU %c | GPU %g | Render mode %r | Render device %h'"
            "MAX_RS_RS_003": setRenderStamp "Radeon ProRender for 3ds Max 2019 %b | Computer name %i | Current date %d"
        ) 

        rpr_render image_format cases[i]["name"] cases[i]["script_info"]
        caseList.setCaseStatus i "done"
    )
)

main()
resetMaxFile #noPrompt
quitMax #noPrompt