for i = 1:4
    filename = strcat('ITACG_CMMAV', num2str(i), '.mat'); 
    data(i) = load(filename);
end

CMMAV1_x = data(1).ans(2, :);
CMMAV1_y = data(1).ans(3, :);
CMMAV1_z = data(1).ans(4, :);

CMMAV2_x = data(2).ans(2, :);
CMMAV2_y = data(2).ans(3, :);
CMMAV2_z = data(2).ans(4, :);

CMMAV3_x = data(3).ans(2, :);
CMMAV3_y = data(3).ans(3, :);
CMMAV3_z = data(3).ans(4, :);

CMMAV4_x = data(4).ans(2, :);
CMMAV4_y = data(4).ans(3, :);
CMMAV4_z = data(4).ans(4, :);

cla; 
grid on;
hold on;

view(-50, 20);
gif_filename = '3D ITACG Salvo Attack.gif';
xlim([-300 700]);
ylim([-300 400]);
zlim([000 500]);

xlabel('X [m]','fontname','Times New Roman','fontangle','italic');
ylabel('Y [m]','fontname','Times New Roman','fontangle','italic');
zlabel('Z [m]','fontname','Times New Roman', 'FontAngle','italic');
title('3D Salvo Attack', 'fontname','Times New Roman','fontangle','italic');
set(gca, 'FontSize', 16, ...
         'FontAngle', 'italic', ...
         'FontName', 'Times New Roman');
[Xg, Yg] = meshgrid(-300:100:700, -300:100:400);
Zg = zeros(size(Xg));
surf(Xg, Yg, Zg, 'FaceColor', [0.6 0.4 0.2], 'EdgeColor', 'none', 'FaceAlpha', 0.5);
for t=1:10:length(CMMAV1_x)
    if t>1
        delete(m1);
        delete(m2);
        delete(m3);
        delete(m4);
    end

    h1 = plot3(CMMAV1_x(1:t), CMMAV1_y(1:t), CMMAV1_z(1:t), 'k', 'LineWidth', 1.5);
    h2 = plot3(CMMAV2_x(1:t), CMMAV2_y(1:t), CMMAV2_z(1:t), 'b', 'LineWidth', 1.5); 
    h3 = plot3(CMMAV3_x(1:t), CMMAV3_y(1:t), CMMAV3_z(1:t), 'g', 'LineWidth', 1.5); 
    h4 = plot3(CMMAV4_x(1:t), CMMAV4_y(1:t), CMMAV4_z(1:t),'m', 'LineWidth', 1.5); 
    h5 = plot3(0, 0, 0, 'rx', 'MarkerSize', 10, 'LineWidth', 2);


    m1 = plot3(CMMAV1_x(t), CMMAV1_y(t), CMMAV1_z(t), 'ko', 'MarkerSize', 8, 'MarkerFaceColor', 'k');
    m2 = plot3(CMMAV2_x(t), CMMAV2_y(t), CMMAV2_z(t), 'bo', 'MarkerSize', 8, 'MarkerFaceColor', 'b');
    m3 = plot3(CMMAV3_x(t), CMMAV3_y(t), CMMAV3_z(t), 'go', 'MarkerSize', 8, 'MarkerFaceColor', 'g');
    m4 = plot3(CMMAV4_x(t), CMMAV4_y(t), CMMAV4_z(t), 'mo', 'MarkerSize', 8, 'MarkerFaceColor', 'm');
    
    legend([h5, m1, m2, m3, m4], ...
    {'Target', 'UAV1', 'UAV2', 'UAV3', 'UAV4'}, ...
    'Location', 'NW', ...
    'FontName', 'Times New Roman', ...
    'FontAngle', 'italic', ...
    'Orientation', 'horizontal' ,...
    'fontsize', 10);

    drawnow;
    frame = getframe(gcf);
    img = frame2im(frame);
    [A, map] = rgb2ind(img, 256);
    if t == 1
        imwrite(A, map, gif_filename, 'gif', 'LoopCount', Inf, 'DelayTime', .1);
    else
        imwrite(A, map, gif_filename, 'gif', 'WriteMode', 'append', 'DelayTime', .1);
    end

end
