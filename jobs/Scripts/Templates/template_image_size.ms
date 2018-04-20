function prerender test_case width height aperture_width image_aspect_ration piXel_aspect script_info = (
    
    renderers.current = Radeon_ProRender()
    renderers.current.passLimit = {pass_limit}

    renderHeight = height
    renderWidth = width
    setRendApertureWidth = aperture_width
    renderPiXelAspect = piXel_aspect
    rendImageAspectRatio = image_aspect_ration

    rpr_render "jpg" test_case script_info
)

function main = (
    
    filesToRender = #(
        {scene_list}
    )
    
    for fi=1 to filesToRender.count do (
        assetsFile = "{res_path}" + "\\" + filesToRender[fi]
        loadMaXFile assetsFile quiet:true

        prerender "MAX_RS_IS_001" 512 389 24 1.316 1 "[\"Preset: 35mm 1.316:1 Full Aperture (cine)\", \"Resolution: 512x389\"]"
        prerender "MAX_RS_IS_002" 1536 1167 24 1.316 1 "[\"Preset: 35mm 1.316:1 Full Aperture (cine)\", \"Resolution: 1536x1167\"]"
        prerender "MAX_RS_IS_003" 2048 1556 24 1.316 1 "[\"Preset: 35mm 1.316:1 Full Aperture (cine)\", \"Resolution: 2048x1556\"]"
        prerender "MAX_RS_IS_004" 4096 3112 24 1.316 1 "[\"Preset: 35mm 1.316:1 Full Aperture (cine)\", \"Resolution: 4096x3112\"]"

        prerender "MAX_RS_IS_005" 457 333 20.955 1.369 1 "[\"Preset: 35mm 1.37:1 Academy (cine)\", \"Resolution: 457x333\"]"
        prerender "MAX_RS_IS_006" 1371 999 20.955 1.369 1 "[\"Preset: 35mm 1.37:1 Academy (cine)\", \"Resolution: 1371x999\"]"
        prerender "MAX_RS_IS_007" 1828 1332 20.955 1.369 1 "[\"Preset: 35mm 1.37:1 Academy (cine)\", \"Resolution: 1828x1332\"]"
        prerender "MAX_RS_IS_008" 3656 2664 20.955 1.369 1 "[\"Preset: 35mm 1.37:1 Academy (cine)\", \"Resolution: 3656x2664\"]"

        prerender "MAX_RS_IS_009" 250 150 20.955 1.666 1 "[\"Preset: 35mm 1.66:1 (cine)\", \"Resolution: 250x150\"]"
        prerender "MAX_RS_IS_010" 1024 614 20.955 1.666 1 "[\"Preset: 35mm 1.66:1 (cine)\", \"Resolution: 1024x614\"]"
        prerender "MAX_RS_IS_011" 1536 921 20.955 1.666 1 "[\"Preset: 35mm 1.66:1 (cine)\", \"Resolution: 1536x921\"]"
        prerender "MAX_RS_IS_012" 4096 2458 20.955 1.666 1 "[\"Preset: 35mm 1.66:1 (cine)\", \"Resolution: 4096x2458\"]"

        prerender "MAX_RS_IS_013" 350 200 20.955 1.75 1 "[\"Preset: 35mm 1.75:1 (cine)\", \"Resolution: 350x200\"]"
        prerender "MAX_RS_IS_014" 1120 640 20.955 1.75 1 "[\"Preset: 35mm 1.75:1 (cine)\", \"Resolution: 1120x640\"]"
        prerender "MAX_RS_IS_015" 1575 900 20.955 1.75 1 "[\"Preset: 35mm 1.75:1 (cine)\", \"Resolution: 1575x900\"]"
        prerender "MAX_RS_IS_016" 4096 2340 20.955 1.75 1 "[\"Preset: 35mm 1.75:1 (cine)\", \"Resolution: 4096x2340\"]"

        prerender "MAX_RS_IS_017" 370 200 20.955 1.85 1 "[\"Preset: 35mm 1.85:1 (cine)\", \"Resolution: 370x200\"]"
        prerender "MAX_RS_IS_018" 1024 554 20.955 1.85 1 "[\"Preset: 35mm 1.85:1 (cine)\", \"Resolution: 1024x554\"]"
        prerender "MAX_RS_IS_019" 1536 830 20.955 1.85 1 "[\"Preset: 35mm 1.85:1 (cine)\", \"Resolution: 1536x830\"]"
        prerender "MAX_RS_IS_020" 4096 2214 20.955 1.85 1 "[\"Preset: 35mm 1.85:1 (cine)\", \"Resolution: 4096x2214\"]"
       
        prerender "MAX_RS_IS_021" 256 109 42.57 2.35 1 "[\"Preset: 35mm Anamorphic (2.35:1)\", \"Resolution: 256x109\"]"
        prerender "MAX_RS_IS_022" 1024 436 42.57 2.35 1 "[\"Preset: 35mm Anamorphic (2.35:1)\", \"Resolution: 1024x436\"]"
        prerender "MAX_RS_IS_023" 1828 778.57 2.35 1 "[\"Preset: 35mm Anamorphic (2.35:1)\", \"Resolution: 1828x778\"]"
        prerender "MAX_RS_IS_024" 4096 1743 42.57 2.35 1 "[\"Preset: 35mm Anamorphic (2.35:1)\", \"Resolution: 4096x1743\"]"

        prerender "MAX_RS_IS_025" 256 218 42.57 2.35 2 "[\"Preset: 35mm Anamorphic (2.35:1) (Squeezed)\", \"Resolution: 256x218\"]"
        prerender "MAX_RS_IS_026" 1024 871 42.57 2.35 2 "[\"Preset: 35mm Anamorphic (2.35:1) (Squeezed)\", \"Resolution: 1024x871\"]"
        prerender "MAX_RS_IS_027" 1828 1556 42.57 2.35 2 "[\"Preset: 35mm Anamorphic (2.35:1) (Squeezed)\", \"Resolution: 1828x1556\"]"
        prerender "MAX_RS_IS_028" 4096 3486 42.57 2.35 2 "[\"Preset: 35mm Anamorphic (2.35:1) (Squeezed)\", \"Resolution: 4096x3486\"]"

        prerender "MAX_RS_IS_029" 440 200 48.59 2.2 2 "[\"Preset: 70mm Panavision (cine)\", \"Resolution: 440x200\"]"
        prerender "MAX_RS_IS_030" 1024 465 48.59 2.2 2 "[\"Preset: 70mm Panavision (cine)\", \"Resolution: 1024x465\"]"
        prerender "MAX_RS_IS_031" 1536 698 48.59 2.2 2 "[\"Preset: 70mm Panavision (cine)\", \"Resolution: 1536x698\"]"
        prerender "MAX_RS_IS_032" 4096 1862 48.59 2.2 2 "[\"Preset: 70mm Panavision (cine)\", \"Resolution: 4096x1862\"]"

        prerender "MAX_RS_IS_033" 256 188 48.59 1.364 1 "[\"Preset: 70mm IMAX (cine)\", \"Resolution: 256x188\"]"
        prerender "MAX_RS_IS_034" 1024 751 48.59 1.364 1 "[\"Preset: 70mm IMAX (cine)\", \"Resolution: 1024x751\"]"
        prerender "MAX_RS_IS_035" 1536 1126 48.59 1.364 1 "[\"Preset: 70mm IMAX (cine)\", \"Resolution: 1536x1126\"]"
        prerender "MAX_RS_IS_036" 4096 3003 48.59 1.364 1 "[\"Preset: 70mm IMAX (cine)\", \"Resolution: 4096x3003\"]"

        prerender "MAX_RS_IS_037" 360 240 37.719 1.5 1 "[\"Preset: VistaVision\", \"Resolution: 360x240\"]"
        prerender "MAX_RS_IS_038" 1024 683 37.719 1.5 1 "[\"Preset: VistaVision\", \"Resolution: 1024x683\"]"
        prerender "MAX_RS_IS_039" 1536 1024 37.719 1.5 1 "[\"Preset: VistaVision\", \"Resolution: 1536x1024\"]"
        prerender "MAX_RS_IS_040" 4096 2731 37.719 1.5 1 "[\"Preset: VistaVision\", \"Resolution: 4096x2731\"]"

        prerender "MAX_RS_IS_041" 360 240 34.2 1.5 1 "[\"Preset: 35mm (24mm X 36mm) (slide)\", \"Resolution: 360x240\"]"
        prerender "MAX_RS_IS_042" 1024 683 34.2 1.5 1 "[\"Preset: 35mm (24mm X 36mm) (slide)\", \"Resolution: 1024x683\"]"
        prerender "MAX_RS_IS_043" 1536 1024 34.2 1.5 1 "[\"Preset: 35mm (24mm X 36mm) (slide)\", \"Resolution: 1536x1024\"]"
        prerender "MAX_RS_IS_044" 4096 2731 34.2 1.5 1 "[\"Preset: 35mm (24mm X 36mm) (slide)\", \"Resolution: 4096x2731\"]"

        prerender "MAX_RS_IS_045" 256 256 51.6 1 1 "[\"Preset: 6cm X 6cm (2 1/4" X 2 1/4") (slide)\", \"Resolution: 256x256\"]"
        prerender "MAX_RS_IS_046" 1024 1024 51.6 1 1 "[\"Preset: 6cm X 6cm (2 1/4" X 2 1/4") (slide)\", \"Resolution: 1024x1024\"]"
        prerender "MAX_RS_IS_047" 1536 1536 51.6 1 1 "[\"Preset: 6cm X 6cm (2 1/4" X 2 1/4") (slide)\", \"Resolution: 1536x1536\"]"
        prerender "MAX_RS_IS_048" 4096 4096 51.6 1 1 "[\"Preset: 6cm X 6cm (2 1/4" X 2 1/4") (slide)\", \"Resolution: 4096x4096\"]"

        prerender "MAX_RS_IS_049" 512 410 88.9 1.25 1 "[\"Preset: 4" X 5" or 8" X 10" (slide)\", \"Resolution: 512x410\"]"
        prerender "MAX_RS_IS_050" 1024 819 88.9 1.25 1 "[\"Preset: 4" X 5" or 8" X 10" (slide)\", \"Resolution: 1024x819\"]"
        prerender "MAX_RS_IS_051" 1536 1229 88.9 1.25 1 "[\"Preset: 4" X 5" or 8" X 10" (slide)\", \"Resolution: 1536x1229\"]"
        prerender "MAX_RS_IS_052" 4096 3277 88.9 1.25 1 "[\"Preset: 4" X 5" or 8" X 10" (slide)\", \"Resolution: 4096x3277\"]"

        prerender "MAX_RS_IS_053" 720 486 20.12 1.333 0.9 "[\"Preset: NTSC D-1 (video)\", \"Resolution: 720x486\"]"
        prerender "MAX_RS_IS_054" 200 135 20.12 1.333 0.9 "[\"Preset: NTSC D-1 (video)\", \"Resolution: 200x135\"]"
        prerender "MAX_RS_IS_055" 360 243 20.12 1.333 0.9 "[\"Preset: NTSC D-1 (video)\", \"Resolution: 360x243\"]"
        prerender "MAX_RS_IS_056" 512 346 20.12 1.333 0.9 "[\"Preset: NTSC D-1 (video)\", \"Resolution: 512x346\"]"

        prerender "MAX_RS_IS_057" 720 480 20.12 1.35 0.9 "[\"Preset: NTSC DV (video)\", \"Resolution: 720x480\"]"
        prerender "MAX_RS_IS_058" 300 200 20.12 1.35 0.9 "[\"Preset: NTSC DV (video)\", \"Resolution: 300x200\"]"
        prerender "MAX_RS_IS_059" 360 240 20.12 1.35 0.9 "[\"Preset: NTSC DV (video)\", \"Resolution: 360x240\"]"
        prerender "MAX_RS_IS_060" 512 341 20.12 1.35 0.9 "[\"Preset: NTSC DV (video)\", \"Resolution: 512x341\"]"

        prerender "MAX_RS_IS_061" 768 576 20.12 1.333 1 "[\"Preset: PAL (video)\", \"Resolution: 768x576\"]"
        prerender "MAX_RS_IS_062" 180 135 20.12 1.333 1 "[\"Preset: PAL (video)\", \"Resolution: 180x135\"]"
        prerender "MAX_RS_IS_063" 240 180 20.12 1.333 1 "[\"Preset: PAL (video)\", \"Resolution: 240x180\"]"
        prerender "MAX_RS_IS_064" 480 360 20.12 1.333 1 "[\"Preset: PAL (video)\", \"Resolution: 480x360\"]"

        prerender "MAX_RS_IS_065" 720 576 20.12 1.333 1.066 "[\"Preset: PAL D-1 (video)\", \"Resolution: 720x576\"]"
        prerender "MAX_RS_IS_066" 180 144 20.12 1.333 1.066 "[\"Preset: PAL D-1 (video)\", \"Resolution: 180x144\"]"
        prerender "MAX_RS_IS_067" 240 192 20.12 1.333 1.066 "[\"Preset: PAL D-1 (video)\", \"Resolution: 240x192\"]"
        prerender "MAX_RS_IS_068" 480 384 20.12 1.333 1.066 "[\"Preset: PAL D-1 (video)\", \"Resolution: 480x384\"]"

        prerender "MAX_RS_IS_069" 1920 1080 20.12 1.777 1 "[\"Preset: HDTV (video)\", \"Resolution: 1920x1080\"]"
        prerender "MAX_RS_IS_070" 480 270 20.12 1.777 1 "[\"Preset: HDTV (video)\", \"Resolution: 480x270\"]"
        prerender "MAX_RS_IS_071" 1280 720 20.12 1.777 1 "[\"Preset: HDTV (video)\", \"Resolution: 1280x720\"]"
        prerender "MAX_RS_IS_072" 320 180 20.12 1.777 1 "[\"Preset: HDTV (video)\", \"Resolution: 320x180\"]"

        prerender "MAX_RS_IS_073" 2000 2000 36 1.333 1 "[\"Resolution: 2000x2000\"]"
        prerender "MAX_RS_IS_074" 3000 3000 36 1.333 1 "[\"Resolution: 3000x3000\"]"
        prerender "MAX_RS_IS_075" 4000 4000 36 1.333 1 "[\"Resolution: 4000x4000\"]"
        prerender "MAX_RS_IS_076" 5000 5000 36 1.333 1 "[\"Resolution: 5000x5000\"]"
        prerender "MAX_RS_IS_077" 6000 6000 36 1.333 1 "[\"Resolution: 6000x6000\"]"
        prerender "MAX_RS_IS_078" 7000 7000 36 1.333 1 "[\"Resolution: 7000x7000\"]"
        prerender "MAX_RS_IS_079" 8000 8000 36 1.333 1 "[\"Resolution: 8000x8000\"]"

        prerender "MAX_RS_IS_080" 1024 1024 36 1.333 1 "[\"Resolution: 1024x1024\"]"
        prerender "MAX_RS_IS_081" 2048 2048 36 1.333 1 "[\"Resolution: 2048x2048\"]"
        prerender "MAX_RS_IS_082" 3072 3072 36 1.333 1 "[\"Resolution: 3072x3072\"]"
        prerender "MAX_RS_IS_083" 4096 4096 36 1.333 1 "[\"Resolution: 4096x4096\"]"
        prerender "MAX_RS_IS_084" 1500 1125 36 1.333 1 "[\"Resolution: 1500x1125\"]"
    )
)

main()
resetMaXFile #noPrompt
quitMaX #noPrompt
