function err = ErrFunc(gap,x)
e=x(1); m=x(2); b=x(3); c=x(4);
err = e * (tanh(m*(gap-b))+c);
end