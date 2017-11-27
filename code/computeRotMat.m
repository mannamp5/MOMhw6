% 16-741 Mechanics of Manipulation, Fall 2015
% Author: Sung Kyun Kim (kimsk@cs.cmu.edu)
%
% n: inward-pointing direction of a contact normal [nx; ny; nz]; 3x1 vector
% R: a rotation matrix with positive x-axis aligned with n; 3x3 matrix
%
% NOTE: As only one direction vector is specified, there is one redundant degree of freedom in the determination of R

function [R] = computeRotMat(n)

% write your code here
x = [1, 0, 0]';
y = [0, 1, 0]';
z = [0, 0, 1]';

a = x;
b = n;
I = eye(3);
% https://math.stackexchange.com/questions/180418/ ...
% calculate-rotation-matrix-to-align-vector-a-to-vector-b-in-3d?rq=1

A =  a*b';
[V,D] = eig(A'+A);
[~,idx] = min(diag(D));
v = V(:,idx);
R = I - 2*(v*v');