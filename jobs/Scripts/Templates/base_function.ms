resetMaxFile #noPrompt
SetQuietMode true
logsystem.logName "renderTool.log"
units.SystemType = #Meters

-- Initial case list with python wrapper
caseList = undefined
report = undefined
python.ExecuteFile "ms_json.py"

sys_module = python.import("sys")
py_version = sys_module.version
bi = undefined
if py_version[1] == "2" then (
    bi = python.import("__builtin__")
) else (
    bi = python.import("builtins")
)

-- Render Elements Map
REs = Dictionary(#string)
REs["RprOpacity"] = RprOpacity
REs["RprWorldCoordinate"] = RprWorldCoordinate
REs["RprUV"] = RprUV
REs["RprMaterialIdx"] = RprMaterialIdx
REs["RprGeometricNormal"] = RprGeometricNormal
REs["RprShadingNormal"] = RprShadingNormal
REs["RprDepth"] = RprDepth
REs["RprObjectId"] = RprObjectId
REs["RprObjectGroupId"] = RprObjectGroupId
REs["RprBackground"] = RprBackground
REs["RprEmission"] = RprEmission
REs["RprVelocity"] = RprVelocity
REs["RprDirectIllumination"] = RprDirectIllumination
REs["RprIndirectIllumination"] = RprIndirectIllumination
REs["RprAO"] = RprAO
REs["RprDirectDiffuse"] = RprDirectDiffuse
REs["RprDirectReflect"] = RprDirectReflect
REs["RprIndirectDiffuse"] = RprIndirectDiffuse
REs["RprIndirectReflect"] = RprIndirectReflect
REs["RprRefract"] = RprRefract
REs["RprVolume"] = RprVolume


-- Name Volume Material
VOL_MAT_NAME = "RPRVolumeMaterial1"
PBR_MAT_NAME = "RPRPbrMaterial1"
RPR_Physical_Light_NAME = "RPRPhysicalLight001"

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
        SPU: "{SPU}" \
        threshold: "{threshold}" \
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
        group_timeout_exceeded: false \
        testcase_timeout_exceeded: false \
        testcase_timeout: 0 \
        message: (bi.list()) \

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

    -- TODO: remove hard code paths
    if status then (
        status_path = "{work_dir}" + "..\\..\\..\\..\\jobs_launcher\\common\\img\\passed.jpg"
    ) else (
        status_path = "{work_dir}" + "..\\..\\..\\..\\jobs_launcher\\common\\img\\error.jpg"
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
    render renderElementBitmaps:&reb outputfile:image_path
    rend = timeStamp()
    relapsed = ((rend - rstart) / 1000.0)

    buildReport test_case script_info relapsed (test_case + ".jpg") "passed" (renderers.current.passLimit)
    return reb
)


function existFile fname = (getfiles fname).count != 0


function getMaterialFromName n = (
    for mat in sceneMaterials do (
        if mat.name == n do return mat
    )

    return undefined
)


function getColor r g b = (
    return (color r g b)
)


function getLightFromName n = (
    for obj in objects do (
        if obj.name == n do return obj
    )
    
    return undefined
)


function getObjectFromName n = (
    for o in objects do (
        if o.name == n do (
            return o
        )
    )

    return undefined
)