#!/bin/bash

delete_if_exists() {
  local folder=$1
  build_folder="${folder}/build"
  bin_folder="${folder}/bin"
  lib_folder="${folder}/lib"
  if [ -d "$build_folder" ]; then
    rm -rf "$build_folder"
  fi
  if [ -d "$bin_folder" ]; then
    rm -rf "$bin_folder"
  fi
  if [ -d "$lib_folder" ]; then
    rm -rf "$lib_folder"
  fi
}

# Check inputs
force_build=false
verbose=false
for input in "$@"
do
    echo "Processing input: $input"
    if [ "$input" = "-f" ]; then
  	force_build=true   
    fi
    if [ "$input" = "-v" ]; then
  	verbose=true   
    fi
done

# Baseline Dir
ORB_SLAM2_PATH=$(realpath "$0")
ORB_SLAM2_DIR=$(dirname "$ORB_SLAM2_PATH")

## Compile DBoW2 
source_folder="${ORB_SLAM2_DIR}/Thirdparty/DBoW2"     
build_folder="$source_folder/build"
bin_folder="$source_folder/bin"
lib_folder="$source_folder/lib"

if [ "$force_build" = true ]; then
	delete_if_exists ${source_folder}
fi

if [ "$verbose" = true ]; then
	echo "[ORB-SLAM2][build.sh] Compile DBoW2 ... "   
	cmake -G Ninja -B $build_folder -S $source_folder -DCMAKE_PREFIX_PATH=$source_folder -DCMAKE_INSTALL_PREFIX=$source_folder 
	cmake --build $build_folder --config Release 
	ninja install -C $build_folder
else
        echo "[ORB-SLAM2][build.sh] Compile DBoW2 (output disabled) ... "   
	cmake -G Ninja -B $build_folder -S $source_folder -DCMAKE_PREFIX_PATH=$source_folder -DCMAKE_INSTALL_PREFIX=$source_folder > /dev/null 2>&1
	cmake --build $build_folder --config Release > /dev/null 2>&1
	ninja install -C $build_folder > /dev/null 2>&1
fi

## Compile g2o 
source_folder="${ORB_SLAM2_DIR}/Thirdparty/g2o"     
build_folder="$source_folder/build"
bin_folder="$source_folder/bin"
lib_folder="$source_folder/lib"

if [ "$force_build" = true ]; then
	delete_if_exists ${source_folder}
fi

if [ "$verbose" = true ]; then
        echo "[ORB-SLAM2][build.sh] Compile g2o ... "   
	cmake -G Ninja -B $build_folder -S $source_folder -DCMAKE_PREFIX_PATH=$source_folder -DCMAKE_INSTALL_PREFIX=$source_folder 
	cmake --build $build_folder --config Release 
else
        echo "[ORB-SLAM2][build.sh] Compile g2o (output disabled) ... "   
	cmake -G Ninja -B $build_folder -S $source_folder -DCMAKE_PREFIX_PATH=$source_folder -DCMAKE_INSTALL_PREFIX=$source_folder > /dev/null 2>&1
	cmake --build $build_folder --config Release > /dev/null 2>&1
fi

## Compile ORB-SLAM2    
source_folder="${ORB_SLAM2_DIR}"     
build_folder="$source_folder/build"
bin_folder="$source_folder/bin"
lib_folder="$source_folder/lib"

if [ "$force_build" = true ]; then
	delete_if_exists ${source_folder}
fi

if [ "$verbose" = true ]; then
        echo "[ORB-SLAM2][build.sh] Compile ORB-SLAM2 ... "  
	cmake -G Ninja -B $build_folder -S $source_folder -DCMAKE_PREFIX_PATH=$source_folder -DCMAKE_INSTALL_PREFIX=$source_folder 
	cmake --build $build_folder --config Release 
else    
	echo "[ORB-SLAM2][build.sh] Compile ORB-SLAM2 (output disabled) ..."   
	cmake -G Ninja -B $build_folder -S $source_folder -DCMAKE_PREFIX_PATH=$source_folder -DCMAKE_INSTALL_PREFIX=$source_folder > /dev/null 2>&1
	cmake --build $build_folder --config Release > /dev/null 2>&1
fi

## Uncompress vocabulary
echo "[ORB-SLAM2][build.sh] Uncompress vocabulary ... " 
vocabulary_folder="${ORB_SLAM2_DIR}/Vocabulary"
if [ ! -f "${vocabulary_folder}/ORBvoc.txt" ]; then
	tar -xf "${ORB_SLAM2_DIR}/Vocabulary/ORBvoc.txt.tar.gz" -C "${ORB_SLAM2_DIR}/Vocabulary"
fi



