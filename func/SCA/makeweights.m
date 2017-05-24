function weights=makeweights(edges,vals1,vals2,valScale,alpha)

valDistances1 = Dist(vals1,edges,'L2');
valDistances2 = Dist(vals2,edges,'L2');
%%
valDistances = alpha(1)*valDistances1 + alpha(2)*valDistances2;
valDistances = normalize(valDistances);
weights=exp(-valScale*valDistances);