function [ h ] = my_xlabel(label, fontSize)
%MY_XLABEL x_label with Latex and Font
%   my_xlabel(label, fontSize)
h = xlabel(label,'Interpreter','Latex','Fontsize',fontSize);

end