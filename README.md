SwitchConfig with YAML

This is a Python3 script that fills in the YAML feed variables files into the template file for generating
command line configurations.

The script takes several arguments:

Argument 1: Variables in YAML format

Argument 2: Template file

Argument 3: (Optional) Output file name (will have time appended)

Argument 4: (Optional) Verbose operator ("True", "Yes", "V", "Verbose")

To run:

python main.py vars.yml rtr.tpl

python main.py vars.yml rtr.tpl myrouterconfig verbose