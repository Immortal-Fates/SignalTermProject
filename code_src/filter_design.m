close all;
clf; clear; clc; %清空工作区

%%采用汉明窗设计低通FIR滤波器
file='..\audio_src\啦啦啦男无(1).wav';
%音频播放
[Y, FS] = audioread(file);
[m, n] = size(Y);
% 设计参数
Fpass = 1000;  % 通过频率
N = m; %采样点数

% 计算归一化截止频率
Fnorm = Fpass / (FS/2);

% 设计滤波器
b = fir1(N, Fnorm, 'low', hamming(N+1));

% 显示滤波器信息
fvtool(b,1);

% 保存滤波器
save ./mat_src/filter_design.mat b;