resetMaxFile #noPrompt
SetQuietMode true

PASS_LIMIT = {pass_limit}
RENDER_SIZE = {render_size}
FILE_EXTENSION = "{file_extension}" -- for the renderings

struct LibEntry (fname, model="Orb")
MATLIBS = #(
    {scene_list}
)

res_path = "{res_path}"

function safeFilename ff = (
    local f = ff
    local len = f.Count
    for i = 0 to len do (
        if f[i] == "#" then f[i] = "_"
        else if f[i] == "$" then f[i] = "_"
        else if f[i] == "[" then f[i] = "_"
        else if f[i] == "]" then f[i] = "_"
        else if f[i] == "+" then f[i] = "_"
        else if f[i] == "%" then f[i] = "_"
        else if f[i] == "!" then f[i] = "_"
        else if f[i] == "`" then f[i] = "_"
        else if f[i] == "&" then f[i] = "_"
        else if f[i] == "*" then f[i] = "_"
        else if f[i] == "�" then f[i] = "_"
        else if f[i] == "|" then f[i] = "_"
        else if f[i] == "?" then f[i] = "_"
        else if f[i] == "\"" then f[i] = "_"
        else if f[i] == "=" then f[i] = "_"
        else if f[i] == "/" then f[i] = "_"
        else if f[i] == "\\" then f[i] = "_"
        else if f[i] == ":" then f[i] = "_"
        else if f[i] == "@" then f[i] = "_"
    )
    return f
)

