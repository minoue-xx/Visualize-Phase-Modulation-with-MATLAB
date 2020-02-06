# ���̃v���b�g�ǂ�����ĕ`�����́H�FPM�ϒ��̐}


Copyright 2020 Michio Inoue




![image_0.png](visualizePM_part1_images/image_0.png)




������i[Wikipedia:�ʑ��ϒ�](https://ja.wikipedia.org/wiki/%E4%BD%8D%E7%9B%B8%E5%A4%89%E8%AA%BF)�j�Ő}������Ă�����̂� MATLAB �ōČ����܂��I




4 ��Axes �I�u�W�F�N�g�̔z�u��F�t���AAnnotation �I�u�W�F�N�g�̔z�u�ȂǁE�E�����ȗv�f�����񂾂������K�ۑ�ł����̂ŁA�쐬�̉ߒ���Z�߂܂����B




�ǂ񂾂��ƁAMATLAB �̃O���t�B�b�N�X�I�u�W�F�N�g�ɑ΂���n�[�h���͂����Ɖ�����͂��B




[�O���t�B�b�N�X �I�u�W�F�N�g�̎�舵��](https://jp.mathworks.com/help/matlab/learn_matlab/understanding-handle-graphics-objects.html)


# �܂��͂����Ȋm�F����
## �����T�C���J�[�u


�Ƃ肠���� 2 �g�����A0 ���� 4<img src="https://latex.codecogs.com/gif.latex?\inline&space;\pi"/>�܂ŃT�C���g�������Ă݂܂��B


```matlab
N = 100;
t0 = linspace(0,4*pi,N);
y = sin(t0);
handle_line = plot(t0,y);
```

![figure_0.png](visualizePM_part1_images/figure_0.png)



���̔g�`���ʂ߂ʂߓ������ɂ́E�E���W���͌Œ肵����� `t` �������Â傫�����Ă݂܂��B




�܂��͍��W���� handle ���m�ۂ��č��W�����Œ�B


```matlab
handle_axes = gca;
handle_axes.XLim = [0,4*pi];
```


������ for ���[�v�� `y` �̒l��ς��Ă����܂��B


```matlab
dt = 4*pi/N;
for ii=1:N % 2�g�����`���܂��B
    t = t0 + dt*(ii-1);
    y = sin(t);
    handle_line.YData = y;
    drawnow
end
```

![figure_1.png](visualizePM_part1_images/figure_1.png)



�ł����Bx ���̒l���Œ�Ƃ����_���Ȃ�ƂȂ��C���������ł����A����ōs���܂��B


  
## Axes �I�u�W�F�N�g�̘g


�v���b�g�̘g�����������ɂ��Ă����܂��B [Axes �I�u�W�F�N�g�̃v���p�e�B](https://jp.mathworks.com/help/matlab/ref/matlab.graphics.axis.axes-properties.html) �ɉ�������̂��m�F���Ȃ���i�߂܂��B




�܂��͎����x���B����͊ȒP�A`XTick` �� `YTick` �v���p�e�B�[���������Ⴆ��OK�B���������������̂ŁA`LineWidth` ���G���Ă����܂��B


```matlab
handle_axes.XTick = [];
handle_axes.YTick = [];
handle_axes.LineWidth = 2;
```

![figure_2.png](visualizePM_part1_images/figure_2.png)



���������B




���Ƙg�̐F���ς������Ƃ��ɂ́E�E`XColor`�A`YColor` �v���p�e�B�ł����B�Ƃ肠�����Ԃɂ��Ă݂܂��B���Ȃ݂� `Color` �v���p�e�B�͔w�i�F�B���łɃT�C���h���Ԃ��E�������Ă����܂��B


```matlab
handle_axes.XColor = 'red';
handle_axes.YColor = 'red';
handle_line.Color = 'red';
handle_line.LineWidth = 2;
```

![figure_3.png](visualizePM_part1_images/figure_3.png)



����Ŋ�{�͊����B


# Axes �I�u�W�F�N�g�̔z�u


���āA4 �̍��W����z�u���܂��B




�O��i[���̃v���b�g�ǂ�����ĕ`�����́H�F�����v���b�g�A�A�j���[�V������](https://qiita.com/eigs/items/c6efb11c145e4e0e8577)�j�� `subplot` �֐����g���܂������A���傢�Ɣz�u�����G�����B���������Ƃ��� Axes �I�u�W�F�N�g�� `Position` �v���p�e�B�𒼐ڐݒ肵�Ă��܂��܂��傤�B�������� `subplot` �֐��͂��̍�Ƃ�������Ɗy�ɂ��Ă��邾���ł����B




![image_1.png](visualizePM_part1_images/image_1.png)




����� Figure ��̍\���ōs���܂��B




Axes �� `Position` �v���p�e�B�́A�����[�� Figure ��ł̈ʒu�ƁA���ƍ������w�肷�� 4 �v�f�Ő��藧���Ă��܂��̂ł���Ȋ����B


```matlab
handle_fig = figure;
handle_axesA = axes(handle_fig,'Position',[1,1,2,2]/13);
handle_axesB = axes(handle_fig,'Position',[4,1,8,2]/13);
handle_axesC = axes(handle_fig,'Position',[1,4,2,8]/13);
handle_axesD = axes(handle_fig,'Position',[4,7,8,2]/13); 
```

![figure_4.png](visualizePM_part1_images/figure_4.png)



����A�g�����ƍ��ɂ����Ȃ��B




����� `Box` �v���p�e�B�i'on' / 'off'�j�ł��B�S�� 'on' �ɂ��܂��傤�B


```matlab
handle_axesA.Box = 'on';
handle_axesB.Box = 'on';
handle_axesC.Box = 'on';
handle_axesD.Box = 'on';
```

![figure_5.png](visualizePM_part1_images/figure_5.png)



Figure ��� Axes �� 1 ���Ə���� 'on' �A2 �ȏゾ�� 'off' �ɂȂ�ݒ�Ȃ�ł��傤���ˁB


# �]�k�F�g���������@


��H���������΁A�g�������ɂ͂ǂ�����񂾂ƁH




���ׂ��Ƃ���AMATLAB Answers �ɂ���ȓ��e������܂����F[How do I remove the border lines surrounding an axes?](https://jp.mathworks.com/matlabcentral/answers/97101-how-do-i-remove-the-border-lines-surrounding-an-axes)




�v�͘g�̐F��w�i�F�A�������� 'none' �Ɛݒ肷���OK�Ƃ̂��ƁB


```matlab
handle_axesA.XColor = 'none';
handle_axesA.YColor = 'none';
```

![figure_6.png](visualizePM_part1_images/figure_6.png)



�����܂����E�E�E�B


# ��������܂Ƃ�


�����܂łŊm�F�ł������Ƃ��܂Ƃ߂�ƁE�E



   -  �����g�̕`�� 
   -  Axes �I�u�W�F�N�g�F�g�̐F�ݒ�A�����x���̏����� 
   -  4 �� Axes �I�u�W�F�N�g�ݒu�A�g�̏����� 



�Ƃ������ƂŁA�S���g�ݍ��킹�܂��B




�g�ݒ�͌J��Ԃ��������̂Ŋ֐������܂��B


```matlab
function handle_axes = setUpAxes(handle_fig, Position, color)
    handle_axes = axes(handle_fig,'Position',Position,'Box',"on");
    handle_axes.XColor = color;
    handle_axes.YColor = color;
    handle_axes.XTick = [];
    handle_axes.YTick = [];
    handle_axes.LineWidth = 2;
end
```
```matlab
addpath('.\function')
handle_fig = figure('Position',[100,100,400,400]);
handle_axesA = setUpAxes(handle_fig,[1,1,2,2]/13,'none');
handle_axesB = setUpAxes(handle_fig,[4,1,8,2]/13,'green');
handle_axesC = setUpAxes(handle_fig,[1,4,2,8]/13,'red');
handle_axesD = setUpAxes(handle_fig,[4,7,8,2]/13,'blue');
```


Axes C�i�ԁj�� Axes D�i�j�ɃT�C���g��ǉ����܂��B


```matlab
N = 100;
t0 = linspace(0,4*pi,N);
y = pi/2*sin(t0); % �U���� pi/2
handle_lineC = plot(handle_axesC,y,t0); % Axes C �͏c����
handle_lineD = plot(handle_axesD,t0,y);
handle_axesC.YLim = [0,4*pi]; % Axes C �͏c����
handle_axesD.XLim = [0,4*pi];
```

![figure_7.png](visualizePM_part1_images/figure_7.png)

  
## �����A���������̐ݒ���E�E


���� `plot` �֐����Ă��������Ƃ��날���ł���ˁB���O�ݒ�����Z�b�g�����Ⴄ�B�e�ؐS�Ȃ�ł��傤���B����Ȏ��ɂ͂����]���ɐ������� `line` �֐��ɂ��܂��傤�B




`line` �֐��ł��Ȃ����B�F�� Axes �Ɠ����ɁA�����Đ����������Ă����܂��B




�g������������Ă��� Axes A �ɂ�����ǉ����܂��B


```matlab
handle_fig = figure('Position',[100,100,400,400]);
handle_axesA = setUpAxes(handle_fig,[1,1,2,2]/13,'none');
handle_axesB = setUpAxes(handle_fig,[4,1,8,2]/13,'green');
handle_axesC = setUpAxes(handle_fig,[1,4,2,8]/13,'red');
handle_axesD = setUpAxes(handle_fig,[4,7,8,2]/13,'blue');

handle_axesA.XLim = [-pi/2,pi/2];
handle_axesA.YLim = [-pi/2,pi/2];
handle_axesB.XLim = [0,4*pi];
handle_axesB.YLim = [-pi/2,pi/2];
handle_axesC.XLim = [-pi/2,pi/2]; % Axes C �͏c����
handle_axesC.YLim = [0,4*pi]; % Axes C �͏c����
handle_axesD.XLim = [0,4*pi];
handle_axesD.YLim = [-pi/2,pi/2];

N = 100;
t0 = linspace(0,4*pi,N);
y = sin(t0);
handle_lineC = line(handle_axesC,y,t0,'Color','red','LineWidth',2); % Axes C �͏c����
handle_lineD = line(handle_axesD,t0,y,'Color','blue','LineWidth',2);
handle_lineA = line(handle_axesA, [-1,1],[1,-1],'Color','black','LineWidth',2);

dt = 4*pi/N;
for ii=1:N % 2�g�����`���܂��B
    t = t0 + dt*(ii-1);
    y = pi/2*sin(t);
    handle_lineC.XData = y; % Axes C �͏c����
    handle_lineD.YData = y;
    drawnow
end
```

![figure_8.png](visualizePM_part1_images/figure_8.png)

