resetMaxFile #noPrompt
SetQuietMode true
logsystem.logName "renderTool.log"
units.SystemType = #Meters

caseList = undefined
python.ExecuteFile "ms_json.py"


function rpr_render image_format test_case script_info = (
	
    renderers.current.renderDevice = {ren_mode}
    renderers.current.renderLimit = 1

    image_path = "{work_dir}" + "Color\\"
    makeDir image_path

    filename = test_case + "." + image_format as string
    image_path = image_path + filename

    rstart = timeStamp()
    render outputfile:image_path
    rend = timeStamp()
    relapsed = ((rend - rstart) / 1000.0)

    ver_max = filterString (getdir #maxroot) "\\"

    json_path = "{work_dir}" + test_case + "_RPR.json"
    
--     report = Dictionary (#string)
--     report["test_group"] = "{package_name}" 
--     report["tool"] = ver_max[ver_max.count]
--     report["render_device"] = "{render_mode}"
--     report["pass_limit"] = (renderers.current.passLimit as string)
--     report["scene_name"] = maxFileName
--     report["date_time"] = (localtime as String)
--     report["render_color_path"] = filename
--     report["file_name"] = filename
--     report["test_case"] = test_case
--     report["difference_color"] = "not compare yet"
--     report["render_time"] = (relapsed as string)
--     report["render_version"] = "0"
--     report["core_version"] = "0"
--     report["test_status"] = "passed"
--     report["resolution_x"] = (renderWidth as string)
--     report["resolution_y"] = (renderHeight as string)
--     report["script_info"] = script_info


    a = (createFile json_path mode:"w")
    format "%" "[\n" to:a

    json_line = " {{\n" 
    format "%" json_line to:a

    json_line = "  \"test_group\": \"" + "{package_name}" + "\",\n"
    format "%" json_line to:a

    json_line = "  \"tool\": \"" + ver_max[ver_max.count] +  "\",\n"
    format "%" json_line to:a

    json_line = "  \"render_device\": \"" + "{render_mode}" + "\",\n"
    format "%" json_line to:a

    json_line = "  \"pass_limit\": " + (renderers.current.passLimit as string) + ",\n"
    format "%" json_line to:a

    json_line = "  \"scene_name\": \"" + maxFileName + "\",\n"
    format "%" json_line to:a

    json_line = "  \"date_time\": \"" + (localtime as String) + "\",\n"
    format "%" json_line to:a

    json_line = "  \"render_color_path\": \"Color/" + filename + "\",\n"
    format "%" json_line to:a

    json_line = "  \"file_name\": \"" + filename + "\",\n"
    format "%" json_line to:a  

    json_line = "  \"test_case\": \"" + test_case + "\",\n"
    format "%" json_line to:a      

    json_line = "  \"difference_color\": \"not compare yet\",\n"
    format "%" json_line to:a    

    json_line = "  \"render_time\": " + (relapsed as string) + ",\n"
    format "%" json_line to:a 

    json_line = "  \"render_version\": " + "\"0\"" + ",\n"
    format "%" json_line to:a 

    json_line = "  \"core_version\": " + "\"0\"" + ",\n"
    format "%" json_line to:a 
    
    json_line = "  \"test_status\": \"passed\",\n"
    format "%" json_line to:a 

    json_line = "  \"resolution_x\": " + (renderWidth as string) + ",\n"
    format "%" json_line to:a 

    json_line = "  \"resolution_x\": " + (renderHeight as string) + ",\n"
    format "%" json_line to:a 

    json_line = "  \"script_info\": " + script_info + "\n"
    format "%" json_line to:a 

    json_line = " }}\n"
    format "%" json_line to:a 

    json_line = "]"
    format "%" json_line to:a
    flush a
    close a 

)
