close all;
clf; clear; clc; %清空工作区
%设计滤波器
% % 设计参数
% Fs = 1000;  % 采样频率
% Fpass = 200;  % 通过频率
% Fstop = 300;  % 停止频率
% Apass = 1;  % 通过带最大损失（dB）
% Astop = 60;  % 停止带最小衰减（dB）

% % 设计滤波器
% d = designfilt('lowpassfir', ...
%   'PassbandFrequency', Fpass, 'StopbandFrequency', Fstop, ...
%   'PassbandRipple', Apass, 'StopbandAttenuation', Astop, ...
%   'DesignMethod', 'kaiserwin', 'SampleRate', Fs);

% % 显示滤波器信息
% fvtool(d);

% %%汉明窗
% N = 64; % 窗口长度
% w = hamming(N); % 设计汉明窗

% % 绘制汉明窗的形状
% figure;
% plot(w);
% title('Hamming Window');
% xlabel('Sample');
% ylabel('Amplitude');

%%采用汉明窗设计低通FIR滤波器
file='..\audio_src\啦啦啦男无(1).wav';
%音频播放
[Y, FS] = audioread(file);
[m, n] = size(Y);
% 设计参数
Fpass = 500;  % 通过频率
N = m; %采样点数

% 计算归一化截止频率
Fnorm = Fpass / (FS/2);

% 设计滤波器
b = fir1(N, Fnorm, 'low', hamming(N+1));

% 显示滤波器信息
fvtool(b,1);

% 保存滤波器
save ./mat_src/filter_design.mat b;