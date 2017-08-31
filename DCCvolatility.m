    function  mvP  = DCCvolatility(my_star, Qbar, a, b)
% input: mystar, devolatilised series and parameter values
[n N] = size(my_star); % dimensions
Q = zeros(N,N);
mvH = [];
mvP = []; % store time varying correlations
for i = 1:n
    if i ==1
        Q =  Qbar;
    else            
        Q = (1 - a - b) * Qbar + a * ( my_star(i-1,:)' * my_star(i-1,:) ) + b * Q ;
    end
    Qnsqrt = diag(1 ./ sqrt(diag(Q)));
    P = Qnsqrt * Q * Qnsqrt;
    mvP = [mvP;  vech(P)'];
end
end
 

