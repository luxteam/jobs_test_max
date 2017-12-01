set PATH=c:\python35\;c:\python35\scripts\;%PATH%

python ..\jobs_launcher\executeTests.py --tests_root ..\jobs --work_root ..\Results --work_dir Max --cmd_variables Tool "C:\Program Files\Autodesk\3ds Max 2017\3dsmax.exe" RenderDevice 2 TestsFilter small