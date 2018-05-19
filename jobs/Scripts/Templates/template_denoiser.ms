
function prerender_aov test_list = (
    
    renderers.current = Radeon_ProRender()
    renderers.current.passLimit = {pass_limit}

    if ({resolution_y} != 0 and {resolution_x} != 0) do (
        renderHeight = {resolution_y}
        renderWidth = {resolution_x}
    )

    renderers.current.enableDenoiser = True
    renderers.current.denoiserType = test_list[4]

    if (test_list[4] == 1) then (

        renderers.current.bilateralRadius = 3

    ) else if (test_list[4] == 2) then (

        renderers.current.lwrSamples = 4
        renderers.current.lwrRadius = 4
        renderers.current.lwrBandwidth = 0.1

    ) else if (test_list[4] == 3) then (

        renderers.current.eawColor = 0.1
        renderers.current.eawNormal = 0.1
        renderers.current.eawDepth = 0.1
        renderers.current.eawObjectId = 0.1

    )

    re = maxOps.GetCurRenderElementMgr()
    re.removeallrenderelements()

    re.addrenderelement (test_list[3] elementname:(test_list[3] as string))

    rpr_render "jpg" test_list[1] test_list[2]
)

function prerender_bilateral test_list = (
    
    renderers.current = Radeon_ProRender()
    renderers.current.passLimit = {pass_limit}

    if ({resolution_y} != 0 and {resolution_x} != 0) do (
        renderHeight = {resolution_y}
        renderWidth = {resolution_x}
    )

    renderers.current.enableDenoiser = True
    renderers.current.denoiserType = 1

    renderers.current.bilateralRadius = test_list[3]

    rpr_render "jpg" test_list[1] test_list[2]
)

function prerender_lwr test_list = (
    
    renderers.current = Radeon_ProRender()
    renderers.current.passLimit = {pass_limit}

    if ({resolution_y} != 0 and {resolution_x} != 0) do (
        renderHeight = {resolution_y}
        renderWidth = {resolution_x}
    )

    renderers.current.enableDenoiser = True
    renderers.current.denoiserType = 2

    renderers.current.lwrSamples = test_list[3]
    renderers.current.lwrRadius = test_list[3]
    renderers.current.lwrBandwidth = test_list[4]

    rpr_render "jpg" test_list[1] test_list[2]
)

function prerender_eaw test_list = (
    
    renderers.current = Radeon_ProRender()
    renderers.current.passLimit = {pass_limit}

    if ({resolution_y} != 0 and {resolution_x} != 0) do (
        renderHeight = {resolution_y}
        renderWidth = {resolution_x}
    )

    renderers.current.enableDenoiser = True
    renderers.current.denoiserType = 3

    renderers.current.eawColor = test_list[3]
    renderers.current.eawNormal = test_list[3]
    renderers.current.eawDepth = test_list[3]
    renderers.current.eawObjectId = test_list[3]

    rpr_render "jpg" test_list[1] test_list[2]
)

