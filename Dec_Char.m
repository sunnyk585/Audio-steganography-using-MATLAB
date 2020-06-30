function data = Dec_Char(CH1,CH2)

txt=0;

if bitand(CH1,8)== 8 
txt=bitor(txt,128);
end
if bitand(CH1,4)== 4 
txt=bitor(txt,64);
end
if bitand(CH1,2)== 2 
txt=bitor(txt,32);
end
if bitand(CH1,1)== 1 
txt=bitor(txt,16);
end

if bitand(CH2,8)== 8 
txt=bitor(txt,8);
end
if bitand(CH2,4)== 4 
txt=bitor(txt,4);
end
if bitand(CH2,2)== 2 
txt=bitor(txt,2);
end
if bitand(CH2,1)== 1 
txt=bitor(txt,1);
end

data=txt;
return
 