% 16-741 Mechanics of Manipulation, Fall 2015
% Author: Sung Kyun Kim (kimsk@cs.cmu.edu)
%
% n: inward-pointing direction of a contact normal [nx; ny; nz]; 3x1 vector
% R: a rotation matrix with positive x-axis aligned with n; 3x3 matrix
%
% NOTE: As only one direction vector is specified, there is one redundant degree of freedom in the determination of R

function [R] = computeRotMat(n)

% write your code here
X = [1, 0, 0]';
Y = [0, 1, 0]';
Z = [0, 0, 1]';
N = n;
% %n = n / norm(n);
% 
% x = n(1);
% y = n(2); 
% z = n(3);
% 
% xyLength = sqrt(x * x + y * y);
% zAngle = acos(y / xyLength);
% vecLength = sqrt(x * x + y * y + z * z);
% xAngle = acos(xyLength / vecLength);
%  
% Rx = @(th) [1 0 0; ...
%             0 cos(th) -sin(th); ...
%             0 sin(th) cos(th)]; 
%         
% Ry = @(th) [cos(th) 0 sin(th); ... 
%             0 1 0; ...
%             -sin(th) 0 cos(th)]; 
%         
% Rz = @(th) [cos(th) -sin(th) 0; ...
%             sin(th) cos(th) 0; ...
%             0 0 1]; 
% 
% R = Rz(zAngle)*Rx(xAngle);
u = [1, 0, 0]';

v = n / norm(n);
w=cross(u,v);

cos_tht=u'*v/norm(u)/norm(v);
tht=acos(cos_tht);

if norm(w) == 0 
    if norm(pi - tht) <0.1
        R = [-1,0,0;0,0,1;0,-1,0];
    else
        R=eye(size(u,1));
    end
else
    w=w/norm(w);
    w_hat=fcn_GetSkew(w);
    R=eye(size(u,1))+w_hat*sin(tht)+w_hat^2*(1-cos(tht));
end

end

function x_skew=fcn_GetSkew(x)
x_skew=[0 -x(3) x(2);
 x(3) 0 -x(1);
 -x(2) x(1) 0];
end

