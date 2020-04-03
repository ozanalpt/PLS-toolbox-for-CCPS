function settings = initSettings()
    
    settings.sim = 2; %Number of simulations
    
    % Alice and Bob setup
    settings.Pos_a           = [-0.5,0];          %Position of Alice
    settings.Pos_b           = [0.5,0];           %Position of Bob
    settings.P_s             = 5;                 %Signal power in dB (scalar)
    
    % BUNLAR NE ?Ç?N ???
    settings.x_array         = -2:0.5:2;
    settings.y_array         = -2:0.5:2;
    
    % tx antenna of Alice and number of rx antenna of Bob
    settings.antennas        = [1,2,3,4]; % Choose desired number of tx and rx antennas (max. 2x2)
                                   % Add "1" for 1x1
                                   % Add "2" for 1x2
                                   % Add "3" for 2x1
                                   % Add "4" for 2x2
     
    % Attacker models
    settings.Pos_j           = [0,-1];            %Position of Jammer
    settings.x_mean_array    = [-0.5, 0, 0.5];    %Eavesdropper_x_position_mean  
    settings.y_mean          = 0;                 %Eavesdropper_y_position_mean
    settings.loc_variance    = 0.5;               %Eavesdropper location variance
    settings.P_j_array       = [-1e4, 0, 5, 10]; %Jammer power in dB
    
    %AN power
    settings.P_w             = [0 5 10]; %Artifical noise in dB (1xP array)
    
    settings.utility_weights = [0.33 0.33 0.33; %Utility weights [security, QoS, Cost]
                                0.4 0.5 0.1; %URLLC 
                                0.5 0.1 0.4; %mMTC
                                0.3 0.1 0.6]; %Health Networks
                            
    settings.cost_coeff      = [0.333,0.333,0.333]; %Cost coefficients [Power, TX antenna, RX antenna]

end