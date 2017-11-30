% 16-741 Mechanics of Manipulation, Fall 2015
% Author: Sung Kyun Kim (kimsk@cs.cmu.edu)
%
% Execution script to test your code for Part 2
%
% FRIC: a flag which is false (or 0) for frictionless contact and true (or 1) for frictional contact; boolean

function part2(FRIC)

% check input arguments
if nargin ~= 1
    FRIC = false;
end


%% Create and draw a soccer ball

% make a class instance
ball = SoccerBall;

% draw an icosahedron
figure;
ball.drawBall;

% % get a single contact normal; but you probably need more
%iv = 20;
%ratio = ones(3,1)./3
%[cp, cn] = ball.getContactNormal(iv, ratio)


%% Find a force closure grasp
switch (FRIC)    % flag for contact condition
    
    case 0        % frictionless contact
        
        % write your code here
        % write your code here
        % write your code here
        N = 8
        bFC = 0
        while bFC == 0
            CP = [];
            CN = [];
            for num = 1:N
                iv = randi(20);%ivs(num);
                ratio = normc(randi(2,3,1)).^2;
                [cp, cn] = ball.getContactNormal(iv, ratio);
                CP = [CP,cp];
                CN = [CN,cn];
            end
            [W] = contactScrew(CP, CN);
            try
                [bFC, zmax] = isForceClosure(W);
            catch
                bFC = 0
            end

        end


        % draw contact screws
        drawContactScrew(CP, W);
        
        % print out results
        N
        CP
        W
        zmax
        
    case 1        % frictional contact
        
        % friction coefficient
        mu = 0.3;
        
        % the number of side facets of a linearized polyhedral friction cone
        M = 10;

        % write your code here
        % write your code here
        % write your code here

                N = 2
        bFC = 0
        while bFC == 0
            CPF = [];
            CN = [];
            for num = 1:N
                iv = randi(20);%ivs(num);
                ratio = normc(randi(2,3,1)).^2;
                [cp, cn] = ball.getContactNormal(iv, ratio);
                [cpf, cnf] = frictionCone(cp, cn, mu, M);
                CPF = [CPF cpf];
                CN = [CN,cnf];
            end
            [WF] = contactScrew(CPF, CN);
            try
                [bFC, zmax] = isForceClosure(WF);
            catch
                bFC = 0
            end

        end

        
        % draw contact screws
        drawContactScrew(CPF, WF, M);
        
        % print out results
        N
        CP
        zmaxF
        
end