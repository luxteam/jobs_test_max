resetMaxFile #noPrompt
SetQuietMode true
logsystem.logName "renderTool.log"
units.SystemType = #Meters

caseList = undefined
report = undefined
python.ExecuteFile "ms_json.py"
bi = python.import("__builtin__")


function getMaxVersion = (
    -- return string such as "3ds Max 2019|21.0.0.845" = "<tool>|<release number>.<service pack>.<build number>"
    maxName = filterString (getdir #maxroot) "\\"
    maxName =  maxName[maxName.count]

    maxInfo = filterString (getFileVersion "$max/3dsmax.exe") "\t"
    maxInfo = filterString maxInfo[1] ","
    version = maxName + "|"

    for i = 1 to (maxInfo.count - 1) do version += maxInfo[i] + "."
    version += maxInfo[maxInfo.count]

    return version
)


function buildReport test_case script_info render_time filename test_status passLimit = (
    json_path = "{work_dir}" + test_case + "_RPR.json"
    report.set_filename json_path

    data = bi.dict \
        test_group: "{package_name}" \
        render_device: "{render_device}" \
        render_mode: "{render_mode}" \
        pass_limit: passLimit \
        scene_name: maxFileName \
        date_time: (localtime as string) \
        render_color_path: ("Color/" + filename) \
        test_case: test_case \
        difference_color: "not compare yet" \ 
        render_time: render_time \
        render_version: "0" \
        core_version: "0" \
        test_status: "passed" \                        
        resolution_x: renderWidth \
        resolution_y: renderHeight \
        script_info: script_info \

    data["file_name"] = filename

    maxV = getMaxVersion()
    data["tool"] = maxV

    report.set_data(data)
    report.dump()   
)

function withoutRender test_case script_info status = (
    
    image_path = "{work_dir}" + "Color\\"
    makeDir image_path
    filename = test_case + ".jpg"

    if status then (
        status_path = "{work_dir}" + "..\\..\\..\\..\\jobs\\Tests\\pass.jpg"
    ) else (
        status_path = "{work_dir}" + "..\\..\\..\\..\\jobs\\Tests\\failed.jpg"
    )
    

    
    copyFile status_path (image_path + filename)
    buildReport test_case script_info 0 filename status "0"
)


function rpr_render image_format test_case script_info = (
    image_path = "{work_dir}" + "Color\\"
    makeDir image_path

    filename = test_case + "." + image_format as string
    image_path = image_path + filename

    rstart = timeStamp()
    render outputfile:image_path
    rend = timeStamp()
    relapsed = ((rend - rstart) / 1000.0)

    buildReport test_case script_info relapsed (test_case + ".jpg") "passed" (renderers.current.passLimit)
)


function existFile fname = (getfiles fname).count != 0
