# Analyze cyclomatic complexity of all GDScript files in project

# See: https://radon.readthedocs.io/en/latest/commandline.html#the-cc-command

# CC score | Rank | Risk
# -----------------------------------------------------------
# 1 - 5    | A	  | low - simple block
# 6 - 10   | B    | low - well structured and stable block
# 11 - 20  | C    | moderate - slightly complex block
# 21 - 30  | D    | more than moderate - more complex block
# 31 - 40  | E    | high - complex block, alarming
# 41+      | F    | very high - error-prone, unstable block

# Files with a rating of E or F should be considered for refactoring

# It is recommended to run this from a Python virtual environment where gdtoolkit is installed
# See: https://docs.python.org/3/tutorial/venv.html#creating-virtual-environments
# See: https://github.com/Scony/godot-gdscript-toolkit

$projectPath = '../'

gdradon cc $projectPath