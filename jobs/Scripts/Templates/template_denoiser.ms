
function prerender_aov test_case aov denoiser_type script_info = (
    
    renderers.current = Radeon_ProRender()
    renderers.current.passLimit = {pass_limit}
    if ({resolution_y} != 0 and {resolution_x} != 0) do (
        renderHeight = {resolution_y}
        renderWidth = {resolution_x}
    )

    renderers.current.enableDenoiser = True
    renderers.current.denoiserType = denoiser_type

    if (denoiser_type == 1) then (
    renderers.current.bilateralRadius = 3
    ) else if (denoiser_type == 2) then (
    renderers.current.lwrSamples = 4
    renderers.current.lwrRadius = 4
    renderers.current.lwrBandwidth = 0.1
    ) else if (denoiser_type == 3) then (
    renderers.current.eawColor = 0.1
    renderers.current.eawNormal = 0.1
    renderers.current.eawDepth = 0.1
    renderers.current.eawObjectId = 0.1
    )

    re = maxOps.GetCurRenderElementMgr()
    re.removeallrenderelements()

    re.addrenderelement (aov elementname:(aov as string))

    rpr_render "jpg" test_case script_info
)

function prerender_bilateral test_case param1 script_info = (
    
    renderers.current = Radeon_ProRender()
    renderers.current.passLimit = {pass_limit}
    if ({resolution_y} != 0 and {resolution_x} != 0) do (
        renderHeight = {resolution_y}
        renderWidth = {resolution_x}
    )

    renderers.current.enableDenoiser = True
    renderers.current.denoiserType = 1

    renderers.current.bilateralRadius = param1

    rpr_render "jpg" test_case script_info
)

function prerender_lwr test_case param1 param2 script_info = (
    
    renderers.current = Radeon_ProRender()
    renderers.current.passLimit = {pass_limit}
    if ({resolution_y} != 0 and {resolution_x} != 0) do (
        renderHeight = {resolution_y}
        renderWidth = {resolution_x}
    )

    renderers.current.enableDenoiser = True
    renderers.current.denoiserType = 2

    renderers.current.lwrSamples = param1
    renderers.current.lwrRadius = param1
    renderers.current.lwrBandwidth = param2

    rpr_render "jpg" test_case script_info
)

function prerender_eaw test_case param1 script_info = (
    
    renderers.current = Radeon_ProRender()
    renderers.current.passLimit = {pass_limit}
    if ({resolution_y} != 0 and {resolution_x} != 0) do (
        renderHeight = {resolution_y}
        renderWidth = {resolution_x}
    )

    renderers.current.enableDenoiser = True
    renderers.current.denoiserType = 3

    renderers.current.eawColor = param1
    renderers.current.eawNormal = param1
    renderers.current.eawDepth = param1
    renderers.current.eawObjectId = param1

    rpr_render "jpg" test_case script_info
)

