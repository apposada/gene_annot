

organism = config["organism"]
genome = config["path_genome"]
annot = config["path_gtf"]

# helper functions

def proteome_organism():
	species = config["organism"]
	proteomepath = 'orthofinder/' + species + ".fa"
	return proteomepath

# input function
# here is to be a rule that dynamically expands according to what is being specified by the user in the config file. Remember we must learn to include true/false, activate/deactivate switches.