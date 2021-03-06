%% export_obama_actions

% clear all;
load obama_actions.mat
num_blank = 0;

N = length({a.date_string});

%%
for jj = 1:N
  dv = datevec(a(jj).date_string,'mmmm dd, yyyy');
  relpath = fullfile(...
    sprintf('%04d',dv(1)),...
    sprintf('%02d',dv(2)),...
    sprintf('%02d',dv(3)));
  mkdir(relpath)
  
  %   str_title = regexprep(a(jj).title,' ','-');
  %   % str_sub_type = regexprep(a(jj).sub_type,' ','-');
  %   str_type = regexprep(a(jj).type,' ','-');
  %
  %   %fname = sprintf('%s_%s_%s',str_type,str_sub_type,str_title);
  %   fname = sprintf('%s_%s',str_type,str_title);
  
  
  uri = a(jj).uri;
  tmp = strsplit(uri,'/');
  fname = tmp{end};
  fname = regexprep(fname,',','');
  fname = regexprep(fname,'\.','');
  fname = regexprep(fname,'(','');
  fname = regexprep(fname,')','');
  txt = a(jj).plaintext;
  fullfilepath = fullfile(relpath,sprintf('%s.txt',fname));
  
  fid = fopen(fullfilepath,'w');
  if ~isempty(txt), fprintf(fid,txt); else
    num_blank = num_blank+1;
    fprintf(fid,'Does not exist.\n');
  end
  fclose(fid);
  ffp{jj,1} = fullfilepath;
end

head = {'type','subtype','uri','date','title','fullfilepath'};
out = [{a.type}',{a.sub_type}',{a.uri}',{a.date_string}',{a.title}',ffp];

xlswrite('obama_actions_meta.xls',[head;out]);

