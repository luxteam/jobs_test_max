
function prerender test_case aov script_info = (
    
    renderers.current = Radeon_ProRender()
    renderers.current.passLimit = {pass_limit}
    if ({resolution_y} != 0 and {resolution_x} != 0) do (
        renderHeight = {resolution_y}
        renderWidth = {resolution_x}
    )

    re = maxOps.GetCurRenderElementMgr()
    re.removeallrenderelements()

    re.addrenderelement (aov elementname:(aov as string))

    rpr_render "jpg" test_case script_info
)

function main = (
    
    filesToRender = #(
        {scene_list}
    )

    for fi=1 to filesToRender.count do (
        assetsFile = "{res_path}" + "\\" + filesToRender[fi]
        loadMaxFile assetsFile useFileUnits:true quiet:true

        prerender "MAX_RS_AOV_001" RprOpacity "[\"AOV: Opacity\"]"
        prerender "MAX_RS_AOV_002" RprWorldCoordinate "[\"AOV: World Coordinate\"]"
        prerender "MAX_RS_AOV_003" RprUV "[\"AOV: UV\"]"
        prerender "MAX_RS_AOV_004" RprMaterialIdx "[\"AOV: Material Index\"]"
        prerender "MAX_RS_AOV_005" RprGeometricNormal "[\"AOV: Geometric Normal\"]"
        prerender "MAX_RS_AOV_006" RprShadingNormal "[\"AOV: Shading Normal\"]"
        prerender "MAX_RS_AOV_007" RprDepth "[\"AOV: Depth\"]"
        prerender "MAX_RS_AOV_008" RprObjectId "[\"AOV: Object ID\"]"
        prerender "MAX_RS_AOV_009" RprObjectGroupId "[\"AOV: Object Group ID\"]"
        prerender "MAX_RS_AOV_010" RprBackground "[\"AOV: Background\"]"
        prerender "MAX_RS_AOV_011" RprEmission "[\"AOV: Emission\"]"
        prerender "MAX_RS_AOV_012" RprVelocity "[\"AOV: Velocity\"]"
        prerender "MAX_RS_AOV_013" RprDirectIllumination "[\"AOV: Direct Illumination\"]"
        prerender "MAX_RS_AOV_014" RprIndirectIllumination "[\"AOV: Indirect Illumination\"]"
        prerender "MAX_RS_AOV_015" RprAO "[\"AOV: AO\"]"
        prerender "MAX_RS_AOV_016" RprDirectDiffuse "[\"AOV: Direct Diffuse\"]"
        prerender "MAX_RS_AOV_017" RprDirectReflect "[\"AOV: Direct Reflect\"]"
        prerender "MAX_RS_AOV_018" RprIndirectDiffuse "[\"AOV: Indirect Diffuse\"]"
        prerender "MAX_RS_AOV_019" RprIndirectReflect "[\"AOV: Indirect Reflect\"]"
        prerender "MAX_RS_AOV_020" RprRefract "[\"AOV: Refract\"]"
        prerender "MAX_RS_AOV_021" RprVolume "[\"AOV: Volume\"]"

    )
)

main()
resetMaxFile #noPrompt
quitMax #noPrompt
