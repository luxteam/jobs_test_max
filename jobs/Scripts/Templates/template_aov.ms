
function prerender test_case aov = (
    
    renderers.current = Radeon_ProRender()
    renderers.current.passLimit = {pass_limit}

    re = maxOps.GetCurRenderElementMgr()
    re.removeallrenderelements()

    re.addrenderelement (aov elementname:(aov as string))

    rpr_render "jpg" test_case
)

function main = (
    
    filesToRender = #(
        {scene_list}
    )
    
    aovs = #(RprOpacity, RprWorldCoordinate, RprUV, RprMaterialIdx, RprGeometricNormal, RprShadingNormal, RprDepth, RprObjectId, RprObjectGroupId, 
    RprBackground, RprEmission, RprVelocity, RprDirectIllumination, RprIndirectIllumination, RprAO, RprDirectDiffuse, RprDirectReflect, RprIndirectDiffuse, RprIndirectReflect, RprRefract, RprVolume)

    for fi=1 to filesToRender.count do (
        assetsFile = "{res_path}" + "\\" + filesToRender[fi]
        loadMaxFile assetsFile quiet:true

        for aov=1 to aovs.count do (
            if (aov < 10) then (
            prerender ("MAX_RS_AOV_00" + aov as string) aovs[aov]
            ) else (
            prerender ("MAX_RS_AOV_0" + aov as string) aovs[aov]
            )

        )
    )
)

main()
resetMaxFile #noPrompt
quitMax #noPrompt
