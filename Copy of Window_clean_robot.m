close all
clear all
clc
% start positon 
Start_Pos=[5 10]
moter_one_Pos=[0 10]
moter_two_Pos=[10 10]

destination=[]
prompt = {'Enter destination 1 x coordinate:','Enter  destination 1 y coordinate:' 'Enter destination 2 x coordinate:','Enter  destination 2 y coordinate:'};
dlgtitle = 'Input';
dims = [1 35];
definput = {'8','5' '6','2'};
answer = inputdlg(prompt,dlgtitle,dims,definput)
destinations=[str2num(answer{1}) str2num(answer{2}) str2num(answer{3}) str2num(answer{4})]
Lenghth2=[]
Lenghth1=[]
XX=[]
YY=[]

% list = {'vertical','horizontal'};
% [indx,tf] = listdlg('ListString',list);

%% make path

% make a matix of a paths 
destination1=[destinations(1,1) destinations(1,2)]
path=[Start_Pos ; destination1]

destination2=[destinations(1,3) destinations(1,4)]
Y_range=abs(destinations(1,4)-destinations(1,2))
X_range=abs(destinations(1,1)-destinations(1,3))


%if indx==2
    p=destination1(1,2)
for I=0:Y_range-2
    
    if destination1(1,2)> destination2(1,2)
        p=p-1
        
        Next_P=[destination1(1,1),p]
        path=[path ; Next_P]
        Next_P=[destination2(1,1),p]
        path=[path ; Next_P]
        p=p-1
        Next_P=[destination2(1,1),p]
        path=[path ; Next_P]
        Next_P=[destination1(1,1),p]
        path=[path ; Next_P]
        
    end
    
    if destination1(1,2)< destination2(1,2)
        p=p+1
    end
    
end
%end

%if indx==1
    
% for I=0:X_range-2
%     p=destination1(1,1)
%     if destination1(1,2)> destination2(1,2)
%         
%         Next_P=[p,destination2(1,2)]
%         path=[path ; Next_P]
%         p=p-1
%         Next_P=[p,destination2(1,2)]
%         path=[path ; Next_P]
%         Next_P=[p,destination1(1,2)]
%         path=[path ; Next_P]
%         p=p-1
%         Next_P=[p,destination1(1,2)]
%         path=[path ; Next_P]
%         Next_P=[p,destination2(1,2)]
%         path=[path ; Next_P]
%         
%     end
%     
%     if destination1(1,2)< destination2(1,2)
%         p=p+1
%     end
%     
% end
%end

jdj=size(path)
for test=1:jdj(1,1)
plot(path(test,1),path(test,2),'s--g')
hold on
end 


% path=[path; ]
%%
for D=2:jdj(1,1)


        destination=[path(D,1) path(D,2)]
        Start_Pos=[path(D-1,1) path(D-1,2)]
    

% equation of a line to from start point to destination
m=(Start_Pos(1,2)-destination(1,2))/(Start_Pos(1,1)-destination(1,1))

 X=[]
 Y=[]

if Start_Pos(1,1)< destination(1,1)
    for x=Start_Pos(1,1):.1:destination(1,1)
        
        y=(m*(x-Start_Pos(1,1))+ Start_Pos(1,2));
        
        X=[X x];
        Y=[Y y];
    end
end

if Start_Pos(1,1)> destination(1,1)
    for x=destination(1,1):.1:Start_Pos(1,1)
        
        %y=(m*(x-Start_Pos(1,1))+ Start_Pos(1,2));
        y=(m*(x-destination(1,1))+ destination(1,2));
        
        X=[x X]
        Y=[y Y]
    end   
end

if Start_Pos(1,1)== destination(1,1)
    
    if Start_Pos(1,2)< destination(1,2)
    
    for y=Start_Pos(1,2):.1:destination(1,2)
        
        %y=(m*(x-Start_Pos(1,1))+ Start_Pos(1,2));
        x=Start_Pos(1,1)
        
        X=[X x]
        Y=[Y y]
    end   
    
    end
    
    if destination(1,2)< Start_Pos(1,2)
    
    for y=destination(1,2):.1:Start_Pos(1,2)
        
        %y=(m*(x-Start_Pos(1,1))+ Start_Pos(1,2));
        x=Start_Pos(1,1)
        
        X=[x X]
        Y=[y Y]
    end   
    
    end
    
    
end

s=size(X);
% calculate length of moter 1 rope
% Lenghth1=[]
for i=1:s(1,2)
d1=(((moter_one_Pos(1,1)-X(1,i))^2)+((moter_one_Pos(1,2)-Y(1,i))^2))^(1/2);
Lenghth1=[Lenghth1 d1];
end

% calculate length of moter 2 rope
% Lenghth2=[]
for i=1:s(1,2)
d1=(((moter_two_Pos(1,1)-X(1,i))^2)+((moter_two_Pos(1,2)-Y(1,i))^2))^(1/2);
Lenghth2=[Lenghth2 d1];
end

% vidObj = VideoWriter('window.avi');
% vidObj.FrameRate = 10;
% open(vidObj);

for i=1:s(1,2)
    
figure(1)
hold on
plot(Start_Pos(1,1),Start_Pos(1,2),'s--g')
plot(destination(1,1),destination(1,2),'s--g')

plot(X,Y,'--')
plot([moter_one_Pos(1,1) Start_Pos(1,1)],[moter_one_Pos(1,2) Start_Pos(1,2)],'-r')
plot([moter_two_Pos(1,1) Start_Pos(1,1)],[moter_two_Pos(1,2) Start_Pos(1,2)],'-r')

plot([moter_one_Pos(1,1) X(1,i)],[moter_one_Pos(1,2) Y(1,i)],'-r')
plot([moter_two_Pos(1,1) X(1,i)],[moter_two_Pos(1,2) Y(1,i)],'-r')

plot(moter_one_Pos(1,1),moter_one_Pos(1,2),'o--r')
plot(moter_two_Pos(1,1),moter_two_Pos(1,2),'o--r')
grid on 
axis([0 12 0 12])
% currFrame = getframe;
hold off
% writeVideo(vidObj,currFrame);
        
        
end


XX=[XX X]
YY=[YY Y]

end

figure(2)
hold on
plot(Lenghth2)
plot(Lenghth1)
hold off

Data=[]
Data(:,1)=XX(1,:)
Data(:,2)=YY(1,:)
Data(:,3)=Lenghth1(1,:)
Data(:,4)=Lenghth2(1,:)
% %%
% yc=[];
% xc=[];
% r=20
% for x=-20:.5:20
%     y=(r^2-x^2)^(1/2);
%     yc=[yc y];
%     xc=[xc x];
% end
% 
% start_y=(r^2-Start_Pos(1,1)^2)^(1/2);
% 
% 
% plot(Start_Pos(1,1),start_y,'s--g')
% hold on
% plot(xc,yc)
% axis([-20 20 0 30])