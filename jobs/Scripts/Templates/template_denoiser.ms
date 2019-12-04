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
        renderers.current.enableDenoiser = true

        case cases[i]["name"] of (
            "MAX_RS_DEN_001": bilateral 1
            "MAX_RS_DEN_002": bilateral 5
            "MAX_RS_DEN_003": bilateral 10
            "MAX_RS_DEN_004": LWR false false false
            "MAX_RS_DEN_005": LWR 2 false false
            "MAX_RS_DEN_006": LWR 10 false false
            "MAX_RS_DEN_007": LWR false false 1
            "MAX_RS_DEN_008": LWR false false 10
            "MAX_RS_DEN_009": LWR false 0.1 false
            "MAX_RS_DEN_010": LWR false 1 false
            "MAX_RS_DEN_011": LWR 2 0.1 1
            "MAX_RS_DEN_012": LWR 5 0.5 5
            "MAX_RS_DEN_013": LWR 10 0.1 10
            "MAX_RS_DEN_014": EAW false false false false
            "MAX_RS_DEN_015": EAW 0.1 false false false
            "MAX_RS_DEN_016": EAW 1 false false false
            "MAX_RS_DEN_017": EAW false false 0.1 false
            "MAX_RS_DEN_018": EAW false false 1 false
            "MAX_RS_DEN_019": EAW false 0.1 false false
            "MAX_RS_DEN_020": EAW false 1 false false
            "MAX_RS_DEN_021": EAW false false false 0.1
            "MAX_RS_DEN_022": EAW false false false 1
            "MAX_RS_DEN_023": EAW 0.1 0.1 0.1 0.1
            "MAX_RS_DEN_024": EAW 1 1 1 1
            "MAX_RS_DEN_025": renderers.current.denoiserType = 4
            -- "MAX_RS_DEN_026": <...>
            -- "MAX_RS_DEN_027": <...>
            -- "MAX_RS_DEN_028": <...>
            -- "MAX_RS_DEN_029": <...> 
            "MAX_RS_DEN_030": bilateral 1
            "MAX_RS_DEN_031": bilateral 5
            "MAX_RS_DEN_032": bilateral 10
            -- "MAX_RS_DEN_033": <...>
            "MAX_RS_DEN_034": LWR 5 false false
            "MAX_RS_DEN_035": LWR 10 false false
            "MAX_RS_DEN_036": LWR false false 5
            "MAX_RS_DEN_037": LWR false false 10
            "MAX_RS_DEN_038": LWR false 0.1 false
            "MAX_RS_DEN_039": EAW 0.1 0.1 0.1 0.1
            "MAX_RS_DEN_040": EAW 0.5 0.5 0.5 0.5
            -- "MAX_RS_DEN_041": <...>
            -- "MAX_RS_DEN_042": <...>
            -- "MAX_RS_DEN_043": <...>
            -- "MAX_RS_DEN_044": <...>
            -- "MAX_RS_DEN_045": <...>
            -- "MAX_RS_DEN_046": <...>
            -- "MAX_RS_DEN_047": <...>
            -- "MAX_RS_DEN_048": <...>
            -- "MAX_RS_DEN_049": <...>
            -- "MAX_RS_DEN_050": <...>
            -- "MAX_RS_DEN_051": <...>
            -- "MAX_RS_DEN_052": <...>
            "MAX_RS_DEN_053": EAW false false false false
            "MAX_RS_DEN_054": LWR false false false
            "MAX_RS_DEN_055": bilateral false
            -- "MAX_RS_DEN_056": <...>
            -- "MAX_RS_DEN_057": <...>
            "MAX_RS_DEN_058": EAW false false false false
            "MAX_RS_DEN_059": LWR false false false
            "MAX_RS_DEN_060": bilateral false
            -- "MAX_RS_DEN_061": <...>
            -- "MAX_RS_DEN_062": <...>
            "MAX_RS_DEN_063": EAW false false false false
            "MAX_RS_DEN_064": LWR false false false
            "MAX_RS_DEN_065": bilateral false
            -- "MAX_RS_DEN_066": <...>
            -- "MAX_RS_DEN_067": <...>
            "MAX_RS_DEN_068": EAW false false false false
            "MAX_RS_DEN_069": LWR false false false
            "MAX_RS_DEN_070": bilateral false
        )

        rpr_render image_format cases[i]["name"] cases[i]["script_info"]
        caseList.setCaseStatus i "done"
    )
)


main()
resetMaxFile #noPrompt
quitMax #noPrompt
