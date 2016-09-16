function V = opv(gap,v0,m,bf,bc)
V = v0 * (tanh(m*(gap-bf)) - tanh(m*(bc-bf)));
end