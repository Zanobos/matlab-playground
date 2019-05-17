function [ h ] = my_legend( labels, FontSize)
%MY_LEGEND make a legend and set fluff things like interpreter and fontsize
%   my_legend( labels, FontSize)
h=legend(labels);
set(h,'Interpreter','Latex','Fontsize',FontSize);

end

