set PATH=c:\python35\;c:\python35\scripts\;%PATH%
set RENDER_DEVICE=%1
set TESTS_FILTER=%2
set TEST_PACKAGE=%3
if "%RENDER_DEVICE%" EQU "" set RENDER_DEVICE=2
if "%TESTS_FILTER%" EQU "" set TESTS_FILTER=full

python ..\jobs_launcher\executeTests.py --test_package Smoke_Test --tests_root ..\jobs --work_root ..\Work\Results --work_dir Max --cmd_variables Tool "C:\Program Files\Autodesk\3ds Max 2017\3dsmax.exe" RenderDevice %RENDER_DEVICE% TestsFilter %TESTS_FILTER% ResPath "C:\TestResources\MaxAssets\scenes" PassLimit 10 rx 0 ry 0

pause