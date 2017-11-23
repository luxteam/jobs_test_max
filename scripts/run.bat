set PATH=c:\python35\;c:\python35\scripts\;%PATH%
set HWProfiles=CPU+WX7100
set TestsFilter=small
set Tool=2017
set ConfigPath=%CD%\Max.config.json

python ..\..\jobs_launcher\executeTests.py --tests_root ..\jobs --work_root ..\Results --work_dir Max