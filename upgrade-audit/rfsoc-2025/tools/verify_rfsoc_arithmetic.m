checks = getenv('CASPER_CHECKS_DIR');
modelpath = getenv('CASPER_MODEL_FILE');
assert(~isempty(checks) && isfolder(checks), ...
    'CASPER_CHECKS_DIR must specify an existing directory.');
assert(~isempty(modelpath) && isfile(modelpath), ...
    'CASPER_MODEL_FILE must specify an existing model.');

[testdir,model] = fileparts(modelpath);
cd(testdir);
setenv('COMPILER_PATH',fullfile(checks,'system-linker'));
load_system(modelpath);

% Add temporary logging branches; do not save them to the model.
sources = {'ain','bin','AddSub','sum_a_b'};
variables = {'probe_a','probe_b','probe_add','probe_sum'};
for k = 1:numel(sources)
    sink = ['numeric_probe_' num2str(k)];
    add_block('simulink/Sinks/To Workspace',[model '/' sink], ...
        'VariableName',variables{k},'SaveFormat','Timeseries', ...
        'MaxDataPoints','inf','Decimation','1');
    add_line(model,[sources{k} '/1'],[sink '/1'],'autorouting','on');
end

cases = [10 20; 0 0; 12345 6789];

for index = 1:size(cases,1)
    inputA = cases(index,1);
    inputB = cases(index,2);
    expected = inputA + inputB;

    set_param([model '/a_sim'],'Value',num2str(inputA));
    set_param([model '/b_sim'],'Value',num2str(inputB));

    result = sim(model,'StopTime','64','ReturnWorkspaceOutputs','on');

    save(fullfile(checks,sprintf('rfsoc-arithmetic-case-%d.mat',index)), ...
        'result','inputA','inputB','expected');

    a = result.get('probe_a');
    b = result.get('probe_b');
    c = result.get('probe_add');
    s = result.get('probe_sum');

    va = double(a.Data(:));
    vb = double(b.Data(:));
    vc = double(c.Data(:));
    vs = double(s.Data(:));

    assert(isequal(a.Time(:),b.Time(:),c.Time(:)), ...
        'Intermediate signal time grids differ.');
    assert(isequal(vc,va+vb),'AddSub sample-by-sample mismatch.');

    assert(numel(va)>=3 && numel(vb)>=3 && numel(vs)>=3, ...
        'Insufficient recorded samples.');
    assert(all(va(end-2:end)==inputA),'Register A mismatch.');
    assert(all(vb(end-2:end)==inputB),'Register B mismatch.');
    assert(all(vs(end-2:end)==expected),'Final sum mismatch.');

    fprintf('CASE_%d_PASS: A=%g B=%g expected=%g actual=%g\n', ...
        index,inputA,inputB,expected,vs(end));
end

disp('ARITHMETIC_CHECK_PASS');
close_system(model,0);
