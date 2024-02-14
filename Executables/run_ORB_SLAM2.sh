# Variables
system="ORB_SLAM2_VANILLA"
experiment_name="test1"
experiment_folder="/home/fontan/testToDelete"

echo "Experiment ${experiment_name}"
echo "    system = ${system}"

# Constants
mode="mono" # Mode: mono / (rgbd) / (stereo) / (visualInertial)
numRuns="1"	
activeVisualization="1"
vocabulary_file="ORBvoc.txt"

ws_path="/home/fontan"
datasets_path="/media/fontan/data/Datasets"

seqNames=(
	 "rgbd_dataset_freiburg2_desk"
	 "rgbd_dataset_freiburg3_long_office_household"	
)
	  
datasetNames=(
	  "RGBDTUM" 
	  "RGBDTUM"
)
	  	
settingFiles=(
	  "TUM2.yaml" 
	  "TUM3.yaml"  
)

seqIndex=0
for sequence_name in "${seqNames[@]}"
do
	dataset_name=${datasetNames[seqIndex]}
	settings_file=${settingFiles[seqIndex]}
	path_to_output="${experiment_folder}/${experiment_name}/${sequence_name}"
	
	if [ ! -d ${path_to_output} ]; then
  		mkdir ${path_to_output}
	fi
	
	#./run_ORB_SLAM2_sequence.sh ${mode} ${numRuns} ${ws_path} ${sequence_name} ${dataset_name} ${settings_file} ${vocabulary_file} ${path_to_output} ${datasets_path} ${activeVisualization} ${system}
	
	groundtruth_file="${datasets_path}/${dataset_name}/${sequence_name}/groundtruth.txt"
	./evaluate_ORB_SLAM2_sequence.sh "ate" ${path_to_output} ${groundtruth_file} "0.033" " ${ws_path}/${system}"
done
