model = 'rfsoc4x2_tut_platform';
src = fullfile(getenv('CASPER_TUTORIAL_ROOT'), ...
    'rfsoc','tut_platform',[model '.slx']);

% 每次建立新目錄，確保從原始模型開始
testdir = tempname(getenv('CASPER_CHECKS_DIR'));
mkdir(testdir);
dst = fullfile(testdir,[model '.slx']);
copyfile(src,dst);
fprintf('TEST_MODEL: %s\n',dst);

cd(testdir);
load_system(dst);

disp('AMD_HUB_CONVERSION_BEGIN');
sg = [model '/ System Generator'];
hub = vmcReplaceSysgenWithHubBlock(sg);
hub = getfullname(hub);
fprintf('CONVERTED_HUB: %s\n',hub);
set_param(hub,'Tag','genX');

% 確認新版 Hub API 能辨識轉換結果
assert(strcmp(get_param(hub,'ReferenceBlock'), ...
    'vmcUtilities/Vitis Model Composer Hub'), ...
    'Unexpected Hub library reference.');
disp('AMD_HUB_CONVERSION_PASS');

platform = [model '/RFSoC4x2'];
position = get_param(platform,'Position');
delete_block(platform);
add_block('xps_library/Platforms/RFSoC',platform,'Position',position);

set_param(platform,'hw_sys','RFSoC4x2:xczu48dr-ffvg1517-2-e');
set_param(platform,'clk_src','adc_clk', ...
    'clk_rate','245.76','pl_clk_rate','122.88','sample_period','1');
disp('PLATFORM_MIGRATION_PASS');

disp('HUB_MODEL_UPDATE_BEGIN');
set_param(model,'SimulationCommand','update');
disp('HUB_MODEL_UPDATE_PASS');

save_system(model,dst);
fprintf('MIGRATED_MODEL_SAVED: %s\n',dst);
