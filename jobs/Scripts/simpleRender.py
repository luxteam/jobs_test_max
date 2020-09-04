import argparse
import sys
import os
import subprocess
import psutil
import json
import ctypes
import pyscreenshot
from shutil import copyfile, which
import time
ROOT_DIR = os.path.abspath(os.path.join(os.path.dirname(__file__), os.path.pardir, os.path.pardir))
sys.path.append(ROOT_DIR)
from jobs_launcher.core.config import main_logger, RENDER_REPORT_BASE, TEST_CRASH_STATUS, TEST_IGNORE_STATUS, CASE_REPORT_SUFFIX, THUMBNAIL_PREFIXES
from jobs_launcher.core.system_info import get_gpu

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


def dump_reports(work_dir, case_list, render_device):

    with open(os.path.join(work_dir, case_list)) as file:
        data = json.loads(file.read())
        test_group = data["test_group"]
        cases = data["cases"]

    baseline_path_tr = os.path.join(
            'c:/TestResources/rpr_max_autotests_baselines', test_group)

    baseline_path = os.path.join(
        work_dir, os.path.pardir, os.path.pardir, os.path.pardir, 'Baseline', test_group)

    if not os.path.exists(baseline_path):
        os.makedirs(baseline_path)
        os.makedirs(os.path.join(baseline_path, 'Color'))

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
            report_body["test_status"] = TEST_CRASH_STATUS
            path_2_orig_img = os.path.join(ROOT_DIR, 'jobs_launcher', 'common', 'img', 'error.jpg')
        else:
            report_body["test_status"] = TEST_IGNORE_STATUS
            report_body['group_timeout_exceeded'] = False
            path_2_orig_img = os.path.join(ROOT_DIR, 'jobs_launcher', 'common', 'img', 'skipped.jpg')

        path_2_case_img = os.path.join(work_dir, "Color\\{test_case}.jpg".format(test_case=case["name"]))
        copyfile(path_2_orig_img, path_2_case_img)

        with open(os.path.join(work_dir, report_name), "w") as file:
            json.dump([report_body], file, indent=4)

        main_logger.info(case["name"] + ": Report template created.")

        try:
            copyfile(os.path.join(baseline_path_tr, case['name'] + CASE_REPORT_SUFFIX),
                     os.path.join(baseline_path, case['name'] + CASE_REPORT_SUFFIX))

            with open(os.path.join(baseline_path, case['name'] + CASE_REPORT_SUFFIX)) as baseline:
                baseline_json = json.load(baseline)

            for thumb in list(set().union([''], THUMBNAIL_PREFIXES)):
                if thumb + 'render_color_path' and os.path.exists(os.path.join(baseline_path_tr, baseline_json[thumb + 'render_color_path'])):
                    copyfile(os.path.join(baseline_path_tr, baseline_json[thumb + 'render_color_path']),
                             os.path.join(baseline_path, baseline_json[thumb + 'render_color_path']))
        except:
            main_logger.error('Failed to copy baseline ' +
                                          os.path.join(baseline_path_tr, case['name'] + CASE_REPORT_SUFFIX))

    return 1


