function [Superpixel, Graph] = build_graph(Superpixel)

    fprintf('                Building the graph model...\n');
    tstart = tic;
    
    supNum = max(Superpixel.sulabel(:));
    Superpixel.supNum = supNum;
    bdIds = GetBndPatchIds(Superpixel.sulabel);
    
    impfactor = Superpixel.impfactor8;
    for i=1:length(bdIds)
        for j=i+1:length(bdIds)
        impfactor(bdIds(i),bdIds(j))=1;
        impfactor(bdIds(j),bdIds(i))=1;
        end
    end
    edges=[];
    for i=1:Superpixel.supNum
        indext=[];
        ind=find(impfactor(i,:)==1);
        for j=1:length(ind)
            indj=find(impfactor(ind(j),:)==1);
            indext=[indext,indj];
        end
        indext=[indext,ind];
        indext=indext((indext>i));    
        indext=unique(indext);
        if(~isempty(indext))
            ed=ones(length(indext),2);
            ed(:,2)=i*ed(:,2);
            ed(:,1)=indext;
            edges=[edges;ed];
        end
    end
    Graph.edges = edges;
    Graph.bdIds = bdIds;
    telapsed = toc(tstart);
    fprintf('                      Done! Use %f seconds.\n', telapsed);