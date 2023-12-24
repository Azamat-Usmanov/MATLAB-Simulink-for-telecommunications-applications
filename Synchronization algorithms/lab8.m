
A = imread('redSquare.png');
% r = imbinarize(A);
% g = double(r(:)');
s = size(A);
B = dec2bin(A(:),8)';
g = B(:)'-'0';
