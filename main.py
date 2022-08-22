from sys import argv as argv
from yaml import safe_load
from jinja2 import FileSystemLoader, Environment, TemplateNotFound
from time import strftime


def generate_config(configVars, j2_template, filename="config", printconfig=False):
    timestring = strftime("%Y%m%d-%H%M%S")
    try:
        with open(configVars) as envvars:
            configData = safe_load(envvars)
            env = Environment(loader = FileSystemLoader('./templates'))
            try:
                template = env.get_template(j2_template)
                config = template.render(configData)
                with open(filename + timestring + ".txt", 'w') as f:
                    f.write(config)
                if printconfig is True:
                    print(config)
            except TemplateNotFound:
                print("Template file not found.")
    except FileNotFoundError:
        print("Feed variables file not found.")


def main():

    if len(argv) < 3:
        raise Exception('Please specify Variables (YML), Template File, Output File (optional), Verbose (optional)')
    elif len(argv) == 3:
        generate_config(argv[1], argv[2])
    elif len(argv) == 4:
        generate_config(argv[1], argv[2], argv[3])
    else:
        verbose = argv[4]
        if verbose.lower() in ['true', 'yes', 'v', 'verbose']:
            generate_config(argv[1], argv[2], argv[3], True)
        else:
            generate_config(argv[1], argv[2], argv[3])


if __name__ == "__main__":
    main()
