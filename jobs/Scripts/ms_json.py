import json
import pymxs

rt = pymxs.runtime

class Dictionary:
	def __init__(self, dictionary, filename):
		self.dictionary = dictionary
		self.filename = filename


	def dump(self):
		with open(self.filename, "w") as f:
			json.dump(self.dictionary, f, indent=4)
		return True

	def get(self):
		return self.dictionary


	def setCaseStatus(self, index, value):
		
		self.dictionary["cases"][index - 1]["status"] = value
		self.dump()

		return True


with open("case_list.json") as file:
	data = json.loads(file.read())

rt.caseList = Dictionary(data, "case_list.json")
