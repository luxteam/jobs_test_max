
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
       
    )
)

main()
resetMaxFile #noPrompt
quitMax #noPrompt