function createCatalog = (

    OUT_DIR = "{work_dir}"

    lastModel = "Orb"

    assetsFile = res_path + "\\CAT_Objects.max"
    loadMaxFile assetsFile quiet:true

    renderers.current = Radeon_ProRender()
    fr = renderers.current
    fr.renderLimit = 1
    fr.passLimit = PASS_LIMIT
    fr.renderDevice = {ren_mode}

    count_file = OUT_DIR + "\\expected.json"
    t = (createFile count_file mode:"w")
    line = "[\n"
    format "%" line to:t

    for fi=1 to MATLIBS.count do (
        basePath= "C:\\Users\\"
        chainPath= "\\Documents\\Radeon ProRender\\3ds Max\\matlib\\"
        userName=sysInfo.username 
        userPath= basePath+ userName+chainPath 
        matfilename = userPath
        lib = loadTempMaterialLibrary (matfilename + MATLIBS[fi].fname)
        for m=1 to lib.count do (
            if fi!=MATLIBS.count do (
                mfilename = "{{\"file_name\": \"" + (safeFilename lib[m].name) + FILE_EXTENSION + "\"}},\n"
                format "%" mfilename to:t
            ) 
            if fi == MATLIBS.count do (
                if m != lib.count do (
                    mfilename = "{{\"file_name\": \"" + (safeFilename lib[m].name) + FILE_EXTENSION + "\"}},\n"
                    format "%" mfilename to:t
                )
                if m== lib.count do (
                    mfilename = "{{\"file_name\": \"" + (safeFilename lib[m].name) + FILE_EXTENSION + "\"}}\n"
                    format "%" mfilename to:t
                )
            )
        )
    )

    e_line = "]"
    format "%" e_line to:t
    flush t
    close t

    IMAGE_DIR = OUT_DIR + "\\Color\\"
    makeDir IMAGE_DIR 

    result = OUT_DIR + "report.json"
    a = (createFile result mode:"w")
    line = "["
    format "%" line to:a

    for matf=1 to MATLIBS.count do (
        basePath= "C:\\Users\\"
        chainPath= "\\Documents\\Radeon ProRender\\3ds Max\\matlib\\"
        userName=sysInfo.username 
        userPath= basePath+ userName+chainPath 
        matfile = MATLIBS[matf]
        matfilename = userPath
        lib = loadTempMaterialLibrary (matfilename + matfile.fname)

        if (lastModel != matfile.model) do (
            layer = LayerManager.getLayerFromName lastModel
            layer.on = false
            lastModel = matfile.model
            layer = LayerManager.getLayerFromName lastModel
            layer.on = true
        )

        for m in lib do (
            local mat = m
            print m.name

            if (lastModel == "Orb") then (
                p0 = getnodebyname "Probe00" exact:true
                p0.material = mat
                p1 = getnodebyname "Probe01" exact:true
                p1.material = mat
                p2 = getnodebyname "Probe02" exact:true
                p2.material = mat
            )
            else if (lastModel == "Cloth") then (
                p0 = getnodebyname "Cloth" exact:true
                p0.material = mat
            )
            else if (lastModel == "Displacement") then (
                p0 = getnodebyname "Grass" exact:true
                p0.material = mat
            )
            else if (lastModel == "Pool") then (
                p0 = getnodebyname "water" exact:true
                p0.material = mat
            )
            else if (lastModel == "Rigns") then (
                p0 = getnodebyname "Tube001" exact:true
                p0.material = mat
                p1 = getnodebyname "Tube002" exact:true
                p1.material = mat
                p2 = getnodebyname "Tube003" exact:true
                p2.material = mat
            )
            else if (lastModel == "SpeedShape") then (
                p0 = getnodebyname "SpeedShape" exact:true
                p0.material = mat
            )
            else if (lastModel == "Tyre") then (
                p0 = getnodebyname "Tyre" exact:true
                p0.material = mat
            )
            else if (lastModel == "Wall") then (
                p0 = getnodebyname "Plane003" exact:true
                p0.material = mat
            )
            else if (lastModel == "Cup") then (
                p0 = getnodebyname "Line003" exact:true
                p0.material = mat
            )
            else if (lastModel == "Diamonds") do (
                p0 = getnodebyname "niz_206" exact:true
                p0.material = mat
                p1 = getnodebyname "niz_207" exact:true
                p1.material = mat
                p2 = getnodebyname "niz_208" exact:true
                p2.material = mat
                p3 = getnodebyname "niz_209" exact:true
                p3.material = mat
                p4 = getnodebyname "niz_210" exact:true
                p4.material = mat
                p5 = getnodebyname "niz_211" exact:true
                p5.material = mat
                p6 = getnodebyname "Obj_000001" exact:true
                p6.material = mat
                p7 = getnodebyname "pear.d_284" exact:true
                p7.material = mat
                p8 = getnodebyname "pear.d_285" exact:true
                p8.material = mat
                p9 = getnodebyname "pear.d_286" exact:true
                p9.material = mat
                p10 = getnodebyname "pear.d_287" exact:true
                p10.material = mat
                p11 = getnodebyname "pear.d_288" exact:true
                p11.material = mat
                p12 = getnodebyname "pear.d_289" exact:true
                p12.material = mat
                )
            meditmaterials[1] = mat
            mfilename = (safeFilename m.name) + FILE_EXTENSION
            mpath = IMAGE_DIR + mfilename

            start = timeStamp()
            render outputwidth:RENDER_SIZE outputheight:RENDER_SIZE outputfile:mpath vfb:true
            end = timeStamp()
            elapsed = ((end - start) / 1000.0)
            ver_max = filterString (getdir #maxroot) "\\"
            fra = 0
            if matf!=MATLIBS.count do (
                temp_line = "\n {{\n  \"Test\": \"" + "{package_name}" + "\",\n  \"Tool\": \"" + ver_max[ver_max.count] +  "\",\n  \"renderDevice\": \""+"{render_mode}"+"\",\n  \"PassLimit\": " + (fr.passLimit as string) + ",\n  \"RenderSize\": " + (RENDER_SIZE as string) + ",\n  \"scene\": \"" + "CAT_Objects.max" + "\",\n  \"frame\": " + (fra as string) + ",\n  \"Start_Time\": \"" + (localtime as String) + "\",\n  \"file_name\": \"" + mfilename + "\",\n  \"Render_Time\": " + (elapsed as string) + "\n }},"
                format "%" temp_line to:a                               
                )
            if  matf==MATLIBS.count do(
                local materialsOnly = for i in lib where isKindOf i Material collect i
                if m!=materialsOnly[materialsOnly.count] do (
                    temp_line = "\n {{\n  \"Test\": \"" + "{package_name}" + "\",\n  \"Tool\": \"" + ver_max[ver_max.count] +  "\",\n  \"renderDevice\": \""+"{render_mode}"+"\",\n  \"PassLimit\": " + (fr.passLimit as string) + ",\n  \"RenderSize\": " + (RENDER_SIZE as string) + ",\n  \"scene\": \"" + "CAT_Objects.max" + "\",\n  \"frame\": " + (fra as string) + ",\n  \"Start_Time\": \"" + (localtime as String) + "\",\n  \"file_name\": \"" + mfilename + "\",\n  \"Render_Time\": " + (elapsed as string) + "\n }},"
                    format "%" temp_line to:a
                )
                if m==materialsOnly[materialsOnly.count]  do (

                    temp_line = "\n {{\n  \"Test\": \"" + "{package_name}" + "\",\n  \"Tool\": \"" + ver_max[ver_max.count] +  "\",\n  \"renderDevice\": \""+"{render_mode}"+"\",\n  \"PassLimit\": " + (fr.passLimit as string) + ",\n  \"RenderSize\": " + (RENDER_SIZE as string) + ",\n  \"scene\": \"" + "CAT_Objects.max" + "\",\n  \"frame\": " + (fra as string) + ",\n  \"Start_Time\": \"" + (localtime as String) + "\",\n  \"file_name\": \"" + mfilename + "\",\n  \"Render_Time\": " + (elapsed as string) + "\n }}"
                    format "%" temp_line to:a
                )
            )
        )
    )

    e_line = "\n]"
    format "%" e_line to:a
    flush a
    close a
)

createCatalog()     
resetMaxFile #noPrompt
quitMax #noPrompt