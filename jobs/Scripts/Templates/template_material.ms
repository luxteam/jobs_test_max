
function prerender test_case model lib_material script_info = (
    
    renderers.current = Radeon_ProRender()
    renderers.current.passLimit = {pass_limit}
    if ({resolution_y} != 0 and {resolution_x} != 0) do (
        renderHeight = {resolution_y}
        renderWidth = {resolution_x}
    )

    lastModel = model

    local mat = lib_material

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
    

    rpr_render "jpg" test_case  script_info
)

fn existFile fname = (getfiles fname).count != 0

function main = (
    
    struct LibEntry (fname, model="Orb")
    matlib = #(
        {scene_list}
    )
    
    basePath= "C:\\Users\\"
    chainPath = "\\Documents\\Radeon ProRender\\3ds Max\\matlib\\"
    userName = sysInfo.username 
    matPath = basePath + userName + chainPath 

    if (existFile(matPath + "\RPR_CarPaints.mat")) do (

        test_case = 1

        for m=1 to matlib.count do (
            assetsFile = "{res_path}" + "\\CAT_Objects.max"
            loadMaxFile assetsFile useFileUnits:true quiet:true

            lib = loadTempMaterialLibrary (matPath +  matlib[m].fname)

            lastModel = "Orb"

            if (lastModel != matlib[m].model) do (
                layer = LayerManager.getLayerFromName lastModel
                layer.on = false
                lastModel = matlib[m].model
                layer = LayerManager.getLayerFromName lastModel
                layer.on = true
            )

            for n=1 to lib.count do (
                if (test_case < 10) then (
                    prerender ("MAX_MAT_LIB_00" + test_case as string) matlib[m].model lib[n] "[\"Will add later\"]"
                ) else if (test_case < 100) then (
                    prerender ("MAX_MAT_LIB_0" + test_case as string) matlib[m].model lib[n] "[\"Will add later\"]"
                ) else (
                    prerender ("MAX_MAT_LIB_" + test_case as string) matlib[m].model lib[n] "[\"Will add later\"]"
                )
                test_case += 1
            )
        )
        
    )

)

main()
resetMaxFile #noPrompt
quitMax #noPrompt
