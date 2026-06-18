function T = analyzeWorkspaceSimulations()

signalsToAnalyze = {'BodyAcceleration','RoadHolding','Power'};

workspaceVars = evalin('base','whos');

Simulation = {};
Variable = {};
IntegralAbs = [];
MeanAbs = [];
StdDev = [];
RMSVal = [];
PeakAbs = [];

for k = 1:length(workspaceVars)

    workspaceName = workspaceVars(k).name;
    simOut = evalin('base',workspaceName);

    % Only process SimulationOutput objects
    if ~isa(simOut,'Simulink.SimulationOutput')
        continue
    end

    for s = 1:length(signalsToAnalyze)

        signalName = signalsToAnalyze{s};

        try

            signal = simOut.(signalName);

            t = signal.time(:);
            y = signal.signals.values(:);

            Simulation{end+1,1} = workspaceName;
            Variable{end+1,1} = signalName;

            IntegralAbs(end+1,1) = trapz(t,abs(y));
            MeanAbs(end+1,1) = mean(abs(y));
            StdDev(end+1,1) = std(y);
            RMSVal(end+1,1) = rms(y);
            PeakAbs(end+1,1) = max(abs(y));

        catch
            % Signal does not exist
        end

    end

end

T = table( ...
    Simulation,...
    Variable,...
    IntegralAbs,...
    MeanAbs,...
    StdDev,...
    RMSVal,...
    PeakAbs,...
    'VariableNames',...
    {'Simulation',...
     'Variable',...
     'IntegralAbs',...
     'MeanAbs',...
     'StdDev',...
     'RMS',...
     'PeakAbs'});

disp(T)

writetable(T,'SimulationMetrics.xlsx');

fprintf('Found %d signals across %d simulations.\n',height(T),numel(unique(T.Simulation)));

end