def main():
    parser = argparse.ArgumentParser()

    parser.add_argument('--tool', required=True, metavar="<path>")
    parser.add_argument('--pass_limit', required=True, type=int)
    parser.add_argument('--resolution_x', required=True, type=int)
    parser.add_argument('--resolution_y', required=True, type=int)
    parser.add_argument('--package_name', required=True)
    parser.add_argument('--render_mode', required=True)
    parser.add_argument('--template', required=True)
    parser.add_argument('--output', required=True)
    parser.add_argument('--res_path', required=True)
    parser.add_argument('--testCases', required=True)
    parser.add_argument('--SPU', required=True)
    parser.add_argument('--threshold', required=True)

    args = parser.parse_args()
    tool = args.tool

    if which(tool) is None:
        tool_path = r'{}\documents\3ds Max 2021\3ds Max 2021\3dsmax.exe'.format(os.environ['USERPROFILE'])
        if which(tool_path) is None:
            main_logger.error('Can\'t find tool ' + tool)
            exit(-1)
        else:
            tool = tool_path

    template = args.template
    with open(os.path.join(os.path.dirname(sys.argv[0]), template)) as f:
        max_script_template = f.read()
    with open(os.path.join(os.path.dirname(sys.argv[0]), "Templates", "base_function.ms")) as f:
        base = f.read()

    global work_dir

    work_dir = args.output
    work_dir = work_dir.replace("\\", "\\\\")
    res_path = args.res_path
    res_path = res_path.replace("\\", "\\\\")

    render_device = get_gpu()

    # TODO: create symlincs or install max single path
    # TODO: refactor "maybe" paths
    maybe = [
        tool,
        "C://Users//user//Documents//3ds Max 2021//3ds Max 2021//3dsmax.exe"
    ]

    max_script_template = base + max_script_template
    maxScript = max_script_template.format(pass_limit=args.pass_limit,
                                           work_dir=work_dir,
                                           package_name=args.package_name,
                                           render_device=render_device,
                                           render_mode=args.render_mode,
                                           res_path=res_path,
                                           resolution_y=args.resolution_y,
                                           resolution_x=args.resolution_x,
                                           SPU=args.SPU,
                                           threshold=args.threshold)
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

    # prepare case_list.json
    if args.testCases != 'None':
        # open original case_list
        with open(os.path.join(ROOT_DIR, 'jobs', 'Tests', args.package_name, case_list)) as file:
            cases = json.loads(file.read())

        # open custom json group
        with open(args.testCases) as file:
            case_names = json.loads(file.read())[str(args.package_name)]
        
        # prepare template for custom json
        filter_cases = {
            'test_group': args.package_name,
            'cases': []
        }

        # collect cases
        filter_cases['cases'] = [case for case in cases['cases'] if case['name'] in case_names or case_names == "all"]

        # dump new custom case list
        with open(os.path.join(work_dir, case_list), 'w') as file:
            json.dump(filter_cases, file, indent=4)
    else:
        copyfile(os.path.join(ROOT_DIR, 'jobs', 'Tests', args.package_name, case_list), os.path.join(work_dir, case_list))

    # copy ms_json.py for json parsing in MaxScript
    copyfile(os.path.join(os.path.dirname(__file__), "ms_json.py"), os.path.join(work_dir, "ms_json.py"))

    dump_reports(work_dir, case_list, render_device)

    for path in maybe:
        exist = os.path.isfile(path)
        main_logger.info("TOOL PATH: {path} | Existed: {exist}".format(
            path=path, exist=exist))
        if exist:
            tool = path
            main_logger.info("Selected last path.")
            break
    else:
        main_logger.error("Tool not found! Test execution will be stopped.")
        return -1

    os.chdir(work_dir)
    maxScriptPath = maxScriptPath.replace("\\\\", "\\")
    rc = -1

    error_windows = set()

    main_logger.info("Start check cases")
    while check_cases(args.package_name, work_dir):
        p = psutil.Popen(os.path.join(args.output, 'script.bat'), stdout=subprocess.PIPE, stderr=subprocess.PIPE)

        while True:
            try:
                p.communicate(timeout=30)
            except (subprocess.TimeoutExpired, psutil.TimeoutExpired) as err:
                fatal_errors_titles = ['Radeon ProRender', 'AMD Radeon ProRender debug assert', '3ds Max',
                                       maxScriptPath + ' - MAXScript', 'Microsoft Visual C++ Runtime Library',
                                       '3ds Max Error Report', '3ds Max application', 'Radeon ProRender Error',
                                       'Image I/O Error']
                window_titles = get_windows_titles()
                main_logger.info(str(window_titles))
                error_window = set(fatal_errors_titles).intersection(window_titles)
                if error_window:
                    main_logger.info("Error window found: {}".format(error_window))
                    main_logger.info("Found windows: {}".format(window_titles))
                    error_windows.update(error_window)
                    rc = -1
                    try:
                        error_screen = pyscreenshot.grab()
                        error_case = get_error_case(args.package_name, work_dir)
                        error_screen.save(os.path.join(args.output, "Color", error_case + '.jpg'))
                    except Exception as err:
                        main_logger.error(str(err))

                    child_processes = p.children()
                    main_logger.info("Child processes: {}".format(child_processes))
                    for ch in child_processes:
                        try:
                            ch.terminate()
                            time.sleep(10)
                            ch.kill()
                            time.sleep(10)
                            status = ch.status()
                            main_logger.error("Process is alive: {}. Name: {}. Status: {}".format(ch, ch.name(), status))
                        except psutil.NoSuchProcess:
                            main_logger.info("Process is killed: {}".format(ch))

                    try:
                        p.terminate()
                        time.sleep(10)
                        p.kill()
                        time.sleep(10)
                        status = p.status()
                        main_logger.error("Process is alive: {}. Name: {}. Status: {}".format(p, p.name(), status))
                    except psutil.NoSuchProcess:
                        main_logger.info("Process is killed: {}".format(p))

                    break
            else:
                rc = 0
                break

    with open(os.path.join(work_dir, case_list)) as file:
        data = json.loads(file.read())
        cases = data["cases"]

    for case in cases:
        error_message = ''
        if case['status'] in ['fail', 'error']:
            error_message = "Testcase wasn't executed successfully"
        elif case['status'] in ['progress']:
            error_message = "Testcase wasn't finished"

        if error_message:
            main_logger.info("Testcase {} wasn't finished successfully: {}".format(case['name'], error_message))
            path_to_file = os.path.join(args.output, case['name'] + '_RPR.json')

            with open(path_to_file, 'r') as file:
                report = json.load(file)

            report[0]['group_timeout_exceeded'] = False
            report[0]['message'].append(error_message)
            if len(error_windows) != 0:
                report[0]['message'].append("Error windows {}".format(error_windows))

            with open(path_to_file, 'w') as file:
                json.dump(report, file, indent=4)

    main_logger.info("Search hanged processes...")
    for proc in psutil.process_iter():
        main_proc = psutil.Process(proc.pid)
        # Get process name & pid from process object.
        if proc.name() in ('3dsmax.exe', 'acwebbrowser.exe', 'AdSSO.exe'):
            main_logger.warning("UNTERMINATED PROCESS")
            try:
                main_proc.terminate()
                time.sleep(10)
                main_proc.kill()
                time.sleep(10)
                status = main_proc.status()
                main_logger.error("Process is alive: {}. Name: {}. Status: {}".format(main_proc, main_proc.name(), status))
            except psutil.NoSuchProcess:
                main_logger.info("Process is killed: {}".format(main_proc))

    return rc


if __name__ == "__main__":
    rc = main()
    exit(rc)
