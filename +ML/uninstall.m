function uninstall(varargin)
% ML.uninstall MLab uninstall
%   ML.uninstall() uninstalls MLab and all associated plugins.
%
%   ML.uninstall('plugins', P) uninstalls only the plugin(s) P. P can be 
%   either a string (single plugin name) or a cell of string (list of 
%   plugin names).
%
%   ML.uninstall(..., 'config', true) also uninstalls the configuration
%   files. After uninstallation with this option set to true, there is no 
%   trace left of MLab in the filesystem.
%
%   See also ML.stop
%
%   More on <a href="matlab:ML.doc('ML.uninstall');">ML.doc</a>

% --- Inputs
in = ML.Input;
in.plugins({}) = @(x) ischar(x) || iscellstring(x);
in.config(false) = @islogical;
in = +in;

% Cellification
if ischar(in.plugins)
    in.plugins = {in.plugins};
end

% --- Preparation
config = ML.Config.get;

% --- Remove MLab
if isempty(in.plugins)
   
    % Remove MLab
    rmdir(config.path, 's');
    
    % Remove configuration file
    if in.config
        delete([prefdir filesep 'MLab.mat']);
    end
    
end
    
% --- Remove plugins

for i = 1:numel(in.plugins)
    
    % Remove plugin
    rmdir([config.path 'Plugins' filesep in.plugins{i}], 's');
    
    % Remove configuration file
    if in.config
        fname = [prefdir filesep 'MLab_' in.plugins{i} '.mat'];
        if exist(fname, 'file'), delete(fname); end
    end
end