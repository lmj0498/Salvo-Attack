close all; clear; clc;

%% Simulation parameters
CMMAV_range = 1:4;
t_d = 28;
fig1 = figure();
%az
ax1 = axes('Parent',fig1,'XLim',[0 t_d],'YLim',[-1 1],...
    'xgrid','on','ygrid','on', 'position',[0.13 0.6 0.80 0.32],...
    'fontsize',16,'fontname','Times New Roman','fontangle','italic');
%ay
ax2 = axes('Parent',fig1,'XLim',[0 t_d],'YLim',[-10 10],...
    'xgrid','on','ygrid','on','position',[0.13 0.15 0.80 0.32],...
    'fontsize',16,'fontname','Times New Roman','fontangle','italic');

fig2 = figure();
% R
ax3 = axes('Parent',fig2,'XLim',[0 t_d],'YLim',[0 700],...
    'xgrid','on','ygrid','on','box', 'on','position',[0.13 0.72 0.80 0.24],...
    'fontsize',16,'fontname','Times New Roman','fontangle','italic');

% theta_L
ax4 = axes('Parent',fig2,'XLim',[0 t_d],'YLim',[-90 0],'Ytick', -80:10:-50,...
    'xgrid','on','ygrid','on', 'box', 'on', 'position',[0.13 0.4 0.80 0.24],...
    'fontsize',16,'fontname','Times New Roman','fontangle','italic');

% psi_L
ax5 = axes('Parent',fig2,'XLim',[0 t_d],'YLim',[-50 50],...
    'xgrid','on','ygrid','on','box', 'on', 'position',[0.13 0.08 0.80 0.24],...
    'fontsize',16,'fontname','Times New Roman','fontangle','italic');

C_map = ['k', 'b', 'g', 'm'];

for i = 1:length(CMMAV_range)
    % filename = strcat('3DCMMAV', num2str(i),'.mat'); 
    filename = strcat('ITACG_CMMAV', num2str(i), '.mat'); 
    data = load(filename);
    
    t = data.ans(1,:);
    pos_X = data.ans(2,:);
    pos_Y = data.ans(3,:);
    pos_Z = data.ans(4,:);
    psi = data.ans(5,:) * 180/pi;
    theta = data.ans(6,:) * 180/pi;
    az = data.ans(8,:);
    ay = data.ans(9,:);
    psi_L = data.ans(10,:) * 180/pi;
    theta_L = data.ans(11,:) * 180/pi;
    sigma = data.ans(12,:) * 180/pi;

    dist = sqrt(pos_X.^2 + pos_Y.^2 + pos_Z.^2);

    idx = find(dist < 15, 1, 'first');

    if ~isempty(idx)
        pos_X(idx:end) = pos_X(idx);
        pos_Y(idx:end) = pos_Y(idx);
        pos_Z(idx:end) = pos_Z(idx);
        psi(idx:end) = psi(idx);
        theta(idx:end) = theta(idx);
        az(idx:end) = az(idx);
        ay(idx:end) = ay(idx);
        sigma(idx:end) = sigma(idx);
        psi_L(idx:end) = psi_L(idx);
        theta_L(idx:end) = theta_L(idx);
    end

    li1(i) = line('parent',ax1,'xdata',t,'ydata',az,...
        'color',C_map(i),'linewidth',4);

    li2(i) = line('parent',ax2,'xdata',t,'ydata',ay,...
        'color',C_map(i),'linewidth',4);

    li3(i) = line('parent',ax3,'xdata',t,'ydata',dist,...
        'color',C_map(i),'linewidth',4);

    li4(i) = line('parent',ax4,'xdata',t,'ydata',theta_L,...
        'color',C_map(i),'linewidth',2);

    li5(i) = line('parent',ax5,'xdata',t,'ydata',psi_L,...
        'color',C_map(i),'linewidth',2);

    y_lines = [-50, -60, -70, -80];
    
    % 빨간 점선 추가
    for i = 1:length(y_lines)
        li6(i) = line('Parent', ax4, ...
                      'XData', [0, t_d], ...
                      'YData', [y_lines(i), y_lines(i)], ...
                      'Color', 'r', ...
                      'LineWidth', 1.5, ...
                      'LineStyle', '--');
    end
end
% xlabel(ax1,'time [s]','fontsize',14,'FontWeight','bold')
ylabel(ax1,'a_z [m/s^2]','fontsize',14,'FontWeight','bold')
% legend(ax1,[li1(1) li1(2) li1(3) li1(4)], {'CMMAV1' 'CMMAV2' 'CMMAV3' 'CMMAV4'},'Location','NE','FontSize',10)
title(ax1, "Acceleration", 'fontsize',16,'fontname','Times New Roman','fontangle','italic', 'fontsize', 14)

xlabel(ax2,'time [s]','fontsize',14,'FontWeight','bold')
ylabel(ax2,'a_y [m/s^2]','fontsize',14,'FontWeight','bold')
% legend(ax2,[li1(1) li1(2) li1(3) li1(4)], {'CMMAV1' 'CMMAV2' 'CMMAV3' 'CMMAV4'},'Location','SE','FontSize',10)
% title(ax2, "Impact time error", 'fontsize',16,'fontname','Times New Roman','fontangle','italic','fontsize', 14)

% xlabel(ax1,'time [s]','fontsize',14,'FontWeight','bold')
ylabel(ax3,'R [m]','fontsize',14,'FontWeight','bold')
legend(ax3,[li1(1) li1(2) li1(3) li1(4)], {'UAV1' 'UAV2' 'UAV3' 'UAV4'},'Location','NE','FontSize',10)
% title(ax3, "t_{go}", 'fontsize',16,'fontname','Times New Roman','fontangle','italic', 'fontsize', 14)

% xlabel(ax4,'time [s]','fontsize',14,'FontWeight','bold')
ylabel(ax4,'\theta_L [deg]','fontsize',14,'FontWeight','bold')
% legend(ax4,[li1(1) li1(2) li1(3) li1(4)], {'#1 t_d=30' '#2 t_d=31' '#3 t_d=32' '#4 t_d=33'},'Location','NE','FontSize',14)
% title(ax4, "Impact time error", 'fontsize',16,'fontname','Times New Roman','fontangle','italic','fontsize', 14)

xlabel(ax5,'time [s]','fontsize',14,'FontWeight','bold')
ylabel(ax5,'\psi_L [deg]','fontsize',14,'FontWeight','bold')
% legend(ax5,[li1(1) li1(2) li1(3) li1(4)], {'UAV1' 'UAV2' 'UAV3' 'UAV4'},'Location','NE','FontSize',10)
% title(ax5, "Relative distance", 'fontsize',16,'fontname','Times New Roman','fontangle','italic','fontsize', 14)