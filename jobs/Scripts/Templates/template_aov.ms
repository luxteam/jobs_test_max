
function prerender test_case aov script_info = (
    
    renderers.current = Radeon_ProRender()
    re = maxOps.GetCurRenderElementMgr()
    re.removeallrenderelements()

    re.addrenderelement (aov elementname:(aov as string))

    rpr_render "jpg" test_case script_info
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

        renderers.current = Radeon_ProRender()
        re = maxOps.GetCurRenderElementMgr()
        re.removeallrenderelements()
        re.addrenderelement (REs[cases[i]["aov"]] elementname:(REs[cases[i]["aov"]] as string))
        reb = rpr_render image_format cases[i]["name"] cases[i]["script_info"]

        path2image = "{work_dir}Color\\" + cases[i]["name"] + ".jpg"
        deleteFile path2image

        reb[1].filename = path2image
        save reb[1]

        -- BmpPath = image_path = "{work_dir}Color\\" + cases[i]["name"] + "_" + (REs[cases[i]["aov"]] as string) + ".jpg"
        -- deleteFile BmpPath 


        caseList.setCaseStatus i "done"
    )
)


main()
resetMaXFile #noPrompt
quitMaX #noPrompt
