import argparse
import sys
import os
import subprocess
import psutil
import json
import ctypes
import pyscreenshot
from shutil import copyfile


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

	max_script_template = base + max_script_template
	maxScript = max_script_template.format(pass_limit=args.pass_limit,
										   work_dir=work_dir,
										   package_name=args.package_name, ren_mode=args.render_mode,
										   render_mode=args.render_mode, res_path=res_path, scene_list=scene_list, resolution_y = args.resolution_y,
										   resolution_x = args.resolution_x)

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

	maxScriptPath = maxScriptPath.replace("\\\\", "\\")

	p = psutil.Popen(os.path.join(args.output, 'script.bat'), stdout=subprocess.PIPE, stderr=subprocess.PIPE)
	rc = -1

	while True:
		try:
			rc = p.communicate(timeout=5)
		except (subprocess.TimeoutExpired, psutil.TimeoutExpired) as err:
			fatal_errors_titles = ['Radeon ProRender', 'AMD Radeon ProRender debug assert',\
			maxScriptPath + ' - MAXScript', '3ds Max', 'Microsoft Visual C++ Runtime Library', \
			'3ds Max Error Report', '3ds Max application', 'Radeon ProRender Error', 'Image I/O Error']
			if set(fatal_errors_titles).intersection(get_windows_titles()):
				rc = -1
				try:
					error_screen = pyscreenshot.grab()
					error_screen.save(os.path.join(args.output, 'error_screenshot.jpg'))
				except:
					pass
				for child in reversed(p.children(recursive=True)):
					child.terminate()
				p.terminate()
				break
		else:
			rc = 0
			break

	with open(os.path.join(args.output, args.stage_report), 'w') as file:
		json.dump(stage_report, file, indent=' ')

	return rc


if __name__ == "__main__":
	rc = main()
	exit(rc)
