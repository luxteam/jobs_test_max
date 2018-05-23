
function prerender test_list = (
    
    renderers.current = Radeon_ProRender()
    renderers.current.passLimit = {pass_limit}

    if ({resolution_y} != 0 and {resolution_x} != 0) do (
        renderHeight = {resolution_y}
        renderWidth = {resolution_x}
    )

    re = maxOps.GetCurRenderElementMgr()
    re.removeallrenderelements()

    re.addrenderelement (test_list[3] elementname:(test_list[3] as string))

    rpr_render "jpg" test_list[1] test_list[2]

    deleteFile ("{work_dir}" + "Color\\" + test_list[1] + ".jpg")
    renameFile ("{work_dir}" + "Color\\" + test_list[1] + "_RPR___" + test_list[4] + ".jpg") ("{work_dir}\\" + "Color\\" + test_list[1] + ".jpg")
)

function main = (
    
    sf = {start_from}

    list_tests = #(
        #("MAX_RS_AOV_001", "[\"AOV: Opacity\"]", RprOpacity, "Opacity"), 
        #("MAX_RS_AOV_002", "[\"AOV: World Coordinate\"]", RprWorldCoordinate, "World_Coordinate"),
        #("MAX_RS_AOV_003", "[\"AOV: UV\"]", RprUV, "UV"),
        #("MAX_RS_AOV_004", "[\"AOV: Material Index\"]", RprMaterialIdx, "Material_Index"), 
        #("MAX_RS_AOV_005", "[\"AOV: Geometric Normal\"]", RprGeometricNormal, "Geometric_Normal"),
        #("MAX_RS_AOV_006", "[\"AOV: Shading Normal\"]", RprShadingNormal, "Shading_Normal"),
        #("MAX_RS_AOV_007", "[\"AOV: Depth\"]", RprDepth, "Depth"),
        #("MAX_RS_AOV_008", "[\"AOV: Object ID\"]", RprObjectId, "Object_Id"),
        #("MAX_RS_AOV_009", "[\"AOV: Object Group ID\"]", RprObjectGroupId, "Object_Group_Id"),
        #("MAX_RS_AOV_010", "[\"AOV: Background\"]", RprBackground, "Background"),
        #("MAX_RS_AOV_011", "[\"AOV: Emission\"]", RprEmission, "Emission"),
        #("MAX_RS_AOV_012", "[\"AOV: Velocity\"]", RprVelocity, "Velocity"),
        #("MAX_RS_AOV_013", "[\"AOV: Direct Illumination\"]", RprDirectIllumination, "Direct_Illumination"),
        #("MAX_RS_AOV_014", "[\"AOV: Indirect Illumination\"]", RprIndirectIllumination, "Indirect_Illumination"),
        #("MAX_RS_AOV_015", "[\"AOV: AO\"]", RprAO, "Ambient_Occlusion"),
        #("MAX_RS_AOV_016", "[\"AOV: Direct Diffuse\"]", RprDirectDiffuse, "Direct_Diffuse"),
        #("MAX_RS_AOV_017", "[\"AOV: Direct Reflect\"]", RprDirectReflect, "Direct_Reflect"),
        #("MAX_RS_AOV_018", "[\"AOV: Indirect Diffuse\"]", RprIndirectDiffuse, "Indirect_Diffuse"),
        #("MAX_RS_AOV_019", "[\"AOV: Indirect Reflect\"]", RprIndirectReflect, "Indirect_Reflect"),
        #("MAX_RS_AOV_020", "[\"AOV: Refract\"]", RprRefract, "Refract"),
        #("MAX_RS_AOV_021", "[\"AOV: Volume\"]", RprVolume, "Volume")
    )

    filesToRender = #(
        {scene_list}
    )

    for fi=1 to filesToRender.count do (
        assetsFile = "{res_path}" + "\\" + filesToRender[fi]
        loadMaxFile assetsFile useFileUnits:true quiet:true

        if (sf != 1) do (
            create_failed_report list_tests[sf][1] list_tests[sf][2] "failed"
            sf += 1
        )

        for i=sf to list_tests.count do (
            prerender list_tests[i]
        )
    )
)

main()
resetMaxFile #noPrompt
quitMax #noPrompt
