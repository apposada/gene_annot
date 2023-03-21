import argparse

# Parse the command-line arguments
parser = argparse.ArgumentParser()
parser.add_argument('input_file', help='path to the interproscan results tsv')
parser.add_argument('db_file', help='path to the database')
parser.add_argument('output_file', help='path to the output file')
args = parser.parse_args()

# Open the input file for reading
with open(args.input_file, "r") as f:
    # Read in the lines of the file as a list of strings
    lines = f.readlines()

# Open the db file for reading
with open(args.db_file, "r") as f:
    # Read in the lines of the file as a list of strings and strip any whitespace
    values = [line.strip() for line in f.readlines()]

# Filter the lines of the input file based on whether any of their columns match any of the values in the db file
filtered_lines = []
for line in lines:
    columns = line.strip().split('\t')
    for column in columns:
        if column in values:
            filtered_lines.append(line)
            break  # no need to check remaining columns once a match is found

# Write the filtered lines to the output file
with open(args.output_file, "w") as f:
    f.writelines(filtered_lines)