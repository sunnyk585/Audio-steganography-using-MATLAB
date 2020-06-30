function [MSE,PSNR]=psnr(Y,Z)
input=Y; %storing value of Y in input
Embedded=Z; % storing value of Z in Embedded
[r c p]=size(Embedded); % store size of embedded in r,c and p
% storing the value in double precision format
input=double(input); 
Embedded=double(Embedded);
% calculating Mean Square Error(MSE)
MSE =sum(sum((input-Embedded).^2))/(r*c);
disp(MSE);
% calculating power signal noise ratio
PSNR = 10*log10(1*1/MSE);  % if the input is double-precision floating-point data type, then R is 1.
disp(PSNR);
return