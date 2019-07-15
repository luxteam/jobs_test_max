

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
        params = cases[i]["parameters"].keys()
        l = getLightFromName RPR_Physical_Light_NAME

        for j=1 to params.count do (
        	setProperty l params[j] cases[i]["parameters"][params[j]]
        )

        rpr_render image_format cases[i]["name"] cases[i]["script_info"]

        caseList.setCaseStatus i "done"
    )
)

-- Exception: 
-- Known system exception 
-- ######################################################################## 
-- Address: 0xdc8fa2a3; nCode: 0x00000000C0000005 
-- Desc: EXCEPTION_ACCESS_VIOLATION The thread tried to read from or write to a virtual address for which it does not have the appropriate access. 
--       Read of Address: 0x0000000000000000 
-- ########################################################################

main()
resetMaxFile #noPrompt
quitMax #noPrompt
