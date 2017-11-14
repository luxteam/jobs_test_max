import argparse
import sys
import os
import subprocess
import psutil
import json
# TODO: create


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

    cmdRun = '"{tool}" -U MAXScript "{job_script}" -silent' \
        .format(tool=tool, job_script=maxScriptPath)

    cmdScriptPath = os.path.join(work_dir, 'script.bat')
    with open(cmdScriptPath, 'w') as f:
        f.write(cmdRun)

    os.chdir(work_dir)

    p = psutil.Popen(os.path.join(args.output, 'script.bat'), stdout=subprocess.PIPE)
    try:
        rc = p.wait(timeout=2000)
    except psutil.TimeoutExpired as err:
        sub_skip = -1
        for child in reversed(p.children(recursive=True)):
            child.terminate()
        p.terminate()

    sub_skip = 0

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
    check_count()
    exit(rc)
