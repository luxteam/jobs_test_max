

function main = (
    cases = caseList.get_data()
    cases = cases["cases"]

    for i=1 to bi.len(cases) do (
        -- continue if status not equal active   
        if (cases[i]["status"] != "active") do continue
        
        -- set status progress        
        caseList.setCaseStatus i "progress"
        
        -- upload scene         
        assetFile = "{res_path}\\{package_name}\\" + cases[i]["scene_name"]
        loadMaxFile assetFile useFileUnits:true quiet:true
        
        renderers.current = Radeon_ProRender()

        -- render settings
        if ({resolution_y} != 0 and {resolution_x} != 0) do (
            renderHeight = {resolution_y}
            renderWidth = {resolution_x}
        )
        renderers.current.samplesMax = {pass_limit}
        renderers.current.iterations = {SPU}
        renderers.current.adaptiveNoiseThreshold = {threshold}
        rpr_render cases[i]["format"] cases[i]["case"] cases[i]["script_info"]
        path_case_img = "{work_dir}Color\\" + cases[i]["case"] + "." + cases[i]["format"]
        -- check existFile
        if (existFile path_case_img) do (
            -- check extention to saving
            if cases[i]["format"] != "jpg"  then (

                -- delete <test_case>.jpg like filed
                path_case_img = "{work_dir}Color\\" + cases[i]["case"] + ".jpg"
                deleteFile path_case_img
                
                -- save <test_case>.jpg like passed
                path_passed_img = "{work_dir}..\\..\\..\\..\\jobs_launcher\\common\\img\\passed.jpg"
                copyFile path_passed_img path_case_img

            )
            -- if extention equal 'jpg' then it just render image
        )
        -- if file not exist simpleRender.py alredy save fail.png for this test case

        -- set status done
        caseList.setCaseStatus i "done"
    )
)

main()
resetMaxFile #noPrompt
quitMax #noPrompt
