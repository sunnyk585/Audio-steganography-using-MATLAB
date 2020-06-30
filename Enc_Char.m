function [CH1,CH2] = Enc_Char(CH1,CH2,text)
CH1=bitand(CH1,240);
CH2=bitand(CH2,240);
if bitand(text,128)== 128
    CH1 =bitor(CH1,8);
end
if bitand(text,64)== 64
    CH1 =bitor(CH1,4);
end
if bitand(text,32)== 32
    CH1 =bitor(CH1,2);
end
if bitand(text,16)== 16
    CH1 =bitor(CH1,1);
end
if bitand(text,8)== 8
    CH2 =bitor(CH2,8);
end
if bitand(text,4)== 4
    CH2 =bitor(CH2,4);
end
if bitand(text,2)== 2
    CH2 =bitor(CH2,2);
end
if bitand(text,1)== 1
    CH2 =bitor(CH2,1);
end
return