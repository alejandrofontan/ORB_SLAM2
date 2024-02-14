#Inputs
mode=${1?Error: no mode}				 # Mode: mono / (rgbd) / (stereo) / (visualInertial)
numRuns=${2?Error: no numRuns}				
ws_path=${3?Error: no ws_path}				
sequence_name=${4?Error: no sequence_name}				
dataset_name=${5?Error: no dataset_name}				
settings_file=${6?Error: no settings_file}				
vocabulary_file=${7?Error: no vocabulary_file}				
path_to_output=${8?Error: no path_to_output}
datasets_path=${9?Error: no datasets_path}
activeVisualization=${10?Error: no activeVisualization}
system=${11?Error: no system}

echo "Executing run ${system}.sh ..."
echo "    mode = ${mode}"
echo "    numRuns = ${numRuns}"

# Constants
system_path="${ws_path}/${system}"
executable="Examples/${mode}/${mode}"
path_to_settings="${system_path}/Examples/${mode}/${settings_file}"
path_to_sequence="${datasets_path}/${dataset_name}/${sequence_name}"
path_to_vocabulary="${system_path}/Vocabulary/${vocabulary_file}"

echo ""
echo "    Running .${system_path}/${executable} ..."	
cd ${system_path}
for ((iRun = 0 ; iRun < ${numRuns} ; iRun++));
do
	previousRuns=($(ls ${path_to_output}/*system_output* 2>/dev/null)) 
	experimentIndex=${#previousRuns[@]}
	system_output="${path_to_output}/system_output_${experimentIndex}"
	> ${system_output}
	echo "        in /${dataset_name}/${sequence_name} , exp index = ${experimentIndex} , with : /${mode}/${settings_file}" 
	./${executable} ${path_to_vocabulary} ${path_to_settings} ${path_to_sequence} ${path_to_output} ${experimentIndex} ${activeVisualization} > /dev/null > $system_output 2>&1
done
