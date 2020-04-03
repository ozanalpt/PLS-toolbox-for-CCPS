function Sec_Qos_results = security_methods(settings)
% This function calculates the security, QoS and cost for each security
% policy for chosen settings (initSettings.m)

for counter_2 = 1:length(settings.x_mean_array)
    x_mean = settings.x_mean_array(counter_2);
    weight_x = normpdf(settings.x_array,x_mean,settings.loc_variance);
    weight_y = normpdf(settings.y_array,settings.y_mean,settings.loc_variance);
    loc_weight = weight_x.'*weight_y;
    
    for counter_1 = 1:length(settings.P_j_array)
        P_j = settings.P_j_array(counter_1);
        
%% Security and QoS
        %SC-AN security and QoS (1xP array)
        [security_scAN,QoS_scAN] = sc_AN(settings.x_array,settings.y_array,...
                                    loc_weight,settings.Pos_a,settings.Pos_b,...
                                    settings.Pos_j,settings.P_s,settings.P_w,...
                                    P_j,settings.sim); %
        %AI security and QoS
        [security_AI,QoS_AI] = rec_AI(settings.x_array,settings.y_array,...
                               loc_weight,settings.Pos_a,settings.Pos_b,...
                               settings.Pos_j,settings.P_s,settings.P_w,...
                               P_j,settings.sim);                       
                                
        %Beamforming with and without AN, 
        %(1xP+1 array) first element shows the beamforming wo AN                 
        [security_bAN,QoS_bAN] = b_AN(settings.x_array,settings.y_array,...
                                    loc_weight,settings.Pos_a,settings.Pos_b,...
                                    settings.Pos_j,settings.P_s,settings.P_w...
                                    ,P_j,settings.sim); 
                                
        %AN security and QoS
        security_AN = security_bAN(2:end);
        QoS_AN = QoS_bAN(2:end);
                                
        %Beamforming security and QoS
        security_b = security_bAN(1).*ones(1,length(security_scAN));
        QoS_b = QoS_bAN(1).*ones(1,length(QoS_scAN));
        
%%% Normalization Phase in the order with [SC-AN, AI, AN, beamforming]

        securities = [security_scAN;security_AI;security_AN;security_b];
        QoS = [QoS_scAN;QoS_AI;QoS_AN;QoS_b];

        maximum_sec = max(securities);
        maximum_QoS = max(QoS);
        normalized_security = securities./maximum_sec;
        normalized_QoS = QoS./maximum_QoS;

        Sec_Qos_results(counter_1,counter_2).securities = securities;
        Sec_Qos_results(counter_1,counter_2).QoS = QoS;
        Sec_Qos_results(counter_1,counter_2).normalized_security = normalized_security;
        Sec_Qos_results(counter_1,counter_2).normalized_QoS = normalized_QoS;

    end
end
 close all;
 %save ('Sec_QoS_results.mat','Sec_QoS_results');
 disp('Simulations are finished');
end