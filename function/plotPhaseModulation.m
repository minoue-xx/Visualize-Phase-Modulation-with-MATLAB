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

% Figure 上で Axes 作成
handle_fig = figure('Position',[100,100,400,400],'Color','white');
handle_axesA = setUpAxes(handle_fig,[1,1,2,2]/13,'none');
handle_axesB = setUpAxes(handle_fig,[4,1,8,2]/13,'green');
handle_axesC = setUpAxes(handle_fig,[1,4,2,8]/13,'red');
handle_axesD = setUpAxes(handle_fig,[4,7,8,2]/13,'blue');

% やっぱりこれ
text(handle_axesB, 1, -0.1,"Visualized by MATLAB",'HorizontalAlignment','right',...
    'Units','normalized','FontSize', 10,'Color',0.5*[1,1,1]);

% y = 0 の Tick 作成 (Axes A 以外）
handle_axesB.YTick = 0;
handle_axesC.XTick = 0; % Axes C は縦向き
handle_axesC.YTick = 2*pi; % 真ん中（y = 2pi を t = 0 と表示）
handle_axesC.YTickLabel = "t = 0"; % 真ん中（y = 2pi を t = 0 と表示）
handle_axesD.YTick = 0;
grid(handle_axesB,'on');
grid(handle_axesC,'on');
grid(handle_axesD,'on');

% それぞれの Axes 表示範囲を固定
handle_axesA.XLim = [-pi/2,pi/2];
handle_axesA.YLim = [-pi/2,pi/2];
handle_axesB.XLim = [0,4*pi];
handle_axesB.YLim = [-pi/2,pi/2];
handle_axesC.XLim = [-pi/2,pi/2]; % Axes C は縦向き
handle_axesC.YLim = [0,4*pi]; % Axes C は縦向き
handle_axesD.XLim = [0,4*pi];
handle_axesD.YLim = [-pi/2,pi/2];

% Axes A の y = -x の線を描く
handle_lineA = line(handle_axesA, [-pi/2,pi/2],[pi/2,-pi/2],'Color','black','LineWidth',2);

% Axes C, Axes D のサインカーブ
t0 = linspace(0,4*pi,N);
y = pi/2*sin(t0);
handle_lineC = line(handle_axesC,y,t0,'Color','red','LineWidth',2); % Axes C は縦向き
handle_lineD = line(handle_axesD,t0,y,'Color','blue','LineWidth',2);

% 動く点座標を描画
tC = 2*pi+y(1); % y position in C axes
xC = pi/2*sin(tC); % x position in C axes
handle_pointA = line(handle_axesA,xC,-xC,'Marker','o','MarkerFaceColor','black');
handle_pointB = line(handle_axesB,0,-xC,'Marker','o','MarkerFaceColor','green');
handle_pointC = line(handle_axesC,xC,tC,'Marker','o','MarkerFaceColor','red');
handle_pointD = line(handle_axesD,0,y(1),'Marker','o','MarkerFaceColor','blue');

% Axes B に新たな線を追加（時間経過とともに伸びます）
handle_lineB = line(handle_axesB,0,-xC,'Color','green','LineWidth',2);

% 式表示
handle_axesB.Title.Interpreter = 'latex';
handle_axesB.Title.FontSize = 15;
handle_axesB.Title.String = "$$\frac{\pi}{2}\sin\left(" + string(fC) + ...
    "t + \frac{\pi}{2} \sin \left( " + string(fD) +" t \right) \right)$$";

% 動く点を結ぶ線を描きます。
% Figure 座標系に変換
[xAfig,yAfig] = axesPosition2figurePosition([xC,-xC],handle_axesA);
[xBfig,yBfig] = axesPosition2figurePosition([0,-xC],handle_axesB);
[xCfig,yCfig] = axesPosition2figurePosition([xC,tC],handle_axesC);
[xDfig,yDfig] = axesPosition2figurePosition([0,y(1)],handle_axesD);
% まず A <-> B
handle_annAB = annotation('line',[xAfig,xBfig],[yAfig,yBfig],'Color','green');
handle_annAC = annotation('line',[xAfig,xCfig],[yAfig,yCfig],'Color','red');
handle_annCD = annotation('line',[xCfig,xDfig],[yCfig,yDfig],'Color','blue');

% あとはデータを更新して動かすだけ！
dt = 4*pi/N;
for ii=1:2*N % 2波長分描きます。
    yC = pi/2*sin(t0 + fC*dt*ii);
    yD = pi/2*sin(t0 + fD*dt*ii);
    
    % Axes C, Axes D のサインカーブ
    handle_lineC.XData = yC; % Axes C は縦向き
    handle_lineD.YData = yD;
    
    % 動く点座標を描画
    tC = 2*pi+yD(1); % y position in C axes
    xC = pi/2*sin(tC+fC*dt*ii); % x position in C axes
    handle_pointA.XData = xC;
    handle_pointA.YData = -xC;
    handle_pointB.YData = -xC;
    handle_pointC.XData = xC;
    handle_pointC.YData = tC;
    handle_pointD.YData = yD(1);
    
    % Axes B にデータ追加（線を伸ばす）
    handle_lineB.XData = [dt*ii,handle_lineB.XData];
    handle_lineB.YData = [handle_lineB.YData,-xC];
    
    % 動く点を結ぶ線を描きます。
    % Figure 座標系に変換
    [xAfig,yAfig] = axesPosition2figurePosition([xC,-xC],handle_axesA);
    [xBfig,yBfig] = axesPosition2figurePosition([0,-xC],handle_axesB);
    [xCfig,yCfig] = axesPosition2figurePosition([xC,tC],handle_axesC);
    [xDfig,yDfig] = axesPosition2figurePosition([0,yD(1)],handle_axesD);
    % まず A <-> B
    handle_annAB.X = [xAfig,xBfig];
    handle_annAB.Y = [yAfig,yBfig];
    handle_annAC.X = [xAfig,xCfig];
    handle_annAC.Y = [yAfig,yCfig];
    handle_annCD.X = [xCfig,xDfig];
    handle_annCD.Y = [yCfig,yDfig];
    drawnow
    
    if generateGIF
        frame = getframe(handle_fig); % Figure 画面をムービーフレーム（構造体）としてキャプチャ
        tmp = frame2im(frame); % 画像に変更
        [A,map] = rgb2ind(tmp,256); % RGB -> インデックス画像に
        if ii == 1 % 新規 gif ファイル作成
            imwrite(A,map,filename,'gif','LoopCount',Inf,'DelayTime',0.1);
        else % 以降、画像をアペンド
            imwrite(A,map,filename,'gif','WriteMode','append','DelayTime',0.1);
        end
    end
end