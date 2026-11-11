% Migrate a fresh copy, then generate its Model Composer IP.
flowTools = fileparts(mfilename('fullpath'));

run(fullfile(flowTools, 'migrate_rfsoc_platform.m'));
setenv('CASPER_MODEL_FILE', dst);
close_system(model, 0);

disp('REPOSITORY_FRONTEND_BEGIN');
run(fullfile(flowTools, 'build_rfsoc_frontend.m'));
