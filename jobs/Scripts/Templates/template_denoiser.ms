
function prerender_aov test_case aov denoiser = (
    
    renderers.current = Radeon_ProRender()
    renderers.current.passLimit = {pass_limit}
    renderHeight = {resolution_y}
    renderWidth = {resolution_x}

    renderers.current.enableDenoiser = True
    renderers.current.denoiserType = denoiser

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

    rpr_render "jpg" test_case
)

function prerender_bilateral test_case param1 = (
    
    renderers.current = Radeon_ProRender()
    renderers.current.passLimit = {pass_limit}

    renderers.current.enableDenoiser = True
    renderers.current.denoiserType = 1

    renderers.current.bilateralRadius = param1

    rpr_render "jpg" test_case
)

function prerender_lwr test_case param1 param2 = (
    
    renderers.current = Radeon_ProRender()
    renderers.current.passLimit = {pass_limit}

    renderers.current.enableDenoiser = True
    renderers.current.denoiserType = 2

    renderers.current.lwrSamples = param1
    renderers.current.lwrRadius = param1
    renderers.current.lwrBandwidth = param2

    rpr_render "jpg" test_case
)

function prerender_eaw test_case param1 = (
    
    renderers.current = Radeon_ProRender()
    renderers.current.passLimit = {pass_limit}

    renderers.current.enableDenoiser = True
    renderers.current.denoiserType = 3

    renderers.current.eawColor = param1
    renderers.current.eawNormal = param1
    renderers.current.eawDepth = param1
    renderers.current.eawObjectId = param1

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

        prerender_bilateral "MAX_RS_DEN_001" 1
        prerender_bilateral "MAX_RS_DEN_002" 3
        prerender_bilateral "MAX_RS_DEN_003" 6
        prerender_bilateral "MAX_RS_DEN_004" 10

        prerender_lwr "MAX_RS_DEN_005" 1 0.1
        prerender_lwr "MAX_RS_DEN_006" 5 0.5
        prerender_lwr "MAX_RS_DEN_007" 10 1

        prerender_eaw "MAX_RS_DEN_008" 0.1
        prerender_eaw "MAX_RS_DEN_009" 0.5
        prerender_eaw "MAX_RS_DEN_0010" 1

        for aov=1 to aovs.count do (
        prerender_aov ("MAX_RS_AOV_0" + (aov+10) as string) aovs[aov] 1
        )

        for aov=1 to aovs.count do (
        prerender_aov ("MAX_RS_AOV_0" + (aov+31) as string) aovs[aov] 2
        )

        for aov=1 to aovs.count do (
        prerender_aov ("MAX_RS_AOV_0" + (aov+52) as string) aovs[aov] 3
        )

    )
)

main()
resetMaxFile #noPrompt
quitMax #noPrompt
