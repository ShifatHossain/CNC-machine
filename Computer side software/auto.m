x = xs;
y = ys;

sr=ser;

fprintf(sr,'a');
fprintf(sr,'b');
fprintf(sr,'w');

if xs<0
    fprintf(sr,'7');
    fprintf(sr,[int2str(abs(xs)) 't']);
elseif xs>0
    fprintf(sr,'8');
    fprintf(sr,[int2str(abs(xs)) 't']);
else
    fprintf(sr,'b');
end


if ys<0
    fprintf(sr,'5');
    fprintf(sr,[int2str(abs(ys)) 't']);
elseif ys>0
    fprintf(sr,'6');
    fprintf(sr,[int2str(abs(ys)) 't']);
else
    fprintf(sr,'a');
    
while 1
    if fscanf(sr) == 'y'
        break
    end
end 