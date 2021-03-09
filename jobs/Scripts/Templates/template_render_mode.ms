

function setRenderMode rM iC mRD = (
    -- Function setRenderMode body
    rM = case rM of (
        "GI": 1
        "Direct": 2
        "DirectNoShadow": 3 
        "Wireframe": 4
        "MaterialIdx": 5
        "Position": 6
        "Normal": 7 
        "TextCoords": 8
        "AmbientOcclusion": 9
        default: return rM 
    )

    -- setup Render Mode 
    renderers.current.renderMode = rM

    -- setup Irradiance Clamp
    if iC != undefined do (
        renderers.current.useIrradianceClamp = true
        renderers.current.irradianceClamp = iC
    )
    
    -- setup Max Rey Depth
    if mDR != undefined do (
        renderers.current.maxRayDepth = mRD
    )
)


function main = (
    cases = caseList.get_data()
    cases = cases["cases"]
    
    for i=1 to bi.len(cases) do (
        if (cases[i]["status"] != "active") do continue
        caseList.setCaseStatus i "progress"
        
        assetFile = "{res_path}\\{package_name}\\" + cases[i]["scene_name"]
        loadMaxFile assetFile useFileUnits:true quiet:true
        image_format = "jpg"

        renderers.current = Radeon_ProRender()
        if ({resolution_y} != 0 and {resolution_x} != 0) do (
            renderHeight = {resolution_y}
            renderWidth = {resolution_x}
        )
        renderers.current.samplesMax = {pass_limit}
        renderers.current.iterations = {SPU}
        renderers.current.adaptiveNoiseThreshold = {threshold}

        rM = cases[i]["parameters"]["renderMode"]
        iC = cases[i]["parameters"]["irradianceClamp"]
        mRD = cases[i]["parameters"]["maxRayDepth"]

        setRenderMode rM iC mRD
        rpr_render image_format cases[i]["case"] cases[i]["script_info"]

        caseList.setCaseStatus i "done"
    )
)

main()
resetMaxFile #noPrompt
quitMax #noPrompt
