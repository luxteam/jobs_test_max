set PATH=c:\python35\;c:\python35\scripts\;%PATH%
set RENDER_DEVICE=%1
set FILE_FILTER=%2
set TESTS_FILTER="%3"
set RX=%4
set RY=%5
set SPU=%6
set ITER=%7
set THRESHOLD=%8
set TOOL=%9

if not defined RX set RX=0
if not defined RY set RY=0
if not defined SPU set SPU=25
if not defined ITER set ITER=50
if not defined THRESHOLD set THRESHOLD=0.05
if not defined TOOL set TOOL=2020

python -m pip install -r ..\jobs_launcher\install\requirements.txt

python ..\jobs_launcher\executeTests.py --test_filter %TESTS_FILTER% --file_filter %FILE_FILTER% --tests_root ..\jobs --work_root ..\Work\Results --work_dir Max --cmd_variables Tool "C:\Program Files\Autodesk\3ds Max 2020\3dsmax.exe" RenderDevice %RENDER_DEVICE% ResPath "C:\TestResources\MaxAssets" PassLimit %ITER% rx %RX% ry %RY% SPU %SPU% threshold %THRESHOLD%