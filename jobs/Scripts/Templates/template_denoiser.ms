function bilateral r = (
    if r == false do r = 3

    renderers.current.denoiserType = 1
    renderers.current.bilateralRadius = r
)

function LWR s bW fR = (
    if s == false do s = 4
    if bW == false do bW = 0.1
    if fR == false do fR = 4

    renderers.current.denoiserType = 2
    renderers.current.lwrSamples = s
    renderers.current.lwrBandwidth = bW
    renderers.current.lwrRadius = fR
)

function EAW c n d oId = (
    if c == false do c = 0.1
    if n == false do n = 0.1
    if d == false do d = 0.1
    if oId == false do oId = 0.1

    renderers.current.denoiserType = 3
    renderers.current.eawColor = c
    renderers.current.eawNormal = n
    renderers.current.eawDepth = d
    renderers.current.eawObjectId = oId
)

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
        if ({resolution_y} != 0 and {resolution_x} != 0) do (
            renderHeight = {resolution_y}
            renderWidth = {resolution_x}
        )
        renderers.current.samplesMax = {pass_limit}
        renderers.current.iterations = {SPU}
        renderers.current.adaptiveNoiseThreshold = {threshold}
        renderers.current.enableDenoiser = true



        for p=1 to cases[i]["parameters"].count do (
            case cases[i]["parameters"][p]["class"] of (
                "Denoiser": case cases[i]["parameters"][p]["type"] of (
                    "bilateral": (
                        radius = cases[i]["parameters"][p]["radius"]
                        bilateral radius
                    )
                    "LWR": (
                        samples = cases[i]["parameters"][p]["samples"]
                        filterRadius = cases[i]["parameters"][p]["filter_radius"]
                        bandwidth = cases[i]["parameters"][p]["bandwidth"]
                        LWR samples bandwidth filterRadius
                    )
                    "EWR": (
                        clr = cases[i]["parameters"][p]["color"]
                        depth = cases[i]["parameters"][p]["depth"]
                        normal = cases[i]["parameters"][p]["normal"]
                        objectID = cases[i]["parameters"][p]["objectID"]
                        EAW clr normal depth objectID
                    )
                    default: print "Undefined Denoiser type"
                )
            )
        )

        rpr_render image_format cases[i]["name"] cases[i]["script_info"]
        caseList.setCaseStatus i "done"
    )
)


main()
resetMaxFile #noPrompt
quitMax #noPrompt
