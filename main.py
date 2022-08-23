from sys import argv as argv
from yaml import safe_load
from jinja2 import FileSystemLoader, Environment, TemplateNotFound
from time import strftime


def generate_config(configVars, j2_template, filename="config", printconfig=False):
    # Get time for output file
    timestring = strftime("%Y%m%d-%H%M%S")
    try:
        with open(configVars) as envvars:
            # Load environment variables from YAML
            configData = safe_load(envvars)
            # Create jinja2 environment
            env = Environment(loader = FileSystemLoader('./templates'))
            try:
                template = env.get_template(j2_template)
                # Render configuration file
                config = template.render(configData)
                with open(filename + timestring + ".txt", 'w') as f:
                    # Write config to file
                    f.write(config)
                if printconfig is True:
                    # Print config to terminal if verbose
                    print(config)
            except TemplateNotFound:
                print("Template file not found.")
    except FileNotFoundError:
        print("Feed variables file not found.")


def main():

    """ Arguments:
        1. Feed variables as YAML
        2. Template file
        3. (Optional) Output file name
        4. (Optional) Verbose switch (true, yes, v, or verbose)
    """

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
