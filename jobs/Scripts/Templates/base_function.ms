resetMaxFile #noPrompt
SetQuietMode true
logsystem.logName "log"
units.SystemType = #Meters

function rpr_render test_case = (
	
    renderers.current.renderDevice = {ren_mode}
    renderers.current.renderLimit = 1

    image_path = "{work_dir}" + "Color\\"
    makeDir image_path

    filename = test_case + ".jpg"
    image_path = image_path + filename

    rstart = timeStamp()
    render outputfile:image_path
    rend = timeStamp()
    relapsed = ((rend - rstart) / 1000.0)

    ver_max = filterString (getdir #maxroot) "\\"

    json_path = "{work_dir}" + test_case + "_RPR.json"
    a = (createFile json_path mode:"w")
    format "%" "[\n" to:a

    json_line = " {{\n" 
    format "%" json_line to:a

    json_line = "  \"test_name\": \"" + "{package_name}" + "\",\n"
    format "%" json_line to:a

    json_line = "  \"tool\": \"" + ver_max[ver_max.count] +  "\",\n"
    format "%" json_line to:a

    json_line = "  \"render_device\": \"" + "{render_mode}" + "\",\n"
    format "%" json_line to:a

    json_line = "  \"PassLimit\": " + (renderers.current.passLimit as string) + ",\n"
    format "%" json_line to:a

    json_line = "  \"scene_name\": \"" + "fix" + "\",\n"
    format "%" json_line to:a

    json_line = "  \"date_time\": \"" + (localtime as String) + "\",\n"
    format "%" json_line to:a

    json_line = "  \"render_color_path\": \"Color/" + filename + "\",\n"
    format "%" json_line to:a

    json_line = "  \"file_name\": \"" + filename + "\",\n"
    format "%" json_line to:a    

    json_line = "  \"difference_color\": \"not compare yet\",\n"
    format "%" json_line to:a    

    json_line = "  \"render_time\": " + (relapsed as string) + "\n"
    format "%" json_line to:a 

    json_line = " }}\n"
    format "%" json_line to:a 

    json_line = "]"
    format "%" json_line to:a
    flush a
    close a 

)

