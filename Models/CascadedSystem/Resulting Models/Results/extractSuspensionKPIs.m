function T = extractSuspensionKPIs()

% Find all simulation outputs in base workspace
vars = evalin('base','whos');

simNames = {};
results = [];

for k = 1:length(vars)

    name = vars(k).name;
    simOut = evalin('base',name);

    % Only Simulink simulation outputs
    if ~isa(simOut,'Simulink.SimulationOutput')
        continue
    end

    % Store simulation name
    simNames{end+1,1} = name;

    %% =========================
    %  BODY ACCELERATION (ISO 2631 simplified)
    %% =========================
    try
        a = simOut.BodyAcceleration;
        t = a.time(:);
        y = a.signals.values(:);

        % Remove DC (comfort is vibration, not bias)
        y0 = y - mean(y);

        BA_RMS   = sqrt(mean(y0.^2));
        BA_STD   = std(y0);
        BA_PEAK  = max(abs(y0));

        % Vibration dose value (shock sensitivity)
        BA_VDV = (trapz(t, y0.^4))^(1/4);

    catch
        BA_RMS = NaN; BA_STD = NaN; BA_PEAK = NaN; BA_VDV = NaN;
    end

    %% =========================
    %  ROAD HOLDING (Tyre load variation)
    %% =========================
    try
        r = simOut.RoadHolding;
        t = r.time(:);
        y = r.signals.values(:);

        y0 = y - mean(y);

        RH_RMS  = sqrt(mean(y0.^2));
        RH_PEAK = max(abs(y0));
        RH_STD  = std(y0);

        % Road Holding Index (normalized stability)
        Fz0 = mean(y);
        RH_INDEX = 1 - (RH_RMS / abs(Fz0));

    catch
        RH_RMS = NaN; RH_PEAK = NaN; RH_STD = NaN; RH_INDEX = NaN;
    end

    %% =========================
    %  POWER / ENERGY (optional regen systems)
    %% =========================
    try
        p = simOut.Power;
        t = p.time(:);
        y = p.signals.values(:);

        P_PEAK = max(y);
        P_RMS  = sqrt(mean(y.^2));

        % harvested energy (only positive contribution)
        E_HARVEST = trapz(t, max(y,0));

        % total energy magnitude
        E_TOTAL = trapz(t, abs(y));

    catch
        P_PEAK = NaN; P_RMS = NaN;
        E_HARVEST = NaN; E_TOTAL = NaN;
    end

    %% =========================
    % Store row
    %% =========================
    results = [results;
        BA_RMS, BA_STD, BA_PEAK, BA_VDV,...
        RH_RMS, RH_STD, RH_PEAK, RH_INDEX,...
        P_PEAK, P_RMS, E_HARVEST, E_TOTAL];

end

%% =========================
% Build final table
%% =========================
T = array2table(results,...
    'VariableNames', {
    'BA_RMS','BA_STD','BA_PEAK','BA_VDV',...
    'RH_RMS','RH_STD','RH_PEAK','RH_INDEX',...
    'P_PEAK','P_RMS','E_HARVEST','E_TOTAL'});

T.Simulation = simNames;

% Reorder columns (nice for thesis tables)
T = movevars(T,'Simulation','Before',1);

disp(T)

% Optional export
writetable(T,'Thesis_KPI_Table.xlsx');

end