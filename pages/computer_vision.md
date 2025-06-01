## 计算机视觉 Computer Vision

### 知识图谱 Knowledge graph of the class

[课程知识图谱/Link to the KG](https://yeshan-geo.github.io/kg/cv/viz.html)

### 课件 Slides

|节次/Lec|主要内容/Content||
|---|---|---|
|1. 概述 (intro)|课程概况、行业概况、学科关系、哲学基础、发展历史 (overview, related disciplines, fundamentals, history)|[pdf](https://yeshan-geo.github.io/documents/cv/2024/L1-Introduction.pdf)|
|2. 硬件 (hardware)|机器视觉系统的构成、光源、镜头、相机、感光器件 (light source, lens, camera, photosensitive device, etc.)|[pdf](https://yeshan-geo.github.io/documents/cv/2024/L2-Sensors.pdf)|
|3. 图像增强1 (image preprocess 1)|图像的构成及常见格式、色彩空间、锐化和降噪、滤波器 (data structure of images, color space, noise reduction, filtering, etc.)|[pdf](https://yeshan-geo.github.io/documents/cv/2024/L3-Filtering_and_edge_detection1.pdf)|
|4. 图像增强2 (image preprocess 2)|卷积和滤波、边缘检测、图像金字塔、FFT及频域操作 (convolution and filtering, edge detection, image pyramid, Fourier transform, frequency domain operations, etc.)|[pdf](https://yeshan-geo.github.io/documents/cv/2024/L4-Filtering_and_edge_detection2.pdf)|
|5. 图像分类任务1 (image classification 1)|使用场景、任务类别、难点和挑战 (classification tasks, challenges, etc.)|[pdf](https://yeshan-geo.github.io/documents/cv/2024/L5-Image_classification1.pdf)|
|6. 图像分类任务2 (image classification 2)|图像的向量表示、图像的特征表示、机器学习流程 (vector representation of images, features of images, review on machine learning basics)|[pdf](https://yeshan-geo.github.io/documents/cv/2024/L6-Image_classification2.pdf)|
|7. 线性分类器1 (linear classifier 1)|线性代数表达、决策边界、合叶损失 (linear algebra basics review, decision boundary, Hinge loss, etc.)|[pdf](https://yeshan-geo.github.io/documents/cv/2024/L7-Linear_classifier1.pdf)|
|8. 线性分类器2 (linear classifier 1)|超参数、正则项、梯度计算 (hyperparameters, regularization, gradient, etc.)|[pdf](https://yeshan-geo.github.io/documents/cv/2024/L8-Linear_classifier2.pdf)|
|9. 模型的训练 (training a model)|随机梯度下降、小批量梯度下降、交叉验证 (stochastic gradient descent, mini-batch gradient descent, cross validation, etc.)|[pdf](https://yeshan-geo.github.io/documents/cv/2024/L9-Linear_classifier3.pdf)|
|10. 全连接神经网络1 (fully-connected neural networks 1)|网络结构、激活函数、交叉熵损失和KL散度、信号传播、梯度回传 (ANN structure, activation function, cross entropy loss and KL divergence, signal propagation, backpropagation, etc.)|[pdf](https://yeshan-geo.github.io/documents/cv/2024/L10-FC_networks1.pdf)|
|11. 全连接神经网络2 (fully-connected neural networks 1)|梯度消失和梯度爆炸、动量法、自适应梯度、自适应矩估计、权值初始化、批归一化、随机失活、调参 (gradient disappearance and gradient explosion, momentum method, AdaGrad, Adam, weight initialization, batch normalization, dropout, parameter tuning, etc.)|[pdf](https://yeshan-geo.github.io/documents/cv/2024/L11-FC_networks2.pdf)|
|12. 卷积神经网络1 (convolutional neural network 1)|CNN总体架构、纹理基元、卷积核组 (CNN architecture, image texture, convolution kernel group)|[pdf](https://yeshan-geo.github.io/documents/cv/2024/L12-CNN1.pdf)|
|13. 卷积神经网络2 (convolutional neural network 2)|卷积层的堆叠、池化层 (stacking of convolutional layers, pooling)|[pdf](https://yeshan-geo.github.io/documents/cv/2024/L13-CNN2.pdf)|
|14. 经典构架1 (classic CNNs 1)|LeNet, AlexNet|[pdf](https://yeshan-geo.github.io/documents/cv/2024/L14-CNN_architecture1.pdf)|
|15. 经典构架2 (classic CNNs 2)|ZF Net, VGG, GoogLeNet, ResNet|[pdf](https://yeshan-geo.github.io/documents/cv/2024/L15-CNN_architecture2.pdf)|
|16. 前沿进展 (recent advances)|vision transformer, diffusion models, GANs|[pdf](https://yeshan-geo.github.io/documents/cv/2024/L16-Latest.pdf)|

每个节次90分钟 (90 mins per lecture)

### Lab 课作业

|节次/Lec|主要内容/Contents||
|---|---|---|
|Lab 1|环境配置、Python练习、图像的基本操作 (working environment configuration, Python basics, basic image operations)|[pdf](https://yeshan-geo.github.io/documents/cv/2024/Lab1.pdf)|
|Lab 2|卷积和滤波、OpenCV的基本操作 (convolution, filtering, basics of OpenCV)|[pdf](https://yeshan-geo.github.io/documents/cv/2024/Lab2.pdf)|
|Lab 3|图像金字塔 (image pyramid)|[pdf](https://yeshan-geo.github.io/documents/cv/2024/Lab3.pdf)|
|Lab 4|傅里叶转换和频率域操作 (Fourier transforms and frequency domain operations)|[pdf](https://yeshan-geo.github.io/documents/cv/2024/Lab4.pdf)|
|Lab 5|线性分类器的实现 (coding up a linear classifier)|[pdf](https://yeshan-geo.github.io/documents/cv/2024/Lab5.pdf)|
|Lab 6|计算图的OOP实现、梯度计算 (object-oriented programming for a computation graph, gradient calculation)|[pdf](https://yeshan-geo.github.io/documents/cv/2024/Lab6.pdf)|
|Lab 7|ResNet和迁移学习 (coding up a ResNet, transfer learning)|[pdf](https://yeshan-geo.github.io/documents/cv/2024/Lab7.pdf)|
|Lab 8|风格迁移 (style transfering)|[pdf](https://yeshan-geo.github.io/documents/cv/2024/Lab8.pdf)|

### 说明 Notes
本课程部分内容参考了以下课程 (This course is partially derived from the following classes)：
- 斯坦福大学 Stanford University [CS231n](https://cs231n.stanford.edu/)
- 密歇根大学 University of Michigan [EECS442](https://web.eecs.umich.edu/~fouhey/teaching/EECS442_W23/index.html) & [EECS498](https://web.eecs.umich.edu/~justincj/teaching/eecs498/FA2020/)
- 威斯康辛大学麦迪逊分校 University of Wisconsin-Madison [CS766](https://pages.cs.wisc.edu/~mohitg/courses/CS766/)
