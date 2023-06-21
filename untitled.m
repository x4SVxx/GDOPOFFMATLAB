function varargout = untitled(varargin)
% UNTITLED MATLAB code for untitled.fig
%      UNTITLED, by itself, creates a new UNTITLED or raises the existing
%      singleton*.
%
%      H = UNTITLED returns the handle to a new UNTITLED or the handle to
%      the existing singleton*.
%
%      UNTITLED('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UNTITLED.M with the given input arguments.
%
%      UNTITLED('Property','Value',...) creates a new UNTITLED or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before untitled_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to untitled_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help untitled

% Last Modified by GUIDE v2.5 20-Dec-2019 23:10:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @untitled_OpeningFcn, ...
    'gui_OutputFcn',  @untitled_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before untitled is made visible.
function untitled_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to untitled (see VARARGIN)

% Choose default command line output for untitled
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes untitled wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = untitled_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function kolroom_Callback(hObject, eventdata, handles)
% hObject    handle to kolroom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of kolroom as text
%        str2double(get(hObject,'String')) returns contents of kolroom as a double



% --- Executes during object creation, after setting all properties.
function kolroom_CreateFcn(hObject, eventdata, handles)
% hObject    handle to kolroom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function kolmayak_Callback(hObject, eventdata, handles)
% hObject    handle to kolmayak (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of kolmayak as text
%        str2double(get(hObject,'String')) returns contents of kolmayak as a double


% --- Executes during object creation, after setting all properties.
function kolmayak_CreateFcn(hObject, eventdata, handles)
% hObject    handle to kolmayak (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in roomb.
function roomb_Callback(hObject, eventdata, handles)
% hObject    handle to roomb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles=guidata(hObject);
a=get(handles.ap,'string');
a=str2double(a);
b=get(handles.bp,'string');
b=str2double(b);
if a~=a
    set(handles.varning,'String','the data entered is incorrect');
    set(handles.varning,'ForegroundColor',[1 0 0]);
elseif b~=b
    set(handles.varning,'String','the data entered is incorrect');
    set(handles.varning,'ForegroundColor',[1 0 0]);
else
    set(handles.varning,'String','');
    y=get(handles.kolroom,'string');
    y=str2double(y);
    j=y;
    if j<3
        set(handles.varning,'String','the data entered is incorrect');
        set(handles.varning,'ForegroundColor',[1 0 0]);
    else
        set(handles.varning,'String','');
        n=1;
        while n<=j
            [x,y]=ginput(1);
            plot(x,y,'k.','MarkerSize',20);
            BoxPos(1,n)=x;%BoxPos-Massiv s koordinatami yglov komnati
            BoxPos(2,n)=y;
            if n>1
                for n=n:n
                    plot(BoxPos(1,(n-1):n),BoxPos(2,(n-1):n),'k','LineWidth',5);%Postroenie komnati
                end
            end
            n=n+1;
        end
        BoxPos(1,n)=BoxPos(1,1);%Zapis' koordinat 1 ygla na poslednee mesto v massive(nygno dlya postroeniya)
        BoxPos(2,n)=BoxPos(2,1);
        plot(BoxPos(1,j:(j+1)),BoxPos(2,j:(j+1)),'k','LineWidth',5);%Soedinyaet poslednyy i pervyy tochky komnaty
        BoxPosSave=BoxPos;
        handles.BoxPosSave=BoxPosSave;
        %% MASSIVI S KOORDINATAMI YGLOV KOMNATI PO OSYAM
        n=1;
        while n<=j
            aa(1,n)=BoxPos(1,n);%aa-Massiv s koordinatami komnati po osi OX
            bb(1,n)=BoxPos(2,n);%bb-Massiv s koordinatami komnati po osi OY
            n=n+1;
        end
        BoxPosTABLO(:,1)=[aa];
        BoxPosTABLO(:,2)=[bb];
        handles.BoxPosTABLO=BoxPosTABLO;
        BoxPosTABLO=handles.BoxPosTABLO;
        set(handles.TABLO1,'Data',BoxPosTABLO);
        aa(1,n)=BoxPos(1,n);%Zapis' koordinat 1 ygla na poslednee mesto v massive(nygno dlya postroeniya)
        bb(1,n)=BoxPos(2,n);
        handles.BoxPos=BoxPos;
        handles.aa=aa;
        handles.bb=bb;
        handles.j=j;
        guidata(hObject,handles);
    end
end


% --- Executes on button press in mayakb.
function mayakb_Callback(hObject, eventdata, handles)
% hObject    handle to mayakb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles=guidata(hObject);
a=get(handles.ap,'string');
a=str2double(a);
b=get(handles.bp,'string');
b=str2double(b);
if a~=a
    set(handles.varning,'String','the data entered is incorrect');
    set(handles.varning,'ForegroundColor',[1 0 0]);
elseif b~=b
    set(handles.varning,'String','the data entered is incorrect');
    set(handles.varning,'ForegroundColor',[1 0 0]);
else
    set(handles.varning,'String','');
    x=get(handles.kolmayak,'string');
    x=str2double(x);
    k=x;
    if k<2
        set(handles.varning,'String','the data entered is incorrect');
        set(handles.varning,'ForegroundColor',[1 0 0]);
    else
        set(handles.varning,'String','');
        n=1;
        while n<=k%k-Kollichestvo mayakov
            [x,y]=ginput(1);
            plot(x,y,'ro');%Postroenie mayakov
            XM(n,1)=x;%XM-Massiv s koordinatami mayakov po osi OX
            YM(n,1)=y;%YM-Massiv s koordinatami mayakov po osi OY
            n=n+1;
        end
        SatPosTABLO(:,1)=[XM];
        SatPosTABLO(:,2)=[YM];
        handles.SatPosTABLO=SatPosTABLO;
        SatPosTABLO=handles.SatPosTABLO;
        set(handles.TABLO,'Data',SatPosTABLO);
        SatPos=[XM,YM]';%SatPos-Massiv s koordinatami vseh mayakov
        SatPosSave=SatPos;
        handles.SatPosSave=SatPosSave;
        handles.k=k;
        handles.XM=XM;
        handles.YM=YM;
        guidata(hObject,handles);
    end
end


% --- Executes on button press in go.
function go_Callback(hObject, eventdata, handles)
% hObject    handle to go (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles=guidata(hObject);
step=get(handles.shag,'string');
step=str2double(step);
if step~=step
    set(handles.varning,'String','the data entered is incorrect');
    set(handles.varning,'ForegroundColor',[1 0 0]);
else
    set(handles.varning,'String','');
    if step==0;
        set(handles.varning,'String','the data entered is incorrect');
        set(handles.varning,'ForegroundColor',[1 0 0]);
    else
        set(handles.varning,'String','');
        XM=handles.XM;
        YM=handles.YM;
        BoxPos=handles.BoxPos;
        aa=handles.aa;
        bb=handles.bb;
        j=handles.j;
        a=handles.a;
        b=handles.b;
        [in,on]=inpolygon(XM,YM,aa,bb);
        plot(XM(in&~on),YM(in&~on),'g.','MarkerSize',20);%Mayaki v komnate
        plot(XM(~in),YM(~in),'r.','MarkerSize',20);%Mayaki vne komnati
        [in,on]=inpolygon(XM,YM,aa,bb);
        SatPos=[XM(in&~on),YM(in&~on)]';%Yberaym iz massiva mayaki vne komnati
        u=size(aa);
        u1=u(1,2);
        m=size(SatPos);
        m1=m(1,2);
        if m1<2
            set(handles.varning,'String','the data entered is incorrect');
            set(handles.varning,'ForegroundColor',[1 0 0]);
        else
            set(handles.varning,'String','');
            vD=get(handles.D,'Value');
            vRD=get(handles.RD,'Value');
            if vRD==1 && vD==0
                set(handles.varning,'String','');
                %% RAZNOSTNO-DAL'NOMERNIY METOD
                XC=SatPos(1,m1);%koordinati glavnogo mayaka po osi OX
                YC=SatPos(2,m1);%koordinati glavnogo mayaka po osi OY
                plot(XC,YC,'ko','MarkerSize',10,'LineWidth',2);%Videlenie glavnogo mayaka
                n=1;
                while n<m1
                    SatPosX(1,n)=SatPos(1,n);%Koordinaty obichnih mayakov
                    SatPosX(2,n)=SatPos(2,n);
                    n=n+1;
                end
                SizeSatPosX=size(SatPosX);
                SizeSat=SizeSatPosX(1,2);
                if SizeSat<2
                    set(handles.varning,'String','the data entered is incorrect');
                    set(handles.varning,'ForegroundColor',[1 0 0]);
                else
                    set(handles.varning,'String','');
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
                        set(handles.varning,'String','the data entered is incorrect');
                        set(handles.varning,'ForegroundColor',[1 0 0]);
                    elseif SizePosX1==1
                        set(handles.varning,'String','the data entered is incorrect');
                        set(handles.varning,'ForegroundColor',[1 0 0]);
                    else
                        set(handles.varning,'String','');
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
                            set(handles.varning,'String','the data entered is incorrect');
                            set(handles.varning,'ForegroundColor',[1 0 0]);
                        else
                            set(handles.varning,'String','');
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
                            surf(X,Y,Z);
                            shading interp;%Sglagivanie
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
                            plot3(XM(in&~on),YM(in&~on),inr,'g.','MarkerSize',20);%Mayaki v komnate
                            plot3(XM(~in),YM(~in),onr,'r.','MarkerSize',20);%Mayaki vne komnati
                        end
                    end
                end
            elseif vD==1 && vRD==0
                set(handles.varning,'String','');
                %% Расчет градиентной матрицы
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
                surf(X,Y,Z);
                shading interp;%Sglagivaem
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
                plot3(XM(in&~on),YM(in&~on),inr,'g.','MarkerSize',20);%Mayaki v komnate
                plot3(XM(~in),YM(~in),onr,'r.','MarkerSize',20);%Mayaki vne komnati
            else
                set(handles.varning,'String','the data entered is incorrect');
                set(handles.varning,'ForegroundColor',[1 0 0]);
            end
        end
    end
end
guidata(hObject,handles)


% --- Executes on button press in D.
function D_Callback(hObject, eventdata, handles)
% hObject    handle to D (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of D




% --- Executes on button press in RD.
function RD_Callback(hObject, eventdata, handles)
% hObject    handle to RD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of RD



function ap_Callback(hObject, eventdata, handles)
% hObject    handle to ap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ap as text
%        str2double(get(hObject,'String')) returns contents of ap as a double


% --- Executes during object creation, after setting all properties.
function ap_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function bp_Callback(hObject, eventdata, handles)
% hObject    handle to bp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of bp as text
%        str2double(get(hObject,'String')) returns contents of bp as a double


% --- Executes during object creation, after setting all properties.
function bp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function shag_Callback(hObject, eventdata, handles)
% hObject    handle to shag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of shag as text
%        str2double(get(hObject,'String')) returns contents of shag as a double


% --- Executes during object creation, after setting all properties.
function shag_CreateFcn(hObject, eventdata, handles)
% hObject    handle to shag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in clearroom.
function clearroom_Callback(hObject, eventdata, handles)
% hObject    handle to clearroom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles=guidata(hObject);
cla;
handles.BoxPosTABLO=[];
BoxPosTABLO=handles.BoxPosTABLO;
set(handles.TABLO1,'Data',BoxPosTABLO);
XM=handles.XM;
YM=handles.YM;
v=isempty(YM);
if v==0
    %% MAYAKI
    plot(XM,YM,'ro');
    handles.BoxPos=[];
    handles.aa=[];
    handles.bb=[];
    handles.j=[];
elseif v==1
    handles.BoxPos=[];
    handles.aa=[];
    handles.bb=[];
    handles.j=[];
end
guidata(hObject,handles);



% --- Executes on button press in clearm.
function clearm_Callback(hObject, eventdata, handles)
% hObject    handle to clearm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles=guidata(hObject);
cla;
handles.SatPosTABLO=[];
SatPosTABLO=handles.SatPosTABLO;
set(handles.TABLO,'Data',SatPosTABLO);
BoxPos=handles.BoxPos;
v=isempty(BoxPos);
if v==0
    j=handles.j;
    %% ROOM
    n=1;
    while n<=j
        if n>1
            for n=n:n
                plot(BoxPos(1,(n-1):n),BoxPos(2,(n-1):n),'k','LineWidth',5);%Postroenie komnati
            end
        end
        n=n+1;
    end
    plot(BoxPos(1,j:(j+1)),BoxPos(2,j:(j+1)),'k','LineWidth',5);%Soedinenie pervoi i posledney tochki
    handles.SatPos=[];
    handles.XM=[];
    handles.YM=[];
    handles.m1=[];
    handles.k=[];
elseif v==1
    handles.SatPos=[];
    handles.XM=[];
    handles.YM=[];
    handles.m1=[];
    handles.k=[];
end
guidata(hObject,handles);



% --- Executes on button press in clearall.
function clearall_Callback(hObject, eventdata, handles)
% hObject    handle to clearall (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles=guidata(hObject);
cla;
handles.SatPosTABLO=[];
SatPosTABLO=handles.SatPosTABLO;
set(handles.TABLO,'Data',SatPosTABLO);
handles.BoxPosTABLO=[];
BoxPosTABLO=handles.BoxPosTABLO;
set(handles.TABLO1,'Data',BoxPosTABLO);
handles.XM=[];
handles.YM=[];
handles.BoxPos=[];
handles.aa=[];
handles.bb=[];
handles.k=[];
handles.j=[];
guidata(hObject,handles);


% --- Executes on button press in clearGDOP.
function clearGDOP_Callback(hObject, eventdata, handles)
% hObject    handle to clearGDOP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles=guidata(hObject);
cla;
BoxPos=handles.BoxPos;
j=handles.j;
aa=handles.aa;
bb=handles.bb;
XM=handles.XM;
YM=handles.YM;
%% ROOM
n=1;
while n<=j
    if n>1
        for n=n:n
            plot(BoxPos(1,(n-1):n),BoxPos(2,(n-1):n),'k','LineWidth',5);%Postroenie komnati
        end
    end
    n=n+1;
end
plot(BoxPos(1,j:(j+1)),BoxPos(2,j:(j+1)),'k','LineWidth',5);%Soedinenie pervoi i posledney tochki
%% MAYAKI
plot(XM,YM,'ro');
%% VIDIMOST' MAYAKOV VNE KOMNATI
[in,on]=inpolygon(XM,YM,aa,bb);
plot(XM(in&~on),YM(in&~on),'g.','MarkerSize',20);%Mayaki v komnate
plot(XM(~in),YM(~in),'r.','MarkerSize',20);%Mayaki vne komnati
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
plot3(XM(in&~on),YM(in&~on),inr,'g.','MarkerSize',20);%Mayaki v komnate
plot3(XM(~in),YM(~in),onr,'r.','MarkerSize',20);%Mayaki vne komnati
guidata(hObject,handles);


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in create.
function create_Callback(hObject, eventdata, handles)
% hObject    handle to create (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles=guidata(hObject);
a=get(handles.ap,'string');
a=str2double(a);
b=get(handles.bp,'string');
b=str2double(b);
if (a~=a);
    set(handles.varning,'String','the data entered is incorrect');
    set(handles.varning,'ForegroundColor',[1 0 0]);
elseif (b~=b);
    set(handles.varning,'String','the data entered is incorrect');
    set(handles.varning,'ForegroundColor',[1 0 0]);
else
    set(handles.varning,'String','');
    if a==0 || b==0
        set(handles.varning,'String','the data entered is incorrect');
        set(handles.varning,'ForegroundColor',[1 0 0]);
    else
        set(handles.varning,'String','');
        axis([0 a 0 b]);%Razmer komnati v santimetrah
        hold on;
        handles.a=a;
        handles.b=b;
    end
end
guidata(hObject,handles);


% --- Executes on button press in good.
function good_Callback(hObject, eventdata, handles)
% hObject    handle to good (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in bad.
function bad_Callback(hObject, eventdata, handles)
% hObject    handle to bad (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in saveroom.
function saveroom_Callback(hObject, eventdata, handles)
% hObject    handle to saveroom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles=guidata(hObject);
BoxPos=handles.BoxPosSave;
fileID=fopen('my_file.txt','w');%Sohranenie koordinat yglov v fail
fprintf(fileID,'% 3.2f% 3.2f\r\n',BoxPos);
fclose(fileID);
guidata(hObject,handles);


% --- Executes on button press in savebeacon.
function savebeacon_Callback(hObject, eventdata, handles)
% hObject    handle to savebeacon (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles=guidata(hObject);
SatPos=handles.SatPosSave;
fileID=fopen('my_file2.txt','w');%Sohranenie koordinat mayakov v fail
fprintf(fileID,'% 3.2f% 3.2f\r\n',SatPos);
fclose(fileID);
guidata(hObject,handles);

% --- Executes on button press in loadroom.
function loadroom_Callback(hObject, eventdata, handles)
% hObject    handle to loadroom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles=guidata(hObject);
BoxPos=load('my_file.txt');
BoxPos=BoxPos';
j1=size(BoxPos);
j=j1(1,2);%j=kolichestvo yglov komnati
if j==0
    set(handles.varning,'String','the data entered is incorrect');
    set(handles.varning,'ForegroundColor',[1 0 0]);
elseif j==1
    set(handles.varning,'String','the data entered is incorrect');
    set(handles.varning,'ForegroundColor',[1 0 0]);
elseif j==2
    set(handles.varning,'String','the data entered is incorrect');
    set(handles.varning,'ForegroundColor',[1 0 0]);
else
    set(handles.varning,'String','');
    n=1;
    while n<=j
        if n>1
            for n=n:n
                plot(BoxPos(1,(n-1):n),BoxPos(2,(n-1):n),'k','LineWidth',5);%Postroenie komnati
            end
        end
        n=n+1;
    end
    BoxPos(1,n)=BoxPos(1,1);
    BoxPos(2,n)=BoxPos(2,1);
    plot(BoxPos(1,j:(j+1)),BoxPos(2,j:(j+1)),'k','LineWidth',5);%Soedinenie pervoi i posledney tochki
    n=1;
    while n<=j
        aa(1,n)=BoxPos(1,n);%aa-Massiv s koordinatami komnati po osi OX
        bb(1,n)=BoxPos(2,n);%bb-Massiv s koordinatami komnati po osi OY
        n=n+1;
    end
    BoxPosTABLO(:,1)=[aa];
    BoxPosTABLO(:,2)=[bb];
    handles.BoxPosTABLO=BoxPosTABLO;
    BoxPosTABLO=handles.BoxPosTABLO;
    set(handles.TABLO1,'Data',BoxPosTABLO);
    BoxPos(1,n)=BoxPos(1,1);
    BoxPos(2,n)=BoxPos(2,1);
    aa(1,n)=BoxPos(1,n);
    bb(1,n)=BoxPos(2,n);
    handles.BoxPos=BoxPos;
    handles.aa=aa;
    handles.bb=bb;
    handles.j=j;
    guidata(hObject,handles);
end





% --- Executes on button press in loadbeacon.
function loadbeacon_Callback(hObject, eventdata, handles)
% hObject    handle to loadbeacon (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles=guidata(hObject);
SatPos=load('my_file2.txt');%Zagryzka koordinat mayakov iz faila
SatPos=SatPos';
k1=size(SatPos);
k=k1(1,2);%k=kolichestvo mayakov
if k==0
    set(handles.varning,'String','the data entered is incorrect');
    set(handles.varning,'ForegroundColor',[1 0 0]);
elseif k==1
    set(handles.varning,'String','the data entered is incorrect');
    set(handles.varning,'ForegroundColor',[1 0 0]);
else
    set(handles.varning,'String','');
    n=1;
    while n<=k%k-Kollichestvo mayakov
        XM(n,1)=SatPos(1,n);%XM-Massiv s koordinatami mayakov po osi OX
        YM(n,1)=SatPos(2,n);%YM-Massiv s koordinatami mayakov po osi OY
        n=n+1;
    end
    plot(XM,YM,'ro');
    SatPosTABLO(:,1)=[XM];
    SatPosTABLO(:,2)=[YM];
    handles.SatPosTABLO=SatPosTABLO;
    SatPosTABLO=handles.SatPosTABLO;
    set(handles.TABLO,'Data',SatPosTABLO);
    SatPos=[XM,YM]';%SatPos-Massiv s koordinatami vseh mayakov
    %% MAYAKI VNE/VNYTRI KOMNATI
    aa=handles.aa;
    bb=handles.bb;
    [in,on]=inpolygon(XM,YM,aa,bb);
    plot(XM(in&~on),YM(in&~on),'g.','MarkerSize',20);%Mayaki v komnate
    plot(XM(~in),YM(~in),'r.','MarkerSize',20);%Mayaki vne komnati
    handles.k=k;
    handles.XM=XM;
    handles.YM=YM;
    guidata(hObject,handles);
end
