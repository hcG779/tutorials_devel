checks = getenv('CASPER_CHECKS_DIR');
src = getenv('CASPER_MODEL_FILE');
assert(~isempty(checks) && isfolder(checks), ...
    'CASPER_CHECKS_DIR must specify an existing directory.');
assert(~isempty(src) && isfile(src), ...
    'CASPER_MODEL_FILE must specify an existing model.');

% Use a new build directory and retain previous results.
workdir = tempname(checks);
mkdir(workdir);
model = 'rfsoc4x2_tut_platform';
modelpath = fullfile(workdir,[model '.slx']);
copyfile(src,modelpath);
builddir = fullfile(workdir,model);

fprintf('FRONTEND_MODEL: %s\n',modelpath);
fprintf('FRONTEND_BUILD_DIR: %s\n',builddir);

venv = getenv('CASPER_PYTHON_VENV_ON_START');
setenv('PATH',[fullfile(venv,'bin') pathsep getenv('PATH')]);
setenv('PYTHONHOME','');
setenv('COMPILER_PATH',fullfile(checks,'system-linker'));

cd(workdir);
load_system(modelpath);
assert(strcmp(bdroot,model),'Unexpected current model.');

disp('JASPER_FRONTEND_BEGIN');
build_cmd = jasper_frontend(modelpath);
assert(~isempty(build_cmd),'Frontend returned no backend command.');

fid = fopen(fullfile(workdir,'backend-command.txt'),'w');
assert(fid>=0,'Cannot save backend command.');
fprintf(fid,'%s\n',build_cmd);
fclose(fid);

disp('JASPER_FRONTEND_RETURNED');
disp('GENERATED_IP_DESCRIPTORS');
descriptors = dir(fullfile(builddir,'sysgen','**','component.xml'));
for k = 1:numel(descriptors)
    disp(fullfile(descriptors(k).folder,descriptors(k).name));
end
fprintf('IP_DESCRIPTOR_COUNT: %d\n',numel(descriptors));
assert(~isempty(descriptors), 'No generated IP descriptor found.');
fprintf('BACKEND_COMMAND_FILE: %s\n', ...
    fullfile(workdir,'backend-command.txt'));
disp('REPOSITORY_FRONTEND_PASS');


close_system(model,0);
