close all;
clf; clear; clc; %清空工作区

load ./mat_src/filter_design.mat
%TODO: 读取音频文件
% file = '..\audio_src\1-9男无(1).wav'; %读取文件
% file='..\audio_src\1-9女无杂音(1).wav';
file='..\audio_src\啦啦啦男无(1).wav';
% file='..\audio_src\啦啦啦女无(1).wav';
%音频播放
[Y, FS] = audioread(file);
[m, n] = size(Y);
% disp(m); %输出采样点数
% disp(n); %输出音频通道数
% disp(FS); %输出采样频率
% disp(m / FS); %输出素材音频时长

% sound(Y, FS); %播放对应Y和FS对应参数的音频
s1 = Y(:, 1);
s1_filter=filter(b,1,s1); %滤波
% sound(s1, FS); %只播放其中一个通道的音频

%%音频绘制
timeArray = (0:m - 1) / FS;
timeArray1 = timeArray * 1000; %放大到毫秒级
figure; plot(timeArray1, s1, 'k'); title('Amplitude Curve'); xlabel('Time(ms)'); ylabel('Amplitude');

%%绘制信号频率信息
s1_L = length(s1);
% %原始信号频率信息
% p = fft(s1); %计算傅里叶变换
%滤波后信号频率信息
p=fft(s1_filter);

nUniquePts = ceil((s1_L + 1) / 2);
p1 = p(1:nUniquePts); %选择前半部，因为后半部是前半部的一个镜像
p2 = abs(p1); %取绝对值，即幅度
p3 = p2 / s1_L; %使用点数按比例缩放，这样幅度和信号长度或者它自身的频率无关
p4 = p3 .^ 2; %平方得到功率

if rem(s1_L, 2) %奇数，nfft需要排除奈奎斯特点
    p4(2:end) = p4(2:end) * 2;
else
    p4(2:end - 1) = p4(2:end - 1) * 2;
end

sampFreq = FS;
freqArray = (0:nUniquePts - 1) * (sampFreq / n); %创建频率数组
figure; plot(freqArray / 1000000, 10 * log10(p4), 'k');
title('Power-Frequency Curve');
xlabel('Frequency(kHz)');
ylabel('Power(dB)');

% 计算频谱
p = abs(fft(s1_filter));

% 找到最大幅度的频率
[~, maxIndex] = max(p);

% 计算基频
f_base = (maxIndex - 1) * FS / length(s1_filter);

% 显示基频
disp(['The base frequency is: ', num2str(f_base), ' Hz']);

%%信号重构
% TODO:设置新基频
f_new_base = 180;

% 采用重采样方法
% 计算新的采样率
FS_new = round(FS * (f_new_base / f_base));

% 计算采样率的比例
[p, q] = rat(FS / FS_new);

% 使用新的采样率重采样
s1_resampled = resample(s1_filter, p, q);

% 设置变调比例
pitch_ratio = f_new_base / f_base; 

% 设置TSM比例
tsm_ratio = 1 / pitch_ratio; % 保持原速

% 使用TSM
s1_resampled = stretchAudio(s1_resampled, tsm_ratio);


% 播放重采样后的音频
sound(s1_resampled, FS_new);
% 将重采样后的音频保存到文件
audiowrite('..\audio_output\啦啦啦男resampled_audio.wav', s1_resampled, FS_new);

% %% 采用音高移位方法
% % 创建音高移位器
% shifter = audiopluginexample.PitchShifter;

% % 计算音高移位的比例
% shiftRatio = f_new_base / f_base;

% % 设置音高移位的比例
% shifter.PitchShift = shiftRatio;

% % 对音频进行音高移位
% s1_resampled = shifter(s1_filter);

% % 播放音高移位后的音频
% sound(s1_resampled, FS);

% % 将音高移位后的音频保存到文件
% audiowrite('..\audio_output\啦啦啦男shifted_audio.wav', s1_resampled, FS);


% 重构音频的频域波形
%%绘制信号频率信息
s1_L = length(s1_resampled);
% %原始信号频率信息
% p = fft(s1); %计算傅里叶变换
%滤波后信号频率信息
p=fft(s1_resampled);

nUniquePts = ceil((s1_L + 1) / 2);
p1 = p(1:nUniquePts); %选择前半部，因为后半部是前半部的一个镜像
p2 = abs(p1); %取绝对值，即幅度
p3 = p2 / s1_L; %使用点数按比例缩放，这样幅度和信号长度或者它自身的频率无关
p4 = p3 .^ 2; %平方得到功率

if rem(s1_L, 2) %奇数，nfft需要排除奈奎斯特点
    p4(2:end) = p4(2:end) * 2;
else
    p4(2:end - 1) = p4(2:end - 1) * 2;
end

sampFreq = FS;
freqArray = (0:nUniquePts - 1) * (sampFreq / n); %创建频率数组
figure; plot(freqArray / 1000000, 10 * log10(p4), 'k');
title('Power-Frequency Curve');
xlabel('Frequency(kHz)');
ylabel('Power(dB)');
% 计算频谱
p = abs(fft(s1_resampled));

% 找到最大幅度的频率
[~, maxIndex] = max(p);

% 计算基频
f_base = (maxIndex - 1) * FS / length(s1_resampled);

% 显示基频
disp(['The base frequency is: ', num2str(f_base), ' Hz']);


% 重构音频的时域波形
file_refactor='..\audio_output\啦啦啦男resampled_audio.wav';
%音频播放
[Y, FS] = audioread(file_refactor);
[m, n] = size(Y);
s1 = Y(:, 1);
s1_filter=filter(b,1,s1); %滤波

%%音频绘制
timeArray = (0:m - 1) / FS;
timeArray1 = timeArray * 1000; %放大到毫秒级
figure; plot(timeArray1, s1, 'k'); title('Amplitude Curve'); xlabel('Time(ms)'); ylabel('Amplitude');
