file1='Pulse_2.xlsx'; %select file containing pulse
file='Brachiocephalic.xlsx'; %select carotid or brachiocephalic
[status,sheets,xlFormat]= xlsfinfo(file);
%j=20;
heart_rate=[];
ecgp=xlsread(file,1);%select sheet here(1=Red, 2=IR, 3=Green)
    for j=1:1:20
            ecg1=ecgp(20:1600,(j)); %removing first 20 observations
%          figure, plot(ecg1);
            y=detrend(ecg1); %detrend complete ecg
            ecg=denoise(y,0.8,50); 
%          figure, plot(ecg);
            N=length(ecg); 
            x=1:1:N;
            D1=0;
%           figure, plot(ecg);
            xlabel('Sample value','FontSize',13);
            ylabel('Voltage','FontSize',13);
            if j<=5 %for 1st 5 settings (100Hz)
%             hold on;
                findpeaks(ecg,x,'MinPeakProminence',5, 'MinPeakDistance',45,'Annotate','extents');
%             hold off;
%             fs=100;
                [peaks1,locs1,w,prom]= findpeaks(ecg,x,'MinPeakProminence',5, 'MinPeakDistance',45,'Annotate','extents');
                %for i=1:1:length(locs1)
                   %if peaks1(i+1)-peakl(i)>110    
                if length(peaks1)>8
                    k=find(peaks1)>1000;
                    if any(k)>0
                        if sum(k==1)==0
                        peaks1(k)=peaks1(k-1);
                        locs1(k)=locs1(k-1);
                        else
                        peaks1(1)=peaks1(2);
                        locs1(1)=locs1(2);
                        k(1)=[];
                        peaks1(k)=peaks1(k-1);
                        locs1(k)=locs1(k-1);
                        end
                    end   
                else 
                peaks1(1:length(peaks1))=0;
                locs1(1:length(locs1))=0;
                end
                D1=diff(locs1);
                k=length(D1);
                D=0;
                loc=0;
                RR1=0;
                RR=0;
%               heart_rate(1:100,1:20)=0;
                avg_HR=0;
                l=1;
                t=1;
                 for i=1:1:k %selecting peaks
                    if(D1(i)>=50&&D1(i)<=150)
                        D(l)=D1(i); 
                        loc(l)=locs1(i);
                        l=l+1;

                    elseif (D1(i)>150)
                        if (i>1&&i<k&&l>1)
                            D(l)=(D1(i-1)+D1(i+1))/2;
                            loc(l)=locs1(i);
                            l=l+1;

                        end            
                    elseif (D1(i)<50&&D1(i)>25)
                    %elseif (D1(i)<66)
                        if (i>1&&i<k&&l>1)
                            X=D(l-1)+D1(i+1);
                            if (X>150)
                                D(l)=(D(l-1)+D1(i+1))/2;
                                loc(l)=locs1(i);
                                l=l+1;
                            elseif(X>50&&X<150)
                                D(l)=(D(l-1)+D1(i+1));
                                loc(l)=locs1(i);
                                l=l+1;
                            end
                        end                  
                    end

                 end


                RR = D./100; %gives the difference in Rpeaks in sec (has precision of milliseconds)[0.800 -> 800ms]

                for q=1:1:length(RR) 
                    disp (q);
                    heart_rate((q),(j))=60/RR(q);
                end
            elseif j>5 && j<=10 %for settings 6-10 (50Hz)
                 %          hold on;
            findpeaks(ecg,x,'MinPeakProminence',5, 'MinPeakDistance',25,'Annotate','extents');
%           hold off;
%             fs=100;
            [peaks1,locs1,w,prom]= findpeaks(ecg,x,'MinPeakProminence',5, 'MinPeakDistance',25,'Annotate','extents');
                 if length(peaks1)>15
                    k=find(peaks1)>1000;
                    if any(k)>0
                        if sum(k==1)==0
                        peaks1(k)=peaks1(k-1);
                        locs1(k)=locs1(k-1);
                        else
                        peaks1(1)=peaks1(2);
                        locs1(1)=locs1(2);
                        k(1)=[];
                        peaks1(k)=peaks1(k-1);
                        locs1(k)=locs1(k-1);
                        end
                    end   
                else 
                peaks1(1:length(peaks1))=0;
                locs1(1:length(locs1))=0;
                end
            D1=diff(locs1);
            k=length(D1);
            D=0;
            loc=0;
            RR1=0;
            RR=0;