function main = (
    
    filesToRender = #(
        {scene_list}
    )

    for fi=1 to filesToRender.count do (
        assetsFile = "{res_path}" + "\\" + filesToRender[fi]
        loadMaxFile assetsFile useFileUnits:true quiet:true

        prerender_bilateral "MAX_RS_DEN_001" 1 "[\"Filter type: Bilateral\", \"Radius: 1\"]"
        prerender_bilateral "MAX_RS_DEN_002" 3 "[\"Filter type: Bilateral\", \"Radius: 3\"]"
        prerender_bilateral "MAX_RS_DEN_003" 6 "[\"Filter type: Bilateral\", \"Radius: 6\"]"
        prerender_bilateral "MAX_RS_DEN_004" 10 "[\"Filter type: Bilateral\", \"Radius: 10\"]"

        prerender_lwr "MAX_RS_DEN_005" 1 0.1 "[\"Filter type: Local Weighted Regression\", \"Samples: 1\", \"Filter radius: 1\", \"Bandwidth: 0.1\"]"
        prerender_lwr "MAX_RS_DEN_006" 5 0.5 "[\"Filter type: Local Weighted Regression\", \"Samples: 5\", \"Filter radius: 5\", \"Bandwidth: 0.5\"]"
        prerender_lwr "MAX_RS_DEN_007" 10 1 "[\"Filter type: Local Weighted Regression\", \"Samples: 10\", \"Filter radius: 10\", \"Bandwidth: 1.0\"]"

        prerender_eaw "MAX_RS_DEN_008" 0.1 "[\"Filter type: Edge Avoiding Wavelets\", \"Color: 0.1\", \"Depth: 0.1\", \"Normal: 0.1\", \"Object ID: 0.1\"]"
        prerender_eaw "MAX_RS_DEN_009" 0.5 "[\"Filter type: Edge Avoiding Wavelets\", \"Color: 0.5\", \"Depth: 0.5\", \"Normal: 0.5\", \"Object ID: 0.5\"]"
        prerender_eaw "MAX_RS_DEN_010" 1 "[\"Filter type: Edge Avoiding Wavelets\", \"Color: 1.0\", \"Depth: 1.0\", \"Normal: 1.0\", \"Object ID: 1.0\"]"

        prerender_aov "MAX_RS_DEN_011" RprOpacity 1 "[\"AOV: Opacity\", \"Filter type: Bilateral\"]"
        prerender_aov "MAX_RS_DEN_012" RprWorldCoordinate 1 "[\"AOV: World Coordinate\", \"Filter type: Bilateral\"]"
        prerender_aov "MAX_RS_DEN_013" RprUV 1 "[\"AOV: UV\", \"Filter type: Bilateral\"]"
        prerender_aov "MAX_RS_DEN_014" RprMaterialIdx 1 "[\"AOV: Material Index\", \"Filter type: Bilateral\"]"
        prerender_aov "MAX_RS_DEN_015" RprGeometricNormal 1 "[\"AOV: Geometric Normal\", \"Filter type: Bilateral\"]"
        prerender_aov "MAX_RS_DEN_016" RprShadingNormal 1 "[\"AOV: Shading Normal\", \"Filter type: Bilateral\"]"
        prerender_aov "MAX_RS_DEN_017" RprDepth 1 "[\"AOV: Depth\", \"Filter type: Bilateral\"]"
        prerender_aov "MAX_RS_DEN_018" RprObjectId 1 "[\"AOV: Object ID\", \"Filter type: Bilateral\"]"
        prerender_aov "MAX_RS_DEN_019" RprObjectGroupId 1 "[\"AOV: Object Group ID\", \"Filter type: Bilateral\"]"
        prerender_aov "MAX_RS_DEN_020" RprBackground 1 "[\"AOV: Background\", \"Filter type: Bilateral\"]"
        prerender_aov "MAX_RS_DEN_021" RprEmission 1 "[\"AOV: Emission\", \"Filter type: Bilateral\"]"
        prerender_aov "MAX_RS_DEN_022" RprVelocity 1 "[\"AOV: Velocity\", \"Filter type: Bilateral\"]"
        prerender_aov "MAX_RS_DEN_023" RprDirectIllumination 1 "[\"AOV: Direct Illumination\", \"Filter type: Bilateral\"]"
        prerender_aov "MAX_RS_DEN_024" RprIndirectIllumination 1 "[\"AOV: Indirect Illumination\", \"Filter type: Bilateral\"]"
        prerender_aov "MAX_RS_DEN_025" RprAO 1 "[\"AOV: AO\", \"Filter type: Bilateral\"]"
        prerender_aov "MAX_RS_DEN_026" RprDirectDiffuse 1 "[\"AOV: Direct Diffuse\", \"Filter type: Bilateral\"]"
        prerender_aov "MAX_RS_DEN_027" RprDirectReflect 1 "[\"AOV: Direct Reflect\", \"Filter type: Bilateral\"]"
        prerender_aov "MAX_RS_DEN_028" RprIndirectDiffuse 1 "[\"AOV: Indirect Diffuse\", \"Filter type: Bilateral\"]"
        prerender_aov "MAX_RS_DEN_029" RprIndirectReflect 1 "[\"AOV: Indirect Reflect\", \"Filter type: Bilateral\"]"
        prerender_aov "MAX_RS_DEN_030" RprRefract 1 "[\"AOV: Refract\", \"Filter type: Bilateral\"]"
        prerender_aov "MAX_RS_DEN_031" RprVolume 1 "[\"AOV: Volume\", \"Filter type: Bilateral\"]"

        prerender_aov "MAX_RS_DEN_032" RprOpacity 2 "[\"AOV: Opacity\", \"Filter type: Local Weighted Regression\"]"
        prerender_aov "MAX_RS_DEN_033" RprWorldCoordinate 2 "[\"AOV: World Coordinate\", \"Filter type: Local Weighted Regression\"]"
        prerender_aov "MAX_RS_DEN_034" RprUV 2 "[\"AOV: UV\", \"Filter type: Local Weighted Regression\"]"
        prerender_aov "MAX_RS_DEN_035" RprMaterialIdx 2 "[\"AOV: Material Index\", \"Filter type: Local Weighted Regression\"]"
        prerender_aov "MAX_RS_DEN_036" RprGeometricNormal 2 "[\"AOV: Geometric Normal\", \"Filter type: Local Weighted Regression\"]"
        prerender_aov "MAX_RS_DEN_037" RprShadingNormal 2 "[\"AOV: Shading Normal\", \"Filter type: Local Weighted Regression\"]"
        prerender_aov "MAX_RS_DEN_038" RprDepth 2 "[\"AOV: Depth\", \"Filter type: Local Weighted Regression\"]"
        prerender_aov "MAX_RS_DEN_039" RprObjectId 2 "[\"AOV: Object ID\", \"Filter type: Local Weighted Regression\"]"
        prerender_aov "MAX_RS_DEN_040" RprObjectGroupId 2 "[\"AOV: Object Group ID\", \"Filter type: Local Weighted Regression\"]"
        prerender_aov "MAX_RS_DEN_041" RprBackground 2 "[\"AOV: Background\", \"Filter type: Local Weighted Regression\"]"
        prerender_aov "MAX_RS_DEN_042" RprEmission 2 "[\"AOV: Emission\", \"Filter type: Local Weighted Regression\"]"
        prerender_aov "MAX_RS_DEN_043" RprVelocity 2 "[\"AOV: Velocity\", \"Filter type: Local Weighted Regression\"]"
        prerender_aov "MAX_RS_DEN_044" RprDirectIllumination 2 "[\"AOV: Direct Illumination\", \"Filter type: Local Weighted Regression\"]"
        prerender_aov "MAX_RS_DEN_045" RprIndirectIllumination 2 "[\"AOV: Indirect Illumination\", \"Filter type: Local Weighted Regression\"]"
        prerender_aov "MAX_RS_DEN_046" RprAO 2 "[\"AOV: AO\", \"Filter type: Local Weighted Regression\"]"
        prerender_aov "MAX_RS_DEN_047" RprDirectDiffuse 2 "[\"AOV: Direct Diffuse\", \"Filter type: Local Weighted Regression\"]"
        prerender_aov "MAX_RS_DEN_048" RprDirectReflect 2 "[\"AOV: Direct Reflect\", \"Filter type: Local Weighted Regression\"]"
        prerender_aov "MAX_RS_DEN_049" RprIndirectDiffuse 2 "[\"AOV: Indirect Diffuse\", \"Filter type: Local Weighted Regression\"]"
        prerender_aov "MAX_RS_DEN_050" RprIndirectReflect 2 "[\"AOV: Indirect Reflect\", \"Filter type: Local Weighted Regression\"]"
        prerender_aov "MAX_RS_DEN_051" RprRefract 2 "[\"AOV: Refract\", \"Filter type: Local Weighted Regression\"]"
        prerender_aov "MAX_RS_DEN_052" RprVolume 2 "[\"AOV: Volume\", \"Filter type: Local Weighted Regression\"]"

        prerender_aov "MAX_RS_DEN_053" RprOpacity 3 "[\"AOV: Opacity\", \"Filter type: Edge Avoiding Wavelets\"]"
        prerender_aov "MAX_RS_DEN_054" RprWorldCoordinate 3 "[\"AOV: World Coordinate\", \"Filter type: Edge Avoiding Wavelets\"]"
        prerender_aov "MAX_RS_DEN_055" RprUV 3 "[\"AOV: UV\", \"Filter type: Edge Avoiding Wavelets\"]"
        prerender_aov "MAX_RS_DEN_056" RprMaterialIdx 3 "[\"AOV: Material Index\", \"Filter type: Edge Avoiding Wavelets\"]"
        prerender_aov "MAX_RS_DEN_057" RprGeometricNormal 3 "[\"AOV: Geometric Normal\", \"Filter type: Edge Avoiding Wavelets\"]"
        prerender_aov "MAX_RS_DEN_058" RprShadingNormal 3 "[\"AOV: Shading Normal\", \"Filter type: Edge Avoiding Wavelets\"]"
        prerender_aov "MAX_RS_DEN_059" RprDepth 3 "[\"AOV: Depth\", \"Filter type: Edge Avoiding Wavelets\"]"
        prerender_aov "MAX_RS_DEN_060" RprObjectId 3 "[\"AOV: Object ID\", \"Filter type: Edge Avoiding Wavelets\"]"
        prerender_aov "MAX_RS_DEN_061" RprObjectGroupId 3 "[\"AOV: Object Group ID\", \"Filter type: Edge Avoiding Wavelets\"]"
        prerender_aov "MAX_RS_DEN_062" RprBackground 3 "[\"AOV: Background\", \"Filter type: Edge Avoiding Wavelets\"]"
        prerender_aov "MAX_RS_DEN_063" RprEmission 3 "[\"AOV: Emission\", \"Filter type: Edge Avoiding Wavelets\"]"
        prerender_aov "MAX_RS_DEN_064" RprVelocity 3 "[\"AOV: Velocity\", \"Filter type: Edge Avoiding Wavelets\"]"
        prerender_aov "MAX_RS_DEN_065" RprDirectIllumination 3 "[\"AOV: Direct Illumination\", \"Filter type: Edge Avoiding Wavelets\"]"
        prerender_aov "MAX_RS_DEN_066" RprIndirectIllumination 3 "[\"AOV: Indirect Illumination\", \"Filter type: Edge Avoiding Wavelets\"]"
        prerender_aov "MAX_RS_DEN_067" RprAO 3 "[\"AOV: AO\", \"Filter type: Edge Avoiding Wavelets\"]"
        prerender_aov "MAX_RS_DEN_068" RprDirectDiffuse 3 "[\"AOV: Direct Diffuse\", \"Filter type: Edge Avoiding Wavelets\"]"
        prerender_aov "MAX_RS_DEN_069" RprDirectReflect 3 "[\"AOV: Direct Reflect\", \"Filter type: Edge Avoiding Wavelets\"]"
        prerender_aov "MAX_RS_DEN_070" RprIndirectDiffuse 3 "[\"AOV: Indirect Diffuse\", \"Filter type: Edge Avoiding Wavelets\"]"
        prerender_aov "MAX_RS_DEN_071" RprIndirectReflect 3 "[\"AOV: Indirect Reflect\", \"Filter type: Edge Avoiding Wavelets\"]"
        prerender_aov "MAX_RS_DEN_072" RprRefract 3 "[\"AOV: Refract\", \"Filter type: Edge Avoiding Wavelets\"]"
        prerender_aov "MAX_RS_DEN_073" RprVolume 3 "[\"AOV: Volume\", \"Filter type: Edge Avoiding Wavelets\"]"

    )
)

main()
resetMaxFile #noPrompt
quitMax #noPrompt
