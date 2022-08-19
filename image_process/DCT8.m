function y = DCT8(inputArg1)
D = getDCTOperator(8);
y = D*(double(inputArg1)-128)*D';
end