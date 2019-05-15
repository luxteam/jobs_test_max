import MaxPlus
import json
import os

case_list = "case_list.json"

def dict_py_to_ms(d):
	""" Return string such as 'Dictionary #(#key1, value1) ... #(#keyN, valueN)' for MS eval """
	
	key_value = []

	for k in d:
		if type(d[k]) in [unicode, list]:
			if type(d[k]) == list:
				# unicode issue
				d[k] = [str(i) for i in d[k]]
				# backslash issue
				d[k] = str(d[k]).replace("'", '\\"')
			
			key_value += ["#(#'{}', \"{}\")".format(k, str(d[k]))]
		
		else:
			key_value += ["#(#'{}', {})".format(k, d[k])]
	
	return "Dictionary " + " ".join(key_value)


def switch_case_status(case_name, status):
	""" Change case status during execution tests """
	
	with open(case_list) as file:
		data = json.loads(file.read())

	try:
		for case in data["cases"]:
			if case["name"] == case_name:
				case["status"] = status
	except KeyError as err:
		return False

	with open(case_list, 'w') as file:
		json.dump(data, file, indent=4)

	return True


def read_json(group):
	""" Read json file """
	with open("case_list.json") as file:
		data = json.loads(file.read())
	cases = [dict_py_to_ms(case) for case in data["cases"]]
	MaxPlus.Core.EvalMAXScript("tmp = {}".format("#({})".format(", ".join(cases))))
