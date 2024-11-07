% calc UACI
function [UACI_value] = UACI( after_change,befor_change )
[row, col]=size(befor_change);
AB=[];
for i=1:row
    for j=1:col
AB(i,j)=abs(befor_change(i,j)-after_change(i,j));
    end
 end
    UACI_value = sum(AB(:))/(255*row*col)*100
end