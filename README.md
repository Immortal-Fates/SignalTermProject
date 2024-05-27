# Main Takeaway

我们小组决定完成变声器的实现。



# Intro

![image-20240527094302060](markdown-img/README.assets/image-20240527094302060.png)

人声的两大特点来自于基频和共振峰

- 基频即为发出浊音时声带自然振动的频率
- 共振峰则是之声门波在声道里发生共鸣的频率。共振峰的主要影响因素是声道的长度：声道越长共振峰的频率越高，反之亦然。



# 变声器原理

计算机中的数字音频的存储方式被称之为 `PCM`（脉冲编码调制），声音的高低变换被转化为一系列高低电平的二进制编码。在此过程中有三个主要反映其特征的参数：采样率、通道数和位深：

- 采样率：即每秒采样的次数，单位为 Hz

- 通道数：也就是音轨数。由于自然界许多声音的混叠将会导致计算处理的困难，而如果又要重现出富有层次感的丰富声音效果，我们就需要使用到更多的通道（音轨）
- 位深：直观反映了声音的振幅范围。利用计算机常见的补码编码一个幅度的分度范围从而显示对不同振幅的模拟。

 `wav`文件的流就是 `PCM`编码，因此也被称为原始音频文件。其他类型的编码，都是对此进行了有损或是无损的压缩，降低了存储量的消耗

| 人群 | 基频分布（Hz) | 共振峰频率分布 |
| ---- | ------------- | -------------- |
| 男声 | [50,180]      | 偏低           |
| 女生 | [160,380]     | 中             |
| 童声 | [400,1000]    | 偏高           |

# References

- [变声导论-变声器原理及实现(核心算法实现篇)](https://zhuanlan.zhihu.com/p/110278983)
- [人声变声器的原理_变声软件 原理](https://blog.csdn.net/zhuoqingjoking97298/article/details/125581253)

