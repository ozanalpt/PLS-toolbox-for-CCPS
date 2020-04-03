function plot_sim_vs_test(scan_ai_sim_vs_test,settings)

load test_results.mat;
scan_ai_sim_vs_test(1).test(1,:) = [test_results.security_scAN_test(1,2) test_results.security_AI_test(1,2)];
scan_ai_sim_vs_test(1).test(2,:) = [test_results.QoS_scAN_test(1,2) test_results.QoS_AI_test(1,2)];
scan_ai_sim_vs_test(1).test(3,:) = [test_results.cost_scAN(1,2) test_results.cost_AI(1,2)];

figure('Name','Utility Results','units','normalized','outerposition',[0 0 1 1]);
subplot(2,1,1);
bar(scan_ai_sim_vs_test(1).sim,'Facecolor','[0.75 0 0]'); 
hold on;
bar(scan_ai_sim_vs_test(1).test,'Facecolor','[0.95 0.45 0]'); 
hold on; 
bar(scan_ai_sim_vs_test(1).sim(1:2,:),'Facecolor','[0.75 0 0]');
xtick = {'Security';'QoS';'Cost'};
set(gca,'xtick',[1:3],'xticklabel',xtick);
set(gca,'FontSize',20);
title('(a) Simulation and Test Comparison for each Dimension','FontSize',18);
grid on;
ylim([0,1.25]);
L(1) = plot(nan, nan, 'Color',[1 1 1]);
L(2) = plot(nan, nan, 'Color',[1 1 1]);
legend(L, {'Left Sided Bar: SC-AN','Right Sided Bar: AI'},'Location','north','NumColumns',2)
%legend({'Left Sided Bar: SC-AN','Right Sided Bar: AI'},'Location','northwest','NumColumns',2)
legend boxoff
ylabel({'Normalized Security,';'QoS and Cost'},'Rotation',90)
% colors=[[1 1 1]; 
%     [1 1 1]];                                  
% nColors=size(colors,1);                             % make variable so can change easily
% labels={'Left Sided Bars: SC-AN';'Right Sided Bars: AI'};
% hBLG = bar(nan(2,nColors));         % the bar object array for legend
% for i=1:nColors
%   hBLG(i).FaceColor=colors(i,:);
% end
% hLG=legend(hBLG,labels,'location','northeast');
%legend({'Left Sided Bar: SC-AN','Right Sided Bar: AI'},'Location','northwest','NumColumns',2)

for weight = 1:size(settings.utility_weights,1)
    
    %scan_ai_test(weight).utility(1,:) = zeros(1,2); %Utilities of test results will be calculated
    utility_weights = settings.utility_weights(weight,:); % respectively security / QoS / Cost

    scan_ai_sim_vs_test(2).utility_test(weight,:) =  utility_weights(1)*scan_ai_sim_vs_test(1).test(1,:)...
                                                     + utility_weights(2)*scan_ai_sim_vs_test(1).test(2,:)...
                                                     + utility_weights(3)*scan_ai_sim_vs_test(1).test(3,:);
end
subplot(2,1,2);
bar(scan_ai_sim_vs_test(2).utility_sim,'Facecolor','[0.75 0 0]'); 
hold on;
bar(scan_ai_sim_vs_test(2).utility_test,'Facecolor','[0.95 0.45 0]'); 
hold on;
bar(scan_ai_sim_vs_test(2).utility_sim(1:3,:),'Facecolor','[0.75 0 0]');
xtick = {'Drone Swarms';'URLLC';'mMTC';'Health Networks'};
set(gca,'xtick',[1:4],'xticklabel',xtick);
set(gca,'FontSize',20);
title('(b) Simulation and Test Comparison for Utility ','FontSize',18);
grid on;
ylim([0,1.25]);
colors=[[0.75 0 0]; 
    [0.95 0.45 0]];                                  
nColors=size(colors,1);                             % make variable so can change easily
labels={'Simulation';'Test'};
hBLG = bar(nan(2,nColors));         % the bar object array for legend
for i=1:nColors
  hBLG(i).FaceColor=colors(i,:);
end
hLG=legend(hBLG,labels,'location','northeast');
ylabel('Normalized Utility','Rotation',90);
end
