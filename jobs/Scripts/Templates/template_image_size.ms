function prerender test_list = (
    
    renderers.current = Radeon_ProRender()
    renderers.current.passLimit = {pass_limit}

    renderWidth = test_list[3]
    renderHeight = test_list[4]
    
    setRendApertureWidth = test_list[5]
    rendImageAspectRatio = test_list[6]
    renderPiXelAspect = test_list[7]
    
    rpr_render "jpg" test_list[1] test_list[2]
)

function main sf = (
    
    list_tests = #(
        #("MAX_RS_IS_001", "[\"Preset: 35mm 1.316:1 Full Aperture (cine)\", \"Resolution: 512x389\"]", 512, 389, 24, 1.316, 1),
        #("MAX_RS_IS_002", "[\"Preset: 35mm 1.316:1 Full Aperture (cine)\", \"Resolution: 1536x1167\"]", 1536, 1167, 24, 1.316, 1),
        #("MAX_RS_IS_003", "[\"Preset: 35mm 1.316:1 Full Aperture (cine)\", \"Resolution: 2048x1556\"]", 2048, 1556, 24, 1.316, 1),
        #("MAX_RS_IS_004", "[\"Preset: 35mm 1.316:1 Full Aperture (cine)\", \"Resolution: 4096x3112\"]", 4096, 3112, 24, 1.316, 1),

        #("MAX_RS_IS_005", "[\"Preset: 35mm 1.37:1 Academy (cine)\", \"Resolution: 457x333\"]", 457, 333, 20.955, 1.369, 1),
        #("MAX_RS_IS_006", "[\"Preset: 35mm 1.37:1 Academy (cine)\", \"Resolution: 1371x999\"]", 1371, 999, 20.955, 1.369, 1),
        #("MAX_RS_IS_007", "[\"Preset: 35mm 1.37:1 Academy (cine)\", \"Resolution: 1828x1332\"]", 1828, 1332, 20.955, 1.369, 1),
        #("MAX_RS_IS_008", "[\"Preset: 35mm 1.37:1 Academy (cine)\", \"Resolution: 3656x2664\"]", 3656, 2664, 20.955, 1.369, 1),

        #("MAX_RS_IS_009", "[\"Preset: 35mm 1.66:1 (cine)\", \"Resolution: 250x150\"]", 250, 150, 20.955, 1.666, 1), 
        #("MAX_RS_IS_010", "[\"Preset: 35mm 1.66:1 (cine)\", \"Resolution: 1024x614\"]", 1024, 614, 20.955, 1.666, 1), 
        #("MAX_RS_IS_011", "[\"Preset: 35mm 1.66:1 (cine)\", \"Resolution: 1536x921\"]", 1536, 921, 20.955, 1.666, 1), 
        #("MAX_RS_IS_012", "[\"Preset: 35mm 1.66:1 (cine)\", \"Resolution: 4096x2458\"]", 4096, 2458, 20.955, 1.666, 1),

        #("MAX_RS_IS_013", "[\"Preset: 35mm 1.75:1 (cine)\", \"Resolution: 350x200\"]", 350, 200, 20.955, 1.75, 1),
        #("MAX_RS_IS_014", "[\"Preset: 35mm 1.75:1 (cine)\", \"Resolution: 1120x640\"]", 1120, 640, 20.955, 1.75, 1),
        #("MAX_RS_IS_015", "[\"Preset: 35mm 1.75:1 (cine)\", \"Resolution: 1575x900\"]", 1575, 900, 20.955, 1.75, 1),
        #("MAX_RS_IS_016", "[\"Preset: 35mm 1.75:1 (cine)\", \"Resolution: 4096x2340\"]", 4096, 2340, 20.955, 1.75, 1),

        #("MAX_RS_IS_017", "[\"Preset: 35mm 1.85:1 (cine)\", \"Resolution: 370x200\"]", 370, 200, 20.955, 1.85, 1),
        #("MAX_RS_IS_018", "[\"Preset: 35mm 1.85:1 (cine)\", \"Resolution: 1024x554\"]", 1024, 554, 20.955, 1.85, 1),
        #("MAX_RS_IS_019", "[\"Preset: 35mm 1.85:1 (cine)\", \"Resolution: 1536x830\"]", 1536, 830, 20.955, 1.85, 1),
        #("MAX_RS_IS_020", "[\"Preset: 35mm 1.85:1 (cine)\", \"Resolution: 4096x2214\"]", 4096, 2214, 20.955, 1.85, 1),
       
        #("MAX_RS_IS_021", "[\"Preset: 35mm Anamorphic (2.35:1)\", \"Resolution: 256x109\"]", 256, 109, 42.57, 2.35, 1),
        #("MAX_RS_IS_022", "[\"Preset: 35mm Anamorphic (2.35:1)\", \"Resolution: 1024x436\"]", 1024, 436, 42.57, 2.35, 1),
        #("MAX_RS_IS_023", "[\"Preset: 35mm Anamorphic (2.35:1)\", \"Resolution: 1828x778\"]", 1828, 778, 42.57, 2.35, 1),
        #("MAX_RS_IS_024", "[\"Preset: 35mm Anamorphic (2.35:1)\", \"Resolution: 4096x1743\"]", 4096, 1743, 42.57, 2.35, 1)

        #("MAX_RS_IS_025", "[\"Preset: 35mm Anamorphic (2.35:1) (Squeezed)\", \"Resolution: 256x218\"]", 256, 218, 42.57, 2.35, 2),
        #("MAX_RS_IS_026", "[\"Preset: 35mm Anamorphic (2.35:1) (Squeezed)\", \"Resolution: 1024x871\"]", 1024, 871, 42.57, 2.35, 2),
        #("MAX_RS_IS_027", "[\"Preset: 35mm Anamorphic (2.35:1) (Squeezed)\", \"Resolution: 1828x1556\"]", 1828, 1556, 42.57, 2.35, 2)
        #("MAX_RS_IS_028", "[\"Preset: 35mm Anamorphic (2.35:1) (Squeezed)\", \"Resolution: 4096x3486\"]", 4096, 3486, 42.57, 2.35, 2)

        #("MAX_RS_IS_029", "[\"Preset: 70mm Panavision (cine)\", \"Resolution: 440x200\"]", 440, 200, 48.59, 2.2, 2),
        #("MAX_RS_IS_030", "[\"Preset: 70mm Panavision (cine)\", \"Resolution: 1024x465\"]", 1024, 465, 48.59, 2.2, 2),
        #("MAX_RS_IS_031", "[\"Preset: 70mm Panavision (cine)\", \"Resolution: 1536x698\"]", 1536, 698, 48.59, 2.2, 2),
        #("MAX_RS_IS_032", "[\"Preset: 70mm Panavision (cine)\", \"Resolution: 4096x1862\"]", 4096, 1862, 48.59, 2.2, 2),

        #("MAX_RS_IS_033", "[\"Preset: 70mm IMAX (cine)\", \"Resolution: 256x188\"]", 256, 188, 48.59, 1.364, 1),
        #("MAX_RS_IS_034", "[\"Preset: 70mm IMAX (cine)\", \"Resolution: 1024x751\"]", 1024, 751, 48.59, 1.364, 1),
        #("MAX_RS_IS_035", "[\"Preset: 70mm IMAX (cine)\", \"Resolution: 1536x1126\"]", 1536, 1126, 48.59, 1.364, 1),
        #("MAX_RS_IS_036", "[\"Preset: 70mm IMAX (cine)\", \"Resolution: 4096x3003\"]", 4096, 3003, 48.59, 1.364, 1),

        #("MAX_RS_IS_037", "[\"Preset: VistaVision\", \"Resolution: 360x240\"]", 360, 240, 37.719, 1.5, 1),
        #("MAX_RS_IS_038", "[\"Preset: VistaVision\", \"Resolution: 1024x683\"]", 1024, 683, 37.719, 1.5, 1),
        #("MAX_RS_IS_039", "[\"Preset: VistaVision\", \"Resolution: 1536x1024\"]", 1536, 1024, 37.719, 1.5, 1),
        #("MAX_RS_IS_040", "[\"Preset: VistaVision\", \"Resolution: 4096x2731\"]", 4096, 2731, 37.719, 1.5, 1),

        #("MAX_RS_IS_041", "[\"Preset: 35mm (24mm X 36mm) (slide)\", \"Resolution: 360x240\"]", 360, 240, 34.2, 1.5, 1),
        #("MAX_RS_IS_042", "[\"Preset: 35mm (24mm X 36mm) (slide)\", \"Resolution: 1024x683\"]", 1024, 683, 34.2, 1.5, 1),
        #("MAX_RS_IS_043", "[\"Preset: 35mm (24mm X 36mm) (slide)\", \"Resolution: 1536x1024\"]", 1536, 1024, 34.2, 1.5, 1),
        #("MAX_RS_IS_044", "[\"Preset: 35mm (24mm X 36mm) (slide)\", \"Resolution: 4096x2731\"]", 4096, 2731, 34.2, 1.5, 1),

        #("MAX_RS_IS_045", "[\"Preset: 6cm X 6cm (slide)\", \"Resolution: 256x256\"]", 256, 256, 51.6, 1, 1),
        #("MAX_RS_IS_046", "[\"Preset: 6cm X 6cm (slide)\", \"Resolution: 1024x1024\"]", 1024, 1024, 51.6, 1, 1),
        #("MAX_RS_IS_047", "[\"Preset: 6cm X 6cm (slide)\", \"Resolution: 1536x1536\"]", 1536, 1536, 51.6, 1, 1),
        #("MAX_RS_IS_048", "[\"Preset: 6cm X 6cm (slide)\", \"Resolution: 4096x4096\"]", 4096, 4096, 51.6, 1, 1),

        #("MAX_RS_IS_049", "[\"Preset: 4 X 5 or 8 X 10 (slide)\", \"Resolution: 512x410\"]", 512, 410, 88.9, 1.25, 1),
        #("MAX_RS_IS_050", "[\"Preset: 4 X 5 or 8 X 10 (slide)\", \"Resolution: 1024x819\"]", 1024, 819, 88.9, 1.25, 1),
        #("MAX_RS_IS_051", "[\"Preset: 4 X 5 or 8 X 10 (slide)\", \"Resolution: 1536x1229\"]", 1536, 1229, 88.9, 1.25, 1),
        #("MAX_RS_IS_052", "[\"Preset: 4 X 5 or 8 X 10 (slide)\", \"Resolution: 4096x3277\"]", 4096, 3277, 88.9, 1.25, 1),

        #("MAX_RS_IS_053", "[\"Preset: NTSC D-1 (video)\", \"Resolution: 720x486\"]", 720, 486, 20.12, 1.333, 0.9),
        #("MAX_RS_IS_054", "[\"Preset: NTSC D-1 (video)\", \"Resolution: 200x135\"]", 200, 135, 20.12, 1.333, 0.9),
        #("MAX_RS_IS_055", "[\"Preset: NTSC D-1 (video)\", \"Resolution: 360x243\"]", 360, 243, 20.12, 1.333, 0.9),
        #("MAX_RS_IS_056", "[\"Preset: NTSC D-1 (video)\", \"Resolution: 512x346\"]", 512, 346, 20.12, 1.333, 0.9),

        #("MAX_RS_IS_057", "[\"Preset: NTSC DV (video)\", \"Resolution: 720x480\"]", 720, 480, 20.12, 1.35, 0.9),
        #("MAX_RS_IS_058", "[\"Preset: NTSC DV (video)\", \"Resolution: 300x200\"]", 300, 200, 20.12, 1.35, 0.9),
        #("MAX_RS_IS_059", "[\"Preset: NTSC DV (video)\", \"Resolution: 360x240\"]", 360, 240, 20.12, 1.35, 0.9),
        #("MAX_RS_IS_060", "[\"Preset: NTSC DV (video)\", \"Resolution: 512x341\"]", 512, 341, 20.12, 1.35, 0.9),

        #("MAX_RS_IS_061", "[\"Preset: PAL (video)\", \"Resolution: 768x576\"]", 768, 576, 20.12, 1.333, 1),
        #("MAX_RS_IS_062", "[\"Preset: PAL (video)\", \"Resolution: 180x135\"]", 180, 135, 20.12, 1.333, 1),
        #("MAX_RS_IS_063", "[\"Preset: PAL (video)\", \"Resolution: 240x180\"]", 240, 180, 20.12, 1.333, 1),
        #("MAX_RS_IS_064", "[\"Preset: PAL (video)\", \"Resolution: 480x360\"]", 480, 360, 20.12, 1.333, 1),

        #("MAX_RS_IS_065", "[\"Preset: PAL D-1 (video)\", \"Resolution: 720x576\"]", 720, 576, 20.12, 1.333, 1.066),
        #("MAX_RS_IS_066", "[\"Preset: PAL D-1 (video)\", \"Resolution: 180x144\"]", 180, 144, 20.12, 1.333, 1.066),
        #("MAX_RS_IS_067", "[\"Preset: PAL D-1 (video)\", \"Resolution: 240x192\"]", 240, 192, 20.12, 1.333, 1.066),
        #("MAX_RS_IS_068", "[\"Preset: PAL D-1 (video)\", \"Resolution: 480x384\"]", 480, 384, 20.12, 1.333, 1.066),

        #("MAX_RS_IS_069", "[\"Preset: HDTV (video)\", \"Resolution: 1920x1080\"]", 1920, 1080, 20.12, 1.777, 1),
        #("MAX_RS_IS_070", "[\"Preset: HDTV (video)\", \"Resolution: 480x270\"]", 480, 270, 20.12, 1.777, 1),
        #("MAX_RS_IS_071", "[\"Preset: HDTV (video)\", \"Resolution: 1280x720\"]", 1280, 720, 20.12, 1.777, 1), 
        #("MAX_RS_IS_072", "[\"Preset: HDTV (video)\", \"Resolution: 320x180\"]", 320, 180, 20.12, 1.777, 1),

        #("MAX_RS_IS_073", "[\"Resolution: 2000x2000\"]", 2000, 2000, 36, 1.333, 1),
        #("MAX_RS_IS_074", "[\"Resolution: 3000x3000\"]", 3000, 3000, 36, 1.333, 1),
        #("MAX_RS_IS_075", "[\"Resolution: 4000x4000\"]", 4000, 4000, 36, 1.333, 1),
        #("MAX_RS_IS_076", "[\"Resolution: 5000x5000\"]", 5000, 5000, 36, 1.333, 1),
        #("MAX_RS_IS_077", "[\"Resolution: 6000x6000\"]", 6000, 6000, 36, 1.333, 1),
        #("MAX_RS_IS_078", "[\"Resolution: 7000x7000\"]", 7000, 7000, 36, 1.333, 1),
        #("MAX_RS_IS_079", "[\"Resolution: 8000x8000\"]", 8000, 8000, 36, 1.333, 1),

        #("MAX_RS_IS_080", "[\"Resolution: 1024x1024\"]", 1024, 1024, 36, 1.333, 1),
        #("MAX_RS_IS_081", "[\"Resolution: 2048x2048\"]", 2048, 2048, 36, 1.333, 1),
        #("MAX_RS_IS_082", "[\"Resolution: 3072x3072\"]", 3072, 3072, 36, 1.333, 1),
        #("MAX_RS_IS_083", "[\"Resolution: 4096x4096\"]", 4096, 4096, 36, 1.333, 1),
        #("MAX_RS_IS_084", "[\"Resolution: 1500x1125\"]", 1500, 1125, 36, 1.333, 1)
    )

    filesToRender = #(
        {scene_list}
    )
    
    for fi=1 to filesToRender.count do (
        assetsFile = "{res_path}" + "\\" + filesToRender[fi]
        loadMaXFile assetsFile useFileUnits:true quiet:true

        if (sf != 1) (
            create_failed_report list_tests[sf-1][1] list_tests[$sf-1][2] "failed"
        )

        for sf=1 to list_tests.count do (
            prerender list_tests[sf]
        )
    )
)

main()
resetMaXFile #noPrompt
quitMaX #noPrompt
