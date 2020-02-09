% Generate GIF for moving a sine curve
% Copyright 2020 Michio Inoue

filename = 'sineCurve.gif';
handle_fig = gcf;
handle_fig.Color = 'white';
handle_axes = gca;
handle_axes.XLim = [0,4*pi];

N = 100;
t0 = linspace(0,4*pi,N);
handle_line = plot(t0,sin(t0));

% for ループで y の値を変えていきます。
dt = 4*pi/N;
for ii=1:N
    t = t0 + dt*(ii-1);
    y = sin(t);
    handle_line.YData = y;
    drawnow
    frame = getframe(handle_fig); % Figure 画面をムービーフレーム（構造体）としてキャプチャ
    tmp = frame2im(frame); % 画像に変更
    [A,map] = rgb2ind(tmp,256); % RGB -> インデックス画像に
    if ii == 1 % 新規 gif ファイル作成
        imwrite(A,map,filename,'gif','LoopCount',Inf,'DelayTime',0.1);
    else % 以降、画像をアペンド
        imwrite(A,map,filename,'gif','WriteMode','append','DelayTime',0.1);
    end
end
