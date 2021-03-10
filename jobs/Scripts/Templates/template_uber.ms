

function main = (
    cases = caseList.get_data()
    
    
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

        params = bi.list(cases[i]["parameters"].keys())
        for j=1 to bi.len(params) do (
        	val = cases[i]["parameters"][params[j]]
            pColor = findString params[j] "Color"
            if params[j] == "DiffuseSeparateBackScatteringColor" do pColor = undefined
            
            pTextmap = findString params[j] "Texmap"
            pRadius = findString params[j] "Radius"

            -- check color
            if (pColor != undefined) and (pTextmap == undefined) do val = getColor val["r"] val["g"] val["b"]

            -- check textmap
            if (pTextmap != undefined) do (
                pathTextmap = "{res_path}\\{package_name}\\" + val
                val = Bitmaptexture fileName:pathTextmap
        	)

            -- check radius
            if (pRadius != undefined) and (pTextmap == undefined) do (
                val = Point3 val[0] val[1] val[2]
            )

        	setProperty rootScene[#SME][#View1][#RPRUberMaterial1____RPR_Uber_Material].Properties.reference params[j] val
        )

        rpr_render image_format cases[i]["case"] cases[i]["script_info"]

        caseList.setCaseStatus i "done"
    )
)


main()
resetMaxFile #noPrompt
quitMax #noPrompt
