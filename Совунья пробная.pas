uses GraphABC;

type 
  Smesharik = abstract class 
  protected
    x,y:integer;// координата, где рождается смешарик
    s:integer;//размер смешарика

    procedure setX(x:integer);
      begin
        if x<=0 then
          x:=WindowWidth div 2;//ширина объекта
          self.x:=x;
      end;

    procedure setY(y:integer);
      begin
        if y<=0 then
          y:=WindowHeight div 2;//высота объекта
          self.y:=y;
      end;

    procedure setS(s:integer);
      begin
        if s<=0 then
          s:=100;
          self.s:=s;
      end;

  public
    constructor (x,y,s:integer);
      begin
        px:=x;
        py:=y;
        ps:=s;
      end;

    procedure draw;
      abstract;

    procedure action(dy:integer);
      abstract;

    property px:integer read x write setX;

    property py:integer read y write setY;

    property ps:integer read s write setS;

  end;

  bun = class(Smesharik)
    public
      c:color;
    constructor(x,y,s:integer; c:color);
      begin
        inherited create(x,y,s);//поспользоваться
        self.c:=c;
      end;
    
     procedure draw; override;
      begin
        hat();
        ears();
        ears2();
        legs();
        telo();
        eyes();
        nose();
      end;

    procedure action(step:integer); override;
      var y1,y2:integer;
      begin
        LockDrawing;
        y1:=py - WindowHeight div 2;//Верхняя точка
        y2:=py + WindowHeight div 2;//Нижняя точка
        for var i:= 1 to 1000 do
          begin
            while (py-ps-(ps div 2) - (ps div 7))>=y1 do//Двигаться вверх, пока бубончик не заденет верха экрана
              begin
                setBrushColor(clIndigo);
                Window.Clear;
                FillEllipse(px-ps-(ps div 2), py-(ps div 8), px+ps+(ps div 2), py+(ps div 2));
                draw;
                py:=py-step div 20;
                Redraw;
                window.Clear;
                setBrushColor(clIndigo);
                FillEllipse(px-ps-(ps div 2), py-(ps div 4), px+ps+(ps div 2), py+(ps div 4));
                draw;
                Redraw;
                sleep(10);
              end;
            while py+ps+(ps div 2)+(ps div 10) <= y2 do//Двигаться вниз, пока лапы не заденут низа экрана 
              begin
                setBrushColor(clIndigo);
                Window.Clear;
                FillEllipse(px-ps-(ps div 2), py-(ps div 8), px+ps+(ps div 2), py+(ps div 2));
                draw;
                py:=py+step div 20;
                Redraw;
                window.Clear;
                setBrushColor(clIndigo);
                FillEllipse(px-ps-(ps div 2), py-(ps div 4), px+ps+(ps div 2), py+(ps div 4));
                draw;
                Redraw;
                sleep(10);
              end;
          end;
      end;

    private
    procedure telo();
      begin
        setBrushColor(clIndigo);
        FillCircle(px,py,(ps+2));
        setBrushColor(clMediumPurple);
        FillCircle(px,py,ps);
      end;

    procedure eyes();
      begin
        var x1, x2,y1,y2, size: integer;
      y1:=py - (ps div 4);
      y2:=py - (ps div 4);
      x1 := px - (ps div 4);
      x2 := px + (ps div 4);
      size := (ps div 3);
      //Глаза
      setBrushColor(clIndigo);
      FillCircle(x1, y1, size);
      FillCircle(x2, y2, size);
      setBrushColor(clWhite);
      FillCircle(x1, y1, size+1);
      FillCircle(x2, y2, size+1);
      //Зрачки
      setBrushColor(clBlack);
      FillCircle(x1, y1, size div 3);
      FillCircle(x2, y2, size div 3);
      end;

    procedure nose();
       begin
         setBrushColor(clOrange);
         FillCircle(px,py + (ps div 10),ps div 4);
         SetPenWidth(ps div 50); 
         line(px-(ps div 4), py + (ps div 10), px+ (ps div 4), py + (ps div 10), clPurple);
       end;

    procedure ears();
      begin
        //Левое ухо
        SetPenWidth(ps div 21); 
        line(px-ps,py-ps-(ps div 20), px-ps+(ps div 10), py, clIndigo);//1,2
        line(px-ps,py-ps-(ps div 20), px, py-ps+(ps div 5), clIndigo);//1,3
        line(px-ps+(ps div 10), py, px, py-ps+(ps div 5), clIndigo);//2,3
        floodfill(px-ps+(ps div 10),py-ps+(ps div 20), clMediumPurple);
        //Правое ухо
        line(px+ps,py-ps-(ps div 20), px+ps-(ps div 10), py, clIndigo);//1,2
        line(px+ps,py-ps-(ps div 20), px, py-ps+(ps div 5), clIndigo);//1,3
        line(px+ps-(ps div 10), py, px, py-ps+(ps div 5), clIndigo);//2,3
        floodfill(px+ps-(ps div 10),py-ps+(ps div 20), clMediumPurple);
      end;

    procedure ears2();
      begin
        setBrushColor(clIndigo);
        FillCircle(px-ps,py-ps-(ps div 20), ps div 8);//Левая мочка
        FillCircle(px+ps,py-ps-(ps div 20), ps div 8);//Правая мочка
      end;

    procedure hat();
      begin
        //Шапка
        SetPenWidth(ps div 21);
        line(px, py-ps-(ps div 2), px-ps+(ps div 5), py, clPurple);
        line(px, py-ps-(ps div 2), px+ps-(ps div 5), py, clPurple);
        line(px-ps+(ps div 5), py, px+ps-(ps div 5), py, clPurple);
        floodfill(px, py-ps, clDarkOrange);
        //полоса на шапке
        SetPenWidth(ps div 10);
        line(px - (ps div 5), py-ps-(ps div 6), px + (ps div 5), py-ps-(ps div 6), clPurple);
        //Бубончик
        setBrushColor(clPurple);
        FillCircle(px, py-ps-(ps div 2), ps div 7);
      end;


    procedure legs();
      begin
        SetPenWidth(ps div 10);
        SetPenColor(clIndigo);
        line(px-(ps div 4), py, px-(ps div 4), py+ps+(ps div 2)+(ps div 10));//Левая нога
        line(px-(ps div 4), py+ps+(ps div 3), px-(ps div 4)-(ps div 4), py+ps+(ps div 2));//левый левый коготь
        line(px-(ps div 4), py+ps+(ps div 3), px-(ps div 4)+(ps div 4), py+ps+(ps div 2));//левый правый коготь
        line(px+(ps div 4), py, px+(ps div 4), py+ps+(ps div 2)+(ps div 10));// Правая нога
        line(px+(ps div 4), py+ps+(ps div 3), px+(ps div 4)-(ps div 4), py+ps+(ps div 2));//Правый левый коготь
        line(px+(ps div 4), py+ps+(ps div 3), px+(ps div 4)+(ps div 4), py+ps+(ps div 2));//Правый правый коготь
      end;

end;

var sovuniya:Bun; 
  begin
    sovuniya:=new Bun (-10,-10,-10, clPurple);
    sovuniya.draw;
    sovuniya.action(sovuniya.ps);
    sovuniya:=nil;
  end.



