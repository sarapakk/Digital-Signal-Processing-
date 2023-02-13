function y = reconst(x,t,Ts)

n=1:length(x);

  for i=1:length(t)
      h=sinc((t(i)-(n-1).*Ts)./Ts);
      y(i)=x*h.';
  end
  
end