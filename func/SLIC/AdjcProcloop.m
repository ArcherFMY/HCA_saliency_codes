function adjcMerge8= AdjcProcloop(M)
% $Description:
%    -compute the adjacent matrix
% $Agruments
% Input;
%    -M: superpixel label matrix
% Output:
%    -adjcMerge: adjacent matrix

adjcMerge = full(regionadjacency(M)); 

adjcMerge8 = adjcMerge;

% bd=unique([M(1,:),M(m,:),M(:,1)',M(:,n)']);
% for i=1:length(bd)
%     for j=i+1:length(bd)
%         adjcMerge(bd(i),bd(j))=1;
%         adjcMerge(bd(j),bd(i))=1;
%     end
% end
    