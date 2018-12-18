
clc;
clear;
close all;
  
%% problem
CostFunction = @(x) Fault(x);       % CostFunction to be minimized

nVar = 4 ;                           % no of decesion variables

VarSize = [1 nVar];                  % matrix size of decesion variables

VarMin1 = 3;                        % lower bound of lower boundary 

VarMax1 = 10;                         % upper bound of lower boundary

VarMin2 = 1;                        % lower bound of upper boundary

VarMax2 = 3;                          %upper bound of upper boundary

VarMin3 = 0;                        % lower bound of density contrast  

VarMax3 = 1;                          %upper bound of density contrast

VarMin4 = 0;                        % lower bound of decesion variables 

VarMax4 = pi/2;                       %upper bound

%% pso parameters

MaxIt = 1000;    %max no of iteration 

nPop = 100;      %population size

w = 1;          % inertia coefficient 
wdamp =0.99;     % damping of inertia
c1 = 2;         % personal acceleration coefficient 

c2 = 2;         % social acceleration coefficient 

%% initialization

%%%%   particle template 
empty_particle.position = [];
empty_particle.velocity = [];
empty_particle.cost = [];
empty_particle.best.position = [];
empty_particle.best.cost = [];


%%%% create population array
particle = repmat(empty_particle, nPop, 1);


%initialize global best
globalbest.cost = 500;


%%%% initialization population member    


for i = 1:nPop 
    %%%% generate random solution 
   particle(i).position(1)  = unifrnd(VarMin1, VarMax1);
   particle(i).position(2)  = unifrnd(VarMin2, VarMax2);
   particle(i).position(3)  = unifrnd(VarMin3, VarMax3);
   particle(i).position(4)  = unifrnd(VarMin4, VarMax4);
   %%%initialize velocity
   particle(i).velocity = zeros(VarSize);
    
   %%% evalution 
    particle(i).cost = CostFunction(particle(i).position) ;
    
    % update the personal best 
    particle(i).best.position = particle(i).position ;
    particle(i).best.cost = particle(i).cost;
    
    %update global best 
    if  particle(i).best.cost < globalbest.cost
        
        globalbest = particle(i).best ;
        
    end 
    
    
end
%% main loop of pso

% array to hold best cost value on each iteration 
     BestCosts = zeros(MaxIt, 1);
    for it = 1:MaxIt 
        for i = 1:nPop 
            %update velocity 
            particle(i).velocity = w*particle(i).velocity  +c1*rand(VarSize).*(particle(i).best.position - particle(i).position) +c2*rand(VarSize).*(globalbest.position - particle(i).position);
           
           %update position
            particle(i).position = particle(i).position + particle(i).velocity;
            
            particle(i).cost = CostFunction(particle(i).position) ;
            
           % update the personal best 
             if particle(i).cost < particle(i).best.cost
             particle(i).best.position = particle(i).position ;
             particle(i).best.cost = particle(i).cost;
             end
           %update global best 
             if  particle(i).best.cost < globalbest.cost
        
             globalbest = particle(i).best ;
        
    end 
            w= w*wdamp ;
            
   end 
        
        % store best values 
        BestCosts(it) = globalbest.cost;
        
        %display iteration info 
        disp(['iteration ' num2str(it) ': BestCost ='  num2str( BestCosts(it))]);
        end
%% results
result = zeros (VarSize);
result = globalbest.position;
%plot (BestCosts , 'LineWidth' , 2);
semilogy(BestCosts , 'LineWidth' , 2);

xlabel ('iteration');
ylabel ('best cost');
grid on ;
