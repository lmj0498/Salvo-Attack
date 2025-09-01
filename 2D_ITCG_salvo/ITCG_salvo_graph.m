close all; clear; clc;

%% Simulation parameters
CMMAV_range = 1:4;

fig1 = figure();
ax1 = axes('Parent',fig1,'XLim',[0 45],'YLim',[-10 10],...
    'xgrid','on','ygrid','on','position',[0.13 0.6 0.80 0.32],...
    'fontsize',16,'fontname','Times New Roman','fontangle','italic');
ax2 = axes('Parent',fig1,'XLim',[0 45],'YLim',[-10 2],...
    'xgrid','on','ygrid','on','position',[0.13 0.15 0.80 0.32],...
    'fontsize',16,'fontname','Times New Roman','fontangle','italic');
fig2 = figure();
ax3 = axes('Parent',fig2,'XLim',[0 45],'YLim',[0 500],...
    'xgrid','on','ygrid','on',...
    'fontsize',16,'fontname','Times New Roman','fontangle','italic');
C_map = ['k', 'b', 'g', 'm'];

for i = 1:length(CMMAV_range)
    filename = strcat('CMMAV', num2str(i), '_state', '.mat'); % 파일 이름 생성
    data = load(filename);
    t = data.ans(1,:);
    pos_X = data.ans(2,:);
    pos_Y = data.ans(3,:);
    psi = data.ans(4,:)*180/pi;
    acc = data.ans(5,:);
    ksi = data.ans(6,:);
    R = sqrt(pos_X.^2+pos_Y.^2);

    % --- ksi가 0.2보다 클 경우 0으로 바꾸기 ---
    ksi(ksi > 1) = 0;

    li1(i) = line('parent',ax1,'xdata',t,'ydata',acc,...
        'color',C_map(i),'linewidth',4);

    li2(i) = line('parent',ax2,'xdata',t,'ydata',ksi,...
        'color',C_map(i),'linewidth',4);

    li3(i) = line('parent',ax3,'xdata',t,'ydata',R,...
        'color',C_map(i),'linewidth',4);
end
% xlabel(ax1,'time [s]','fontsize',14,'FontWeight','bold')
ylabel(ax1,'[m/s^2]','fontsize',14,'FontWeight','bold')
% legend(ax1,[li1(1) li1(2) li1(3) li1(4)], {'CMMAV1 t_d=30' 'CMMAV2 t_d=35' 'CMMAV3 t_d=40' 'CMMAV4 t_d=45'},'Location','NE','FontSize',10)
title(ax1, "Acceleration", 'fontsize',16,'fontname','Times New Roman','fontangle','italic', 'fontsize', 14)

xlabel(ax2,'time [s]','fontsize',14,'FontWeight','bold')
ylabel(ax2,'[s]','fontsize',14,'FontWeight','bold')
% legend(ax2,[li1(1) li1(2) li1(3) li1(4)], {'#1 t_d=30' '#2 t_d=35' '#3 t_d=40' '#4 t_d=45'},'Location','SE','FontSize',14)
title(ax2, "Impact time error", 'fontsize',16,'fontname','Times New Roman','fontangle','italic','fontsize', 14)

xlabel(ax3,'time [s]','fontsize',14,'FontWeight','bold')
ylabel(ax3,'[m]','fontsize',14,'FontWeight','bold')
% legend(ax3,[li1(1) li1(2) li1(3) li1(4)], {'CMMAV1' 'CMMAV2' 'CMMAV3' 'CMMAV4'},'Location','SE','FontSize',10)
title(ax3, "Relative distance", 'fontsize',16,'fontname','Times New Roman','fontangle','italic','fontsize', 14)