%             heart_rate(1:100,1:20)=0;
            avg_HR=0;
            l=1;
            t=1;
                 for i=1:1:k
                    if(D1(i)>=25&&D1(i)<=75)
                        D(l)=D1(i); 
                        loc(l)=locs1(i);
                        l=l+1;

                    elseif (D1(i)>75)
                        if (i>1&&i<k&&l>1)
                            D(l)=(D1(i-1)+D1(i+1))/2;
                            loc(l)=locs1(i);
                            l=l+1;

                        end            
                    elseif (D1(i)<25&&D1(i)>13)
                    %elseif (D1(i)<66)
                        if (i>1&&i<k&&l>1)
                            X=D(l-1)+D1(i+1);
                            if (X>75)
                                D(l)=(D(l-1)+D1(i+1))/2;
                                loc(l)=locs1(i);
                                l=l+1;
                            elseif(X>25&&X<75)
                                D(l)=(D(l-1)+D1(i+1));
                                loc(l)=locs1(i);
                                l=l+1;
                            end
                        end                  
                    end

                 end


                RR = D./50; %gives the difference in Rpeaks in sec (has precision of milliseconds)[0.800 -> 800ms]

                for q=1:1:length(RR)
                    disp (q);
                    heart_rate((q),(j))=60/RR(q);
                end
            elseif j>10 && j<=15 %for settings 11- 15(100Hz)
                 %          hold on;
            findpeaks(ecg,x,'MinPeakProminence',5, 'MinPeakDistance',45,'Annotate','extents');
%             hold off;
%             fs=100;
            [peaks1,locs1,w,prom]= findpeaks(ecg,x,'MinPeakProminence',5, 'MinPeakDistance',45,'Annotate','extents');
              if length(peaks1)>8
                    k=find(peaks1)>1000;
                    if any(k)>0
                        if sum(k==1)==0
                        peaks1(k)=peaks1(k-1);
                        locs1(k)=locs1(k-1);
                        else
                        peaks1(1)=peaks1(2);
                        locs1(1)=locs1(2);
                        k(1)=[];
                        peaks1(k)=peaks1(k-1);
                        locs1(k)=locs1(k-1);
                        end
                    end   
                else 
                peaks1(1:length(peaks1))=0;
                locs1(1:length(locs1))=0;
                end
            D1=diff(locs1);
            k=length(D1);
            D=0;
            loc=0;
            RR1=0;
            RR=0;
%             heart_rate(1:100,1:20)=0;
            avg_HR=0;
            l=1;
            t=1;
                  for i=1:1:k
                    if(D1(i)>=50&&D1(i)<=150)
                        D(l)=D1(i); 
                        loc(l)=locs1(i);
                        l=l+1;

                    elseif (D1(i)>150)
                        if (i>1&&i<k&&l>1)
                            D(l)=(D1(i-1)+D1(i+1))/2;
                            loc(l)=locs1(i);
                            l=l+1;

                        end            
                    elseif (D1(i)<50&&D1(i)>25)
                    %elseif (D1(i)<66)
                        if (i>1&&i<k&&l>1)
                            X=D(l-1)+D1(i+1);
                            if (X>150)
                                D(l)=(D(l-1)+D1(i+1))/2;
                                loc(l)=locs1(i);
                                l=l+1;
                            elseif(X>50&&X<150)
                                D(l)=(D(l-1)+D1(i+1));
                                loc(l)=locs1(i);
                                l=l+1;
                            end
                        end                  
                    end

                 end


                RR = D./100; %gives the difference in Rpeaks in sec (has precision of milliseconds)[0.800 -> 800ms]

                for q=1:1:length(RR)
                    disp (q);
                    heart_rate((q),(j))=60/RR(q);
                end
            elseif j>15 && j<=20 %for 1st 16-20 settings (50Hz)
                 %          hold on;
            findpeaks(ecg,x,'MinPeakProminence',5, 'MinPeakDistance',25,'Annotate','extents');
%             hold off;
%             fs=100;
            [peaks1,locs1,w,prom]= findpeaks(ecg,x,'MinPeakProminence',5, 'MinPeakDistance',25,'Annotate','extents');
               if length(peaks1)>15
                    k=find(peaks1)>1000;
                    if any(k)>0
                        if sum(k==1)==0
                        peaks1(k)=peaks1(k-1);
                        locs1(k)=locs1(k-1);
                        else
                        peaks1(1)=peaks1(2);
                        locs1(1)=locs1(2);
                        k(1)=[];
                        peaks1(k)=peaks1(k-1);
                        locs1(k)=locs1(k-1);
                        end
                    end   
                else 
                peaks1(1:length(peaks1))=0;
                locs1(1:length(locs1))=0;
                end
            D1=diff(locs1);
            k=length(D1);
            D=0;
            loc=0;
            RR1=0;
            RR=0;
