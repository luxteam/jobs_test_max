set PATH=c:\python35\;c:\python35\scripts\;%PATH%
set RENDER_DEVICE=%1
set FILE_FILTER=%2
set TESTS_FILTER="%3"

python ..\jobs_launcher\executeTests.py %4 %5 --test_filter %TESTS_FILTER% --file_filter %FILE_FILTER% --tests_root ..\jobs --work_root ..\Work\Results --work_dir Max --cmd_variables Tool "C:\Program Files\Autodesk\3ds Max 2019\3dsmax.exe" RenderDevice %RENDER_DEVICE% ResPath "C:\TestResources\Assets\Smoke" PassLimit 50 rx 0 ry 0

rem set PATH=c:\python35\;c:\python35\scripts\;%PATH%
rem set RENDER_DEVICE=2
rem set FILE_FILTER=smoke
rem set TESTS_FILTER="%3"

rem python ..\jobs_launcher\executeTests.py --test_filter %TESTS_FILTER% --file_filter %FILE_FILTER% --tests_root ..\jobs --work_root ..\Work\Results --work_dir Max --cmd_variables Tool "C:\Program Files\Autodesk\3ds Max 2019\3dsmax.exe" RenderDevice %RENDER_DEVICE% ResPath "C:\TestResources\Assets\Smoke" PassLimit 100 rx 0 ry 0