% 无重复循环 以观察gap及realv为输入 相当于每个时刻都是一次独立的仿真 不合适
function [AbsErr,AbsPErr,N_] = CFM_old (data, x)
[N,~] = size(data);
N_ = N-1;

row = repmat((1:N_)',2,1);
col = [(1:N_)';(2:N_+1)'];
val = [-1*ones(N_,1);ones(N_,1)];
CMAT = sparse(row,col,val,N_,N);%逐差系数矩阵

localx = data(:,1);
gap = data(:,2);
realv = data(:,3);
fid = data(:,4);
% reala = data(:,5);

% 单位转换
localx = localx * 1/6;
gap = gap * 1/6;
realv = realv * 1/6 * 10;
fid = fid /10;

a=x(1); v0=x(2); m=x(3); bf=x(4); bc=x(5);

Sima = a*(opv(gap,v0,m,bf,bc) - realv);
Sima_ = Sima(1:N_,:);

t = CMAT * fid;

realv_ = realv(1:N_,:);
SimDeltax_ = realv_.*t + 0.5*Sima_.*(t.^2);

RealDeltaX = CMAT * localx;

AbsErr = abs(SimDeltax_ - RealDeltaX);
AbsPErr = AbsErr ./ RealDeltaX;

end