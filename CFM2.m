function [AbsErr,AbsPErr,SampleCount] = CFM2 (data, x)
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

t = CMAT * fid;
localx_ = localx - localx(1)*ones(N,1);
PVehLocalX = localx_ + gap;

RealDisplacement = localx_(2:end);

a=x(1); v0=x(2); m=x(3); bf=x(4); bc=x(5);

SampleCount = sum(1:N_);
AbsErr = zeros(SampleCount,1);
RealDisplacement_ = zeros(SampleCount,1);
flag = 0;

gap = gap(1:N_);
v = realv(1:N_);
SimSeedDisplacement = RealDisplacement;
for i = 1:N_    
    Sima = a*(opv(gap,v0,m,bf,bc) - v);
    
    t_ = t(i:N_);
    SimDeltaX = v.*t_ + 0.5*Sima.*(t_.^2);
    SimSeedDisplacement(1:N-i) = SimSeedDisplacement(1:N-i) + SimDeltaX;
    v = Sima .* t_;
    
    RealDisplacement_(flag+1:flag+N_-i+1) = RealDisplacement(i:N_);
    AbsErr(flag+1:flag+N_-i+1) = abs(RealDisplacement_(flag+1:flag+N_-i+1) - SimSeedDisplacement(1:N_-i+1));
    flag = flag + N_ - i + 1;
    
    gap = PVehLocalX(i+1:N_) - SimSeedDisplacement(1:N_-(i+1)+1);
    v = v(1:end-1);
end

AbsPErr = AbsErr ./ RealDisplacement_;

% %test
% figure
% hold on
% plot(RealDisplacement_)
% plot(SimDisplacement_)
end