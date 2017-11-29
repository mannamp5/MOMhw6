% 16-741 Mechanics of Manipulation, Fall 2015
% Author: Sung Kyun Kim (kimsk@cs.cmu.edu)
%
% N: the number of contact points; scalar
% CP: a set of contact point positions [[pix; piy; piz] ...]; 3xN matrix
% CN: a set of inward-pointing directions of contact normals [[nix; niy; niz] ...]; 3xN matrix
% mu: the coefficient of (static) friction; scalar
% M: the number of side facets of a linearized polyhedral friction cone; scalar
% CPF: a set of contact point positions of edges of polyhedral friction cones [[pijx; pijy; pijz] ...]; 3x(NM) matrix
% CNF: a set of inward-pointing directions of edges of polyhedral friction cones [[sijx; sijy; sijz] ...]; 3x(NM) matrix
%
% Examples:
% i;							% index for i-th contact normal
% j;							% index for j-th edge of polyhedral friction cone of i-th contact normal
% CPi = CP(1:3, i);				% i-th contact point position
% CNi = CN(1:3, i);				% i-th contact normal direction
% CPFij = CPF(1:3, M*(i-1)+j);	% contact point position of j-th edge of polyhedral friction cone of i-th contact normal
% CNFij = CNF(1:3, M*(i-1)+j);	% contact normal direction of j-th edge of polyhedral friction cone of i-th contact normal

function [CPF, CNF] = frictionCone(CP, CN, mu, M)

% write your code here
N = size(CP,2);
R = zeros(3,3,N);
% R(:,:,1) = [-1 0 0; 0 0 1; 0 1 0];
% R(:,:,2) = [0 1 0; -1 0 0; 0 0 1];
% R(:,:,3) = [0 0 1; 0 1 0; -1 0 0];
% R(:,:,4) = [0 0 1; 1 0 0; 0 1 0]; 
d = zeros(3,M);
CNF = zeros(3,N*M);
CPF = zeros(3,N*M);
for i=1:N
    R(:,:,i) = computeRotMat(CN(:,i));
    for j=1:M
    d(:,j) = [ 1 mu*cos( (2*j*pi)/M ) mu*sin( (2*j*pi)/M )]' ;
    CNF(:, M*(i-1)+j) = R(:,:,i) * d(:,j);
    CPF(:, M*(i-1)+j) = CP(:,i);
    end
end



