
file        = 'StartDyConToolbox.m';
pathfile    =  replace(which(file),file,''); 

casADi_folder = fullfile(pathfile,'dev');
untar('https://github.com/casadi/casadi/releases/download/3.5.1/casadi-osx-matlabR2015a-v3.5.1.tar.gz',casADi_folder)
