

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
        renderers.current.backgroundOverride = true
        renderers.current.useBackgroundMap = true

        if cases[i]["asset"] != undefined do (
            ASSET_PATH = "{res_path}\\{package_name}\\sourceimages\\" + cases[i]["asset"]
            map = bitmaptexture filename:ASSET_PATH
            renderers.current.backgroundMap = map
        )

        renderers.current.backgroundIntensity = cases[i]["intensity"]

        rpr_render image_format cases[i]["name"] cases[i]["script_info"]

        caseList.setCaseStatus i "done"
    )
)

main()
resetMaxFile #noPrompt
quitMax #noPrompt
