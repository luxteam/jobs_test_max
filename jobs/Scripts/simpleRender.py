import argparse
import sys
import os
import subprocess
import psutil
import json
import ctypes
import pyscreenshot
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), os.path.pardir, os.path.pardir)))
from jobs_launcher.core.config import main_logger, RENDER_REPORT_BASE
from shutil import copyfile
from datetime import datetime

case_list = "case_list.json"


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


def check_cases(group, work_dir):
    with open(os.path.join(work_dir, case_list)) as file:
        data = json.loads(file.read())
    try:
        for case in data["cases"]:
            if case["status"] == "active":
                return True

        return False
    except KeyError as err:
        main_logger.error(str(err))


def get_error_case(group, work_dir):
    with open(os.path.join(work_dir, case_list)) as file:
        data = json.loads(file.read())

    for case in data["cases"]:
        if case["status"] == "progress":
            case["status"] = "error"

            with open(os.path.join(work_dir, case_list), "w") as file:
                data.dump(data, file, indent=4)

            return case["name"]
    else:
        return False


def dump_reports(work_dir, case_list, render_device, scene_list):

    with open(os.path.join(work_dir, case_list)) as file:
        data = json.loads(file.read())
        test_group = data["test_group"]
        cases = data["cases"]

    for case in cases:
        report_name = case["name"] + "_RPR.json"
        report_body = RENDER_REPORT_BASE

        report_body["test_case"] = case["name"]
        report_body["script_info"] = case["script_info"]
        report_body["render_device"] = render_device
        report_body["render_color_path"] = "Color/{0}.jpg".format(case["name"])
        report_body["file_name"] = case["name"] + ".jpg"
        report_body["scene_name"] = case["scene_name"]
        report_body["test_group"] = test_group

        if case["status"] == "active":
            report_body["test_status"] = "error"
            path_2_orig_img = os.path.join(os.path.dirname(scene_list), '..', 'failed.jpg')
        else:
            report_body["test_status"] = "skipped"
            path_2_orig_img = os.path.join(os.path.dirname(scene_list), '..', 'skipped.jpg')

        path_2_case_img = os.path.join(work_dir, "Color\\{test_case}.jpg".format(test_case=case["name"]))
        copyfile(path_2_orig_img, path_2_case_img)

        with open(os.path.join(work_dir, report_name), "w") as file:
            json.dump([report_body], file, indent=4)

        main_logger.info(case["name"] + ": Report template created.")

    return 1


def main():
    stage_report = [{'status': 'INIT'}, {'log': ['simpleRender.py start']}]
    parser = argparse.ArgumentParser()

    parser.add_argument('--stage_report', required=True)
    parser.add_argument('--tool', required=True, metavar="<path>")
    parser.add_argument('--pass_limit', required=True, type=int)
    parser.add_argument('--resolution_x', required=True, type=int)
    parser.add_argument('--resolution_y', required=True, type=int)
    parser.add_argument('--package_name', required=True)
    parser.add_argument('--render_mode', required=True)
    parser.add_argument('--template', required=True)
    parser.add_argument('--output', required=True)
    parser.add_argument('--res_path', required=True)
    parser.add_argument('--scene_list', required=True)

    args = parser.parse_args()
    tool = args.tool

    template = args.template
    with open(os.path.join(os.path.dirname(sys.argv[0]), template)) as f:
        max_script_template = f.read()
    with open(os.path.join(os.path.dirname(sys.argv[0]), "Templates", "base_function.ms")) as f:
        base = f.read()

    with open(os.path.join(os.path.dirname(sys.argv[0]), args.scene_list)) as f:
        scene_list = f.read()

    global work_dir

    work_dir = args.output
    work_dir = work_dir.replace("\\", "\\\\")
    res_path = args.res_path
    res_path = res_path.replace("\\", "\\\\")

    render_device = args.render_mode
    try:
        s = subprocess.Popen("wmic path win32_VideoController get name", stdout=subprocess.PIPE)
        stdout = s.communicate()
        render_device = stdout[0].decode("utf-8").split('\n')[1].replace('\r', '').strip(' ')
    except:
        pass

    max_script_template = base + max_script_template
    maxScript = max_script_template.format(pass_limit=args.pass_limit,
                                           work_dir=work_dir,
                                           package_name=args.package_name,
                                           render_device=render_device,
                                           render_mode=args.render_mode,
                                           res_path=res_path,
                                           scene_list=scene_list,
                                           resolution_y=args.resolution_y,
                                           resolution_x=args.resolution_x)
    try:
        os.makedirs(os.path.join(work_dir, 'Color'))
    except Exception as err:
        main_logger.error(str(err))

    maxScriptPath = os.path.join(work_dir, 'script.ms')
    with open(maxScriptPath, 'w') as f:
        f.write(maxScript)

    cmdRun = '"{tool}" -U MAXScript "{job_script}" -silent' \
        .format(tool=tool, job_script=maxScriptPath)

    cmdScriptPath = os.path.join(work_dir, 'script.bat')
    with open(cmdScriptPath, 'w') as f:
        f.write(cmdRun)

    # copy case_list.json for track cases in group
    copyfile(os.path.join(os.path.dirname(args.scene_list), case_list), os.path.join(work_dir, case_list))

    # copy ms_json.py for json parsing in MaxScript
    copyfile(os.path.join(os.path.dirname(__file__), "ms_json.py"), os.path.join(work_dir, "ms_json.py"))

    dump_reports(work_dir, case_list, render_device, args.scene_list)

    os.chdir(work_dir)
    maxScriptPath = maxScriptPath.replace("\\\\", "\\")
    rc = -1

    while check_cases(args.package_name, work_dir):
        p = psutil.Popen(os.path.join(args.output, 'script.bat'), stdout=subprocess.PIPE, stderr=subprocess.PIPE)

        while True:
            try:
                p.communicate(timeout=10)
            except (subprocess.TimeoutExpired, psutil.TimeoutExpired) as err:
                fatal_errors_titles = ['Radeon ProRender', 'AMD Radeon ProRender debug assert', \
                                       maxScriptPath + ' - MAXScript', '3ds Max', 'Microsoft Visual C++ Runtime Library', \
                                       '3ds Max Error Report', '3ds Max application', 'Radeon ProRender Error', 'Image I/O Error']
                if set(fatal_errors_titles).intersection(get_windows_titles()):
                    rc = -1
                    try:
                        error_screen = pyscreenshot.grab()
                        error_case = get_error_case(args.package_name, work_dir)
                        error_screen.save(os.path.join(args.output, "Color", error_case + '.jpg'))
                    except Exception as err:
                        main_logger.error(str(err))

                    for child in reversed(p.children(recursive=True)):
                        child.kill()
                    p.kill()
                    break
            else:
                rc = 0
                break

        if p.is_running():
            main_logger.error("Max process still is running. Kill: {}".format(p.name()))
            try:
                for child in reversed(p.children(recursive=True)):
                    child.kill()
                p.kill()
            except psutil.NoSuchProcess as err:
                main_logger.error(str(err))

    with open(os.path.join(args.output, args.stage_report), 'w') as file:
        json.dump(stage_report, file, indent=' ')

    return rc


if __name__ == "__main__":
    rc = main()
    exit(rc)
