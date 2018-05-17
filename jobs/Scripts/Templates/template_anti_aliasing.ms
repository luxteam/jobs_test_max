
function prerender test_list = (
    
    renderers.current = Radeon_ProRender()
    renderers.current.passLimit = {pass_limit}
    
    if ({resolution_y} != 0 and {resolution_x} != 0) do (
        renderHeight = {resolution_y}
        renderWidth = {resolution_x}
    )
    
    renderers.current.imageFilter = test_list[3]
    renderers.current.aaSampleCount = test_list[4]

    rpr_render "jpg" test_list[1] test_list[2]
)

function main sf = (
    
    list_tests = #(
        #("MAX_RS_AA_001", "[\"AA filter: Box\", \"AA samples: 1\"]", 1, 1),
        #("MAX_RS_AA_002", "[\"AA filter: Box\", \"AA samples: 5\"]", 1, 5), 
        #("MAX_RS_AA_003", "[\"AA filter: Box\", \"AA samples: 15\"]", 1, 15),
        #("MAX_RS_AA_004", "[\"AA filter: Box\", \"AA samples: 23\"]", 1, 23),
        #("MAX_RS_AA_005", "[\"AA filter: Box\", \"AA samples: 32\"]", 1, 32),

        #("MAX_RS_AA_006", "[\"AA filter: Triangle\", \"AA samples: 1\"]", 2, 1),
        #("MAX_RS_AA_007", "[\"AA filter: Triangle\", \"AA samples: 5\"]", 2, 5),
        #("MAX_RS_AA_008", "[\"AA filter: Triangle\", \"AA samples: 15\"]", 2, 15),
        #("MAX_RS_AA_009", "[\"AA filter: Triangle\", \"AA samples: 23\"]", 2, 23),
        #("MAX_RS_AA_010", "[\"AA filter: Triangle\", \"AA samples: 32\"]", 2, 32),

        #("MAX_RS_AA_011", "[\"AA filter: Gaussian\", \"AA samples: 1\"]", 3, 1),
        #("MAX_RS_AA_012", "[\"AA filter: Gaussian\", \"AA samples: 5\"]", 3, 5),
        #("MAX_RS_AA_013", "[\"AA filter: Gaussian\", \"AA samples: 15\"]", 3, 15),
        #("MAX_RS_AA_014", "[\"AA filter: Gaussian\", \"AA samples: 23\"]", 3, 23),
        #("MAX_RS_AA_015", "[\"AA filter: Gaussian\", \"AA samples: 32\"]", 3, 32),

        #("MAX_RS_AA_016", "[\"AA filter: Mitchell\", \"AA samples: 1\"]", 4, 1),
        #("MAX_RS_AA_017", "[\"AA filter: Mitchell\", \"AA samples: 5\"]", 4, 5),
        #("MAX_RS_AA_018", "[\"AA filter: Mitchell\", \"AA samples: 15\"]", 4, 15),
        #("MAX_RS_AA_019", "[\"AA filter: Mitchell\", \"AA samples: 23\"]", 4, 23),
        #("MAX_RS_AA_020", "[\"AA filter: Mitchell\", \"AA samples: 32\"]", 4, 32),

        #("MAX_RS_AA_021", "[\"AA filter: Lanczos\", \"AA samples: 1\"]", 5, 1),
        #("MAX_RS_AA_022", "[\"AA filter: Lanczos\", \"AA samples: 5\"]", 5, 5),
        #("MAX_RS_AA_023", "[\"AA filter: Lanczos\", \"AA samples: 15\"]", 5, 15),
        #("MAX_RS_AA_024", "[\"AA filter: Lanczos\", \"AA samples: 23\"]", 5, 23),
        #("MAX_RS_AA_025", "[\"AA filter: Lanczos\", \"AA samples: 32\"]", 5, 32),

        #("MAX_RS_AA_026", "[\"AA filter: Blackmanharris\", \"AA samples: 1\"]", 6, 1), 
        #("MAX_RS_AA_027", "[\"AA filter: Blackmanharris\", \"AA samples: 5\"]", 6, 5), 
        #("MAX_RS_AA_028", "[\"AA filter: Blackmanharris\", \"AA samples: 15\"]", 6, 15),
        #("MAX_RS_AA_029", "[\"AA filter: Blackmanharris\", \"AA samples: 23\"]", 6, 23),
        #("MAX_RS_AA_030", "[\"AA filter: Blackmanharris\", \"AA samples: 32\"]", 6, 32)
    )

    filesToRender = #(
        {scene_list}
    )
    
    for fi=1 to filesToRender.count do (
        assetsFile = "{res_path}" + "\\" + filesToRender[fi]
        loadMaxFile assetsFile useFileUnits:true quiet:true

        if (sf != 1) (
            create_failed_report list_tests[sf-1][1] list_tests[$sf-1][2] "failed"
        )

        for sf=1 to list_tests.count do (
                prerender list_tests[sf]
        )
       
    )
)

main()
resetMaxFile #noPrompt
quitMax #noPrompt
