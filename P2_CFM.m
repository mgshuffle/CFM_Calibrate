% 无重复循环 以观察gap为输入
function [AbsErr,AbsPErr,N_,AccErr] = P2_CFM(data,x_ov,x)
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
reala = data(:,5);

% 单位转换
localx = localx * 1/6;
gap = gap * 1/6;
realv = realv * 1/6 * 10;
fid = fid /10;
reala = reala *1/6 *10*10;

RealDisplacement = localx(2:end) - localx(1)*ones(N_,1);

a=x_ov(1); v0=x_ov(2); m=x_ov(3); bf=x_ov(4); bc=x_ov(5);

t = CMAT * fid;
gap_ = gap(1:end-1);
V_ = opv(gap_,v0,m,bf,bc);
E_ = ErrFunc(gap_,x);

AccErr=zeros(N_,1);
v = realv(1);
SimDisplacement = zeros(N_,1);
for i = 1:N_
   sima = a * (V_(i) - v) + E_(i);
   AccErr(i) = reala(i) -sima;
   SimDeltaX = v * t(i) + 0.5*t(i)^2*sima;
   SimDisplacement(i:N_) = SimDisplacement(i:N_) + SimDeltaX;
   
   v = v + t(i)*sima;
end
AbsErr = abs(SimDisplacement - RealDisplacement);
% AbsErr = SimDisplacement - RealDisplacement;
AbsPErr = AbsErr ./ RealDisplacement;

AccErr = AccErr(1:end-2);
end