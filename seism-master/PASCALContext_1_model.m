%% Experiments parameters (TODO: add the necessary paths)
addpath('/home/nipopovic/switchtask_beegfs02/NIKOLA/edge_evaluation/edge_eval_regular_1/seism-master/src/scripts/')
addpath('/home/nipopovic/switchtask_beegfs02/NIKOLA/edge_evaluation/edge_eval_regular_1/seism-master/src/misc/')
addpath('/home/nipopovic/switchtask_beegfs02/NIKOLA/edge_evaluation/edge_eval_regular_1/seism-master/src/tests/')
addpath('/home/nipopovic/switchtask_beegfs02/NIKOLA/edge_evaluation/edge_eval_regular_1/seism-master/src/gt_wrappers/')
addpath('/home/nipopovic/switchtask_beegfs02/NIKOLA/edge_evaluation/edge_eval_regular_1/seism-master/src/io/')
addpath('/home/nipopovic/switchtask_beegfs02/NIKOLA/edge_evaluation/edge_eval_regular_1/seism-master/src/measures/')
addpath('/home/nipopovic/switchtask_beegfs02/NIKOLA/edge_evaluation/edge_eval_regular_1/seism-master/src/piotr_edges/')
addpath('/home/nipopovic/switchtask_beegfs02/NIKOLA/edge_evaluation/edge_eval_regular_1/seism-master/src/segbench/')
database = 'PASCALContext';

% Write results in format to use latex code?
writePR = 0;

% Use precomputed results or evaluate on your computer?
USEprecomputed = 0;

% Precision-recall measures
measures = {'fb',...  % Precision-recall for boundaries
'fop'};   % Precision-recall for Object Proposals

% Define all methods to be compared
methods  = [];
switch database
case 'PASCALContext'
gt_set   = 'val';
methods(end+1).name = 'PASCALContext_1_model'; methods(end).io_func = @read_one_png; methods(end).legend =     methods(end).name;  methods(end).type = 'contour';
otherwise
error('Unknown name of the database');
end

% Colors to display
colors = {'b','g','r','k','m','c','y','b','g','r','k','m','c','y','k','g','b','g','r'};

% % Evaluate using the correct reading function
if ~USEprecomputed
for ii=1:length(measures)
for jj=1:length(methods)
% Contours only in 'fb'
is_cont = strcmp(methods(jj).type,'contour');
if strcmp(measures{ii},'fb') || ~is_cont
if exist('cat_id','var')
eval_method_all_params(methods(jj).name, measures{ii}, methods(jj).io_func, database, gt_set, is_cont, cat_id);
else
eval_method_all_params(methods(jj).name, measures{ii}, methods(jj).io_func, database, gt_set, is_cont);
end
end
end
end
end

for kk=1:length(measures)
% Plot methods
for ii=1:length(methods)
if strcmp(measures{kk},'fb') || strcmp(methods(ii).type,'segmentation')
fprintf([methods(ii).name ': ' repmat(' ',[1,15-length(methods(ii).name)])]);

if strcmp(methods(ii).type,'contour'),style='--';else, style='-';end

params = get_method_parameters(methods(ii).name);

if strcmp(database,'SBD')
curr_meas = gather_measure(methods(ii).name,params,measures{kk},database,gt_set,cat_id);
else
curr_meas = gather_measure(methods(ii).name,params,measures{kk},database,gt_set);
end
curr_ods  = general_ods(curr_meas);
curr_ois  = general_ois(curr_meas);
curr_ap   = general_ap(curr_meas);
filename = '/srv/beegfs02/scratch/switchtasks/data/NIKOLA/Experiments/AWS_exp/2021-01-23/3_exp/single_task_edges/PASCALContext_test_edge.txt'
display(filename)
fileID = fopen(filename, 'w')
fprintf(fileID, ['odsF:' sprintf('%0.3f',curr_ods.mean_value) '\n' ' oisF:' sprintf('%0.3f',curr_ois.mean_value) '\n'])

fclose(fileID)
end
end
end
