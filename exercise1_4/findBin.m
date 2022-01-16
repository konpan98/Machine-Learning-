function index = findBin(value, binEnds)
    numBins = length(binEnds) - 1;
    % return the index of the bin where value belongs {1, ..., numBins}. 
    for i=1:length(value)
        index(i)=1*(binEnds(1)<=value(i) & value(i)<=binEnds(2))+2*(binEnds(2)<=value(i) & value(i)<=binEnds(3))+3*(value(i)>=binEnds(3));
    end
    
    
    
end