function c=TRGBin(S0,K,r,sigma,T,n)
%S0--spot price, K--strike price, r--interest rate, sigma--volitility,
%T--time to maturity, n--number of steps
%initialize trees and parameters
dt=T/n;
v=r-0.5*sigma^2;
dx=sqrt((sigma^2)*dt+(v^2)*dt^2);
u=exp(dx);
d=exp(-dx);
    
pu=0.5*(1+v*dt/dx);
pd=0.5*(1-v*dt/dx);
dpu=exp(-r*dt)*pu;
dpd=exp(-r*dt)*(pd);

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


