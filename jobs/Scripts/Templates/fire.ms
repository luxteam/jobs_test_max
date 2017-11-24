resetMaxFile #noPrompt
SetQuietMode true
-- main parameters
PASS_LIMIT = {pass_limit}
RENDER_SIZE = {render_size}

FILE_EXTENSION = "{file_extension}" -- for the renderings

res_path = "{res_path}"

function createCatalog = (
    OUT_DIR = "{work_dir}"

    units.SystemType = #Meters
    renderers.current = Radeon_ProRender()
    fr = renderers.current
    fr.renderLimit = 1
    fr.passLimit = PASS_LIMIT
    fr.renderDevice = {ren_mode}

    result = OUT_DIR + "report.json" 
    a = (createFile result mode:"w")
    line = "[\n"
    format "%" line to:a

    filesToRender = #(
        {scene_list}
    )

    count_file = OUT_DIR + "\\expected.json"
    t = (createFile count_file mode:"w")
    line = "[\n"
    format "%" line to:t

    for fi=1 to filesToRender.count do (
        local framesToRender = #(20,40,60,80,90,100)
        assetsFile = res_path + filesToRender[fi]
        loadMaxFile assetsFile quiet:true
        for fra in framesToRender do (
            if fi != filesToRender.count do(
                mfilename = " {{\"file_name\": \"" + maxFileName + "_" + (fra as string)    + FILE_EXTENSION +"\"}},\n"
                format "%" mfilename to:t
            )
            
            if fi == filesToRender.count do(
                if fra != 100 do (
                    mfilename = " {{\"file_name\": \"" + maxFileName + "_" + (fra as string)    + FILE_EXTENSION +"\"}},\n"
                    format "%" mfilename to:t
                ) 
                if fra == 100 do (
                    mfilename = " {{\"file_name\": \"" + maxFileName + "_" + (fra as string)    + FILE_EXTENSION +"\"}}\n"
                    format "%" mfilename to:t
                )
            )
        )
    )

    e_line = "]"
    format "%" e_line to:t
    flush t
    close t

    IMAGE_DIR = OUT_DIR + "\\images\\"
    makeDir IMAGE_DIR
    for fi=1 to filesToRender.count do (
        assetsFile = res_path + filesToRender[fi]
        loadMaxFile assetsFile quiet:true
        fr = renderers.current
        fr.passLimit = PASS_LIMIT
        fr.renderDevice = {ren_mode}
        local framesToRender = #(20,40,60,80,90,100)

        for fra in framesToRender do (
            mfilename = maxFileName + "_" + (fra as string)  + FILE_EXTENSION
            mpath = IMAGE_DIR + mfilename
            rstart = timeStamp()
            render outputwidth:RENDER_SIZE outputheight:RENDER_SIZE frame:fra outputfile:mpath vfb:true
            rend = timeStamp()
            relapsed = ((rend - rstart) / 1000.0)
            ver_max = filterString (getdir #maxroot) "\\"
            scene_json = filterString (filesToRender[fi]) "\\"
            if fi != filesToRender.count do (
                if fra != 100 do(
                    temp_line = " {{\n    \"Test\": \"" + "{package_name}" + "\",\n    \"Tool\": \"" + ver_max[ver_max.count] +    "\",\n    \"renderDevice\": \""+"{render_mode}"+"\",\n    \"PassLimit\": " + (fr.passLimit as string) + ",\n    \"RenderSize\": " + (RENDER_SIZE as string) + ",\n    \"scene\": \"" + scene_json[scene_json.count] + "\",\n    \"frame\": " + (fra as string) + ",\n    \"Start_Time\": \"" + (localtime as String) + "\",\n    \"file_name\": \"" + mfilename + "\",\n    \"Render_Time\": " + (relapsed as string) + "\n }},\n"
                    format "%" temp_line to:a
                    )
                if fra == 100 do(
                    temp_line = " {{\n    \"Test\": \"" + "{package_name}" + "\",\n    \"Tool\": \"" + ver_max[ver_max.count] +    "\",\n    \"renderDevice\": \""+"{render_mode}"+"\",\n    \"PassLimit\": " + (fr.passLimit as string) + ",\n    \"RenderSize\": " + (RENDER_SIZE as string) + ",\n    \"scene\": \"" + scene_json[scene_json.count] + "\",\n    \"frame\": " + (fra as string) + ",\n    \"Start_Time\": \"" + (localtime as String) + "\",\n    \"file_name\": \"" + mfilename + "\",\n    \"Render_Time\": " + (relapsed as string) + "\n }},\n"
                    format "%" temp_line to:a
                    )
                )
            if fi == filesToRender.count do(
                if fra != 100 do(
                    temp_line = " {{\n    \"Test\": \"" + "{package_name}" + "\",\n    \"Tool\": \"" + ver_max[ver_max.count] +    "\",\n    \"renderDevice\": \""+"{render_mode}"+"\",\n    \"PassLimit\": " + (fr.passLimit as string) + ",\n    \"RenderSize\": " + (RENDER_SIZE as string) + ",\n    \"scene\": \"" + scene_json[scene_json.count] + "\",\n    \"frame\": " + (fra as string) + ",\n    \"Start_Time\": \"" + (localtime as String) + "\",\n    \"file_name\": \"" + mfilename + "\",\n    \"Render_Time\": " + (relapsed as string) + "\n }},\n"
                    format "%" temp_line to:a
                    )                                                     
                if fra == 100 do(
                    temp_line = " {{\n    \"Test\": \"" + "{package_name}" + "\",\n    \"Tool\": \"" + ver_max[ver_max.count] +    "\",\n    \"renderDevice\": \""+"{render_mode}"+"\",\n    \"PassLimit\": " + (fr.passLimit as string) + ",\n    \"RenderSize\": " + (RENDER_SIZE as string) + ",\n    \"scene\": \"" + scene_json[scene_json.count] + "\",\n    \"frame\": " + (fra as string) + ",\n    \"Start_Time\": \"" + (localtime as String) + "\",\n    \"file_name\": \"" + mfilename + "\",\n    \"Render_Time\": " + (relapsed as string) + "\n }}\n"
                    format "%" temp_line to:a
                    )
                )
            )
        )

    e_line = "]"
    format "%" e_line to:a
    flush a
    close a 
    )

createCatalog()
resetMaxFile #noPrompt
quitMax #noPrompt