%             heart_rate(1:100,1:20)=0;
            avg_HR=0;
            l=1;
            t=1;
                 for i=1:1:k
                    if(D1(i)>=25&&D1(i)<=75)
                        D(l)=D1(i); 
                        loc(l)=locs1(i);
                        l=l+1;

                    elseif (D1(i)>75)
                        if (i>1&&i<k&&l>1)
                            D(l)=(D1(i-1)+D1(i+1))/2;
                            loc(l)=locs1(i);
                            l=l+1;

                        end            
                    elseif (D1(i)<25&&D1(i)>13)
                    %elseif (D1(i)<66)
                        if (i>1&&i<k&&l>1)
                            X=D(l-1)+D1(i+1);
                            if (X>75)
                                D(l)=(D(l-1)+D1(i+1))/2;
                                loc(l)=locs1(i);
                                l=l+1;
                            elseif(X>25&&X<75)
                                D(l)=(D(l-1)+D1(i+1));
                                loc(l)=locs1(i);
                                l=l+1;
                            end
                        end                  
                    end

                 end


                RR = D./50; %gives the difference in Rpeaks in sec (has precision of milliseconds)[0.800 -> 800ms]
                for q=1:1:length(RR)
                    disp (q);
                    heart_rate((q),(j))=60/RR(q);
                end
                
            end
    end
   
    %%  %% Replacing 0 values in heart_rate with NaN
        
        for j1=1:1:20 
            for i1=1:1:size(heart_rate,1)
                if(heart_rate((i1),(j1))==0)
                    heart_rate((i1),(j1))=NaN;
                end
            end
        end
                
        %% 25-75 percentile values
   
  pr_heart_rate=[]; 
  for j2=1:1:20
      for i2 = 1:1:size(heart_rate,1)
         if((heart_rate(i2,(j2))>= prctile(heart_rate(:,(j2)),25)) && (heart_rate(i2,(j2))<= prctile(heart_rate(:,(j2)),75)) )
          pr_heart_rate((i2),(j2))= heart_rate((i2),(j2));
          
         end
      end
  end
  
  %% Original pulse rate
  %pulse recorded every minute
  
pulse=xlsread(file1,1);
pulse1=pulse(1,1);
pulse2=pulse(2,1);
pulse3=pulse(3,1);
pulse4=pulse(4,1);
pulse5=pulse(5,1);
pulse6=pulse(6,1);
pulse7=pulse(7,1);
pulse8=pulse(8,1);

%% rmse calculation
%distribution of settings is approx. with +- 10 secs
rms=[];
for j=1:1:20
    if j<=4 %first 4 setings are in 1 minute
        for i=1:1:size(pr_heart_rate,1)
            if(pr_heart_rate((i),(j))>0)
                rms((i),(j))= pr_heart_rate((i),(j))-pulse1;
            end
        end
    elseif j>4 && j<=7 %setings 5-7 are in next 1 minute
        for i=1:1:size(pr_heart_rate,1)
            if(pr_heart_rate((i),(j))>0)
                rms((i),(j))= pr_heart_rate((i),(j))-pulse2;
            end
        end
    elseif j<=8 %setings 8 is in next 1 minute
        for i=1:1:size(pr_heart_rate,1)
            if(pr_heart_rate((i),(j))>0)
                rms((i),(j))= pr_heart_rate((i),(j))-pulse3;
            end
        end
    elseif j>8 && j<=11 %setings 9-11 are in next 1 minute
        for i=1:1:size(pr_heart_rate,1)
            if(pr_heart_rate((i),(j))>0)
                rms((i),(j))= pr_heart_rate((i),(j))-pulse4;
            end
        end
    elseif j>11 && j<=15 %setings 12-15 are in next 1 minute
        for i=1:1:size(pr_heart_rate,1)
            if(pr_heart_rate((i),(j))>0)
                rms((i),(j))= pr_heart_rate((i),(j))-pulse5;
            end
        end
    elseif j==16 %setings 16 are in next 1 minute
        for i=1:1:size(pr_heart_rate,1)
            if(pr_heart_rate((i),(j))>0)
                rms((i),(j))= pr_heart_rate((i),(j))-pulse6;
            end
        end
    elseif j>16 && j<=18 %setings 17-18 are in next 1 minute
        for i=1:1:size(pr_heart_rate,1)
            if(pr_heart_rate((i),(j))>0)
                rms((i),(j))= pr_heart_rate((i),(j))-pulse7;
            end
        end
    elseif j>18 && j<=20 %setings 19-20 are in next 1 minute
        for i=1:1:size(pr_heart_rate,1)
            if(pr_heart_rate((i),(j))>0)
                rms((i),(j))= pr_heart_rate((i),(j))-pulse8;
            end
        end
    end
            
end


 for j1=1:1:20
            for i1=1:1:size(pr_heart_rate,1)
                if(rms((i1),(j1))==0)
                    rms((i1),(j1))=NaN;
                end
            end
 end
 
rmse= rms.^2;
mean1 = mean(rmse,1,'omitnan','double');
 
 RMSE=[];
 for i=1:1:20
      
            RMSE(1,(i)) = sqrt(mean1(1,i));
 end
 
RMSE1=RMSE'; %taking transpose
 
  %% Finding median & mean predicted heart-rate corresponding to every setting 
  for j1=1:1:20
            for i1=1:1:size(pr_heart_rate,1)
                if(pr_heart_rate((i1),(j1))==0)
                    pr_heart_rate((i1),(j1))=NaN;
                end
            end
   end
  
  
  median_mean_heart_rate=[];
  for k=1:1:20
      median_mean_heart_rate(k,1)= mean(pr_heart_rate(:,k),'omitnan')
      median_mean_heart_rate(k,2)= median(pr_heart_rate(:,k),'omitnan')

  end
 
  