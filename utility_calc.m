clc; clear; close all;
% Parameters
% x_array=-2:0.2:2;
% y_array=-2:0.2:2;
% Pos_a=[-1,0];
% Pos_b=[1,0];
% Pos_j=[0,-1];
% P_s=5; %Signal power in dB (scalar)
%  P_w=[5]; %Artifical noise in dB (1xP array)
% sim=1e3;
% P_j_array=[5]; %dB
% 
% %%%%Eve location pdf
% x_mean_array=[-0.5, 0, 0.5];
% y_mean=0;
% loc_variance=0.5;
% for counter_2=1:length(x_mean_array)
% x_mean=x_mean_array(counter_2);
% weight_x=normpdf(x_array,x_mean,loc_variance);
% weight_y=normpdf(y_array,y_mean,loc_variance);
% loc_weight=weight_x.'*weight_y;
% for counter_1=1:length(P_j_array)
% P_j=P_j_array(counter_1);
% %% Security and QoS
% [security_scAN,QoS_scAN]=sc_AN(x_array,y_array,loc_weight,Pos_a,Pos_b,Pos_j,P_s,P_w,P_j,sim); %(1xP array)
% [security_bAN,QoS_bAN]= b_AN(x_array,y_array,loc_weight,Pos_a,Pos_b,Pos_j,P_s,P_w,P_j,sim); %(1xP+1 array) first element shows the beamforming wo AN
% %security_b=security_bAN(1).*ones(1,length(security_scAN));
% %QoS_b=QoS_bAN(1).*ones(1,length(QoS_scAN));
% %QoS_AN=QoS_bAN(2:end);
% %security_AN=security_bAN(2:end);
% [security_AI,QoS_AI]= rec_AI(x_array,y_array,loc_weight,Pos_a,Pos_b,Pos_j,P_s,P_w,P_j,sim);
% 
% %%% Normalization Phase
% securities=[security_scAN;security_AI;security_AN;security_b];
% QoS=[QoS_scAN;QoS_AI;QoS_AN;QoS_b];
% 
% maximum_sec=max(securities);
% maximum_QoS=max(QoS);
% normalized_security=securities./maximum_sec;
% normalized_QoS=QoS./maximum_QoS;
% 
% 
% A(counter_1,counter_2).securities=securities;
% A(counter_1,counter_2).QoS=QoS;
% A(counter_1,counter_2).normalized_security=normalized_security;
% A(counter_1,counter_2).normalized_QoS=normalized_QoS;
% 
% end
% end
%  
 %save A.mat

%% Part2

 load A.mat
 clearvars -except A P_w
% antenna=2;
% for cont_1=1:4
%     for cont_2=1:3
%         normalized_security= A(cont_1,cont_2).normalized_security;
%         normalized_QoS= A(cont_1,cont_2).normalized_QoS;
% %% Cost
% cost_coeff=[0.333,0.333,0.333]; %Coefficients for cost terms respectively Power, TX antenna, RX antenna
% Power_c=10.^(P_w/10);
% norm_power=Power_c./max(Power_c);
% Power_cost=[norm_power;norm_power;norm_power;zeros(1,length(P_w))];
% TX_antenna_c=[zeros(2,length(P_w));ones(2,length(P_w))];
% RX_antenna_c=[zeros(1,length(P_w));ones(1,length(P_w));zeros(2,length(P_w))];
% normalized_cost=1-(cost_coeff(1)*Power_cost+cost_coeff(2)*TX_antenna_c+cost_coeff(3)*RX_antenna_c);
% 
% 
% %% Building Utility
% utility_weights= [0.1,0.5,0.4]; % respectively security / QoS / Cost
% utility=utility_weights(1)*normalized_security+utility_weights(2)*normalized_QoS+utility_weights(3)*normalized_cost;
% U=max(utility,[],2); 
% if antenna==1 %1x1
%     U(2:4)=0;
% elseif antenna==2 %1x2
%     U(3:4)=0;
% elseif antenna==3 %2x1
%     U(2)=0;
% end
% [Ut,I]=max(U);
% Selection(cont_1,cont_2)=I;
% Ut_values(cont_1,cont_2)=Ut;
%     end
% end
% Selection



