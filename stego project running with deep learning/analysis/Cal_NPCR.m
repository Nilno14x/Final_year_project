% calc NPCR
function [ NPCR ] = Cal_NPCR( imge,enc)
[rows,columns]=size(imge);
step=0;
for i=1:rows
    for j=1:columns
        if imge(i,j)~= enc(i,j)
           step=step+1;
        else 
             step=step+0;
        end
    end
end
NPCR =(step/(rows*columns))*100;
end


