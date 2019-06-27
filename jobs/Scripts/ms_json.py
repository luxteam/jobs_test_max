import json
import pymxs

rt = pymxs.runtime

class JSONWrapper:
	def __init__(self, data, filename, mode=None):
		self.data = data
		self.filename = filename
		self.mode = mode

	def dump(self):
		with open(self.filename, "w") as f:
			if self.mode == "report":
				json.dump([self.data], f, indent=4)
			else:
				json.dump(self.data, f, indent=4)
		return True


	def get_data(self):
		return self.data


	def set_data(self, data):
		self.data = data
		return True


	def get_filename(self):
		return self.filename


	def set_filename(self, filename):
		self.filename = filename
		return True


	def setCaseStatus(self, index, value):
		self.data["cases"][index - 1]["status"] = value
		self.dump()
		return True


with open("case_list.json") as file:
	data = json.loads(file.read())


rt.caseList = JSONWrapper(data, "case_list.json")
rt.report = JSONWrapper({}, None, "report")