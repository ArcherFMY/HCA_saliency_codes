function matrix = normalize_1(mat, flag)
% INPUT : 
%         mat
%         flag:  1 denotes that the mat is a cell;
%                0 denotes that the mat is a matrix;
% OUTPUT: 
%         matrix
%         
if flag ~= 0
    dim = length(mat);
    for i = 1:dim
       matrix{i} = ( mat{i} - min(min(mat{i})) +0.001) / ( max(max(mat{i})) - min(min( mat{i}))+0.002 );
    end
else
    matrix = ( mat - repmat(min(min(mat)),[size(mat,1), size(mat, 2)])+0.001 )./( repmat(max(max(mat)), [size(mat, 1), size(mat, 2)]) - repmat(min(min(mat)), [size(mat, 1), size(mat, 2)])+0.002 );
end
