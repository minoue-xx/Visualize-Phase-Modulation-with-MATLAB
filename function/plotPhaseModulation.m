function handle_fig = plotPhaseModulation(fC,fD,filename)
% Copyright 2020 Michio Inoue

% Number of data points to plot
% if fC or fD is big, N needs to be appropriately bigger for drawing smooth
% line
N = 100*log(max(fC,fD));

if nargin > 2
    generateGIF = true;
else
    generateGIF = false;
end

% Figure ��� Axes �쐬
handle_fig = figure('Position',[100,100,400,400],'Color','white');
handle_axesA = setUpAxes(handle_fig,[1,1,2,2]/13,'none');
handle_axesB = setUpAxes(handle_fig,[4,1,8,2]/13,'green');
handle_axesC = setUpAxes(handle_fig,[1,4,2,8]/13,'red');
handle_axesD = setUpAxes(handle_fig,[4,7,8,2]/13,'blue');

% ����ς肱��
text(handle_axesB, 1, -0.1,"Visualized by MATLAB",'HorizontalAlignment','right',...
    'Units','normalized','FontSize', 10,'Color',0.5*[1,1,1]);

% y = 0 �� Tick �쐬 (Axes A �ȊO�j
handle_axesB.YTick = 0;
handle_axesC.XTick = 0; % Axes C �͏c����
handle_axesC.YTick = 2*pi; % �^�񒆁iy = 2pi �� t = 0 �ƕ\���j
handle_axesC.YTickLabel = "t = 0"; % �^�񒆁iy = 2pi �� t = 0 �ƕ\���j
handle_axesD.YTick = 0;
grid(handle_axesB,'on');
grid(handle_axesC,'on');
grid(handle_axesD,'on');

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
handle_axesB.Title.String = "$$\frac{\pi}{2}\sin\left(" + string(fC) + ...
    "t + \frac{\pi}{2} \sin \left( " + string(fD) +" t \right) \right)$$";

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
for ii=1:2*N % 2�g�����`���܂��B
    yC = pi/2*sin(t0 + fC*dt*ii);
    yD = pi/2*sin(t0 + fD*dt*ii);
    
    % Axes C, Axes D �̃T�C���J�[�u
    handle_lineC.XData = yC; % Axes C �͏c����
    handle_lineD.YData = yD;
    
    % �����_���W��`��
    tC = 2*pi+yD(1); % y position in C axes
    xC = pi/2*sin(tC+fC*dt*ii); % x position in C axes
    handle_pointA.XData = xC;
    handle_pointA.YData = -xC;
    handle_pointB.YData = -xC;
    handle_pointC.XData = xC;
    handle_pointC.YData = tC;
    handle_pointD.YData = yD(1);
    
    % Axes B �Ƀf�[�^�ǉ��i����L�΂��j
    handle_lineB.XData = [dt*ii,handle_lineB.XData];
    handle_lineB.YData = [handle_lineB.YData,-xC];
    
    % �����_�����Ԑ���`���܂��B
    % Figure ���W�n�ɕϊ�
    [xAfig,yAfig] = axesPosition2figurePosition([xC,-xC],handle_axesA);
    [xBfig,yBfig] = axesPosition2figurePosition([0,-xC],handle_axesB);
    [xCfig,yCfig] = axesPosition2figurePosition([xC,tC],handle_axesC);
    [xDfig,yDfig] = axesPosition2figurePosition([0,yD(1)],handle_axesD);
    % �܂� A <-> B
    handle_annAB.X = [xAfig,xBfig];
    handle_annAB.Y = [yAfig,yBfig];
    handle_annAC.X = [xAfig,xCfig];
    handle_annAC.Y = [yAfig,yCfig];
    handle_annCD.X = [xCfig,xDfig];
    handle_annCD.Y = [yCfig,yDfig];
    drawnow
    
    if generateGIF
        frame = getframe(handle_fig); % Figure ��ʂ����[�r�[�t���[���i�\���́j�Ƃ��ăL���v�`��
        tmp = frame2im(frame); % �摜�ɕύX
        [A,map] = rgb2ind(tmp,256); % RGB -> �C���f�b�N�X�摜��
        if ii == 1 % �V�K gif �t�@�C���쐬
            imwrite(A,map,filename,'gif','LoopCount',Inf,'DelayTime',0.1);
        else % �ȍ~�A�摜���A�y���h
            imwrite(A,map,filename,'gif','WriteMode','append','DelayTime',0.1);
        end
    end
end