%% OCHISTKA
close all
clear all
cla
%% VIBOR
disp ('Vvedite 1, esli hotite rabotat vrychnyy ili 0, esli hotite zagryzit dannie iz faila')
Q=input('');
if Q==1
    %% REGIM VRYCHNYY
    %% VVOD I POSTROENIE KOMNATI
    disp('Vvedite razmer komnati(v santimetrah')
    disp('Dlina=')
    a=input('');
    disp('Shirina')
    b=input('');
    disp('Vvedite shag')
    step=input('');
    disp ('Vvedite kolichestvo yglov v komnate')
    j=input('');%j-kolichestvo yglov komnati
    axis([0 a 0 b]);%Razmer komnati v santimetrah
    hold on;
    n=1;
    while n<=j
        [x,y]=ginput(1);
        plot(x,y,'k.','MarkerSize',20)
        BoxPos(1,n)=x;%BoxPos-Massiv s koordinatami yglov komnati
        BoxPos(2,n)=y;
        if n>1
            for n=n:n
                plot(BoxPos(1,(n-1):n),BoxPos(2,(n-1):n),'k','LineWidth',5)%Postroenie komnati
            end
        end
        n=n+1;
    end
    SizeBox=size(BoxPos);%%Proverka
    SizeBox1=SizeBox(1,2);
    if SizeBox1==0
        disp('Nevozmognie parametri komnaty')
        return
    end
    if SizeBox1==1
        disp('Nevozmognie parametri komnaty')
        return
    end
    if SizeBox1==2
        disp('Nevozmognie parametri komnaty')
        return
    end
    fileID=fopen('my_file.txt','w');%Sohranenie koordinat yglov v fail
    fprintf(fileID,'% 3.2f% 3.2f\r\n',BoxPos);
    fclose(fileID);
    BoxPos(1,n)=BoxPos(1,1);%Zapis' koordinat 1 ygla na poslednee mesto v massive(nygno dlya postroeniya)
    BoxPos(2,n)=BoxPos(2,1);
    plot(BoxPos(1,j:(j+1)),BoxPos(2,j:(j+1)),'k','LineWidth',5);%Soedinyaet poslednyy i pervyy tochky komnaty
    %% MASSIVI S KOORDINATAMI YGLOV KOMNATI PO OSYAM
    n=1;
    while n<=j
        aa(1,n)=BoxPos(1,n);%aa-Massiv s koordinatami komnati po osi OX
        bb(1,n)=BoxPos(2,n);%bb-Massiv s koordinatami komnati po osi OY
        n=n+1;
    end
    aa(1,n)=BoxPos(1,n);%Zapis' koordinat 1 ygla na poslednee mesto v massive(nygno dlya postroeniya)
    bb(1,n)=BoxPos(2,n);
    %% VVOD I RASSTANOVKA MAYAKOV
    disp ('Vvedite kolichestvo mayakov');
    k=input('');
    n=1;
    while n<=k%k-Kollichestvo mayakov
        [x,y]=ginput(1);
        plot(x,y,'ro');%Postroenie mayakov
        XM(n,1)=x;%XM-Massiv s koordinatami mayakov po osi OX
        YM(n,1)=y;%YM-Massiv s koordinatami mayakov po osi OY
        n=n+1;
    end
    SatPos=[XM,YM]';%SatPos-Massiv s koordinatami vseh mayakov
    SizePos=size(SatPos);%Proverka
    SizePos1=SizePos(1,2);
    if SizePos1==0
        disp('Nedopystimoe kolichestvo mayakov')
        return
    end
    if SizePos1==1
        disp('Nedopystimoe kolichestvo mayakov')
        return
    end
    fileID=fopen('my_file2.txt','w');%Sohranenie koordinat mayakov v fail
    fprintf(fileID,'% 3.2f% 3.2f\r\n',SatPos)
    fclose(fileID)
    %% MAYAKI VNE/VNYTRI KOMNATI
    [in,on]=inpolygon(XM,YM,aa,bb);
    plot(XM(in&~on),YM(in&~on),'g.','MarkerSize',20)%Mayaki v komnate
    plot(XM(~in),YM(~in),'r.','MarkerSize',20)%Mayaki vne komnati
    [in,on]=inpolygon(XM,YM,aa,bb);
    SatPos=[XM(in&~on),YM(in&~on)]';%Yberaym iz massiva mayaki vne komnati
    u=size(aa);
    u1=u(1,2);
    m=size(SatPos);
    m1=m(1,2);
    %% VIBOR METODA
    disp('Vvedite 1, esli hotite sdelat raschet po dalnomernomy metode ili 0, esli hotite sdelat raschet po raznostno-dalnomernomy')
    Q1=input('');
    if Q1==1
        %% DAL'NOMERNIY METOD
        %% VIDIMOST'
        D=SatPos;%D-Klon massiva s koordinatami mayakov
        for X=0:step:a
            for Y=0:step:b
                SatPos=D;
                SatPos1=[];
                i=1;
                n=1;
                while n<=m1
                    l=1;
                    while l<u1
                        x1=SatPos(1,n);%Koordinati
                        y1=SatPos(2,n);
                        x2=X;
                        y2=Y;
                        x3=aa(l);
                        y3=bb(l);
                        x4=aa(l+1);
                        y4=bb(l+1);
                        if y2==y1 || x1==x2
                            k1=0;
                        else
                            k1=(y2-y1)/(x2-x1);
                        end
                        if y3==y4 || x3==x4
                            k2=0;
                        else
                            k2=(y4-y3)/(x4-x3);
                        end
                        b1=(x2*y1-x1*y2)/(x2-x1);
                        b2=(x4*y3-x3*y4)/(x4-x3);
                        xp=(b2-b1)/(k1-k2);
                        yp=k1*(b2-b1)/(k1-k2)+b1;
                        x1k=x1;%Kloni koordinat
                        x2k=x2;
                        x3k=x3;
                        x4k=x4;
                        y1k=y1;
                        y2k=y2;
                        y3k=y3;
                        y4k=y4;
                        if x2<x1%SWAP koordinat dlya raschetov
                            x2=x1k;
                            x1=x2k;
                        end
                        if x4<x3
                            x3=x4k;
                            x4=x3k;
                        end
                        if y2<y1
                            y2=y1k;
                            y1=y2k;
                        end
                        if y4<y3
                            y3=y4k;
                            y4=y3k;
                        end
                        if k1~=k2 && b1~=b2 && x1<=xp && xp<=x2 && x3<=xp && xp<=x4 && y1<=yp && yp<=y2 && y3<=yp && yp<=y4%ysloviya peresecheniya otrezkov
                            SatPos(:,n)=0;%Zamenyaem na 0 koordinati mayaka, kotoriy ne vidno
                        end
                        l=l+1;
                    end
                    n=n+1;
                end
                n=1;
                CV=0;
                while n<=m1
                    if SatPos(1,n)==0
                        CV=CV+1;%Schitaem kolichestvo nyley
                    end
                    n=n+1;
                end
                if CV==m1
                    Z(Y+1,X+1)=0;%Esli vse nyli=vidimosi net
                else
                    n=1;
                    N=1;
                    while n<=m1
                        if SatPos(1,n)~=0
                            SatPos1(1,N)=SatPos(1,n);%Yberaem nyli i sozdaem vidimyi dlya tochki massiv
                            SatPos1(2,N)=SatPos(2,n);
                            N=N+1;
                        end
                        n=n+1;
                    end
                    SSR1=size(SatPos1);
                    SSR11=SSR1(1,2);
                    SSR12=SSR1(1,1);
                    if SSR11==0 || SSR12==0 || SSR11==1 || SSR12==1
                        Z(Y+1,X+1)=0;%Esli 0 ili 1 mayakov=vidimosti net
                    else
                        while i<=SSR11
                            r(i,1)=(X-SatPos1(1,i))/(sqrt((X-SatPos1(1,i))^2+(Y-SatPos1(2,i))^2));%r-Gradientnie matrici
                            r(i,2)=(Y-SatPos1(2,i))/(sqrt((X-SatPos1(1,i))^2+(Y-SatPos1(2,i))^2));
                            i=i+1;
                        end
                        Z(Y+1,X+1)=sqrt(trace(((r')*(r))^-1));%Z-Massiv so znacheniyami geometricheskogo factora v kagdoy tochke komnati
                        if Z(Y+1,X+1)>3%Ogranicheniya
                            Z(Y+1,X+1)=3;
                        end
                    end
                end
            end
        end
        %% YBIRAEM VIDIMOST' VNE KOMNATI
        for xq=0:step:a
            for yq=0:step:b
                [in,on]=inpolygon(xq,yq,aa,bb);
                if (on)>0
                    Z(yq+1,xq+1)=0;
                elseif (~in)>0
                    Z(yq+1,xq+1)=0;
                end
            end
        end
        %% POSSTROENIE GRAFIKA
        [X,Y]= meshgrid([0:1:a],[0:1:b]);
        surf(X,Y,Z)
        shading interp%Sglagivaem
        %% POSTROENIE 3D KOMNATI
        n=1;
        z=[3;3];
        while n<=j
            if n>1
                for n=n:n
                    plot3(BoxPos(1,(n-1):n),BoxPos(2,(n-1):n),z,'k','LineWidth',5)
                end
            end
            n=n+1;
        end
        plot3(BoxPos(1,j:(j+1)),BoxPos(2,j:(j+1)),z,'k','LineWidth',5)
        n=1;
        while n<=j
            XS(1,1)=BoxPos(1,n);
            XS(1,2)=BoxPos(1,n);
            YS(1,1)=BoxPos(2,n);
            YS(1,2)=BoxPos(2,n);
            ZS=[0 3];
            plot3(XS,YS,ZS,'k','LineWidth',5)
            n=n+1;
        end
        n=1;
        while n<=j
            x22=BoxPos(1,n);
            y22=BoxPos(2,n);
            plot3(x22,y22,z,'k.','MarkerSize',20)
            n=n+1;
        end
        n=1;
        %% MAYAKI SVERHY
        [in,on]=inpolygon(XM,YM,aa,bb);
        ins=size(XM(in&~on));
        inz=ins(1,1);
        ons=size(XM(~in));
        onz=ons(1,1);
        onr=1:onz;
        inr=1:inz;
        onr(1,:)=3;
        inr(1,:)=3;
        plot3(XM(in&~on),YM(in&~on),inr,'g.','MarkerSize',20)%Mayaki v komnate
        plot3(XM(~in),YM(~in),onr,'r.','MarkerSize',20)%Mayaki vne komnati
    elseif Q1==0
        %% RAZNOSTNO-DAL'NOMERNIY METOD
        XC=SatPos(1,m1);%koordinati glavnogo mayaka po osi OX
        YC=SatPos(2,m1);%koordinati glavnogo mayaka po osi OY
        plot(XC,YC,'ko','MarkerSize',10,'LineWidth',2)%Videlenie glavnogo mayaka
        n=1;
        while n<m1
            SatPosX(1,n)=SatPos(1,n);%Koordinaty obichnih mayakov
            SatPosX(2,n)=SatPos(2,n);
            n=n+1;
        end
        %% VIDIMOST'
        i=1;
        n=1;
        while n<m1
            l=1;
            while l<u1
                x1=SatPosX(1,n);%Koordinati
                y1=SatPosX(2,n);
                x2=XC;
                y2=YC;
                x3=aa(l);
                y3=bb(l);
                x4=aa(l+1);
                y4=bb(l+1);
                if y2==y1 || x1==x2
                    k1=0;
                else
                    k1=(y2-y1)/(x2-x1);
                end
                if y3==y4 || x3==x4
                    k2=0;
                else
                    k2=(y4-y3)/(x4-x3);
                end
                b1=(x2*y1-x1*y2)/(x2-x1);
                b2=(x4*y3-x3*y4)/(x4-x3);
                xp=(b2-b1)/(k1-k2);
                yp=k1*(b2-b1)/(k1-k2)+b1;
                x1k=x1;%Kloni koordinat
                x2k=x2;
                x3k=x3;
                x4k=x4;
                y1k=y1;
                y2k=y2;
                y3k=y3;
                y4k=y4;
                if x2<x1%SWAP koordinat dlya raschetov
                    x2=x1k;
                    x1=x2k;
                end
                if x4<x3
                    x3=x4k;
                    x4=x3k;
                end
                if y2<y1
                    y2=y1k;
                    y1=y2k;
                end
                if y4<y3
                    y3=y4k;
                    y4=y3k;
                end
                if k1~=k2 && b1~=b2 && x1<=xp && xp<=x2 && x3<=xp && xp<=x4 && y1<=yp && yp<=y2 && y3<=yp && yp<=y4%Ysloviya peresecheniya otrezkov
                    SatPosX(:,n)=0;%Zamenyaem na nol' koordinaty mayka esli tochka ego ne vidit
                end
                l=l+1;
            end
            n=n+1;
        end
        n=1;
        CV=0;
        while n<m1
            if SatPosX(1,n)==0
                CV=CV+1;%Schitaem nyli
            end
            n=n+1;
        end
        n=1;
        N=1;
        while n<m1
            if SatPosX(1,n)~=0
                SatPosX1(1,N)=SatPosX(1,n);%Yberaem nyli iz massiva i sozdaem massiv koordinat mayakov, kotorie vidit tochka
                SatPosX1(2,N)=SatPosX(2,n);
                N=N+1;
            elseif SatPosX(1,:)==0
                SatPosX1(1,:)=0;
                SatPosX1(2,:)=0;
            end
            n=n+1;
        end
        SizePosX=size(SatPosX1);
        SizePosX1=SizePosX(1,2);
        if SizePosX1==0
            disp('Nedopystimoe kolichestvo ili raspologenie mayakov')
            return
        end
        if SizePosX1==1
            disp('Nedopystimoe kolichestvo ili raspologenie mayakov')
            return
        end
        for X=1:step:a+1
            for Y=1:step:b+1
                l=1;
                flag=0;%Flag dlya opredeleniya vidimosi ot glavnogo mayaka
                while l<u1
                    x1=XC;%Peresechenie otrezkov
                    y1=YC;
                    x2=X;
                    y2=Y;
                    x3=aa(l);
                    y3=bb(l);
                    x4=aa(l+1);
                    y4=bb(l+1);
                    if y2==y1 || x1==x2
                        k1=0;
                    else
                        k1=(y2-y1)/(x2-x1);
                    end
                    if y3==y4 || x3==x4
                        k2=0;
                    else
                        k2=(y4-y3)/(x4-x3);
                    end
                    b1=(x2*y1-x1*y2)/(x2-x1);
                    b2=(x4*y3-x3*y4)/(x4-x3);
                    xp=(b2-b1)/(k1-k2);
                    yp=k1*(b2-b1)/(k1-k2)+b1;
                    x1k=x1;%Kloni koordinat
                    x2k=x2;
                    x3k=x3;
                    x4k=x4;
                    y1k=y1;
                    y2k=y2;
                    y3k=y3;
                    y4k=y4;
                    if x2<x1%SWAP koordinat dlya raschetov
                        x2=x1k;
                        x1=x2k;
                    end
                    if x4<x3
                        x3=x4k;
                        x4=x3k;
                    end
                    if y2<y1
                        y2=y1k;
                        y1=y2k;
                    end
                    if y4<y3
                        y3=y4k;
                        y4=y3k;
                    end
                    if k1~=k2 && b1~=b2 && x1<=xp && xp<=x2 && x3<=xp && xp<=x4 && y1<=yp && yp<=y2 && y3<=yp && yp<=y4%Ysloviya peresecheniya otrezkov
                        flag=1;
                    end
                    l=l+1;
                end
                if flag==1%1=net vidimosti
                    Z(Y,X)=0;
                elseif flag==0 %0=net vidimosti
                    Z(Y,X)=1;
                end
            end
        end
        SSR1=size(SatPosX1);
        SSR11=SSR1(1,2);
        SSR12=SSR1(1,1);
        if SatPosX(:,:)==0%Proverka
            disp('Vidimosti net');
        else
            for X=1:step:a+1
                for Y=1:step:b+1
                    if Z(Y,X)==1
                        i=1;
                        while i<=SSR11
                            r(i,1)=((X-SatPosX1(1,i))/(sqrt(((X-SatPosX1(1,i))^2)+((Y-SatPosX1(2,i))^2))))-((X-SatPos(1,m1))/(sqrt(((X-SatPos(1,m1))^2)+((Y-SatPos(2,m1))^2))));%r-Gradientnie matrici
                            r(i,2)=((Y-SatPosX1(2,i))/(sqrt(((X-SatPosX1(1,i))^2)+((Y-SatPosX1(2,i))^2))))-((Y-SatPos(2,m1))/(sqrt(((X-SatPos(1,m1))^2)+((Y-SatPos(2,m1))^2))));
                            i=i+1;
                        end
                        Z(Y,X)=sqrt(trace(((r')*(r))^-1));%Z-Massiv so znacheniyami geometricheskogo factora v kagdoy tochke komnati
                        if Z(Y,X)>3%Ogranicheniya
                            Z(Y,X)=3;
                        end
                    end
                end
            end
            %% VIDIMOST' VNE KOMNATI
            for xq=0:step:a
                for yq=0:step:b
                    [in,on]=inpolygon(xq,yq,aa,bb);
                    if (on)>0
                        Z(yq+1,xq+1)=0;
                    elseif (~in)>0
                        Z(yq+1,xq+1)=0;
                    end
                end
            end
            %% POSSTROENIE GRAFIKA
            [X,Y]= meshgrid([0:1:a],[0:1:b]);
            surf(X,Y,Z)
            shading interp%Sglagivanie
            %% POSTROENIE 3D KOMNATI
            n=1;
            z=[3;3];
            while n<=j
                if n>1
                    for n=n:n
                        plot3(BoxPos(1,(n-1):n),BoxPos(2,(n-1):n),z,'k','LineWidth',5)
                    end
                end
                n=n+1;
            end
            plot3(BoxPos(1,j:(j+1)),BoxPos(2,j:(j+1)),z,'k','LineWidth',5)
            n=1;
            while n<=j
                XS(1,1)=BoxPos(1,n);
                XS(1,2)=BoxPos(1,n);
                YS(1,1)=BoxPos(2,n);
                YS(1,2)=BoxPos(2,n);
                ZS=[0 3];
                plot3(XS,YS,ZS,'k','LineWidth',5)
                n=n+1;
            end
            plot3(XC,YC,ZS,'ko','MarkerSize',10,'LineWidth',2)
            n=1;
            while n<=j
                x22=BoxPos(1,n);
                y22=BoxPos(2,n);
                plot3(x22,y22,z,'k.','MarkerSize',20)
                n=n+1;
            end
            n=1;
            %% MAYAKI SVERHY
            [in,on]=inpolygon(XM,YM,aa,bb);
            ins=size(XM(in&~on));
            inz=ins(1,1);
            ons=size(XM(~in));
            onz=ons(1,1);
            onr=1:onz;
            inr=1:inz;
            onr(1,:)=3;
            inr(1,:)=3;
            plot3(XM(in&~on),YM(in&~on),inr,'g.','MarkerSize',20)%Mayaki v komnate
            plot3(XM(~in),YM(~in),onr,'r.','MarkerSize',20)%Mayaki vne komnati
        end
    else
        disp('Nedopystimoe znachenie')
    end
elseif Q==0
    %% REGIM S FAILAMI
    %% VVOD KOMNATI
    disp('Vvedite razmeri komnati')
    disp('Dlina=')
    a=input('');
    disp('Shirina')
    b=input('');
    disp('Vvedite shag')
    step=input('');
    axis([0 a 0 b]);%Razmer komnati v santimetrah
    hold on;
    %% VIBOR ZAGRYZKI
    disp('Vvedite 0,esi hotite zagryzit komnaty, 1, esli hotite zagruzit mayaki ini 2 esli vse vmeste')
    QF=input('');
    if QF==0
        BoxPos=load('my_file.txt');%Zagryzka koordinat komnati iz faila
        BoxPos=BoxPos';
        j1=size(BoxPos);
        j=j1(1,2);%j=kolichestvo yglov komnati
        if j==0
            disp('Nedopystimie parametri komnati')
            return
        end
        if j==1
            disp('Nedopystimie parametri komnati')
            return
        end
        if j==2
            disp('Nedopystimie parametri komnati')
            return
        end
        n=1;
        while n<=j
            if n>1
                for n=n:n
                    plot(BoxPos(1,(n-1):n),BoxPos(2,(n-1):n),'k','LineWidth',5)%Postroenie komnati
                end
            end
            n=n+1;
        end
        BoxPos(1,n)=BoxPos(1,1);
        BoxPos(2,n)=BoxPos(2,1);
        plot(BoxPos(1,j:(j+1)),BoxPos(2,j:(j+1)),'k','LineWidth',5)%Soedinenie pervoi i posledney tochki
        n=1;
        while n<=j
            aa(1,n)=BoxPos(1,n);%aa-Massiv s koordinatami komnati po osi OX
            bb(1,n)=BoxPos(2,n);%bb-Massiv s koordinatami komnati po osi OY
            n=n+1;
        end
        BoxPos(1,n)=BoxPos(1,1);
        BoxPos(2,n)=BoxPos(2,1);
        aa(1,n)=BoxPos(1,n);
        bb(1,n)=BoxPos(2,n);
        %% VVOD I RASSTANOVKA MAYAKOV
        disp ('Vvedite kolichestvo mayakov')
        k=input('');
        n=1;
        while n<=k%k-Kollichestvo mayakov
            [x,y]=ginput(1);
            plot(x,y,'ro');%Postroenie mayakov
            XM(n,1)=x;%XM-Massiv s koordinatami mayakov po osi OX
            YM(n,1)=y;%YM-Massiv s koordinatami mayakov po osi OY
            n=n+1;
        end
        SatPos=[XM,YM]';%SatPos-Massiv s koordinatami vseh mayakov
        SizePos=size(SatPos);%Proverka
        SizePos1=SizePos(1,2);
        if SizePos1==0
            disp('Nedopystimoe kolichestvo mayakov')
            return
        end
        if SizePos1==1
            disp('Nedopystimoe kolichestvo mayakov')
            return
        end
        fileID=fopen('my_file2.txt','w');%Sohranenie koordinat mayakov v fail
        fprintf(fileID,'% 3.2f% 3.2f\r\n',SatPos)
        fclose(fileID)
        %% MAYAKI VNE/VNYTRI KOMNATI
        [in,on]=inpolygon(XM,YM,aa,bb);
        plot(XM(in&~on),YM(in&~on),'g.','MarkerSize',20)%Mayaki v komnate
        plot(XM(~in),YM(~in),'r.','MarkerSize',20)%Mayaki vne komnati
        [in,on]=inpolygon(XM,YM,aa,bb);
        SatPos=[XM(in&~on),YM(in&~on)]';%Yberaym iz massiva mayaki vne komnati
        u=size(aa);
        u1=u(1,2);
        m=size(SatPos);
        m1=m(1,2);
        %% VIBOR METODA
        disp('Vvedite 1, esli hotite sdelat raschet po dalnomernomy metode ili 0, esli hotite sdelat raschet po raznostno-dalnomernomy')
        Q1=input('');
        if Q1==1
            %% DAL'NOMERNIY METOD
            %% VIDIMOST'
            D=SatPos;%D-Klon massiva s koordinatami mayakov
            for X=0:step:a
                for Y=0:step:b
                    SatPos=D;
                    SatPos1=[];
                    i=1;
                    n=1;
                    while n<=m1
                        l=1;
                        while l<u1
                            x1=SatPos(1,n);%Koordinati
                            y1=SatPos(2,n);
                            x2=X;
                            y2=Y;
                            x3=aa(l);
                            y3=bb(l);
                            x4=aa(l+1);
                            y4=bb(l+1);
                            if y2==y1 || x1==x2
                                k1=0;
                            else
                                k1=(y2-y1)/(x2-x1);
                            end
                            if y3==y4 || x3==x4
                                k2=0;
                            else
                                k2=(y4-y3)/(x4-x3);
                            end
                            b1=(x2*y1-x1*y2)/(x2-x1);
                            b2=(x4*y3-x3*y4)/(x4-x3);
                            xp=(b2-b1)/(k1-k2);
                            yp=k1*(b2-b1)/(k1-k2)+b1;
                            x1k=x1;%Kloni koordinat
                            x2k=x2;
                            x3k=x3;
                            x4k=x4;
                            y1k=y1;
                            y2k=y2;
                            y3k=y3;
                            y4k=y4;
                            if x2<x1%SWAP koordinat dlya raschetov
                                x2=x1k;
                                x1=x2k;
                            end
                            if x4<x3
                                x3=x4k;
                                x4=x3k;
                            end
                            if y2<y1
                                y2=y1k;
                                y1=y2k;
                            end
                            if y4<y3
                                y3=y4k;
                                y4=y3k;
                            end
                            if k1~=k2 && b1~=b2 && x1<=xp && xp<=x2 && x3<=xp && xp<=x4 && y1<=yp && yp<=y2 && y3<=yp && yp<=y4%ysloviya peresecheniya otrezkov
                                SatPos(:,n)=0;%Zamenyaem na 0 koordinati mayaka, kotoriy ne vidno
                            end
                            l=l+1;
                        end
                        n=n+1;
                    end
                    n=1;
                    CV=0;
                    while n<=m1
                        if SatPos(1,n)==0
                            CV=CV+1;%Schitaem kolichestvo nyley
                        end
                        n=n+1;
                    end
                    if CV==m1
                        Z(Y+1,X+1)=0;%Esli vse nyli=vidimosi net
                    else
                        n=1;
                        N=1;
                        while n<=m1
                            if SatPos(1,n)~=0
                                SatPos1(1,N)=SatPos(1,n);%Yberaem nyli i sozdaem vidimyi dlya tochki massiv
                                SatPos1(2,N)=SatPos(2,n);
                                N=N+1;
                            end
                            n=n+1;
                        end
                        SSR1=size(SatPos1);
                        SSR11=SSR1(1,2);
                        SSR12=SSR1(1,1);
                        if SSR11==0 || SSR12==0 || SSR11==1 || SSR12==1
                            Z(Y+1,X+1)=0;%Esli 0 ili 1 mayakov=vidimosti net
                        else
                            while i<=SSR11
                                r(i,1)=(X-SatPos1(1,i))/(sqrt((X-SatPos1(1,i))^2+(Y-SatPos1(2,i))^2));%r-Gradientnie matrici
                                r(i,2)=(Y-SatPos1(2,i))/(sqrt((X-SatPos1(1,i))^2+(Y-SatPos1(2,i))^2));
                                i=i+1;
                            end
                            Z(Y+1,X+1)=sqrt(trace(((r')*(r))^-1));%Z-Massiv so znacheniyami geometricheskogo factora v kagdoy tochke komnati
                            if Z(Y+1,X+1)>3%Ogranicheniya
                                Z(Y+1,X+1)=3;
                            end
                        end
                    end
                end
            end
            %% YBIRAEM VIDIMOST' VNE KOMNATI
            for xq=0:step:a
                for yq=0:step:b
                    [in,on]=inpolygon(xq,yq,aa,bb);
                    if (on)>0
                        Z(yq+1,xq+1)=0;
                    elseif (~in)>0
                        Z(yq+1,xq+1)=0;
                    end
                end
            end
            %% POSSTROENIE GRAFIKA
            [X,Y]= meshgrid([0:1:a],[0:1:b]);
            surf(X,Y,Z)
            shading interp%Sglagivaem
            %% POSTROENIE 3D KOMNATI
            n=1;
            z=[3;3];
            while n<=j
                if n>1
                    for n=n:n
                        plot3(BoxPos(1,(n-1):n),BoxPos(2,(n-1):n),z,'k','LineWidth',5)
                    end
                end
                n=n+1;
            end
            plot3(BoxPos(1,j:(j+1)),BoxPos(2,j:(j+1)),z,'k','LineWidth',5)
            n=1;
            while n<=j
                XS(1,1)=BoxPos(1,n);
                XS(1,2)=BoxPos(1,n);
                YS(1,1)=BoxPos(2,n);
                YS(1,2)=BoxPos(2,n);
                ZS=[0 3];
                plot3(XS,YS,ZS,'k','LineWidth',5)
                n=n+1;
            end
            n=1;
            while n<=j
                x22=BoxPos(1,n);
                y22=BoxPos(2,n);
                plot3(x22,y22,z,'k.','MarkerSize',20)
                n=n+1;
            end
            n=1;
            %% MAYAKI SVERHY
            [in,on]=inpolygon(XM,YM,aa,bb);
            ins=size(XM(in&~on));
            inz=ins(1,1);
            ons=size(XM(~in));
            onz=ons(1,1);
            onr=1:onz;
            inr=1:inz;
            onr(1,:)=3;
            inr(1,:)=3;
            plot3(XM(in&~on),YM(in&~on),inr,'g.','MarkerSize',20)%Mayaki v komnate
            plot3(XM(~in),YM(~in),onr,'r.','MarkerSize',20)%Mayaki vne komnati
        elseif Q1==0
            %% RAZNOSTNO-DAL'NOMERNIY METOD
            XC=SatPos(1,m1);%koordinati glavnogo mayaka po osi OX
            YC=SatPos(2,m1);%koordinati glavnogo mayaka po osi OY
            plot(XC,YC,'ko','MarkerSize',10,'LineWidth',2)%Videlenie glavnogo mayaka
            n=1;
            while n<m1
                SatPosX(1,n)=SatPos(1,n);%Koordinaty obichnih mayakov
                SatPosX(2,n)=SatPos(2,n);
                n=n+1;
            end
            %% VIDIMOST'
            i=1;
            n=1;
            while n<m1
                l=1;
                while l<u1
                    x1=SatPosX(1,n);%Koordinati
                    y1=SatPosX(2,n);
                    x2=XC;
                    y2=YC;
                    x3=aa(l);
                    y3=bb(l);
                    x4=aa(l+1);
                    y4=bb(l+1);
                    if y2==y1 || x1==x2
                        k1=0;
                    else
                        k1=(y2-y1)/(x2-x1);
                    end
                    if y3==y4 || x3==x4
                        k2=0;
                    else
                        k2=(y4-y3)/(x4-x3);
                    end
                    b1=(x2*y1-x1*y2)/(x2-x1);
                    b2=(x4*y3-x3*y4)/(x4-x3);
                    xp=(b2-b1)/(k1-k2);
                    yp=k1*(b2-b1)/(k1-k2)+b1;
                    x1k=x1;%Kloni koordinat
                    x2k=x2;
                    x3k=x3;
                    x4k=x4;
                    y1k=y1;
                    y2k=y2;
                    y3k=y3;
                    y4k=y4;
                    if x2<x1%SWAP koordinat dlya raschetov
                        x2=x1k;
                        x1=x2k;
                    end
                    if x4<x3
                        x3=x4k;
                        x4=x3k;
                    end
                    if y2<y1
                        y2=y1k;
                        y1=y2k;
                    end
                    if y4<y3
                        y3=y4k;
                        y4=y3k;
                    end
                    if k1~=k2 && b1~=b2 && x1<=xp && xp<=x2 && x3<=xp && xp<=x4 && y1<=yp && yp<=y2 && y3<=yp && yp<=y4%Ysloviya peresecheniya otrezkov
                        SatPosX(:,n)=0;%Zamenyaem na nol' koordinaty mayka esli tochka ego ne vidit
                    end
                    l=l+1;
                end
                n=n+1;
            end
            n=1;
            CV=0;
            while n<m1
                if SatPosX(1,n)==0
                    CV=CV+1;%Schitaem nyli
                end
                n=n+1;
            end
            n=1;
            N=1;
            while n<m1
                if SatPosX(1,n)~=0
                    SatPosX1(1,N)=SatPosX(1,n);%Yberaem nyli iz massiva i sozdaem massiv koordinat mayakov, kotorie vidit tochka
                    SatPosX1(2,N)=SatPosX(2,n);
                    N=N+1;
                elseif SatPosX(1,:)==0
                    SatPosX1(1,:)=0;
                    SatPosX1(2,:)=0;
                end
                n=n+1;
            end
            SizePosX=size(SatPosX1);
            SizePosX1=SizePosX(1,2);
            if SizePosX1==0
                disp('Nedopystimoe kolichestvo ili raspologenie mayakov')
                return
            end
            if SizePosX1==1
                disp('Nedopystimoe kolichestvo ili raspologenie mayakov')
                return
            end
            for X=1:step:a+1
                for Y=1:step:b+1
                    l=1;
                    flag=0;%Flag dlya opredeleniya vidimosi ot glavnogo mayaka
                    while l<u1
                        x1=XC;%Peresechenie otrezkov
                        y1=YC;
                        x2=X;
                        y2=Y;
                        x3=aa(l);
                        y3=bb(l);
                        x4=aa(l+1);
                        y4=bb(l+1);
                        if y2==y1 || x1==x2
                            k1=0;
                        else
                            k1=(y2-y1)/(x2-x1);
                        end
                        if y3==y4 || x3==x4
                            k2=0;
                        else
                            k2=(y4-y3)/(x4-x3);
                        end
                        b1=(x2*y1-x1*y2)/(x2-x1);
                        b2=(x4*y3-x3*y4)/(x4-x3);
                        xp=(b2-b1)/(k1-k2);
                        yp=k1*(b2-b1)/(k1-k2)+b1;
                        x1k=x1;%Kloni koordinat
                        x2k=x2;
                        x3k=x3;
                        x4k=x4;
                        y1k=y1;
                        y2k=y2;
                        y3k=y3;
                        y4k=y4;
                        if x2<x1%SWAP koordinat dlya raschetov
                            x2=x1k;
                            x1=x2k;
                        end
                        if x4<x3
                            x3=x4k;
                            x4=x3k;
                        end
                        if y2<y1
                            y2=y1k;
                            y1=y2k;
                        end
                        if y4<y3
                            y3=y4k;
                            y4=y3k;
                        end
                        if k1~=k2 && b1~=b2 && x1<=xp && xp<=x2 && x3<=xp && xp<=x4 && y1<=yp && yp<=y2 && y3<=yp && yp<=y4%Ysloviya peresecheniya otrezkov
                            flag=1;
                        end
                        l=l+1;
                    end
                    if flag==1%1=net vidimosti
                        Z(Y,X)=0;
                    elseif flag==0 %0=net vidimosti
                        Z(Y,X)=1;
                    end
                end
            end
            SSR1=size(SatPosX1);
            SSR11=SSR1(1,2);
            SSR12=SSR1(1,1);
            if SatPosX(:,:)==0%Proverka
                disp('Vidimosti net')
            else
                for X=1:step:a+1
                    for Y=1:step:b+1
                        if Z(Y,X)==1
                            i=1;
                            while i<=SSR11
                                r(i,1)=((X-SatPosX1(1,i))/(sqrt(((X-SatPosX1(1,i))^2)+((Y-SatPosX1(2,i))^2))))-((X-SatPos(1,m1))/(sqrt(((X-SatPos(1,m1))^2)+((Y-SatPos(2,m1))^2))));%r-Gradientnie matrici
                                r(i,2)=((Y-SatPosX1(2,i))/(sqrt(((X-SatPosX1(1,i))^2)+((Y-SatPosX1(2,i))^2))))-((Y-SatPos(2,m1))/(sqrt(((X-SatPos(1,m1))^2)+((Y-SatPos(2,m1))^2))));
                                i=i+1;
                            end
                            Z(Y,X)=sqrt(trace(((r')*(r))^-1));%Z-Massiv so znacheniyami geometricheskogo factora v kagdoy tochke komnati
                            if Z(Y,X)>3%Ogranicheniya
                                Z(Y,X)=3;
                            end
                        end
                    end
                end
                %% VIDIMOST' VNE KOMNATI
                for xq=0:step:a
                    for yq=0:step:b
                        [in,on]=inpolygon(xq,yq,aa,bb);
                        if (on)>0
                            Z(yq+1,xq+1)=0;
                        elseif (~in)>0
                            Z(yq+1,xq+1)=0;
                        end
                    end
                end
                %% POSSTROENIE GRAFIKA
                [X,Y]= meshgrid([0:1:a],[0:1:b]);
                surf(X,Y,Z)
                shading interp%Sglagivanie
                %% POSTROENIE 3D KOMNATI
                n=1;
                z=[3;3];
                while n<=j
                    if n>1
                        for n=n:n
                            plot3(BoxPos(1,(n-1):n),BoxPos(2,(n-1):n),z,'k','LineWidth',5)
                        end
                    end
                    n=n+1;
                end
                plot3(BoxPos(1,j:(j+1)),BoxPos(2,j:(j+1)),z,'k','LineWidth',5)
                n=1;
                while n<=j
                    XS(1,1)=BoxPos(1,n);
                    XS(1,2)=BoxPos(1,n);
                    YS(1,1)=BoxPos(2,n);
                    YS(1,2)=BoxPos(2,n);
                    ZS=[0 3];
                    plot3(XS,YS,ZS,'k','LineWidth',5)
                    n=n+1;
                end
                plot3(XC,YC,ZS,'ko','MarkerSize',10,'LineWidth',2)
                n=1;
                while n<=j
                    x22=BoxPos(1,n);
                    y22=BoxPos(2,n);
                    plot3(x22,y22,z,'k.','MarkerSize',20)
                    n=n+1;
                end
                n=1;
                %% MAYAKI SVERHY
                [in,on]=inpolygon(XM,YM,aa,bb);
                ins=size(XM(in&~on));
                inz=ins(1,1);
                ons=size(XM(~in));
                onz=ons(1,1);
                onr=1:onz;
                inr=1:inz;
                onr(1,:)=3;
                inr(1,:)=3;
                plot3(XM(in&~on),YM(in&~on),inr,'g.','MarkerSize',20)%Mayaki v komnate
                plot3(XM(~in),YM(~in),onr,'r.','MarkerSize',20)%Mayaki vne komnati
            end
        else
            disp('Nedopystimoe znachenie')
        end
    elseif QF==1
        %% VVOD MAYAKOV I RASSTANOVKA
        SatPos=load('my_file2.txt');%Zagryzka koordinat mayakov iz faila
        SatPos=SatPos';
        k1=size(SatPos);
        k=k1(1,2);%k=kolichestvo mayakov
        if k==0
            disp('Nedopystimoe kolichestvo mayakov')
            return
        end
        if k==1
            disp('Nedopystimoe kolichestvo mayakov')
            return
        end
        n=1;
        while n<=k%k-Kollichestvo mayakov
            XM(n,1)=SatPos(1,n);%XM-Massiv s koordinatami mayakov po osi OX
            YM(n,1)=SatPos(2,n);%YM-Massiv s koordinatami mayakov po osi OY
            n=n+1;
        end
        plot(XM,YM,'ro')
        SatPos=[XM,YM]';%SatPos-Massiv s koordinatami vseh mayakov
        %% VVOD I POSTROENIE KOMNATI
        disp ('Vvedite kolichestvo yglov v komnate')
        j=input('');%j-kolichestvo yglov komnati
        axis([0 a 0 b])%Razmer komnati v santimetrah
        hold on
        n=1;
        while n<=j
            [x,y]=ginput(1);
            plot(x,y,'k.','MarkerSize',20)
            BoxPos(1,n)=x;%BoxPos-Massiv s koordinatami yglov komnati
            BoxPos(2,n)=y;
            if n>1
                for n=n:n
                    plot(BoxPos(1,(n-1):n),BoxPos(2,(n-1):n),'k','LineWidth',5)%Postroenie komnati
                end
            end
            n=n+1;
        end
        SizeBox=size(BoxPos);%%Proverka
        SizeBox1=SizeBox(1,2);
        if SizeBox1==0
            disp('Nevozmognie parametri komnaty')
            return
        end
        if SizeBox1==1
            disp('Nevozmognie parametri komnaty')
            return
        end
        if SizeBox1==2
            disp('Nevozmognie parametri komnaty')
            return
        end
        fileID=fopen('my_file.txt','w');%Sohranenie koordinat yglov v fail
        fprintf(fileID,'% 3.2f% 3.2f\r\n',BoxPos)
        fclose(fileID)
        BoxPos(1,n)=BoxPos(1,1);%Zapis' koordinat 1 ygla na poslednee mesto v massive(nygno dlya postroeniya)
        BoxPos(2,n)=BoxPos(2,1);
        plot(BoxPos(1,j:(j+1)),BoxPos(2,j:(j+1)),'k','LineWidth',5)%Soedinyaet poslednyy i pervyy tochky komnaty
        %% MASSIVI S KOORDINATAMI YGLOV KOMNATI PO OSYAM
        n=1;
        while n<=j
            aa(1,n)=BoxPos(1,n);%aa-Massiv s koordinatami komnati po osi OX
            bb(1,n)=BoxPos(2,n);%bb-Massiv s koordinatami komnati po osi OY
            n=n+1;
        end
        aa(1,n)=BoxPos(1,n);%Zapis' koordinat 1 ygla na poslednee mesto v massive(nygno dlya postroeniya)
        bb(1,n)=BoxPos(2,n);
        %% VIDIMOST' MAYAKOV VNE KOMNATI
        [in,on]=inpolygon(XM,YM,aa,bb);
        plot(XM(in&~on),YM(in&~on),'g.','MarkerSize',20)%Mayaki v komnate
        plot(XM(~in),YM(~in),'r.','MarkerSize',20)%Mayaki vne komnati
        %% VIDIMOST'
        [in,on]=inpolygon(XM,YM,aa,bb);
        SatPos=[XM(in&~on),YM(in&~on)]';
        u=size(aa);
        u1=u(1,2);
        m=size(SatPos);
        m1=m(1,2);
        %% VIBOR METODA
        disp('Vvedite 1 esli hotite sdelat raschet po dalnomernomy metode ili 0 esli hotite sdelat raschet po dalnostno-raznomernomy')
        Q2=input('');
        if Q2==1
            %% DAL'NOMERNIY METOD
            D=SatPos;%Klon massiva s koordinatami mayakov
            for X=0:step:a
                for Y=0:step:b
                    SatPos=D;
                    SatPos1=[];
                    i=1;
                    n=1;
                    while n<=m1
                        l=1;
                        while l<u1
                            x1=SatPos(1,n);%Peresechenie otrezkov
                            y1=SatPos(2,n);
                            x2=X;
                            y2=Y;
                            x3=aa(l);
                            y3=bb(l);
                            x4=aa(l+1);
                            y4=bb(l+1);
                            if y2==y1 || x1==x2
                                k1=0;
                            else
                                k1=(y2-y1)/(x2-x1);
                            end
                            if y3==y4 || x3==x4
                                k2=0;
                            else
                                k2=(y4-y3)/(x4-x3);
                            end
                            b1=(x2*y1-x1*y2)/(x2-x1);
                            b2=(x4*y3-x3*y4)/(x4-x3);
                            xp=(b2-b1)/(k1-k2);
                            yp=k1*(b2-b1)/(k1-k2)+b1;
                            x1k=x1;%Kloni koordinat
                            x2k=x2;
                            x3k=x3;
                            x4k=x4;
                            y1k=y1;
                            y2k=y2;
                            y3k=y3;
                            y4k=y4;
                            if x2<x1%SWAP dlya raschetov
                                x2=x1k;
                                x1=x2k;
                            end
                            if x4<x3
                                x3=x4k;
                                x4=x3k;
                            end
                            if y2<y1
                                y2=y1k;
                                y1=y2k;
                            end
                            if y4<y3
                                y3=y4k;
                                y4=y3k;
                            end
                            if k1~=k2 && b1~=b2 && x1<=xp && xp<=x2 && x3<=xp && xp<=x4 && y1<=yp && yp<=y2 && y3<=yp && yp<=y4%Ysloviya peresecheniya otrezkov
                                SatPos(:,n)=0;%Zamen koordinat nevidimogo mayaka nylyami
                            end
                            l=l+1;
                        end
                        n=n+1;
                    end
                    n=1;
                    CV=0;
                    while n<=m1
                        if SatPos(1,n)==0
                            CV=CV+1;%Podschet kolichestva nyley v massive
                        end
                        n=n+1;
                    end
                    if CV==m1
                        Z(Y+1,X+1)=0;%Esli v massive vse nyli=vidimosti net
                    else
                        n=1;
                        N=1;
                        while n<=m1
                            if SatPos(1,n)~=0
                                SatPos1(1,N)=SatPos(1,n);%Massiv s vidimimi mayakami dlya tochki
                                SatPos1(2,N)=SatPos(2,n);
                                N=N+1;
                            end
                            n=n+1;
                        end
                        SSR1=size(SatPos1);
                        SSR11=SSR1(1,2);
                        SSR12=SSR1(1,1);
                        if SSR11==0 || SSR12==0 || SSR11==1 || SSR12==1%Esli 0 ili 1 mayak=vidimosti net
                            Z(Y+1,X+1)=0;
                        else
                            while i<=SSR11
                                r(i,1)=(X-SatPos1(1,i))/(sqrt((X-SatPos1(1,i))^2+(Y-SatPos1(2,i))^2));%r-Gradientnaycca matrici
                                r(i,2)=(Y-SatPos1(2,i))/(sqrt((X-SatPos1(1,i))^2+(Y-SatPos1(2,i))^2));
                                i=i+1;
                            end
                            Z(Y+1,X+1)=sqrt(trace(((r')*(r))^-1));%Z-Massiv so znacheniyami geometricheskogo factora v kagdoy tochke komnati
                            if Z(Y+1,X+1)>3%Ogranicheniya
                                Z(Y+1,X+1)=3;
                            end
                        end
                    end
                end
            end
            %% VIDIMOST' VNE KOMNATI
            for xq=0:step:a
                for yq=0:step:b
                    [in,on]=inpolygon(xq,yq,aa,bb);
                    if (on)>0
                        Z(yq+1,xq+1)=0;
                    elseif (~in)>0
                        Z(yq+1,xq+1)=0;
                    end
                end
            end
            %% POSSTROENIE GRAFIKA
            [X,Y]= meshgrid([0:1:a],[0:1:b]);
            surf(X,Y,Z);
            shading interp;%Sglagivanie grafika
            %% POSTROENIE 3D KOMNATI
            n=1;
            z=[3;3];
            while n<=j
                if n>1
                    for n=n:n
                        plot3(BoxPos(1,(n-1):n),BoxPos(2,(n-1):n),z,'k','LineWidth',5)
                    end
                end
                n=n+1;
            end
            plot3(BoxPos(1,j:(j+1)),BoxPos(2,j:(j+1)),z,'k','LineWidth',5)
            n=1;
            while n<=j
                XS(1,1)=BoxPos(1,n);
                XS(1,2)=BoxPos(1,n);
                YS(1,1)=BoxPos(2,n);
                YS(1,2)=BoxPos(2,n);
                ZS=[0 3];
                plot3(XS,YS,ZS,'k','LineWidth',5)
                n=n+1;
            end
            n=1;
            while n<=j
                x22=BoxPos(1,n);
                y22=BoxPos(2,n);
                plot3(x22,y22,z,'k.','MarkerSize',20)
                n=n+1;
            end
            n=1;
            %% MAYAKI SVERHY
            [in,on]=inpolygon(XM,YM,aa,bb);
            ins=size(XM(in&~on));
            inz=ins(1,1);
            ons=size(XM(~in));
            onz=ons(1,1);
            onr=1:onz;
            inr=1:inz;
            onr(1,:)=3;
            inr(1,:)=3;
            plot3(XM(in&~on),YM(in&~on),inr,'g.','MarkerSize',20)%Mayaki v komnate
            plot3(XM(~in),YM(~in),onr,'r.','MarkerSize',20)%Mayaki vne komnati
        elseif Q2==0
            %% RAZNOSTNO-DAL'NOMERNIY METOD
            XC=SatPos(1,m1);%koordinati glavnogo mayaka
            YC=SatPos(2,m1);%koordinati glavnogo mayaka
            plot(XC,YC,'ko','MarkerSize',10,'LineWidth',2)
            n=1;
            while n<m1
                SatPosX(1,n)=SatPos(1,n);%Massiv s koordinatami obichnih mayakov
                SatPosX(2,n)=SatPos(2,n);
                n=n+1;
            end
            i=1;
            n=1;
            while n<m1
                l=1;
                while l<u1
                    x1=SatPosX(1,n);%Peresechenie otrezkov
                    y1=SatPosX(2,n);
                    x2=XC;
                    y2=YC;
                    x3=aa(l);
                    y3=bb(l);
                    x4=aa(l+1);
                    y4=bb(l+1);
                    if y2==y1 || x1==x2
                        k1=0;
                    else
                        k1=(y2-y1)/(x2-x1);
                    end
                    if y3==y4 || x3==x4
                        k2=0;
                    else
                        k2=(y4-y3)/(x4-x3);
                    end
                    b1=(x2*y1-x1*y2)/(x2-x1);
                    b2=(x4*y3-x3*y4)/(x4-x3);
                    xp=(b2-b1)/(k1-k2);
                    yp=k1*(b2-b1)/(k1-k2)+b1;
                    x1k=x1;%Kloni koordinat
                    x2k=x2;
                    x3k=x3;
                    x4k=x4;
                    y1k=y1;
                    y2k=y2;
                    y3k=y3;
                    y4k=y4;
                    if x2<x1%SWAP koordinat dlya raschetov
                        x2=x1k;
                        x1=x2k;
                    end
                    if x4<x3
                        x3=x4k;
                        x4=x3k;
                    end
                    if y2<y1
                        y2=y1k;
                        y1=y2k;
                    end
                    if y4<y3
                        y3=y4k;
                        y4=y3k;
                    end
                    if k1~=k2 && b1~=b2 && x1<=xp && xp<=x2 && x3<=xp && xp<=x4 && y1<=yp && yp<=y2 && y3<=yp && yp<=y4%Yslovie peresecheniya otrezkov
                        SatPosX(:,n)=0;%Zamena koordinat nevidimogo mayaka dlya tochki na nol'
                    end
                    l=l+1;
                end
                n=n+1;
            end
            n=1;
            CV=0;
            while n<m1
                if SatPosX(1,n)==0
                    CV=CV+1;%Podschet nylei
                end
                n=n+1;
            end
            n=1;
            N=1;
            while n<m1
                if SatPosX(1,n)~=0%Zamena nyley i sozdanie massiva s vidimimi mayakami
                    SatPosX1(1,N)=SatPosX(1,n);
                    SatPosX1(2,N)=SatPosX(2,n);
                    N=N+1;
                elseif SatPosX(1,:)==0
                    SatPosX1(1,:)=0;
                    SatPosX1(2,:)=0;
                end
                n=n+1;
            end
            SizePosX=size(SatPosX1);
            SizePosX1=SizePosX(1,2);
            if SizePosX1==0
                disp('Nedopystimoe kolichestvo ili raspologenie mayakov')
                return
            end
            if SizePosX1==1
                disp('Nedopystimoe kolichestvo ili raspologenie mayakov')
                return
            end
            for X=1:step:a+1
                for Y=1:step:b+1
                    l=1;
                    flag=0;%Flag dlya opredeleniya vidimosi mayakov
                    while l<u1
                        x1=XC;%Peresechenie otrezkov
                        y1=YC;
                        x2=X;
                        y2=Y;
                        x3=aa(l);
                        y3=bb(l);
                        x4=aa(l+1);
                        y4=bb(l+1);
                        if y2==y1 || x1==x2
                            k1=0;
                        else
                            k1=(y2-y1)/(x2-x1);
                        end
                        if y3==y4 || x3==x4
                            k2=0;
                        else
                            k2=(y4-y3)/(x4-x3);
                        end
                        b1=(x2*y1-x1*y2)/(x2-x1);
                        b2=(x4*y3-x3*y4)/(x4-x3);
                        xp=(b2-b1)/(k1-k2);
                        yp=k1*(b2-b1)/(k1-k2)+b1;
                        x1k=x1;%Kloni koordinat
                        x2k=x2;
                        x3k=x3;
                        x4k=x4;
                        y1k=y1;
                        y2k=y2;
                        y3k=y3;
                        y4k=y4;
                        if x2<x1%SWAP koordinat dlya raschetov
                            x2=x1k;
                            x1=x2k;
                        end
                        if x4<x3
                            x3=x4k;
                            x4=x3k;
                        end
                        if y2<y1
                            y2=y1k;
                            y1=y2k;
                        end
                        if y4<y3
                            y3=y4k;
                            y4=y3k;
                        end
                        if k1~=k2 && b1~=b2 && x1<=xp && xp<=x2 && x3<=xp && xp<=x4 && y1<=yp && yp<=y2 && y3<=yp && yp<=y4%Yslovya peresecheniya otrezkov
                            flag=1;
                        end
                        l=l+1;
                    end
                    if flag==1%1=vidimossti net
                        Z(Y,X)=0;
                    elseif flag==0%0=vidimost' est'
                        Z(Y,X)=1;
                    end
                end
            end
            SSR1=size(SatPosX1);
            SSR11=SSR1(1,2);
            SSR12=SSR1(1,1);
            if SatPosX(:,:)==0%Proverka
                disp('Vidimosti net');
            else
                for X=1:step:a+1
                    for Y=1:step:b+1
                        if Z(Y,X)==1
                            i=1;
                            while i<=SSR11
                                r(i,1)=((X-SatPosX1(1,i))/(sqrt(((X-SatPosX1(1,i))^2)+((Y-SatPosX1(2,i))^2))))-((X-SatPos(1,m1))/(sqrt(((X-SatPos(1,m1))^2)+((Y-SatPos(2,m1))^2))));%r-Gradientnie matrici
                                r(i,2)=((Y-SatPosX1(2,i))/(sqrt(((X-SatPosX1(1,i))^2)+((Y-SatPosX1(2,i))^2))))-((Y-SatPos(2,m1))/(sqrt(((X-SatPos(1,m1))^2)+((Y-SatPos(2,m1))^2))));
                                i=i+1;
                            end
                            Z(Y,X)=sqrt(trace(((r')*(r))^-1));%Z-Massiv so znacheniyami geometricheskogo factora v kagdoy tochke komnati
                            if Z(Y,X)>3%Ogranicheniya
                                Z(Y,X)=3;
                            end
                        end
                    end
                end
                %% VIDIMOST' VNE KOMNATI
                for xq=0:step:a
                    for yq=0:step:b
                        [in,on]=inpolygon(xq,yq,aa,bb);
                        if (on)>0
                            Z(yq+1,xq+1)=0;
                        elseif (~in)>0
                            Z(yq+1,xq+1)=0;
                        end
                    end
                end
                %% POSSTROENIE GRAFIKA
                [X,Y]= meshgrid([0:1:a],[0:1:b]);
                surf(X,Y,Z)
                shading interp%Sglagivanie grafika
                %% POSTROENIE 3D KOMNATI
                n=1;
                z=[3;3];
                while n<=j
                    if n>1
                        for n=n:n
                            plot3(BoxPos(1,(n-1):n),BoxPos(2,(n-1):n),z,'k','LineWidth',5);
                        end
                    end
                    n=n+1;
                end
                plot3(BoxPos(1,j:(j+1)),BoxPos(2,j:(j+1)),z,'k','LineWidth',5);
                n=1;
                while n<=j
                    XS(1,1)=BoxPos(1,n);
                    XS(1,2)=BoxPos(1,n);
                    YS(1,1)=BoxPos(2,n);
                    YS(1,2)=BoxPos(2,n);
                    ZS=[0 3];
                    plot3(XS,YS,ZS,'k','LineWidth',5);
                    n=n+1;
                end
                plot3(XC,YC,ZS,'ko','MarkerSize',10,'LineWidth',2);
                n=1;
                while n<=j
                    x22=BoxPos(1,n);
                    y22=BoxPos(2,n);
                    plot3(x22,y22,z,'k.','MarkerSize',20);
                    n=n+1;
                end
                n=1;
                %% MAYAKI SVERHY
                [in,on]=inpolygon(XM,YM,aa,bb);
                ins=size(XM(in&~on));
                inz=ins(1,1);
                ons=size(XM(~in));
                onz=ons(1,1);
                onr=1:onz;
                inr=1:inz;
                onr(1,:)=3;
                inr(1,:)=3;
                plot3(XM(in&~on),YM(in&~on),inr,'g.','MarkerSize',20)%Mayaki v komnate
                plot3(XM(~in),YM(~in),onr,'r.','MarkerSize',20)%Mayaki vne komnati
            end
        else
            disp('Vvedeno nedopystimoe znachenie')
        end
    elseif QF==2
        BoxPos=load('my_file.txt');%Zagryzka koordinat komnati iz faila
        BoxPos=BoxPos';
        j1=size(BoxPos);
        j=j1(1,2);%j=kolichestvo yglov komnati
        if j==0
            disp('Nedopystimie parametri komnati')
            return
        end
        if j==1
            disp('Nedopystimie parametri komnati')
            return
        end
        if j==2
            disp('Nedopystimie parametri komnati')
            return
        end
        n=1;
        while n<=j
            if n>1
                for n=n:n
                    plot(BoxPos(1,(n-1):n),BoxPos(2,(n-1):n),'k','LineWidth',5)%Postroenie komnati
                end
            end
            n=n+1;
        end
        BoxPos(1,n)=BoxPos(1,1);
        BoxPos(2,n)=BoxPos(2,1);
        plot(BoxPos(1,j:(j+1)),BoxPos(2,j:(j+1)),'k','LineWidth',5)%Soedinenie pervoi i posledney tochki
        n=1;
        while n<=j
            aa(1,n)=BoxPos(1,n);%aa-Massiv s koordinatami komnati po osi OX
            bb(1,n)=BoxPos(2,n);%bb-Massiv s koordinatami komnati po osi OY
            n=n+1;
        end
        BoxPos(1,n)=BoxPos(1,1);
        BoxPos(2,n)=BoxPos(2,1);
        aa(1,n)=BoxPos(1,n);
        bb(1,n)=BoxPos(2,n);
        SatPos=load('my_file2.txt');%Zagryzka koordinat mayakov iz faila
        SatPos=SatPos';
        k1=size(SatPos);
        k=k1(1,2);%k=kolichestvo mayakov
        if k==0
            disp('Nedopystimoe kolichestvo mayakov')
            return
        end
        if k==1
            disp('Nedopystimoe kolichestvo mayakov')
            return
        end
        n=1;
        while n<=k%k-Kollichestvo mayakov
            XM(n,1)=SatPos(1,n);%XM-Massiv s koordinatami mayakov po osi OX
            YM(n,1)=SatPos(2,n);%YM-Massiv s koordinatami mayakov po osi OY
            n=n+1;
        end
        SatPos=[XM,YM]';%SatPos-Massiv s koordinatami vseh mayakov
        %% VIDIMOST' MAYAKOV VNE KOMNATI
        [in,on]=inpolygon(XM,YM,aa,bb);
        plot(XM(in&~on),YM(in&~on),'g.','MarkerSize',20);%Mayaki v komnate
        plot(XM(~in),YM(~in),'r.','MarkerSize',20);%Mayaki vne komnati
        %% VIDIMOST'
        [in,on]=inpolygon(XM,YM,aa,bb);
        SatPos=[XM(in&~on),YM(in&~on)]';
        u=size(aa);
        u1=u(1,2);
        m=size(SatPos);
        m1=m(1,2);
        %% VIBOR METODA
        disp('Vvedite 1 esli hotite sdelat raschet po dalnomernomy metode ili 0 esli hotite sdelat raschet po dalnostno-raznomernomy')
        Q2=input('');
        if Q2==1
            %% DAL'NOMERNIY METOD
            D=SatPos;%Klon massiva s koordinatami mayakov
            for X=0:step:a
                for Y=0:step:b
                    SatPos=D;
                    SatPos1=[];
                    i=1;
                    n=1;
                    while n<=m1
                        l=1;
                        while l<u1
                            x1=SatPos(1,n);%Peresechenie otrezkov
                            y1=SatPos(2,n);
                            x2=X;
                            y2=Y;
                            x3=aa(l);
                            y3=bb(l);
                            x4=aa(l+1);
                            y4=bb(l+1);
                            if y2==y1 || x1==x2
                                k1=0;
                            else
                                k1=(y2-y1)/(x2-x1);
                            end
                            if y3==y4 || x3==x4
                                k2=0;
                            else
                                k2=(y4-y3)/(x4-x3);
                            end
                            b1=(x2*y1-x1*y2)/(x2-x1);
                            b2=(x4*y3-x3*y4)/(x4-x3);
                            xp=(b2-b1)/(k1-k2);
                            yp=k1*(b2-b1)/(k1-k2)+b1;
                            x1k=x1;%Kloni koordinat
                            x2k=x2;
                            x3k=x3;
                            x4k=x4;
                            y1k=y1;
                            y2k=y2;
                            y3k=y3;
                            y4k=y4;
                            if x2<x1%SWAP dlya raschetov
                                x2=x1k;
                                x1=x2k;
                            end
                            if x4<x3
                                x3=x4k;
                                x4=x3k;
                            end
                            if y2<y1
                                y2=y1k;
                                y1=y2k;
                            end
                            if y4<y3
                                y3=y4k;
                                y4=y3k;
                            end
                            if k1~=k2 && b1~=b2 && x1<=xp && xp<=x2 && x3<=xp && xp<=x4 && y1<=yp && yp<=y2 && y3<=yp && yp<=y4%Ysloviya peresecheniya otrezkov
                                SatPos(:,n)=0;%Zamen koordinat nevidimogo mayaka nylyami
                            end
                            l=l+1;
                        end
                        n=n+1;
                    end
                    n=1;
                    CV=0;
                    while n<=m1
                        if SatPos(1,n)==0
                            CV=CV+1;%Podschet kolichestva nyley v massive
                        end
                        n=n+1;
                    end
                    if CV==m1
                        Z(Y+1,X+1)=0;%Esli v massive vse nyli=vidimosti net
                    else
                        n=1;
                        N=1;
                        while n<=m1
                            if SatPos(1,n)~=0
                                SatPos1(1,N)=SatPos(1,n);%Massiv s vidimimi mayakami dlya tochki
                                SatPos1(2,N)=SatPos(2,n);
                                N=N+1;
                            end
                            n=n+1;
                        end
                        SSR1=size(SatPos1);
                        SSR11=SSR1(1,2);
                        SSR12=SSR1(1,1);
                        if SSR11==0 || SSR12==0 || SSR11==1 || SSR12==1%Esli 0 ili 1 mayak=vidimosti net
                            Z(Y+1,X+1)=0;
                        else
                            while i<=SSR11
                                r(i,1)=(X-SatPos1(1,i))/(sqrt((X-SatPos1(1,i))^2+(Y-SatPos1(2,i))^2));%r-Gradientnaycca matrici
                                r(i,2)=(Y-SatPos1(2,i))/(sqrt((X-SatPos1(1,i))^2+(Y-SatPos1(2,i))^2));
                                i=i+1;
                            end
                            Z(Y+1,X+1)=sqrt(trace(((r')*(r))^-1));%Z-Massiv so znacheniyami geometricheskogo factora v kagdoy tochke komnati
                            if Z(Y+1,X+1)>3%Ogranicheniya
                                Z(Y+1,X+1)=3;
                            end
                        end
                    end
                end
            end
            %% VIDIMOST' VNE KOMNATI
            for xq=0:step:a
                for yq=0:step:b
                    [in,on]=inpolygon(xq,yq,aa,bb);
                    if (on)>0
                        Z(yq+1,xq+1)=0;
                    elseif (~in)>0
                        Z(yq+1,xq+1)=0;
                    end
                end
            end
            %% POSSTROENIE GRAFIKA
            [X,Y]= meshgrid([0:1:a],[0:1:b]);
            surf(X,Y,Z);
            shading interp;%Sglagivanie grafika
            %% POSTROENIE 3D KOMNATI
            n=1;
            z=[3;3];
            while n<=j
                if n>1
                    for n=n:n
                        plot3(BoxPos(1,(n-1):n),BoxPos(2,(n-1):n),z,'k','LineWidth',5)
                    end
                end
                n=n+1;
            end
            plot3(BoxPos(1,j:(j+1)),BoxPos(2,j:(j+1)),z,'k','LineWidth',5)
            n=1;
            while n<=j
                XS(1,1)=BoxPos(1,n);
                XS(1,2)=BoxPos(1,n);
                YS(1,1)=BoxPos(2,n);
                YS(1,2)=BoxPos(2,n);
                ZS=[0 3];
                plot3(XS,YS,ZS,'k','LineWidth',5)
                n=n+1;
            end
            n=1;
            while n<=j
                x22=BoxPos(1,n);
                y22=BoxPos(2,n);
                plot3(x22,y22,z,'k.','MarkerSize',20)
                n=n+1;
            end
            n=1;
            %% MAYAKI SVERHY
            [in,on]=inpolygon(XM,YM,aa,bb);
            ins=size(XM(in&~on));
            inz=ins(1,1);
            ons=size(XM(~in));
            onz=ons(1,1);
            onr=1:onz;
            inr=1:inz;
            onr(1,:)=3;
            inr(1,:)=3;
            plot3(XM(in&~on),YM(in&~on),inr,'g.','MarkerSize',20)%Mayaki v komnate
            plot3(XM(~in),YM(~in),onr,'r.','MarkerSize',20)%Mayaki vne komnati
        elseif Q2==0
            %% RAZNOSTNO-DAL'NOMERNIY METOD
            XC=SatPos(1,m1);%koordinati glavnogo mayaka
            YC=SatPos(2,m1);%koordinati glavnogo mayaka
            plot(XC,YC,'ko','MarkerSize',10,'LineWidth',2)
            n=1;
            while n<m1
                SatPosX(1,n)=SatPos(1,n);%Massiv s koordinatami obichnih mayakov
                SatPosX(2,n)=SatPos(2,n);
                n=n+1;
            end
            i=1;
            n=1;
            while n<m1
                l=1;
                while l<u1
                    x1=SatPosX(1,n);%Peresechenie otrezkov
                    y1=SatPosX(2,n);
                    x2=XC;
                    y2=YC;
                    x3=aa(l);
                    y3=bb(l);
                    x4=aa(l+1);
                    y4=bb(l+1);
                    if y2==y1 || x1==x2
                        k1=0;
                    else
                        k1=(y2-y1)/(x2-x1);
                    end
                    if y3==y4 || x3==x4
                        k2=0;
                    else
                        k2=(y4-y3)/(x4-x3);
                    end
                    b1=(x2*y1-x1*y2)/(x2-x1);
                    b2=(x4*y3-x3*y4)/(x4-x3);
                    xp=(b2-b1)/(k1-k2);
                    yp=k1*(b2-b1)/(k1-k2)+b1;
                    x1k=x1;%Kloni koordinat
                    x2k=x2;
                    x3k=x3;
                    x4k=x4;
                    y1k=y1;
                    y2k=y2;
                    y3k=y3;
                    y4k=y4;
                    if x2<x1%SWAP koordinat dlya raschetov
                        x2=x1k;
                        x1=x2k;
                    end
                    if x4<x3
                        x3=x4k;
                        x4=x3k;
                    end
                    if y2<y1
                        y2=y1k;
                        y1=y2k;
                    end
                    if y4<y3
                        y3=y4k;
                        y4=y3k;
                    end
                    if k1~=k2 && b1~=b2 && x1<=xp && xp<=x2 && x3<=xp && xp<=x4 && y1<=yp && yp<=y2 && y3<=yp && yp<=y4%Yslovie peresecheniya otrezkov
                        SatPosX(:,n)=0;%Zamena koordinat nevidimogo mayaka dlya tochki na nol'
                    end
                    l=l+1;
                end
                n=n+1;
            end
            n=1;
            CV=0;
            while n<m1
                if SatPosX(1,n)==0
                    CV=CV+1;%Podschet nylei
                end
                n=n+1;
            end
            n=1;
            N=1;
            while n<m1
                if SatPosX(1,n)~=0%Zamena nyley i sozdanie massiva s vidimimi mayakami
                    SatPosX1(1,N)=SatPosX(1,n);
                    SatPosX1(2,N)=SatPosX(2,n);
                    N=N+1;
                elseif SatPosX(1,:)==0
                    SatPosX1(1,:)=0;
                    SatPosX1(2,:)=0;
                end
                n=n+1;
            end
            SizePosX=size(SatPosX1);
            SizePosX1=SizePosX(1,2);
            if SizePosX1==0
                disp('Nedopystimoe kolichestvo ili raspologenie mayakov')
                return
            end
            if SizePosX1==1
                disp('Nedopystimoe kolichestvo ili raspologenie mayakov')
                return
            end
            for X=1:step:a+1
                for Y=1:step:b+1
                    l=1;
                    flag=0;%Flag dlya opredeleniya vidimosi mayakov
                    while l<u1
                        x1=XC;%Peresechenie otrezkov
                        y1=YC;
                        x2=X;
                        y2=Y;
                        x3=aa(l);
                        y3=bb(l);
                        x4=aa(l+1);
                        y4=bb(l+1);
                        if y2==y1 || x1==x2
                            k1=0;
                        else
                            k1=(y2-y1)/(x2-x1);
                        end
                        if y3==y4 || x3==x4
                            k2=0;
                        else
                            k2=(y4-y3)/(x4-x3);
                        end
                        b1=(x2*y1-x1*y2)/(x2-x1);
                        b2=(x4*y3-x3*y4)/(x4-x3);
                        xp=(b2-b1)/(k1-k2);
                        yp=k1*(b2-b1)/(k1-k2)+b1;
                        x1k=x1;%Kloni koordinat
                        x2k=x2;
                        x3k=x3;
                        x4k=x4;
                        y1k=y1;
                        y2k=y2;
                        y3k=y3;
                        y4k=y4;
                        if x2<x1%SWAP koordinat dlya raschetov
                            x2=x1k;
                            x1=x2k;
                        end
                        if x4<x3
                            x3=x4k;
                            x4=x3k;
                        end
                        if y2<y1
                            y2=y1k;
                            y1=y2k;
                        end
                        if y4<y3
                            y3=y4k;
                            y4=y3k;
                        end
                        if k1~=k2 && b1~=b2 && x1<=xp && xp<=x2 && x3<=xp && xp<=x4 && y1<=yp && yp<=y2 && y3<=yp && yp<=y4%Yslovya peresecheniya otrezkov
                            flag=1;
                        end
                        l=l+1;
                    end
                    if flag==1%1=vidimossti net
                        Z(Y,X)=0;
                    elseif flag==0%0=vidimost' est'
                        Z(Y,X)=1;
                    end
                end
            end
            SSR1=size(SatPosX1);
            SSR11=SSR1(1,2);
            SSR12=SSR1(1,1);
            if SatPosX(:,:)==0%Proverka
                disp('Vidimosti net')
            else
                for X=1:step:a+1
                    for Y=1:step:b+1
                        if Z(Y,X)==1
                            i=1;
                            while i<=SSR11
                                r(i,1)=((X-SatPosX1(1,i))/(sqrt(((X-SatPosX1(1,i))^2)+((Y-SatPosX1(2,i))^2))))-((X-SatPos(1,m1))/(sqrt(((X-SatPos(1,m1))^2)+((Y-SatPos(2,m1))^2))));%r-Gradientnie matrici
                                r(i,2)=((Y-SatPosX1(2,i))/(sqrt(((X-SatPosX1(1,i))^2)+((Y-SatPosX1(2,i))^2))))-((Y-SatPos(2,m1))/(sqrt(((X-SatPos(1,m1))^2)+((Y-SatPos(2,m1))^2))));
                                i=i+1;
                            end
                            Z(Y,X)=sqrt(trace(((r')*(r))^-1));%Z-Massiv so znacheniyami geometricheskogo factora v kagdoy tochke komnati
                            if Z(Y,X)>3%Ogranicheniya
                                Z(Y,X)=3;
                            end
                        end
                    end
                end
                %% VIDIMOST' VNE KOMNATI
                for xq=0:step:a
                    for yq=0:step:b
                        [in,on]=inpolygon(xq,yq,aa,bb);
                        if (on)>0
                            Z(yq+1,xq+1)=0;
                        elseif (~in)>0
                            Z(yq+1,xq+1)=0;
                        end
                    end
                end
                %% POSSTROENIE GRAFIKA
                [X,Y]= meshgrid([0:1:a],[0:1:b]);
                surf(X,Y,Z)
                shading interp%Sglagivanie grafika
                %% POSTROENIE 3D KOMNATI
                n=1;
                z=[3;3];
                while n<=j
                    if n>1
                        for n=n:n
                            plot3(BoxPos(1,(n-1):n),BoxPos(2,(n-1):n),z,'k','LineWidth',5)
                        end
                    end
                    n=n+1;
                end
                plot3(BoxPos(1,j:(j+1)),BoxPos(2,j:(j+1)),z,'k','LineWidth',5)
                n=1;
                while n<=j
                    XS(1,1)=BoxPos(1,n);
                    XS(1,2)=BoxPos(1,n);
                    YS(1,1)=BoxPos(2,n);
                    YS(1,2)=BoxPos(2,n);
                    ZS=[0 3];
                    plot3(XS,YS,ZS,'k','LineWidth',5)
                    n=n+1;
                end
                plot3(XC,YC,ZS,'ko','MarkerSize',10,'LineWidth',2)
                n=1;
                while n<=j
                    x22=BoxPos(1,n);
                    y22=BoxPos(2,n);
                    plot3(x22,y22,z,'k.','MarkerSize',20)
                    n=n+1;
                end
                n=1;
                %% MAYAKI SVERHY
                [in,on]=inpolygon(XM,YM,aa,bb);
                ins=size(XM(in&~on));
                inz=ins(1,1);
                ons=size(XM(~in));
                onz=ons(1,1);
                onr=1:onz;
                inr=1:inz;
                onr(1,:)=3;
                inr(1,:)=3;
                plot3(XM(in&~on),YM(in&~on),inr,'g.','MarkerSize',20)%Mayaki v komnate
                plot3(XM(~in),YM(~in),onr,'r.','MarkerSize',20)%Mayaki vne komnati
            end
        else
            disp('Vvedeno nedopystimoe znachenie')
        end
    else
        disp('Vvedeno nedopystimoe znachenie')
    end
else
    disp('Vvedeno ne dopystimoe chislo')
end