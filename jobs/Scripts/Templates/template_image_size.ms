function prerender test_case width height aperture_width image_aspect_ration pixel_aspect = (
    
    renderers.current = Radeon_ProRender()
    renderers.current.passLimit = {pass_limit}

    renderHeight = height
    renderWidth = width
    setRendApertureWidth = aperture_width
    renderPixelAspect = pixel_aspect
    rendImageAspectRatio = image_aspect_ration

    rpr_render "jpg" test_case
)

function main = (
    
    filesToRender = #(
        {scene_list}
    )
    
    for fi=1 to filesToRender.count do (
        assetsFile = "{res_path}" + "\\" + filesToRender[fi]
        loadMaxFile assetsFile quiet:true

        prerender "MAX_RS_IS_001" 512 389 24 1.316 1 
        prerender "MAX_RS_IS_002" 1536 1167 24 1.316 1
        prerender "MAX_RS_IS_003" 2048 1556 24 1.316 1
        prerender "MAX_RS_IS_004" 4096 3112 24 1.316 1

        prerender "MAX_RS_IS_005" 457 333 20.955 1.369 1
        prerender "MAX_RS_IS_006" 1371 999 20.955 1.369 1
        prerender "MAX_RS_IS_007" 1828 1332 20.955 1.369 1
        prerender "MAX_RS_IS_008" 3656 2664 20.955 1.369 1

        prerender "MAX_RS_IS_009" 250 150 20.955 1.666 1
        prerender "MAX_RS_IS_010" 1024 614 20.955 1.666 1
        prerender "MAX_RS_IS_011" 1536 921 20.955 1.666 1
        prerender "MAX_RS_IS_012" 4096 2458 20.955 1.666 1

        prerender "MAX_RS_IS_013" 350 200 20.955 1.75 1
        prerender "MAX_RS_IS_014" 1120 640 20.955 1.75 1
        prerender "MAX_RS_IS_015" 1575 900 20.955 1.75 1
        prerender "MAX_RS_IS_016" 4096 2340 20.955 1.75 1

        prerender "MAX_RS_IS_017" 370 200 20.955 1.85 1
        prerender "MAX_RS_IS_018" 1024 554 20.955 1.85 1
        prerender "MAX_RS_IS_019" 1536 830 20.955 1.85 1
        prerender "MAX_RS_IS_020" 4096 2214 20.955 1.85 1
       
        prerender "MAX_RS_IS_021" 256 109 42.57 2.35 1
        prerender "MAX_RS_IS_022" 1024 436 42.57 2.35 1
        prerender "MAX_RS_IS_023" 1828 778.57 2.35 1
        prerender "MAX_RS_IS_024" 4096 1743 42.57 2.35 1

        prerender "MAX_RS_IS_025" 256 218 42.57 2.35 2
        prerender "MAX_RS_IS_026" 1024 871 42.57 2.35 2
        prerender "MAX_RS_IS_027" 1828 1556 42.57 2.35 2
        prerender "MAX_RS_IS_028" 4096 3486 42.57 2.35 2

        prerender "MAX_RS_IS_029" 440 200 48.59 2.2 2
        prerender "MAX_RS_IS_030" 1024 465 48.59 2.2 2
        prerender "MAX_RS_IS_031" 1536 698 48.59 2.2 2
        prerender "MAX_RS_IS_032" 4096 1862 48.59 2.2 2

        prerender "MAX_RS_IS_033" 256 188 48.59 1.364 1
        prerender "MAX_RS_IS_034" 1024 751 48.59 1.364 1
        prerender "MAX_RS_IS_035" 1536 1126 48.59 1.364 1
        prerender "MAX_RS_IS_036" 4096 3003 48.59 1.364 1

        prerender "MAX_RS_IS_037" 360 240 34.2 1.5 1
        prerender "MAX_RS_IS_038" 1024 683 34.2 1.5 1
        prerender "MAX_RS_IS_039" 1536 1024 34.2 1.5 1
        prerender "MAX_RS_IS_040" 4096 2731 34.2 1.5 1

        prerender "MAX_RS_IS_041" 256 256 51.6 1 1
        prerender "MAX_RS_IS_042" 1024 1024 51.6 1 1
        prerender "MAX_RS_IS_043" 1536 1536 51.6 1 1
        prerender "MAX_RS_IS_044" 4096 4096 51.6 1 1

        prerender "MAX_RS_IS_045" 512 410 88.9 1.25 1
        prerender "MAX_RS_IS_046" 1024 819 88.9 1.25 1
        prerender "MAX_RS_IS_047" 1536 1229 88.9 1.25 1
        prerender "MAX_RS_IS_048" 4096 3277 88.9 1.25 1

        prerender "MAX_RS_IS_049" 720 486 20.12 1.333 0.9
        prerender "MAX_RS_IS_050" 200 135 20.12 1.333 0.9
        prerender "MAX_RS_IS_051" 360 243 20.12 1.333 0.9
        prerender "MAX_RS_IS_052" 512 346 20.12 1.333 0.9

        prerender "MAX_RS_IS_053" 720 480 20.12 1.35 0.9
        prerender "MAX_RS_IS_054" 300 200 20.12 1.35 0.9
        prerender "MAX_RS_IS_055" 360 240 20.12 1.35 0.9
        prerender "MAX_RS_IS_056" 512 341 20.12 1.35 0.9

        prerender "MAX_RS_IS_057" 768 576 20.12 1.333 1
        prerender "MAX_RS_IS_058" 180 135 20.12 1.333 1
        prerender "MAX_RS_IS_059" 240 180 20.12 1.333 1
        prerender "MAX_RS_IS_060" 480 360 20.12 1.333 1

        prerender "MAX_RS_IS_061" 720 576 20.12 1.333 1.066
        prerender "MAX_RS_IS_062" 180 144 20.12 1.333 1.066
        prerender "MAX_RS_IS_063" 240 192 20.12 1.333 1.066
        prerender "MAX_RS_IS_064" 480 384 20.12 1.333 1.066

        prerender "MAX_RS_IS_065" 1920 1080 20.12 1.777 1
        prerender "MAX_RS_IS_066" 480 270 20.12 1.777 1
        prerender "MAX_RS_IS_067" 1280 720 20.12 1.777 1
        prerender "MAX_RS_IS_068" 320 180 20.12 1.777 1

        prerender "MAX_RS_IS_069" 2000 2000 36 1.333 1
        prerender "MAX_RS_IS_070" 3000 3000 36 1.333 1
        prerender "MAX_RS_IS_071" 4000 4000 36 1.333 1
        prerender "MAX_RS_IS_072" 5000 5000 36 1.333 1
        prerender "MAX_RS_IS_073" 6000 6000 36 1.333 1
        prerender "MAX_RS_IS_074" 7000 7000 36 1.333 1
        prerender "MAX_RS_IS_075" 8000 8000 36 1.333 1

        prerender "MAX_RS_IS_076" 1024 1024 36 1.333 1
        prerender "MAX_RS_IS_077" 2048 2048 36 1.333 1
        prerender "MAX_RS_IS_078" 3072 3072 36 1.333 1
        prerender "MAX_RS_IS_079" 4096 4096 36 1.333 1
        prerender "MAX_RS_IS_080" 1500 1125 36 1.333 1
    )
)

main()
resetMaxFile #noPrompt
quitMax #noPrompt
