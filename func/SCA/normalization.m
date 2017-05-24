function matrix = normalization(mat, flag)
% INPUT : 
%         flag:  1 denotes that the mat is a cell;
%                0 denotes that the mat is a matrix;
%         
if flag ~= 0
    dim = length(mat);
    for i = 1:dim
       matrix{i} = ( mat{i} - min(min(mat{i}))) / ( max(max(mat{i})) - min(min( mat{i})));
    end
else
    matrix = ( mat - repmat(min(min(mat)),[size(mat,1),size(mat,2)]))./...
        ( repmat(max(max(mat)),[size(mat,1),size(mat,2)])...
        - repmat(min(min(mat)),[size(mat,1),size(mat,2)]));
end