

function setOutputSize preset = (
    case preset of (
        -- 001         
        "35mm 1.316:1 Full Aperture (cine)": (
            renderWidth=512
            renderHeight=389
            setRendApertureWidth 24.0
            renderPixelAspect = 1.0
            rendImageAspectRatio = 1.3162
        )
        -- 002
        "35mm 1.37:1 Academy (cine)": (
            renderWidth=457
            renderHeight=333
            setRendApertureWidth 20.955
            renderPixelAspect = 1.0
            rendImageAspectRatio = 1.36867
        )
        -- 003
        "35mm 1.66:1 (cine)": (
            renderWidth=250
            renderHeight=150
            setRendApertureWidth 20.955
            renderPixelAspect = 1.0
            rendImageAspectRatio = 1.66667
        )
        -- 004
        "35mm 1.75 (cine)": (
            renderWidth=350
            renderHeight=200
            setRendApertureWidth 20.955
            renderPixelAspect = 1.0
            rendImageAspectRatio = 1.75
        )
        -- 005
        "35mm 1.85 (cine)": (
            renderWidth=370
            renderHeight=200
            setRendApertureWidth 20.955
            renderPixelAspect = 1.0
            rendImageAspectRatio = 1.85
        )
        -- 006
        "35mm Anamorphic (2.35:1)": (
            renderWidth=256
            renderHeight=109
            setRendApertureWidth 42.570
            renderPixelAspect = 1.0
            rendImageAspectRatio = 2.35
        )
        -- 007
        "35mm Anamorphic (2.35:1) (Squeezed)": (
            renderWidth=256
            renderHeight=218
            setRendApertureWidth 42.570
            renderPixelAspect = 2.0
            rendImageAspectRatio = 2.35
        )
        -- 008
        "70mm Panavision (cine)": (
            renderWidth=440
            renderHeight=200
            setRendApertureWidth 28.59
            renderPixelAspect = 1.0
            rendImageAspectRatio = 2.2
        )
        -- 009
        "70mm IMAX (cine)": (
            renderWidth=256
            renderHeight=188
            setRendApertureWidth 48.59
            renderPixelAspect = 1.0
            rendImageAspectRatio = 1.3642
        )
        -- 010
        "VistaVision": (
            renderWidth=360
            renderHeight=240
            setRendApertureWidth 37.719
            renderPixelAspect = 1.0
            rendImageAspectRatio = 1.5
        )
        -- 011
        "35mm ( 24mm X 36mm) (slide)": (
            renderWidth=360
            renderHeight=240
            setRendApertureWidth 34.2
            renderPixelAspect = 1.0
            rendImageAspectRatio = 1.5
        )
        -- 012
        "6cm X 6cm (2 1/4 X 2 1/4) (slide)": (
            renderWidth=256
            renderHeight=256
            setRendApertureWidth 51.600
            renderPixelAspect = 1.0
            rendImageAspectRatio = 1.0
        )
        -- 013
        "4 X 5 or 8 X 10 (slide)": (
            renderWidth=512
            renderHeight=410
            setRendApertureWidth 88.9
            renderPixelAspect = 1.0
            rendImageAspectRatio = 1.25
        )
        -- 014
        "NTSC D-1 (video)": (
            renderWidth=720
            renderHeight=486
            setRendApertureWidth 20.12
            renderPixelAspect = 0.9
            rendImageAspectRatio = 1.33333
        )
        -- 015
        "NTSC DV (video)": (
            renderWidth=720
            renderHeight=480
            setRendApertureWidth 20.12
            renderPixelAspect = 0.9
            rendImageAspectRatio = 1.35
        )
        -- 016
        "PAL (video)": (
            renderWidth=768
            renderHeight=576
            setRendApertureWidth 20.120
            renderPixelAspect = 1.0
            rendImageAspectRatio = 1.33333
        )
        -- 017
        "PAL D-1 (video)": (
            renderWidth=720
            renderHeight=576
            setRendApertureWidth 20.12
            renderPixelAspect = 1.06667
            rendImageAspectRatio = 1.33333
        )
        -- 018
        "HDTV (video)": (
            renderWidth=1920
            renderHeight=1080
            setRendApertureWidth 20.12
            renderPixelAspect = 1.0
            rendImageAspectRatio = 1.77778
        )
        -- 018
        "4000x4000": (
            renderWidth=4000
            renderHeight=4000
        )
        "5000x5000": (
            renderWidth=5000
            renderHeight=5000
        )
        "6000x6000": (
            renderWidth=6000
            renderHeight=6000
        )
        
        default: print -1
    )
)


function main = (
    renderers.current = Radeon_ProRender()
    cases = caseList.get_data()
    cases = cases["cases"]
    for i=1 to cases.count do (
        if (cases[i]["status"] != "active") do continue
        caseList.setCaseStatus i "progress"
        
        assetFile = "{res_path}\\{package_name}\\" + cases[i]["scene_name"]
        loadMaxFile assetFile useFileUnits:true quiet:true
        image_format = "jpg"
        renderers.current.samplesMax = {pass_limit}
        renderers.current.iterations = {SPU}
        renderers.current.adaptiveNoiseThreshold = {threshold}

        setOutputSize cases[i]["preset"]
        rpr_render image_format cases[i]["name"] cases[i]["script_info"]

        caseList.setCaseStatus i "done"
    )
)


main()
resetMaXFile #noPrompt
quitMaX #noPrompt
