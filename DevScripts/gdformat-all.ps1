# Format all GDScript files in project

# It is recommended to run this from a Python virtual environment where gdtoolkit is installed
# See: https://docs.python.org/3/tutorial/venv.html#creating-virtual-environments
# See: https://github.com/Scony/godot-gdscript-toolkit

$projectPath = '../'
$maxLineLength = 100

gdformat $projectPath --line-length $maxLineLength