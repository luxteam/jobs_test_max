import argparse
import sys
import os

# sys.path.append(r"..\..\..\CommonScripts\ImageComparator\\")
import time
import subprocess
import multiprocessing
import psutil
import ctypes
from datetime import datetime
import json
# import CompareMetrics
import getpass
from email.mime.multipart import MIMEMultipart as MM
from email.mime.text import MIMEText as MT
import smtplib
import email
import email.mime.application


def get_windows_titles():
    EnumWindows = ctypes.windll.user32.EnumWindows
    EnumWindowsProc = ctypes.WINFUNCTYPE(ctypes.c_bool, ctypes.POINTER(ctypes.c_int), ctypes.POINTER(ctypes.c_int))
    GetWindowText = ctypes.windll.user32.GetWindowTextW
    GetWindowTextLength = ctypes.windll.user32.GetWindowTextLengthW
    IsWindowVisible = ctypes.windll.user32.IsWindowVisible

    titles = []

    def foreach_window(hwnd, lParam):
        if IsWindowVisible(hwnd):
            length = GetWindowTextLength(hwnd)
            buff = ctypes.create_unicode_buffer(length + 1)
            GetWindowText(hwnd, buff, length + 1)
            titles.append(buff.value)
        return True

    EnumWindows(EnumWindowsProc(foreach_window), 0)

    return titles


def _late_kill(pid, delay, real_rc=None):
    proc = psutil.Process(pid)
    titles = []
    while True:
        try:
            proc.wait(delay)
        except psutil.TimeoutExpired as e:
            titles = get_windows_titles()
            if "Radeon ProRender" in titles:
                if real_rc:
                    real_rc.value = -1024
                for child in reversed(proc.children(recursive=True)):
                    child.terminate()
                proc.terminate()
                return
        else:
            return


def main():
    stage_report = [{'status': 'INIT'}, {'log': ['simpleRender.py start']}]
    parser = argparse.ArgumentParser()

    parser.add_argument('--stage_report', required=True)
    parser.add_argument('--tool', required=True, metavar="<path>")
    parser.add_argument('--pass_limit', required=True, type=int)
    parser.add_argument('--render_size', required=True, type=int)
    parser.add_argument('--file_extension', required=True)
    parser.add_argument('--package_name', required=True)
    parser.add_argument('--render_mode', required=True)
    parser.add_argument('--template', required=True)
    parser.add_argument('--output', required=True)
    parser.add_argument('--res_path', required=True)
    parser.add_argument('--scene_list', required=True)

    args = parser.parse_args()

    tool = args.tool

    ren_mode = args.render_mode
    if (ren_mode) == 'GPU':
        render_mode = 'GPU'
        ren_mode = 'fr.renderDevice = 2'
    if (ren_mode) == 'CPU':
        render_mode = 'CPU'
        ren_mode = 'fr.renderDevice = 1'
    if (ren_mode) == 'DUAL':
        render_mode = 'DUAL'
        ren_mode = 'fr.renderDevice = 3'

    global pack
    pack = args.package_name

    template = args.template
    with open(os.path.join(os.path.dirname(sys.argv[0]), template)) as f:
        max_script_template = f.read()
        f.closed

    with open(os.path.join(os.path.dirname(sys.argv[0]), args.scene_list)) as f:
        scene_list = f.read()
        f.closed

    global work_dir

    work_dir = args.output
    work_dir = work_dir.replace("\\", "\\\\")
    res_path = args.res_path
    res_path = res_path.replace("\\", "\\\\")

    maxScript = max_script_template.format(pass_limit=args.pass_limit, render_size=args.render_size,
                                           file_extension=args.file_extension,
                                           work_dir=work_dir,
                                           package_name=args.package_name, ren_mode=ren_mode,
                                           render_mode=render_mode, res_path=res_path, scene_list=scene_list)

    try:
        os.makedirs(work_dir)
    except BaseException:
        print("")

    maxScriptPath = os.path.join(work_dir, 'script.ms')
    with open(maxScriptPath, 'w') as f:
        f.write(maxScript)
        f.closed

    cmdRun = '"{tool}" -U MAXScript "{job_script}" -silent' \
        .format(tool=tool, job_script=maxScriptPath)

    cmdRun_ForBat = '"{tool}" -U MAXScript "{job_script}" -silent' \
        .format(tool=tool, job_script='script.ms')

    cmdScriptPath = os.path.join(work_dir, 'script.bat')
    with open(cmdScriptPath, 'w') as f:
        f.write(cmdRun_ForBat)
        f.closed

    print("start cmdRun time: ", time.time())
    #child = subprocess.Popen(cmdRun, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)

    p = psutil.Popen(cmdRun, stdout=subprocess.PIPE)
    rc = p.wait(timeout=2000)

    #real_rc = multiprocessing.Value('i', 0)
    #monitor = multiprocessing.Process(target=_late_kill, args=(child.pid, 10, real_rc))
    #print("start monitor time: ", time.time())
    #monitor.start()

    sub_skip = 0
    #proc = psutil.Process(child.pid)
    #rc= proc.wait()
#    while True:
#        output = child.stdout.readline()
#        if output == b'' and child.poll() != None:
#            break
#        if output != b'' and output != b'\r\n':
#            output = output.decode("UTF-8")
#            output_noeol = str(output).replace('\r', '')
#            output_noeol = str(output_noeol).replace('\n', '')
#            #print(output_noeol)
#            if "not recognized as an internal or external command" in output_noeol:
#                sub_skip = 1
#            if "The system cannot find the path specified" in output_noeol:
#                sub_skip = 1

    print("finished child.pull time: ", time.time())
    #rc = ctypes.c_long(child.poll()).value

    if sub_skip:
        rc = 2
        print('skipped')
        stage_report[0]['status'] = 'FAILED'
        stage_report[1]['log'].append('subprocess SKIPPED')
    elif rc == 0:
        print('passed')
        stage_report[0]['status'] = 'OK'
        stage_report[1]['log'].append('subprocess PASSED')
    else:
        print('failed')
        stage_report[0]['status'] = 'FAILED'
        stage_report[1]['log'].append('subprocess FAILED')

    #monitor.terminate()
    print("monitor terminated time: ", time.time())

#    if real_rc.value != 0:
#        rc = real_rc.value
#        stage_report[0]['status'] = 'FAILED'
#        stage_report[1]['log'].append('subprocess was terminated by monitor')

    with open(os.path.join(args.output, args.stage_report), 'w') as file:
        json.dump(stage_report, file, indent=' ')

    return rc


def check_count():
    files = os.listdir(work_dir + "\\images\\")
    res = [x for x in files if x.endswith('.png')]
    # print (res)

    path_name = work_dir + "image_list.txt"
    with open(os.path.join(os.path.dirname(sys.argv[0]), path_name)) as f:
        images = f.read()
        f.closed

    image_list = images.split("\n")
    # print (image_list)
    result = list(set(image_list) - set(res))
    # print (result)

    if len(result) == 0:
        status = "All tests successfully completed: " + str(len(res)) + "/" + str(len(image_list))
    else:
        status = "There are some problems. Completed: " + str(len(res)) + "/" + str(
            len(image_list)) + "\nNot rendered: " + str(result)
    print(status)
    return status


if __name__ == "__main__":
    rc = main()
    #os.remove("tahoe.log")
    #os.rmdir("cache")
    print("start check_count time: ", time.time())
    check_count()
    exit(rc)
