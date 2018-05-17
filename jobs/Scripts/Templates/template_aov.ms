
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
)

function main sf = (
    
    list_tests = #(
        #("MAX_RS_AOV_001", "[\"AOV: Opacity\"]", RprOpacity), 
        #("MAX_RS_AOV_002", "[\"AOV: World Coordinate\"]", RprWorldCoordinate),
        #("MAX_RS_AOV_003", "[\"AOV: UV\"]", RprUV),
        #("MAX_RS_AOV_004", "[\"AOV: Material Index\"]", RprMaterialIdx), 
        #("MAX_RS_AOV_005", "[\"AOV: Geometric Normal\"]", RprGeometricNormal),
        #("MAX_RS_AOV_006", "[\"AOV: Shading Normal\"]", RprShadingNormal),
        #("MAX_RS_AOV_007", "[\"AOV: Depth\"]", RprDepth),
        #("MAX_RS_AOV_008", "[\"AOV: Object ID\"]", RprObjectId),
        #("MAX_RS_AOV_009", "[\"AOV: Object Group ID\"]", RprObjectGroupId),
        #("MAX_RS_AOV_010", "[\"AOV: Background\"]", RprBackground),
        #("MAX_RS_AOV_011", "[\"AOV: Emission\"]", RprEmission),
        #("MAX_RS_AOV_012", "[\"AOV: Velocity\"]", RprVelocity),
        #("MAX_RS_AOV_013", "[\"AOV: Direct Illumination\"]", RprDirectIllumination),
        #("MAX_RS_AOV_014", "[\"AOV: Indirect Illumination\"]", RprIndirectIllumination),
        #("MAX_RS_AOV_015", "[\"AOV: AO\"]", RprAO),
        #("MAX_RS_AOV_016", "[\"AOV: Direct Diffuse\"]", RprDirectDiffuse),
        #("MAX_RS_AOV_017", "[\"AOV: Direct Reflect\"]", RprDirectReflect),
        #("MAX_RS_AOV_018", "[\"AOV: Indirect Diffuse\"]", RprIndirectDiffuse),
        #("MAX_RS_AOV_019", "[\"AOV: Indirect Reflect\"]", RprIndirectReflect),
        #("MAX_RS_AOV_020", "[\"AOV: Refract\"]", RprRefract),
        #("MAX_RS_AOV_021", "[\"AOV: Volume\"]", RprVolume)
    )

    filesToRender = #(
        {scene_list}
    )

    for fi=1 to filesToRender.count do (
        assetsFile = "{res_path}" + "\\" + filesToRender[fi]
        loadMaxFile assetsFile useFileUnits:true quiet:true

        if (sf != 1) (
            create_failed_report list_tests[sf-1][1] list_tests[$sf-1][2] "failed"
        )

        for sf=1 to list_tests.count do (
            prerender list_tests[sf]
        )
    )
)

main()
resetMaxFile #noPrompt
quitMax #noPrompt
