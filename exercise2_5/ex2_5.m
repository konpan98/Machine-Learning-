%%%%%%%%%%%%%%Bayesian estimation %%%%%%%%%%%%%%%%
H=[	3.1803
    	3.0208
    	6.3968
    	5.0169
    	4.0323
    	6.2086
    	5.3474
    	3.5154
    	7.0094
    	5.4343
    	7.2184
    	6.7070
    	3.9738
    	3.0621
    	4.8906
    	4.5041
    	3.7346
    	5.7467
        7.2327
        4.1803
        3.7299
        4.6305
    	5.9945
    	3.7187
    	3.1980 	];
    %%%%a%%%%%%%%%%%%%%%%%
    m0=0;
    s=(1.25)^2;
    s0=10*s;
    x=[-12:0.01:12];
   
    figure;
    for n=1:25
        Hn=H(1:n);
        Xn=mean(Hn,1);
        mn=((n*s0)/(n*s0 +s))*Xn +((s/n*s0+s))*m0;
        sn=(s0*s)/(n*s0 +s);
        norm_pdf=normpdf(x,mn,sn);
        
        subplot(5,5,n);
        plot(x,norm_pdf); 
    end
     
    %%%%b%%%%%%%%%%%%%%%%%
         m0=0;
    s=(1.25)^2;
    s0_vec=[0.01*s 0.1*s s 10*s];
    x=[-5:0.01:10];
   
    figure;
    for n=1:4
        s0=s0_vec(n);
        Xn=mean(H,1);
        mn=((n*s0)/(n*s0 +s))*Xn +((s/n*s0+s))*m0;
        sn=(s0*s)/(n*s0 +s);
        sfinal=sn+s;
        norm_pdf=normpdf(x,mn,sfinal);
        
        subplot(2,2,n);
        plot(x,norm_pdf); 
    end
        

