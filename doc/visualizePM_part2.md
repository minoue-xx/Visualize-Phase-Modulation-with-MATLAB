# ���̃v���b�g�ǂ�����ĕ`�����́H�FPM�ϒ��̐}


Copyright 2020 Michio Inoue




![image_0.png](visualizePM_part2_images/image_0.png)




������i[Wikipedia:�ʑ��ϒ�](https://ja.wikipedia.org/wiki/%E4%BD%8D%E7%9B%B8%E5%A4%89%E8%AA%BF)�j�Ő}������Ă�����̂� MATLAB �ōČ����悤�������݁B�O��͂����܂łł��܂����B




���Ƃ́H



   -  �e�v���b�g�œ����Ă���_ 
   -  ���ꂼ������Ԑ� 



�ł��ˁB����Ă����܂��傤�B


# Axes �Ԃ��܂�����


����� `annotation` �֐��ŕ`���܂��B




����������̋L���i[MATLAB�̃v���b�g�ŃA�m�e�[�V����������](https://qiita.com/Monzo_N/items/c68f52e88fd532671a19)�j�ł��G��Ă���悤�ɁAannotation �I�u�W�F�N�g�� Figure ���ł̈ʒu���w�肷��K�v������܂��B���Ԃׂ������_�� Axes ��Œ�`�����f�[�^�l�Ȃ̂ŁA���̕ϊ�����Ԃł����������܂���B




�����͊֐�������ď��z���܂��傤�B


```matlab
function [xFig,yFig] = axesPosition2figurePosition(data,handle_axes)

    x = data(1);
    y = data(2);
    handle_axes.Units = 'normalize';
    axesPos = handle_axes.Position;
    %  axesPos(1): x position of axes in figure
    %  axesPos(2): y position of axes in figure
    %  axesPos(3): width of axes in figure scale
    %  axesPos(4): height of axes in figure scale
    widthData = handle_axes.XLim(2)-handle_axes.XLim(1);
    heightData = handle_axes.YLim(2)-handle_axes.YLim(1);
    xmin = handle_axes.XLim(1);
    ymin = handle_axes.YLim(1);

    xFig = (x-xmin)/widthData*axesPos(3) + axesPos(1);
    yFig = (y-ymin)/heightData*axesPos(4) + axesPos(2);

end
```


���͂� Axes ��̃f�[�^�l�� Axes �I�u�W�F�N�g�BAxes �I�u�W�F�N�g�̕\���͈́i`XLim`, `YLim`�j�� Figure ��ł̈ʒu�i`Position`�j�̏������ƂɁA�f�[�^�l�� Figure ��ł̑��Έʒu (x,y) �ɕϊ����܂��B




�Ⴆ��


```matlab
[xAfig,yAfig] = axesPosition2figurePosition([xA,yA],handle_axesA);
```


����Ȋ����B




���ۂɎg���Ă݂܂��B


```matlab
addpath("function");
handle_axes1 = subplot(2,1,1);
plot(rand(10,1));
handle_axes2 = subplot(2,1,2);
plot(rand(10,1));
```

![figure_0.png](visualizePM_part2_images/figure_0.png)



�����ď�̃O���t�� (x,y) = (2,0.5) ���� ���̃O���t�� (x,y) = (8,0.5) �܂Ő��������Ă݂܂��B


```matlab
[xFig1,yFig1] = axesPosition2figurePosition([2,0.5],handle_axes1);
[xFig2,yFig2] = axesPosition2figurePosition([8,0.5],handle_axes2);
annotation("arrow",[xFig1,xFig2],[yFig1,yFig2])
```

![figure_1.png](visualizePM_part2_images/figure_1.png)



����ȋ�ł��B


# �e�v���b�g�œ����Ă���_


���ꂼ��̃v���b�g�œ����Ă���_��`���āA��̕��@�łȂ��ł݂܂��B




���ł� Axes B �łǂ�ǂ�L�тĂ�����������Ă����܂��B


```matlab
clear
close all
% Figure �̏�� Axes �쐬
handle_fig = figure('Position',[100,100,400,400],'Color','w');
handle_axesA = setUpAxes(handle_fig,[1,1,2,2]/13,'none');
handle_axesB = setUpAxes(handle_fig,[4,1,8,2]/13,'green');
handle_axesC = setUpAxes(handle_fig,[1,4,2,8]/13,'red');
handle_axesD = setUpAxes(handle_fig,[4,7,8,2]/13,'blue');

% ���ꂼ��� Axes �\���͈͂��Œ�
handle_axesA.XLim = [-pi/2,pi/2];
handle_axesA.YLim = [-pi/2,pi/2];
handle_axesB.XLim = [0,4*pi];
handle_axesB.YLim = [-pi/2,pi/2];
handle_axesC.XLim = [-pi/2,pi/2]; % Axes C �͏c����
handle_axesC.YLim = [0,4*pi]; % Axes C �͏c����
handle_axesD.XLim = [0,4*pi];
handle_axesD.YLim = [-pi/2,pi/2];

% Axes A �� y = -x �̐���`��
handle_lineA = line(handle_axesA, [-pi/2,pi/2],[pi/2,-pi/2],'Color','black','LineWidth',2);

% Axes C, Axes D �̃T�C���J�[�u
N = 100;
t0 = linspace(0,4*pi,N);
y = pi/2*sin(t0);
handle_lineC = line(handle_axesC,y,t0,'Color','red','LineWidth',2); % Axes C �͏c����
handle_lineD = line(handle_axesD,t0,y,'Color','blue','LineWidth',2);

% �����_���W��`��
tC = 2*pi+y(1); % y position in C axes
xC = pi/2*sin(tC); % x position in C axes
handle_pointA = line(handle_axesA,xC,-xC,'Marker','o','MarkerFaceColor','black');
handle_pointB = line(handle_axesB,0,-xC,'Marker','o','MarkerFaceColor','green');
handle_pointC = line(handle_axesC,xC,tC,'Marker','o','MarkerFaceColor','red');
handle_pointD = line(handle_axesD,0,y(1),'Marker','o','MarkerFaceColor','blue');

% Axes B �ɐV���Ȑ���ǉ��i���Ԍo�߂ƂƂ��ɐL�т܂��j
handle_lineB = line(handle_axesB,0,-xC,'Color','green','LineWidth',2);

% ���\��
handle_axesB.Title.Interpreter = 'latex';
handle_axesB.Title.FontSize = 15;
handle_axesB.Title.String = "$$\frac{\pi}{2}\sin\left(" + ...
    "t + \frac{\pi}{2} \sin \left( t \right) \right)$$";

% �����_�����Ԑ���`���܂��B
% Figure ���W�n�ɕϊ�
[xAfig,yAfig] = axesPosition2figurePosition([xC,-xC],handle_axesA);
[xBfig,yBfig] = axesPosition2figurePosition([0,-xC],handle_axesB);
[xCfig,yCfig] = axesPosition2figurePosition([xC,tC],handle_axesC);
[xDfig,yDfig] = axesPosition2figurePosition([0,y(1)],handle_axesD);
% �܂� A <-> B
handle_annAB = annotation('line',[xAfig,xBfig],[yAfig,yBfig],'Color','green');
handle_annAC = annotation('line',[xAfig,xCfig],[yAfig,yCfig],'Color','red');
handle_annCD = annotation('line',[xCfig,xDfig],[yCfig,yDfig],'Color','blue');

% ���Ƃ̓f�[�^���X�V���ē����������I
dt = 4*pi/N;
for ii=1:N % 2�g�����`���܂��B
    t = t0 + dt*ii;
    y = pi/2*sin(t);
    
    % Axes C, Axes D �̃T�C���J�[�u
    handle_lineC.XData = y; % Axes C �͏c����
    handle_lineD.YData = y;
    
    % �����_���W��`��
    tC = 2*pi+y(1); % y position in C axes
    xC = pi/2*sin(tC+dt*ii); % x position in C axes
    handle_pointA.XData = xC;
    handle_pointA.YData = -xC;
    handle_pointB.YData = -xC;
    handle_pointC.XData = xC;
    handle_pointC.YData = tC;
    handle_pointD.YData = y(1);
    
    % Axes B �Ƀf�[�^�ǉ��i����L�΂��j
    handle_lineB.XData = [dt*ii,handle_lineB.XData];
    handle_lineB.YData = [handle_lineB.YData,-xC];
    
    % �����_�����Ԑ���`���܂��B
    % Figure ���W�n�ɕϊ�
    [xAfig,yAfig] = axesPosition2figurePosition([xC,-xC],handle_axesA);
    [xBfig,yBfig] = axesPosition2figurePosition([0,-xC],handle_axesB);
    [xCfig,yCfig] = axesPosition2figurePosition([xC,tC],handle_axesC);
    [xDfig,yDfig] = axesPosition2figurePosition([0,y(1)],handle_axesD);
    % �܂� A <-> B
    handle_annAB.X = [xAfig,xBfig];
    handle_annAB.Y = [yAfig,yBfig];
    handle_annAC.X = [xAfig,xCfig];
    handle_annAC.Y = [yAfig,yCfig];
    handle_annCD.X = [xCfig,xDfig];
    handle_annCD.Y = [yCfig,yDfig];
    drawnow
end
```

![figure_2.png](visualizePM_part2_images/figure_2.png)



�ł�������B


# �d�グ


�����܂ł� �����g�iAxes C�j�� �`���M���iAxes D�j�̎��g���������ł����A���낢��V�ׂ�悤�ɂ������ςɂ��Ċ֐��������Ⴂ�܂��傤�BGIF �t�@�C���𐶐�����R�}���h������Ă����܂��B




���Ə������h���ʂł� y = 0 �̂Ƃ���ɐ����~�����C�����܂��B


```matlab
handle_axesB.YTick = 0;
handle_axesC.XTick = 0; % Axes C �͏c����
handle_axesC.YTick = 2*pi; % �^�񒆁iy = 2pi �� t = 0 �ƕ\���j
handle_axesC.YTickLabel = "t = 0"; % �^�񒆁iy = 2pi �� t = 0 �ƕ\���j
handle_axesD.YTick = 0;
grid(handle_axesB,'on');
grid(handle_axesC,'on');
grid(handle_axesD,'on');
```


����Ȋ����Œǉ����܂��B�ȉ������s����΂ł�������I


```matlab
fC = 5;
fD = 2;
addpath('..\function\');
plotPhaseModulation(fC,fD);
```

![figure_3.png](visualizePM_part2_images/figure_3.png)



�ȉ��̂悤�ɑ�O�����Ƀt�@�C����������� GIF ������܂��B


```matlab
% plotPhaseModulation(fC,fD,'output.gif');
```


���FR2019b Update 2 �ł� Live Script ��Ŏ��s����ƃG���[���ł܂��B�����͕�����܂��񂪁A`getFrame` �� Figure ��ʂ��L���v�`������ƁA�O���t�B�b�N�X�I�u�W�F�N�g�̈ꕔ�ɉe�����o�Ă���l�q�B�����Ⴒ���Ⴕ���������B�ł��̂ŁA�R�}���h���C���Ŏ��s���Ă��������E�E�B


