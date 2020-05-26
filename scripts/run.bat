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

shift
shift
shift
shift
shift
shift
shift
shift
shift

set RBS_BUILD_ID=%1
set RBS_JOB_ID=%2
set RBS_URL=%3
set RBS_ENV_LABEL=%4
set IMAGE_SERVICE_URL=%5
set RBS_USE=%6


if not defined RX set RX=0
if not defined RY set RY=0
if not defined SPU set SPU=60
if not defined ITER set ITER=120
if not defined THRESHOLD set THRESHOLD=0.01
if not defined TOOL set TOOL=2020
if not defined CIS_TOOLS set CIS_TOOLS "C:\JN\cis_tools"

IF not EXIST "%CIS_TOOLS%\\..\\TestResources\\rpr_max_autotests" (
    ECHO "rpr_max_autotests assets don't exists"
    Exit 1
)

python -m pip install -r ..\jobs_launcher\install\requirements.txt

python ..\jobs_launcher\executeTests.py --test_filter %TESTS_FILTER% --file_filter %FILE_FILTER% --tests_root ..\jobs --work_root ..\Work\Results --work_dir Max --cmd_variables Tool "C:\Program Files\Autodesk\3ds Max %TOOL%\3dsmax.exe" RenderDevice %RENDER_DEVICE% ResPath "%CIS_TOOLS%\..\TestResources\rpr_max_autotests" PassLimit %ITER% rx %RX% ry %RY% SPU %SPU% threshold %THRESHOLD%
