function generate_road_scenarios()
    % Simulation time parameters
    dt = 0.005;         % 5 ms sampling time
    T_end = 1;          % 1 second of simulation
    t = 0:dt:T_end;     % Time vector

    %% Generate Scenario 1 & 2: Deterministic Sinusoidal Inputs
    % Scenario 1: 1.3 Hz (Sprung mass resonance)
    d1 = 0.03 * sin(2 * pi * 1.3 * t);
    
    % Scenario 2: 10.9 Hz (Unsprung mass resonance)
    d2 = 0.03 * sin(2 * pi * 10.9 * t);

    %% Helper Function for Scenarios 3 to 6: ISO 8608 Random Road
    function d = generate_iso_road(t, v_kmh, class_Gd)
        v_ms = v_kmh / 3.6;     % Convert km/h to m/s
        x = v_ms * t;           % Convert time to spatial coordinate
        
        % Spatial frequency parameters (cycles/m)
        n0 = 0.1;               
        dn = 0.01;              
        n = 0.01:dn:10;         
        
        % Fix the random seed so the road shape is consistent across speeds
        rng(42); 
        phi = 2 * pi * rand(size(n));
        
        % Calculate PSD and Harmonic Amplitudes
        Gd = class_Gd * (n ./ n0).^(-2);
        A = sqrt(2 * Gd * dn);
        
        % Superposition of harmonics
        d = zeros(size(x));
        for k = 1:length(n)
            d = d + A(k) * cos(2 * pi * n(k) * x + phi(k));
        end
        
        % Remove the static offset so the window starts centered around zero
        d = d - mean(d);
    end

    %% Generate Scenario 3 to 6: Stochastic ISO 8608 Inputs
    % Reference roughness degrees Gd(n0) in m^3
    Gd_B = 64e-6;   % Class B
    Gd_D = 1024e-6; % Class D
    
    % Scenario 3: Class B at 120 km/h
    d3 = generate_iso_road(t, 120, Gd_B);
    
    % Scenario 4: Class B at 40 km/h
    d4 = generate_iso_road(t, 40, Gd_B);
    
    % Scenario 5: Class D at 60 km/h
    d5 = generate_iso_road(t, 60, Gd_D);
    
    % Scenario 6: Class D at 40 km/h
    d6 = generate_iso_road(t, 40, Gd_D);

    %% Plotting the 6 Figures
    scenarios = {d1, d2, d3, d4, d5, d6};

    for i = 1:6
        % Create figure with a clean white background
        figure('Name', sprintf('Scenario %d', i), 'Color', 'w', 'Position', [100+(i*30), 100+(i*30), 800, 300]);
        
        % Plot the data
        plot(t, scenarios{i}, 'b', 'LineWidth', 1.2);
        
        % Labels with explicit black text
        xlabel('Time $t$ [s]', 'Interpreter', 'latex', 'FontSize', 12, 'Color', 'k');
        ylabel('Displacement $d(t)$ [m]', 'Interpreter', 'latex', 'FontSize', 12, 'Color', 'k');
        
        % Grid and Axes formatting
        grid on;
        ax = gca;
        ax.Color = 'w';             % Axis background white
        ax.XColor = 'k';            % X-axis line and ticks black
        ax.YColor = 'k';            % Y-axis line and ticks black
        ax.GridColor = 'k';         % Grid lines black
        ax.GridAlpha = 0.15;        % Slight transparency for grid lines
        ax.TickLabelInterpreter = 'latex'; % Matches axis numbers to LaTeX font
        ax.Box = 'on';              % Adds a full bounding box around the plot
        
        % Lock the X-axis to 1 second
        xlim([0 T_end]);
        
        % Lock the Y-axis ONLY for the sine waves. Let ISO roads auto-scale.
        if i <= 2
            ylim([-0.04 0.04]); 
        else
            % Add a 10% vertical padding so the stochastic peaks don't hit the axis box
            y_limits = ylim;
            y_range = y_limits(2) - y_limits(1);
            ylim([y_limits(1) - 0.1*y_range, y_limits(2) + 0.1*y_range]);
        end
    end
end