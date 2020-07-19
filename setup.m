function setup()
% Add Chest wall toolbox to the path
% 
% All rights reserved

[root, ~, ~] = fileparts(mfilename('fullpath'));

addpath(fullfile(root, 'data'))
addpath(fullfile(root, 'misc'))
addpath(fullfile(root, 'results'))

fprintf('Chest wall method is ready\n')