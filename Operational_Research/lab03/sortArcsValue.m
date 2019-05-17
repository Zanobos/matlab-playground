%% sortArcsValue
% arcsSorted = sortArcsValue(arcs);

function arcsSorted = sortArcsValue(arcs);

arcsFields = fieldnames(arcs);
arcsCell = struct2cell(arcs);
sz = size(arcsCell);

arcsCell = reshape(arcsCell, sz(1), []);
arcsCell = arcsCell';
arcsCell = sortrows(arcsCell, 3);
arcsCell = flip(arcsCell); % decreasing order
arcsCell = reshape(arcsCell', sz);
arcsSorted = cell2struct(arcsCell, arcsFields, 1);

% for id = 1:length(arcsSorted)
%     fprintf('%d\n',id)
%     disp(arcsSorted(id))
% end
