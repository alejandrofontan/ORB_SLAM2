import os
import sys
import subprocess
import tarfile
import shutil

       
def main():
      
    current_script_path = __file__
    orbslam2_directory = os.path.dirname(os.path.abspath(current_script_path))
    
    ## Extract vocabulary
    vocabulary_folder = os.path.join(orbslam2_directory, 'Vocabulary')
    print("[ORB-SLAM2][build.py] Extracting vocabulary (output disabled) ... ")   
    vocabulary_file = os.path.join(vocabulary_folder, 'ORBvoc.txt.tar.gz')
           
    with tarfile.open(vocabulary_file, "r:*") as tar:
        tar.extractall(path=vocabulary_folder,filter='fully_trusted')
        
                 
    ## Compile DBoW2 
    print("[ORB-SLAM2][build.py] Compiling DBoW2 (output disabled) ... ")   
    source_folder = os.path.join(orbslam2_directory,"Thirdparty/DBoW2")      
    build_folder = os.path.join(source_folder,"build")
    bin_folder = os.path.join(source_folder,"bin") 
    lib_folder = os.path.join(source_folder,"lib")
    
    if os.path.isdir(build_folder): 
        shutil.rmtree(build_folder)  
    if os.path.isdir(bin_folder): 
        shutil.rmtree(bin_folder)  
    if os.path.isdir(lib_folder): 
        shutil.rmtree(lib_folder)          
    if not os.path.isdir(build_folder): 
        subprocess.run(["mkdir",build_folder])   
   
    subprocess.run(["cmake", "-G", "Ninja","-B", build_folder,"-S",os.path.join(source_folder),"-DCMAKE_PREFIX_PATH=" + source_folder,"-DCMAKE_INSTALL_PREFIX=" + source_folder], capture_output=True, text=True)   
    subprocess.run(["cmake","--build", build_folder, "--config Release"], capture_output=True, text=True)
    subprocess.run(["ninja","install","-C", build_folder], capture_output=True, text=True)
    
    ## Compile g2o 
    print("[ORB-SLAM2][build.py] Compiling g2o (output disabled) ... ")   
    source_folder = os.path.join(orbslam2_directory,"Thirdparty/g2o")      
    build_folder = os.path.join(source_folder,"build")
    bin_folder = os.path.join(source_folder,"bin") 
    lib_folder = os.path.join(source_folder,"lib")
    
    if os.path.isdir(build_folder): 
        shutil.rmtree(build_folder)  
    if os.path.isdir(bin_folder): 
        shutil.rmtree(bin_folder)  
    if os.path.isdir(lib_folder): 
        shutil.rmtree(lib_folder)          
    if not os.path.isdir(build_folder): 
        subprocess.run(["mkdir",build_folder])   
   
    subprocess.run(["cmake", "-G", "Ninja","-B", build_folder,"-S",os.path.join(source_folder),"-DCMAKE_PREFIX_PATH=" + source_folder,"-DCMAKE_INSTALL_PREFIX=" + source_folder], capture_output=True, text=True)   
    subprocess.run(["cmake","--build", build_folder, "--config Release"], capture_output=True, text=True)
    subprocess.run(["ninja","install","-C", build_folder], capture_output=True, text=True)
    
    ## Compile ORB-SLAM2      
    print("[ORB-SLAM2][build.py] Compiling ORB-SLAM2 (output disabled) ... ")             
    source_folder = orbslam2_directory
    build_folder = os.path.join(source_folder,"build")
    bin_folder = os.path.join(source_folder,"bin") 
    lib_folder = os.path.join(source_folder,"lib")
    
    if os.path.isdir(build_folder): 
        shutil.rmtree(build_folder)  
    if os.path.isdir(bin_folder): 
        shutil.rmtree(bin_folder)  
    if os.path.isdir(lib_folder): 
        shutil.rmtree(lib_folder)          
    if not os.path.isdir(build_folder): 
        subprocess.run(["mkdir",build_folder])   
   
    subprocess.run(["cmake", "-G", "Ninja","-B", build_folder,"-S",os.path.join(source_folder),"-DCMAKE_PREFIX_PATH=" + source_folder,"-DCMAKE_INSTALL_PREFIX=" + source_folder], capture_output=True, text=True)   
    subprocess.run(["cmake","--build", build_folder, "--config Release"], capture_output=True, text=True)

if __name__ == "__main__":
    main()                
