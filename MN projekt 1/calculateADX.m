function adxVal = calculateADX(high, low, close, N, M)
  
    tmpTR=max( [high-low;...
        abs(high - [ high(1) close(1:end-1)]);...
        abs(low - [ low(1) close(1:end-1)])  ]);
    win=ones(1,N);
    TR=conv(tmpTR,win);
    TR=TR(1:end-N+1);
    
    % high and low Directional
    HD = high-[ high(1) high(1:end-1)]; 
    LD = [ low(1) low(1:end-1)]-low;
    
    % init 
    tmpDMP=zeros(size(HD));
    tmpDMM=zeros(size(LD));
    
    % find data for +DM
    index=HD>0 & HD>LD;
    tmpDMP(index)= HD(index); 
    win=ones(1,N);
    DMP=conv(tmpDMP,win);
    DMP=DMP(1:end-N+1);
    
    % find data for -DM
    index=LD>0 & LD>HD;
    tmpDMM(index)= LD(index);
    win=ones(1,N);
    DMM=conv(tmpDMM,win);
    DMM=DMM(1:end-N+1);
    
    % calc +DM and -DM
    PDI= (DMP*100)./TR;
    MDI= (DMM*100)./TR;
    
    % calc Directional Movement Index
    win=ones(1,M);
    tmpADX=([abs(MDI-PDI)]./[(MDI+PDI)])*100;
    tmpADX(1)=tmpADX(2); %remove inf
    adxVal= conv(tmpADX,win)/M;
    adxVal= adxVal(1:end-M+1);
end

%do zrobienia algorytmu ADX wykorzystywałem te źródła:https://www.mathworks.com/matlabcentral/fileexchange/75414-adx-directional-movement-system
%https://www.investopedia.com/articles/trading/07/adx-trend-indicator.asp
%https://en.wikipedia.org/wiki/Average_directional_movement_index
