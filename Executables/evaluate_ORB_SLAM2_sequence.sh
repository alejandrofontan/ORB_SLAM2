#Inputs
metric=${1?Error: no metric}		
path_to_output=${2?Error: no path_to_output}		
groundtruth_file=${3?Error: no groundtruth_file}	
max_diff=${4?Error: no max_diff}	
systemPath=${5?Error: no systemPath}

echo "Executing evaluate ORB_SLAM2.sh ..."
echo "    metric = ${metric}"
echo "    max_diff = ${max_diff}"

tools_path="${systemPath}/Executables"
evaluate_ate_scale_script="${tools_path}/evaluate_ate_scale_fontan.py";
echo "    Evaluating  ..."	


if [ ${metric} == 'ate' ]
then

	resuls_keyFrame_TUMformat_ate="${path_to_output}/resuls_keyFrame_TUMformat_ate.txt"
	> ${resuls_keyFrame_TUMformat_ate}


	txtKeyFrameFiles=($(ls ${path_to_output}/*_KeyFrameTrajectory.txt))
	for j in "${txtKeyFrameFiles[@]}"
	do
		trajectoryFile="${j%.txt}"
		alignedTrajectoryPlot="${trajectoryFile}_alignedPlot.png"
		alignedTrajectoryFile="${trajectoryFile}_alignedFile.txt"
		echo "        ${j} against ${groundtruth_file}"
		numKey_ate_scale=$(python2 ${evaluate_ate_scale_script} --plot ${alignedTrajectoryPlot} --save_associations ${alignedTrajectoryFile} --max_difference ${max_diff} ${groundtruth_file} ${j})
		(echo "${numKey_ate_scale}") >> ${resuls_keyFrame_TUMformat_ate}

	done
fi

