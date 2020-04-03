function plot_utility(Selections,settings)

for weight = 1:size(settings.utility_weights,1)
    for ant = 1:length(settings.antennas)
        attack_no = 1;
        for jam=1:length(settings.P_j_array)
            for eve=1:length(settings.x_mean_array)
                Plot_selections.weights(weight).antennas_attack(attack_no,ant) = Selections.antenna_weights(ant,weight).attacks(attack_no);
                attack_no = attack_no + 1;
            end
        end
    end
end

figure('Name','Simulation and Test Results','units','normalized','outerposition',[0 0 1 1]);
ylabel('Equal weights');
colors = [0.65 0.85 0.35; 0.85 0.85 0; 0.95 0.45 0; 0.75 0 0]; %Each colors represent a security method, [SC-AN, AI, AN, beamforming]
%colorbar('southoutside','Ticks',[1,2,3,4],...
        % 'TickLabels',{'1','2','3','4'});
%                 color =  colors(Selections.antenna_weights(ant,weight).attacks(jam,eve));
%                 hAxes = gca;
%                 imagesc(hAxes,'CData',Plot_selections.weights(weight).antennas_attack);
%                 %colormap(hAxes,[1 0.95 0; 1 0.65 0; 0.85 0.3 0; 0.9 0.1 0]);
%                 colormap(hAxes,[0.95 0.85 0; 0.25 0.75 0.25; 0.75 0 0; 0.25 0.35 0.75]); 

for weight = 1:size(settings.utility_weights,1)
    colors = [0.65 0.85 0.35; 0.85 0.85 0; 0.95 0.45 0; 0.75 0 0]; %Each colors represent a security method, [SC-AN, AI, AN, beamforming]
    color_error_location = find(ismember([1:4],Plot_selections.weights(weight).antennas_attack)< 0.01);
    if color_error_location == 4
    colors(color_error_location,:) = [];
    end
    subplot(1,size(settings.utility_weights,1),weight);
    hAxes = gca;
    imagesc(hAxes,'CData',Plot_selections.weights(weight).antennas_attack);
                %colormap(hAxes,[1 0.95 0; 1 0.65 0; 0.85 0.3 0; 0.9 0.1 0]);
                %colormap(hAxes,[0.95 0.85 0; 0.25 0.75 0.25; 0.75 0 0; 0.25 0.35 0.75]);
    colormap(hAxes,colors);
    hold on
    g_y=[0.5:1:12.5]; % user defined grid Y [start:spaces:end]
    g_x=[0.5:1:4.5]; % user defined grid X [start:spaces:end]
    xtick = {'1x1';'1x2';'2x1';'2x2'};
    xtickangle(90);
    pbaspect([0.5 1 1]);
    set(gca,'xtick',[1:4],'xticklabel',xtick);
    for i=1:length(g_x)
        plot([g_x(i) g_x(i)],[g_y(1) g_y(end)],'k','Linewidth',3) %y grid lines
        hold on    
    end
    for i=1:length(g_y)
        plot([g_x(1) g_x(end)],[g_y(i) g_y(i)],'k','Linewidth',3) %x grid lines
        hold on    
    end
    set(gca,'FontSize',20);
    if weight == 1
       ytick = {'P_{J1}, p_{E1}'; 'P_{J2}, p_{E1}'; 'P_{J3}, p_{E1}'; 'P_{J4}, p_{E1}'; 'P_{J1}, p_{E2}'; 'P_{J2}, p_{E2}'; 'P_{J3}, p_{E2}'; 'P_{J4}, p_{E2}';'P_{J1}, p_{E3}'; 'P_{J2}, p_{E3}'; 'P_{J3}, p_{E3}'; 'P_{J4}, p_{E3}';};
        set(gca,'ytick',[1:12],'yticklabel',ytick);
        title('Drone Swarms');
    end
    if weight == 2
        title('URLLC');
    end
    if weight == 3
        title('mMTC');
    end
    if weight == 4
        title('Health Networks');
    end
    if weight ~= 1 
        set(gca,'ytick',[]);
    end
    %cbar_handle = findobj(h,'TickLabels');
    %set(cbar_handle, 'Position',[.11 .9314 .8150 .0581]);
    ylim([0.5 12.5]);
    xlim([0.5 4.5]);
    xticks([1:1:4]);
    
    if weight == size(settings.utility_weights,1)
    cbh = colorbar('southoutside','Ticks',[1,2,3,4],'TickLabels',{'SC-AN','AI','AN','Beamforming'});
    %cbh = colorbar('eastoutside','Ticks',[1,2,3,4],'TickLabels',{'SC-AN','AI','AN','Beamforming'});
    %cbh.Ticks = 1:1:4; 
    set(cbh, 'Position', [.25 .0014 .650 .0581]);
    %set(cbh, 'Position', [.911 .114 .0381 .850]);
    ticks = cbh.TickLabels;
    ax = axes('Position', cbh.Position); 
    edges = linspace(0,1,numel(ticks)+1); 
    centers = edges(2:end)-((edges(2)-edges(1))/2); 
    text(centers,ones(size(centers))*0.5, ticks, 'FontSize', cbh.FontSize,...
    'HorizontalAlignment', 'Center', 'VerticalAlignment', 'Middle'); 
    %text(ones(size(centers))*0.5, centers, ticks, 'FontSize', cbh.FontSize,...
    %'HorizontalAlignment', 'Center', 'VerticalAlignment', 'Middle','Rotation', 90); 
    ax.Visible = 'off';   %turn off new axes
    cbh.Ticks = []; 
    xlabel('Equal weights');
%     txt = text(0, [0,0], 'DENEME DENEME' , 'FontSize', cbh.FontSize,...
%     'HorizontalAlignment', 'Center', 'VerticalAlignment', 'Middle');
%     set(cbh, 'Position', [.911 .114 .0381 .850]);
    h_xlabel = annotation('textbox', [0.45 0.145 0 0], 'String', 'Tx - Rx Setup', 'FitBoxToText', true,...
    'FontSize',20,'Fontweight','bold','Edgecolor','none');
    h_ylabel = text(-.325,6.5,'Attack Scenarios','Rotation',90,'FontSize',20,'Fontweight','bold');
    h_security_methods = text(-0.25,0.5,'Security Methods:','FontSize',20,'Fontweight','bold');

    end
     
end
end