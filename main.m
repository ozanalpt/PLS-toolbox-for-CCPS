clear all; close all;

%% Print startup ==========================================================
fprintf(['\n',...
    'Welcome to:  CPPS Toolbox \n\n', ...
    'An open source software project developed by:\n\n', ...
    'Wireless Communication Research Laboratory, Electrical and Electronics Department, Istanbul Technical University  \n', ...
    '                                   and \n', ...
    'Wireless Communication Laboratory, Electrical and Electronics Department, Bogazici University \n\n', ...
    'This toolbox does not provide ABSOLUTELY NO WARRANTY;\n',...
    'and is free software for research and development for your own project\n']);

fprintf(['                   -------------------------------\n\n',...
    'Existing Security Policies:\n\n',...
    'Subcarrier Based Artificial Noise (SC-AN)\n',...
    'Artificial Interference (AI)\n',...
    'Artificial Noise (AN)\n',...
    'Beamforming \n\n']);

%% Initialize constants, settings =========================================
settings = initSettings();

fprintf(['                   -------------------------------\n\n',...
    'Please Enter:\n\n',...
    '1 to run current parameters, which will be load from initSettings.m \n',...
    '2 to load previously saved data with given initial parameters \n',...
    '0 to exit \n\n']);

CCPSStart = input('Please enter your selection:');

if (CCPSStart == 1)
    disp('Simulations started');
    Sec_QoS_results = security_methods(settings);
    
    disp('Utility calculation is started');
    [Selections, scan_ai_sim_vs_test] = utility_calc(Sec_QoS_results,settings);
    plot_utility(Selections,settings);
    
    disp('Simulations and Test are comparing');
    load test_results.mat
    plot_sim_vs_test(scan_ai_sim_vs_test,settings);
    
    disp('The program is terminated');
    
elseif (CCPSStart == 2)
    load Sec_QoS_results.mat
    disp('Data Loaded');
    
    disp('Utility calculation is started');
    [Selections, scan_ai_sim_vs_test] = utility_calc(Sec_QoS_results,settings);
    plot_utility(Selections,settings);
    
    disp('Simulations and Test are comparing');
    load test_results.mat
    plot_sim_vs_test(scan_ai_sim_vs_test,settings);
    
    disp('The program is terminated');
end
