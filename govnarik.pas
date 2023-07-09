uses GraphABC;

type
  Smesharik = abstract class 
  protected 
    x, y: integer;// координата, где роддается смешарик
    s: integer;//размер смешарика
    
    procedure setX(x: integer);
    begin
      if x <= 0 then
        x := WindowWidth div 2;//ширина объекта
      self.x := x;
    end;
    
    procedure eyesdraw();
    begin
      var x1, x2, size: integer;
      py := py - ((ps * 2) div 5);
      x1 := px + ((ps) div 5);
      x2 := px - ((ps) div 5);
      size := (ps div 6);
      setBrushColor(clDodgerBlue);
      FillCircle(x1, py, (size + 2));
      FillCircle(x2, py, (size + 2));
      setBrushColor(clWhite);
      FillCircle(x1, py, size);
      FillCircle(x2, py, size);
      setBrushColor(clBlack);
      FillCircle(x1, py, size div 2);
      FillCircle(x2, py, size div 2);
      
    end;
    
    procedure nosedraw();
    
    begin
      setBrushColor(clPink);
      FillCircle(px, py + (ps div 7), (ps div 7));
    end;
    
    procedure ushi();
    begin
      setPenColor(clDodgerBlue);
      SetPenWidth(5); //толщина линии границы //цвет границы эллипса
      SetBrushColor(clSkyBlue);
      ellipse(px + (ps div 9), py - (ps div 3), px + (ps div 2), py - (2 * ps));
      ellipse(px - (ps div 9), py - (ps div 3), px - (ps div 2), y - (2 * ps));
      //FloodFill(x+(s div 5),y-s ,clSkyBlue);
      //FloodFill(x-(s div 5),y-s ,clSkyBlue);
    end;
    
    procedure rot();
    
    begin
      setBrushColor(clPink);
      FillCircle(px, (py + (ps div 2)), (ps div 3));
      setBrushColor(clWhite);
      FillCircle(px - (ps div 7), (py + (ps div 2)), (ps div 8));
      FillCircle(px + (ps div 7), (py + (ps div 2)), (ps div 8));
      setPenColor(clSkyBlue); 
      SetBrushColor(clSkyBlue);
      Rectangle(px + (ps div 3), py + (ps div 7), px - (ps div 3), py + (ps div 2));
      //FloodFill(x,y+(s div 4) ,clSkyBlue);
    end;
    
    procedure telo();
    begin
      setBrushColor(clDodgerBlue);
      FillCircle(px, py, (ps + 2));
      setBrushColor(clSkyBlue);
      FillCircle(px, py, ps);
    end;
    
    
    
    
    
    
    
    
    
    
    
    procedure setY(y: integer);
    begin
      if y <= 0 then
        y := WindowHeight div 2;//высота объекта
      self.y := y;
    end;
    
    procedure setS(s: integer);
    begin
      if s <= 0 then
        s := 10;
      self.s := s;
    end;
  
  public 
    constructor(x, y, s: integer);
    begin
      px := x;
      py := y;
      ps := s;
    end;
    
    procedure draw;
      abstract;
    
    procedure action(step: integer);
      abstract;
    
    property px: integer read x write setX;
    
    property py: integer read y write setY;
    
    property ps: integer read s write setS;
  
  end;
  
  bun = class(Smesharik)
  public 
    c: color;
    constructor(x, y, s: integer);
    begin
      inherited create(x, y, s);//
      self.c := c;
    end;
    
    procedure draw; override;
    begin
      ushi();
      telo();
      eyesdraw();
      rot();
      nosedraw();
      
    end;
    
    procedure action(step: integer); override;
    begin
      var x1, x2, a, yc: integer;
      var par: real;
      x1 := px + (WindowWidth div 2);
      x2 := px - (WindowWidth div 2);
      par := -2 * pi;
      yc := windowheight div 2;
      a := 20;
      LockDrawing;
      while (px + s) <= x1 do
      begin
        Window.Clear;
        draw;
        px := px + step;
        py := yc - round(sin(x) * a);
        Redraw;
        sleep(65);
      end;
      
      while ((px - s) - 20) >= x2 do
      begin
        Window.Clear;
        draw;
        px := px - step;
        py := yc - round(sin(x) * a);
        Redraw;
        sleep(65);
      end;
    end;
  end;

var
  krosh: Bun;

begin
  krosh := new Bun(300, 300, 40);
  krosh.draw;
  krosh.action(10);
  
end.



