function [e,enorm,h] = node_entropy(ci,u,v,n)
% node_entropy
%
%   [e,enorm,h] = node_entropy(ci,u,v,n)
%
%   Computes the entropy at each node, based on the overlapping community
%   structure, obtained by clustering the edges
%
%   Inputs:
%       ci,
%           vector of community affiliations, size: (edge)x1
%       u,v,
%           index vectors, obtained by running:
%               [u,v] = find(triu(ones(n),1))
%       n, 
%           number of nodes in original network
%
%   Outputs:
%       h,
%           number of edges in every community of each node

h = zeros(n,max(ci));
for i = 1:n 
    idx = u == i | v == i;
    h(i,:) = hist(ci(idx),1:max(ci));
end
p = bsxfun(@rdivide,h,sum(h,2));  %p:the proportion of edges of each node in each module
e = -nansum(p.*log2(p),2);
enorm = e/log2(max(ci));