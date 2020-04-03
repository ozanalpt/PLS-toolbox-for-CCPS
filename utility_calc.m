function [Selections, scan_ai_sim_vs_test] = utility_calc(Sec_QoS_results,settings)

%This function calculates utilities for chosen weights and it chooses the
%best policies for the weights from initSettings.m

for weight = 1:size(settings.utility_weights,1)
    for ant = 1:length(settings.antennas)
        for jam=1:length(settings.P_j_array )
            for eve=1:length(settings.x_mean_array)
        
            normalized_security = Sec_QoS_results(jam,eve).normalized_security;
            normalized_QoS = Sec_QoS_results(jam,eve).normalized_QoS;
            
%% Cost calculation
            Power_c = 10.^(settings.P_w/10);
            norm_power = Power_c./max(Power_c);
            Power_cost = [norm_power;norm_power;norm_power;zeros(1,length(settings.P_w))];
            
            TX_antenna_c = [zeros(2,length(settings.P_w));ones(2,length(settings.P_w))];
            RX_antenna_c = [zeros(1,length(settings.P_w));ones(1,length(settings.P_w));...
                            zeros(2,length(settings.P_w))];
                        
            normalized_cost = 1-(settings.cost_coeff(1)*Power_cost...
                                + settings.cost_coeff(2)*TX_antenna_c...
                                + settings.cost_coeff(3)*RX_antenna_c);


%% Building Utility
            utility_weights = settings.utility_weights(weight,:); % respectively security / QoS / Cost
            
            utility = utility_weights(1)*normalized_security...
                    + utility_weights(2)*normalized_QoS...
                    + utility_weights(3)*normalized_cost;
    
            U=max(utility,[],2); 
            
%This part is necessary for the comparison of tests and simulatinons
%-------------------------------------------------------------------
            if jam == 1&& eve == 2 %Only when there is no jammer, and the eavesdropper is in the middle
                                   %AN power is 5dB
            scan_ai_sim_vs_test(1).sim(1,:) = normalized_security(1:2,2);
            scan_ai_sim_vs_test(1).sim(2,:) = normalized_QoS(1:2,2);
            scan_ai_sim_vs_test(1).sim(3,:) = normalized_cost(1:2,2);
            scan_ai_sim_vs_test(2).utility_sim(weight,:) = utility(1:2,2); 
            end
%-------------------------------------------------------------------
            
% Policy Selection
            if settings.antennas(ant) == 1        %tx=1 x rx=1 Only SC-AN is available 
                U(2:4)=0;
            elseif settings.antennas(ant) == 2    %tx=1 x rx=2 SC-AN and AI are available
                U(3:4)=0;
            elseif settings.antennas(ant) == 3    %tx=2 x rx=1 SC-AN, AN, Beamforming are available
                U(2)=0;   
            end              

            [Ut,I]=max(U);

            Selections.antenna_weights(ant,weight).attacks(jam,eve) = I;
            Ut_values(jam,eve) = Ut;
            
            end
        end
    end
end
end




