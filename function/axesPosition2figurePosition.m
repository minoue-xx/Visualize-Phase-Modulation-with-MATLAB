function [xFig,yFig] = axesPosition2figurePosition(data,handle_axes)
% Copyright 2020 Michio Inoue

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