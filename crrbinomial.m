function c=crrbinomial(S0,K,r,sigma,T,n)
%Cox-Ross-Rubinstein Binomial Tree
%S0--spot price, K--strike price, r--interest rate, sigma--volitility,
%T--time to maturity, n--number of steps
%initialize trees and parameters
dt=T/n;
u=exp(sigma*sqrt(dt));
d=1/u;
p=(exp(r*dt)-d)/(u-d); %risk neutral probability
dpu=exp(-r*dt)*p;
dpd=exp(-r*dt)*(1-p);

%expectd stock prices at time T
for i=0:n
    for j=0:n
        S(i+1,j+1)=u^(j-i)*(d^i)*S0;
    end
end

%expect payoff  at time T (european call option)

for i = 0:n
    for j = 0:n    
            c(i+1,j+1)=max(S(i+1,j+1)-K,0);
    end
end

%discount back the payoffs

for j=n:-1:1
    for i=1:j
        c(i,j)=dpu*c(i,j+1)+dpd*c(i+1,j+1);
    end
end

%return option price
c=c(1,1);


end


