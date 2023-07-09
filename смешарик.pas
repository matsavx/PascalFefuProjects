uses GraphABC;

type 
  Smesharik = abstract class 
  protected
    x,y:integer;// координата, где роддается смешарик
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
          s:=10;
          self.s:=s;
      end;

  public create:
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
        setBrushColor(dSkyBlue);
        FillCircle(x,y,s);
      end;

    procedure action(step:integer); override;
      begin

        LockDrawing;
        for var i:= 1 to 1000 do
          begin
            Window.Clear;
            draw;
            py:=py+step;
            Redraw;
            sleep(5);
            Window.Clear;
            draw;
            py:=py-step;
            Redraw;
            sleep(5);
          end;
      end;
end;

var slava:Bun; 
  begin
    slava:=new Bun (-10,-10,-10); clSkyBlue;
    slava.draw;
    slava.action(slava.ps*2);
    slava:=nil;
  end.



