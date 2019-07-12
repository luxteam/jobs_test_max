

function main = (
    cases = caseList.get_data()
    cases = cases["cases"]
    
    for i=1 to cases.count do (
        if (cases[i]["status"] != "active") do continue
        caseList.setCaseStatus i "progress"
        
        assetFile = "{res_path}\\{package_name}\\" + cases[i]["scene_name"]
        loadMaxFile assetFile useFileUnits:true quiet:true
        image_format = "jpg"

        renderers.current = Radeon_ProRender()

        params = cases[i]["parameters"].keys()
        for j=1 to params.count do (
        	val = cases[i]["parameters"][params[j]]
            pColor = findString params[j] "Color"
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
            if (pRadius != undefined) do (
                val = Point3 val[0] val[1] val[2]
            )

            -- check normal
            if params[j] == "normal" do (
                n = RPR_Normal()
                n.Map = Bitmaptexture fileName:val["map"]
                sceneMaterials[PBR_MAT_NAME].BaseColorTexmap = n
                continue
            )

        	setProperty sceneMaterials[PBR_MAT_NAME] params[j] val
        )

        rpr_render image_format cases[i]["name"] cases[i]["script_info"]

        caseList.setCaseStatus i "done"
    )
)


main()
resetMaxFile #noPrompt
quitMax #noPrompt