function main = (
    
    sf = {start_from}

    list_tests = #(
        #("MAX_RS_DEN_001", "[\"Filter type: Bilateral\", \"Radius: 1\"]", 1),
        #("MAX_RS_DEN_002", "[\"Filter type: Bilateral\", \"Radius: 3\"]", 3),
        #("MAX_RS_DEN_003", "[\"Filter type: Bilateral\", \"Radius: 6\"]", 6),
        #("MAX_RS_DEN_004", "[\"Filter type: Bilateral\", \"Radius: 10\"]", 10),

        #("MAX_RS_DEN_005", "[\"Filter type: Local Weighted Regression\", \"Samples: 1\", \"Filter radius: 1\", \"Bandwidth: 0.1\"]", 1, 0.1),
        #("MAX_RS_DEN_006", "[\"Filter type: Local Weighted Regression\", \"Samples: 5\", \"Filter radius: 5\", \"Bandwidth: 0.5\"]", 5, 0.5),
        #("MAX_RS_DEN_007", "[\"Filter type: Local Weighted Regression\", \"Samples: 10\", \"Filter radius: 10\", \"Bandwidth: 1.0\"]", 10, 1),

        #("MAX_RS_DEN_008", "[\"Filter type: Edge Avoiding Wavelets\", \"Color: 0.1\", \"Depth: 0.1\", \"Normal: 0.1\", \"Object ID: 0.1\"]", 0.1),
        #("MAX_RS_DEN_009", "[\"Filter type: Edge Avoiding Wavelets\", \"Color: 0.5\", \"Depth: 0.5\", \"Normal: 0.5\", \"Object ID: 0.5\"]", 0.5),
        #("MAX_RS_DEN_010", "[\"Filter type: Edge Avoiding Wavelets\", \"Color: 1.0\", \"Depth: 1.0\", \"Normal: 1.0\", \"Object ID: 1.0\"]", 1),

        #("MAX_RS_DEN_011", "[\"AOV: Opacity\", \"Filter type: Bilateral\"]", RprOpacity, 1),
        #("MAX_RS_DEN_012", "[\"AOV: World Coordinate\", \"Filter type: Bilateral\"]", RprWorldCoordinate, 1),
        #("MAX_RS_DEN_013", "[\"AOV: UV\", \"Filter type: Bilateral\"]", RprUV, 1),
        #("MAX_RS_DEN_014", "[\"AOV: Material Index\", \"Filter type: Bilateral\"]", RprMaterialIdx, 1),
        #("MAX_RS_DEN_015", "[\"AOV: Geometric Normal\", \"Filter type: Bilateral\"]", RprGeometricNormal, 1),
        #("MAX_RS_DEN_016", "[\"AOV: Shading Normal\", \"Filter type: Bilateral\"]", RprShadingNormal, 1), 
        #("MAX_RS_DEN_017", "[\"AOV: Depth\", \"Filter type: Bilateral\"]", RprDepth, 1),
        #("MAX_RS_DEN_018", "[\"AOV: Object ID\", \"Filter type: Bilateral\"]", RprObjectId, 1), 
        #("MAX_RS_DEN_019", "[\"AOV: Object Group ID\", \"Filter type: Bilateral\"]", RprObjectGroupId, 1),
        #("MAX_RS_DEN_020", "[\"AOV: Background\", \"Filter type: Bilateral\"]", RprBackground, 1), 
        #("MAX_RS_DEN_021", "[\"AOV: Emission\", \"Filter type: Bilateral\"]", RprEmission, 1), 
        #("MAX_RS_DEN_022", "[\"AOV: Velocity\", \"Filter type: Bilateral\"]", RprVelocity, 1), 
        #("MAX_RS_DEN_023", "[\"AOV: Direct Illumination\", \"Filter type: Bilateral\"]", RprDirectIllumination, 1),
        #("MAX_RS_DEN_024", "[\"AOV: Indirect Illumination\", \"Filter type: Bilateral\"]", RprIndirectIllumination, 1),
        #("MAX_RS_DEN_025", "[\"AOV: AO\", \"Filter type: Bilateral\"]", RprAO, 1),
        #("MAX_RS_DEN_026", "[\"AOV: Direct Diffuse\", \"Filter type: Bilateral\"]", RprDirectDiffuse, 1),
        #("MAX_RS_DEN_027", "[\"AOV: Direct Reflect\", \"Filter type: Bilateral\"]", RprDirectReflect, 1),
        #("MAX_RS_DEN_028", "[\"AOV: Indirect Diffuse\", \"Filter type: Bilateral\"]", RprIndirectDiffuse, 1),
        #("MAX_RS_DEN_029", "[\"AOV: Indirect Reflect\", \"Filter type: Bilateral\"]", RprIndirectReflect, 1),
        #("MAX_RS_DEN_030", "[\"AOV: Refract\", \"Filter type: Bilateral\"]", RprRefract, 1),
        #("MAX_RS_DEN_031", "[\"AOV: Volume\", \"Filter type: Bilateral\"]", RprVolume, 1),

        #("MAX_RS_DEN_032", "[\"AOV: Opacity\", \"Filter type: Local Weighted Regression\"]", RprOpacity, 2),
        #("MAX_RS_DEN_033", "[\"AOV: World Coordinate\", \"Filter type: Local Weighted Regression\"]", RprWorldCoordinate, 2),
        #("MAX_RS_DEN_034", "[\"AOV: UV\", \"Filter type: Local Weighted Regression\"]", RprUV, 2),
        #("MAX_RS_DEN_035", "[\"AOV: Material Index\", \"Filter type: Local Weighted Regression\"]", RprMaterialIdx, 2),
        #("MAX_RS_DEN_036", "[\"AOV: Geometric Normal\", \"Filter type: Local Weighted Regression\"]", RprGeometricNormal, 2),
        #("MAX_RS_DEN_037", "[\"AOV: Shading Normal\", \"Filter type: Local Weighted Regression\"]", RprShadingNormal, 2),
        #("MAX_RS_DEN_038", "[\"AOV: Depth\", \"Filter type: Local Weighted Regression\"]", RprDepth, 2),
        #("MAX_RS_DEN_039", "[\"AOV: Object ID\", \"Filter type: Local Weighted Regression\"]", RprObjectId, 2),
        #("MAX_RS_DEN_040", "[\"AOV: Object Group ID\", \"Filter type: Local Weighted Regression\"]", RprObjectGroupId, 2),
        #("MAX_RS_DEN_041", "[\"AOV: Background\", \"Filter type: Local Weighted Regression\"]", RprBackground, 2),
        #("MAX_RS_DEN_042", "[\"AOV: Emission\", \"Filter type: Local Weighted Regression\"]", RprEmission, 2),
        #("MAX_RS_DEN_043", "[\"AOV: Velocity\", \"Filter type: Local Weighted Regression\"]", RprVelocity, 2),
        #("MAX_RS_DEN_044", "[\"AOV: Direct Illumination\", \"Filter type: Local Weighted Regression\"]", RprDirectIllumination, 2),
        #("MAX_RS_DEN_045", "[\"AOV: Indirect Illumination\", \"Filter type: Local Weighted Regression\"]", RprIndirectIllumination, 2),
        #("MAX_RS_DEN_046", "[\"AOV: AO\", \"Filter type: Local Weighted Regression\"]", RprAO, 2),
        #("MAX_RS_DEN_047", "[\"AOV: Direct Diffuse\", \"Filter type: Local Weighted Regression\"]", RprDirectDiffuse, 2),
        #("MAX_RS_DEN_048", "[\"AOV: Direct Reflect\", \"Filter type: Local Weighted Regression\"]", RprDirectReflect, 2),
        #("MAX_RS_DEN_049", "[\"AOV: Indirect Diffuse\", \"Filter type: Local Weighted Regression\"]", RprIndirectDiffuse, 2),
        #("MAX_RS_DEN_050", "[\"AOV: Indirect Reflect\", \"Filter type: Local Weighted Regression\"]", RprIndirectReflect, 2),
        #("MAX_RS_DEN_051", "[\"AOV: Refract\", \"Filter type: Local Weighted Regression\"]", RprRefract, 2),
        #("MAX_RS_DEN_052", "[\"AOV: Volume\", \"Filter type: Local Weighted Regression\"]", RprVolume, 2),

        #("MAX_RS_DEN_053", "[\"AOV: Opacity\", \"Filter type: Edge Avoiding Wavelets\"]", RprOpacity, 3),
        #("MAX_RS_DEN_054", "[\"AOV: World Coordinate\", \"Filter type: Edge Avoiding Wavelets\"]", RprWorldCoordinate, 3),
        #("MAX_RS_DEN_055", "[\"AOV: UV\", \"Filter type: Edge Avoiding Wavelets\"]", RprUV, 3),
        #("MAX_RS_DEN_056", "[\"AOV: Material Index\", \"Filter type: Edge Avoiding Wavelets\"]", RprMaterialIdx, 3),
        #("MAX_RS_DEN_057", "[\"AOV: Geometric Normal\", \"Filter type: Edge Avoiding Wavelets\"]", RprGeometricNormal, 3),
        #("MAX_RS_DEN_058", "[\"AOV: Shading Normal\", \"Filter type: Edge Avoiding Wavelets\"]", RprShadingNormal, 3),
        #("MAX_RS_DEN_059", "[\"AOV: Depth\", \"Filter type: Edge Avoiding Wavelets\"]", RprDepth, 3 ),
        #("MAX_RS_DEN_060", "[\"AOV: Object ID\", \"Filter type: Edge Avoiding Wavelets\"]", RprObjectId, 3),
        #("MAX_RS_DEN_061", "[\"AOV: Object Group ID\", \"Filter type: Edge Avoiding Wavelets\"]", RprObjectGroupId, 3),
        #("MAX_RS_DEN_062", "[\"AOV: Background\", \"Filter type: Edge Avoiding Wavelets\"]", RprBackground, 3),
        #("MAX_RS_DEN_063", "[\"AOV: Emission\", \"Filter type: Edge Avoiding Wavelets\"]", RprEmission, 3),
        #("MAX_RS_DEN_064", "[\"AOV: Velocity\", \"Filter type: Edge Avoiding Wavelets\"]", RprVelocity, 3),
        #("MAX_RS_DEN_065", "[\"AOV: Direct Illumination\", \"Filter type: Edge Avoiding Wavelets\"]", RprDirectIllumination, 3),
        #("MAX_RS_DEN_066", "[\"AOV: Indirect Illumination\", \"Filter type: Edge Avoiding Wavelets\"]", RprIndirectIllumination, 3),
        #("MAX_RS_DEN_067", "[\"AOV: AO\", \"Filter type: Edge Avoiding Wavelets\"]", RprAO, 3),
        #("MAX_RS_DEN_068", "[\"AOV: Direct Diffuse\", \"Filter type: Edge Avoiding Wavelets\"]", RprDirectDiffuse, 3),
        #("MAX_RS_DEN_069", "[\"AOV: Direct Reflect\", \"Filter type: Edge Avoiding Wavelets\"]", RprDirectReflect, 3),
        #("MAX_RS_DEN_070", "[\"AOV: Indirect Diffuse\", \"Filter type: Edge Avoiding Wavelets\"]", RprIndirectDiffuse, 3),
        #("MAX_RS_DEN_071", "[\"AOV: Indirect Reflect\", \"Filter type: Edge Avoiding Wavelets\"]", RprIndirectReflect, 3),
        #("MAX_RS_DEN_072", "[\"AOV: Refract\", \"Filter type: Edge Avoiding Wavelets\"]", RprRefract, 3),
        #("MAX_RS_DEN_073", "[\"AOV: Volume\", \"Filter type: Edge Avoiding Wavelets\"]", RprVolume, 3)
    )

    filesToRender = #(
        {scene_list}
    )

    for fi=1 to filesToRender.count do (
        assetsFile = "{res_path}" + "\\" + filesToRender[fi]
        loadMaxFile assetsFile useFileUnits:true quiet:true

        if (sf != 1) do (
            create_failed_report list_tests[sf][1] list_tests[sf][2] "failed"
        )

        for i=sf to 4 do (
            prerender_bilateral list_tests[sf]
            sf += 1
        )

        for i=sf to 7 do (
            prerender_lwr list_tests[sf]
            sf += 1
        )

        for i=sf to 10 do (
            prerender_eaw list_tests[sf]
            sf += 1
        )

        for i=sf to list_tests.count do (
            prerender_aov list_tests[sf]
            sf += 1
        )

    )
)

main()
resetMaxFile #noPrompt
quitMax #noPrompt
