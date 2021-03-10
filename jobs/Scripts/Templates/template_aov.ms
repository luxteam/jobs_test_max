
function prerender test_case aov script_info = (
    
    renderers.current = Radeon_ProRender()
    re = maxOps.GetCurRenderElementMgr()
    re.removeallrenderelements()

    re.addrenderelement (aov elementname:(aov as string))

    rpr_render "jpg" test_case script_info
)


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
        re = maxOps.GetCurRenderElementMgr()
        re.removeallrenderelements()
        re.addrenderelement (REs[cases[i]["aov"]] elementname:(REs[cases[i]["aov"]] as string))
        reb = rpr_render image_format cases[i]["case"] cases[i]["script_info"]

        path2image = "{work_dir}Color\\" + cases[i]["case"] + ".jpg"
        deleteFile path2image

        reb[1].filename = path2image
        save reb[1]

        -- BmpPath = image_path = "{work_dir}Color\\" + cases[i]["case"] + "_" + (REs[cases[i]["aov"]] as string) + ".jpg"
        -- deleteFile BmpPath 


        caseList.setCaseStatus i "done"
    )
)


main()
resetMaXFile #noPrompt
quitMaX #noPrompt
