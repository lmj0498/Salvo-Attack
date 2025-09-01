for i = 1:4
    filename = strcat('CMMAV', num2str(i), '_ITCG_PNG.mat'); % 파일 이름 생성
    data(i) = load(filename);
end

CMMAV1_x = data(1).ans(2, :);
CMMAV1_y = data(1).ans(3, :);

CMMAV2_x = data(2).ans(2, :);
CMMAV2_y = data(2).ans(3, :);

CMMAV3_x = data(3).ans(2, :);
CMMAV3_y = data(3).ans(3, :);

CMMAV4_x = data(4).ans(2, :);
CMMAV4_y = data(4).ans(3, :);

cla; 
grid on;
hold on;
gif_filename = 'ITCG+PNG Salvo Attack.gif';
xlim([-1000 1000]);
ylim([-1000 1000]);
xlabel('X [m]','fontname','Times New Roman','fontangle','italic');
ylabel('Y [m]','fontname','Times New Roman','fontangle','italic');
title('2D Salvo Attack', 'fontname','Times New Roman','fontangle','italic');

for t=1:100:length(CMMAV1_x)
    if t>1
        delete(m1);
        delete(m2);
        delete(m3);
        delete(m4);
    end
    % 이동 경로 그리기
    h1 = plot(CMMAV1_x(1:t), CMMAV1_y(1:t), 'k', 'LineWidth', 1.5);
    h2 = plot(CMMAV2_x(1:t), CMMAV2_y(1:t), 'b', 'LineWidth', 1.5); 
    h3 = plot(CMMAV3_x(1:t), CMMAV3_y(1:t), 'g', 'LineWidth', 1.5); 
    h4 = plot(CMMAV4_x(1:t), CMMAV4_y(1:t), 'm', 'LineWidth', 1.5); 
    h5 = plot(0, 0, 'rx', 'MarkerSize', 10, 'LineWidth', 2);

    % 현재 위치를 마커로 표시
    m1 = plot(CMMAV1_x(t), CMMAV1_y(t), 'ko', 'MarkerSize', 8, 'MarkerFaceColor', 'k');
    m2 = plot(CMMAV2_x(t), CMMAV2_y(t), 'bo', 'MarkerSize', 8, 'MarkerFaceColor', 'b');
    m3 = plot(CMMAV3_x(t), CMMAV3_y(t), 'go', 'MarkerSize', 8, 'MarkerFaceColor', 'g');
    m4 = plot(CMMAV4_x(t), CMMAV4_y(t), 'mo', 'MarkerSize', 8, 'MarkerFaceColor', 'm');

    legend([h5, m1, m2, m3, m4], {'Target', 'CMMAV1', 'CMMAV2', 'CMMAV3', 'CMMAV4'}, 'Location', 'NW', 'fontname','Times New Roman','fontangle','italic');
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
