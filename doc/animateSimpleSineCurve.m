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

% for ���[�v�� y �̒l��ς��Ă����܂��B
dt = 4*pi/N;
for ii=1:N
    t = t0 + dt*(ii-1);
    y = sin(t);
    handle_line.YData = y;
    drawnow
    frame = getframe(handle_fig); % Figure ��ʂ����[�r�[�t���[���i�\���́j�Ƃ��ăL���v�`��
    tmp = frame2im(frame); % �摜�ɕύX
    [A,map] = rgb2ind(tmp,256); % RGB -> �C���f�b�N�X�摜��
    if ii == 1 % �V�K gif �t�@�C���쐬
        imwrite(A,map,filename,'gif','LoopCount',Inf,'DelayTime',0.1);
    else % �ȍ~�A�摜���A�y���h
        imwrite(A,map,filename,'gif','WriteMode','append','DelayTime',0.1);
    end
end
