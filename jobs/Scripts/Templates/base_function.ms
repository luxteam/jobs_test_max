resetMaxFile #noPrompt
SetQuietMode true
logsystem.logName "renderTool.log"
units.SystemType = #Meters

caseList = undefined
report = undefined
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


    bi = python.import("__builtin__")
    data = bi.dict \
        test_group: "{package_name}" \
        tool: ver_max[ver_max.count] \
        render_device: "{render_mode}" \
        pass_limit: (renderers.current.passLimit as string) \
        scene_name: maxFileName \
        date_time: (localtime as string) \
        render_color_path: ("Color/" + filename) \
        test_case: test_case \
        difference_color: "not compare yet" \ 
        render_time: relapsed \
        render_version: "0" \
        core_version: "0" \
        test_status: "passed" \                        
        resolution_x: (renderWidth as string) \
        resolution_y: (renderHeight as string) \
        script_info: script_info \

    data["file_name"] = filename
    report.set_data(data)
    report.set_filename json_path
    report.dump()
)
