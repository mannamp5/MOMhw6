% 16-741 Mechanics of Manipulation, Fall 2015
% Author: Sung Kyun Kim (kimsk@cs.cmu.edu)
%
% W: a set of normalized contact screws [[cix; ciy; ciz; c0ix; c0iy; c0iz] ...]; 6x(NM) matrix
% bFC: a flag which is true if the grasp is force closure; boolean
% zmax: the maximum value of the objective function at the optimal point; scalar

function [bFC, zmax] = isForceClosure(W)
bFC = 0;
zmax = 0;
N = size(W,2); % number of contact points
% write your code here
if (rank(W) < 6) 
    bFC = false;
    zmax = 0;
    disp('rank < 6');
else
    % find an internal point such as centroid
    P = zeros(3,1);
    for i=1:N
        P = P + W(1:3,i);
    end
    P = P/N; % internal point
% %     Q = W(1:3,N); % boundary point
% %     % distance PO and PQ and compare to see if inside polygon
% %     PO = sqrt(P(1)^2 + P(2)^2 + P(3)^2);
% %     PQ = sqrt((P(1)-Q(1))^2 + (P(2)-Q(2))^2 + (P(3)-Q(3))^2);
% %     if (PO >= PQ) 
% %         bFC = false;
% %         zmax = 0;
% %         disp('ray shooting failed');
% %         return;
% %     end
    Wc = [P; zeros(3,1)];
    % subtract centroid from all wrenches
    Wnew = W-repmat(Wc,1,N);
    % min -wc' y s.t. (w-wc)' y <= 1 
    % if min < 1 --> F.C.
    % else not F.C.
    [y, zmax] = linprog(-Wc, Wnew', ones(N,1));
    if ((-Wc'*y < 1))
        bFC = 1;
    else
        bFC = 0;
    end
end

end