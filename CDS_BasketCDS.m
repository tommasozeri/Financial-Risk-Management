% Interest-rate curve
ZeroDates = datenum({'17-Jan-10','17-Jul-10','17-Jul-11','17-Jul-12',...
'17-Jul-13','17-Jul-14'});
ZeroRates = [1.35 1.43 1.9 2.47 2.936 3.311]'/100;
ZeroData = [ZeroDates ZeroRates];

% CDS spreads
% Each row in MarketSpreads corresponds to a different issuer; each
% column to a different maturity date (corresponding to MarketDates)
MarketDates = datenum({'20-Sep-10','20-Sep-11','20-Sep-12','20-Sep-14',...
'20-Sep-16'});
MarketSpreads = [
   160 195 230 285 330;
   130 165 205 260 305;
   150 180 210 260 300;
   165 200 225 275 295];
% Number of issuers equals number of rows in MarketSpreads
nIssuers = size(MarketSpreads,1);

% Settlement date
Settle = datenum('17-Jul-2009');

ProbDates = union(MarketDates,daysadd(Settle,360*(0.25:0.25:8),1));
nProbDates = length(ProbDates);
DefProb = zeros(nIssuers,nProbDates);

for ii = 1:nIssuers
   MarketData = [MarketDates MarketSpreads(ii,:)'];
   ProbData = cdsbootstrap(ZeroData,MarketData,Settle,...
      'ProbDates',ProbDates);
   DefProb(ii,:) = ProbData(:,2)';
end

figure
plot(ProbDates',DefProb)
datetick
title('Individual Default Probability Curves')
ylabel('Cumulative Probability')
xlabel('Date')

DefThresh = norminv(DefProb);

beta = sqrt(0.25)*ones(nIssuers,1);

FTDSurvProb = zeros(size(ProbDates));
for jj = 1:nProbDates
   % Vectorized conditional probability as a function of Z
   vecCondProb = @(Z)prod(normcdf(bsxfun(@rdivide,...
      -repmat(DefThresh(:,jj),1,length(Z))+bsxfun(@times,beta,Z),...
      sqrt(1-beta.^2))));
   % Truncate domain of normal distribution to [-5,5] interval
   FTDSurvProb(jj) = integral(@(Z)vecCondProb(Z).*normpdf(Z),-5,5);
end
FTDDefProb = 1-FTDSurvProb;

figure
plot(ProbDates',DefProb)
datetick
hold on
plot(ProbDates,FTDDefProb,'LineWidth',3)
datetick
hold off
title('FTD and Individual Default Probability Curves')
ylabel('Cumulative Probability')
xlabel('Date')

Maturity = MarketDates;
ProbDataFTD = [ProbDates, FTDDefProb];
FTDSpread = cdsspread(ZeroData,ProbDataFTD,Settle,Maturity);

figure
plot(MarketDates,MarketSpreads')
datetick
hold on
plot(MarketDates,FTDSpread,'LineWidth',3)
hold off
title('FTD and Individual CDS Spreads')
ylabel('FTD Spread (bp)')
xlabel('Maturity Date')

Maturity0 = MarketDates(1); % Assume maturity on nearest market date
Spread0 = 540; % Spread of existing FTD contract
% Assume default values of recovery and notional
FTDPrice = cdsprice(ZeroData,ProbDataFTD,Settle,Maturity0,Spread0);
fprintf('Price of existing FTD contract: %g\n',FTDPrice)

corr = [0 0.01 0.10 0.25 0.5 0.75 0.90 0.99 1];
FTDSpreadByCorr = zeros(length(Maturity),length(corr));
FTDSpreadByCorr(:,1) = sum(MarketSpreads)';
FTDSpreadByCorr(:,end) = max(MarketSpreads)';

for ii = 2:length(corr)-1
   beta = sqrt(corr(ii))*ones(nIssuers,1);
   FTDSurvProb = zeros(length(ProbDates));
   for jj = 1:nProbDates
      % Vectorized conditional probability as a function of Z
      condProb = @(Z)prod(normcdf(bsxfun(@rdivide,...
         -repmat(DefThresh(:,jj),1,length(Z))+bsxfun(@times,beta,Z),...
         sqrt(1-beta.^2))));
      % Truncate domain of normal distribution to [-5,5] interval
      FTDSurvProb(jj) = integral(@(Z)condProb(Z).*normpdf(Z),-5,5);
   end
   FTDSurvProb = FTDSurvProb(:,1);
   FTDDefProb = 1-FTDSurvProb;
   ProbDataFTD = [ProbDates, FTDDefProb];
   FTDSpreadByCorr(:,ii) = cdsspread(ZeroData,ProbDataFTD,Settle,Maturity);
end

figure
legends = cell(1,length(corr));
plot(MarketDates,FTDSpreadByCorr(:,1),'k:')
legends{1} = 'Sum of Spreads';
datetick
hold on
for ii = 2:length(corr)-1
   plot(MarketDates,FTDSpreadByCorr(:,ii),'LineWidth',3*corr(ii))
   legends{ii} = ['Corr ' num2str(corr(ii)*100) '%'];
end
plot(MarketDates,FTDSpreadByCorr(:,end),'k-.')
legends{end} = 'Max of Spreads';

hold off
title('FTD Spreads for Different Correlations')
ylabel('FTD Spread (bp)')
xlabel('Maturity Date')
legend(legends,'Location','NW')

figure
surf(corr,MarketDates,FTDSpreadByCorr)
datetick('y')
ax = gca;
ax.YDir = 'reverse';
view(-40,10)
title('FTD Spreads for Different Correlations and Maturities')
xlabel('Correlation')
ylabel('Maturity Date')
zlabel('FTD Spread (bp)')

PROVA PROVA PROVA 
