function valDistances = Dist(vals,edges,method)

if strcmp(method,'L2')
    valDistances = sqrt(sum((vals(edges(:,1),:)-vals(edges(:,2),:)).^2,2));
    valDistances = normalize(valDistances); %Normalize to [0,1]
    
elseif strcmp(method,'X2')
    valDistances = histDist(vals(edges(:,1),:),vals(edges(:,2),:));
    valDistances = normalize(valDistances); %Normalize to [0,1]
    
elseif strcmp(method,'L1')
    valDistances = sum(vals(edges(:,1),:)-vals(edges(:,2),:),2);
    valDistances = normalize(valDistances); %Normalize to [0,1]
end