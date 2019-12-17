import tkinter as tk
from tkinter import filedialog
import subprocess
import os

abspath = os.path.abspath(__file__)
dname = os.path.dirname(abspath)
os.chdir(dname)
# subprocess.call(["chmod +x lofreq.sh"])

def main(ref,que):
	print("---Pipeling start---")

	subprocess.check_call([os.getcwd()+'/bowtiescript.sh', ref, que])

	queryFileName = que.split("/")[-1].split(".")[0]
	sortedbam = "sorted_"+queryFileName+".bam"

	if choice1 == "1":
		if choice2 == "1":
			subprocess.check_call([os.getcwd()+'/pipeline.sh',"bowtie","lofreq",ref, que])
		elif choice2 == "2":
			subprocess.check_call([os.getcwd()+'/pipeline.sh',"bowtie","virvarseq",ref, que])
	elif choice1 == "2":
		if choice2 == "1":
			subprocess.check_call([os.getcwd()+'/pipeline.sh',"last","lofreq",ref, que])
		elif choice2 == "2":
			subprocess.check_call([os.getcwd()+'/pipeline.sh',"last","virvarseq",ref, que])

	print("Pipeline finished!")

root = tk.Tk()
root.withdraw()

print("Choose your reference sequence")
root.update()
reference_path = filedialog.askopenfilename(title = "Select reference sequence")
print("Your reference sequence is: " + reference_path)

print("Choose your query sequence")
root.update()
query_path = filedialog.askopenfilename(title = "Select query sequence")
print("Your query sequence is: " + query_path)

print("Choose your sequence aligner")
choice1 = input("Input 1 for Bowtie, 2 for Last\n")
print("Choose your variant caller")
choice2 = input("Input 1 for Lofreq, 2 for VirVarSeq\n")

if (choice1 != "1" and choice1 != "2") or (choice2 != "1" and choice2 != "2"):
	print("Invalid input! Program terminating...")
else:
	main(reference_path,query_path)