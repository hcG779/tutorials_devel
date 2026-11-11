% Migrate a fresh copy, then test that exact model.
flowTools = fileparts(mfilename('fullpath'));

run(fullfile(flowTools, 'migrate_rfsoc_platform.m'));
setenv('CASPER_MODEL_FILE', dst);

% Close the saved model before the arithmetic test reloads it.
close_system(model, 0);

disp('REPOSITORY_ARITHMETIC_BEGIN');
run(fullfile(flowTools, 'verify_rfsoc_arithmetic.m'));
disp('REPOSITORY_SIMULATION_PASS');
