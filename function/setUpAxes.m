function handle_axes = setUpAxes(handle_fig, Position, color)
% Copyright 2020 Michio Inoue
    handle_axes = axes(handle_fig,'Position',Position,'Box',"on");
    handle_axes.XColor = color;
    handle_axes.YColor = color;
    handle_axes.XTick = [];
    handle_axes.YTick = [];
    handle_axes.LineWidth = 2;
end