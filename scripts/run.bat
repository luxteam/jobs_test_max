set PATH=c:\python35\;c:\python35\scripts\;%PATH%
set RENDER_DEVICE=%1
set FILE_FILTER=%2
set TESTS_FILTER="%3"
set TOOL=%4
set RX=%5
set RY=%6
set SPU=%7
set ITER=%8
set THRESHOLD=%9

if not defined RX set RX=0
if not defined RY set RY=0
if not defined SPU set SPU=60
if not defined ITER set ITER=120
if not defined THRESHOLD set THRESHOLD=0.01
if not defined TOOL set TOOL=2020

python -m pip install -r ..\jobs_launcher\install\requirements.txt

python ..\jobs_launcher\executeTests.py --test_filter %TESTS_FILTER% --file_filter %FILE_FILTER% --tests_root ..\jobs --work_root ..\Work\Results --work_dir Max --cmd_variables Tool "C:\Program Files\Autodesk\3ds Max %TOOL%\3dsmax.exe" RenderDevice %RENDER_DEVICE% ResPath "C:\TestResources\MaxAssets" PassLimit %ITER% rx %RX% ry %RY% SPU %SPU% threshold %THRESHOLD%
