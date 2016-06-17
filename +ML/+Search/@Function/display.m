function display(this)

% --- Header
ML.CW.print(' ~bc[50 100 150]{%s}~c[gray]{%s} (%s function)', this.Name, this.Extension, this.Category);
fprintf('\t\t[<a href="matlab:edit ''%s'';">Edit file</a>]' , this.Syntax);
fprintf('   [<a href="matlab:help ''%s'';">Help</a>]' , this.Syntax);
switch this.Category
    case {'Built-in', 'Matlab', 'Toolbox'}
        fprintf('   [<a href="matlab:doc ''%s'';">Doc</a>]\n' , this.Syntax);
    case {'MLab', 'Plugin'}
        fprintf('   [<a href="matlab:ML.doc(''%s'');">ML.Doc</a>]\n' , this.Syntax);
end

ML.CW.print('~c[100 175 175]{%s}\n', this.Fullpath);

% --- Properties

Prop = cell(1,2);

Prop{1,1} = '~c[gray]{Syntax}';
Prop{1,2} = this.Syntax;

% Toolbox
if isprop(this, 'Toolbox')
    Prop{end+1,1} = '~c[gray]{Toolbox}';
    Prop{end,2} = this.Toolbox;
end

% Package
if isprop(this, 'Package')
    Prop{end+1,1} = '~c[gray]{Package}';
    Prop{end,2} = ['<a href="matlab:ML.Search.path2obj(''' this.Package ''');">' this.Package '</a>\n'];
end

ML.Text.table(Prop, 'style', 'compact', 'border', 'none');