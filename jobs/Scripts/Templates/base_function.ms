resetMaxFile #noPrompt
SetQuietMode true
logsystem.logName "max.log"
units.SystemType = #Meters

function save_render test_name = (
	
    renderers.current.renderDevice = {ren_mode}
    renderers.current.renderLimit = 1

    image_path = "{work_dir}" + "Color\\"
    makeDir image_path

    json_path = "{work_dir}" + test_name + "_MAX.json"
    a = (createFile json_path mode:"w")
    format "%" "[" to:a

    filename = test_name + ".jpg"
    image_path = image_path + filename

    rstart = timeStamp()
    render outputfile:image_path vfb:true
    rend = timeStamp()
    relapsed = ((rend - rstart) / 1000.0)

    ver_max = filterString (getdir #maxroot) "\\"
    scene_json = filterString (test_name) "\\"

    json_line = "\n {{\n  \"test_name\": \"" + "{package_name}" + "\",\n  \"tool\": \"" + ver_max[ver_max.count] +  "\",\n  \"render_device\": \""+"{render_mode}"+"\",\n  \"PassLimit\": " + (renderers.current.passLimit as string) + ",\n  \"scene_name\": \"" + scene_json[scene_json.count] + "\",\n  \"date_time\": \"" + (localtime as String) + "\",\n  \"render_color_path\": \"Color/" + filename + "\",\n  \"file_name\": \"" + filename + "\",\n  \"difference_color\": \"not compare yet\",\n  \"render_time\": " + (relapsed as string) + "\n }}"
    format "%" json_line to:a

    e_line = "\n]"
    format "%" e_line to:a
    flush a
    close a 

)

