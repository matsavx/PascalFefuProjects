uses GraphABC;

type
	shape = class
	private
	  x,y: integer;
	  r: integer;
	  c:color;
	  class n: integer:= 0;
	  public
	  constructor(xx,yy,rr:integer; cc:color);
	    begin
	      x:=xx;
	      y:=yy;
	      r:=rr;
	      c:=cc;
	      n:=n+1;
	    end;

  class function get_n: integer;
  begin
    Result:=n;
  end;

  procedure draw;
   begin
     SetBrushColor(c);
     FillCircle(x,y,r);
   end;

   procedure move (dx,dy:integer);
    begin
      draw;
      x:= x - dx;
      y:= y + dy;
    end;

    procedure hide;
     begin
       sleep(500);
       ClearWindow;
     end;

     function meet (s:shape): boolean;
       var
         t: shape;
       begin
         result:= ((x - s.x)*(x - s.x)+(y - s.y)*(y - s.y)) <= ((r + s.r)*(r + s.r));
       end;

     function get_x: integer;
       begin
         result:=x;
       end;

     function get_y: integer;
       begin
         result:=y;
       end;

     function get_r: integer;
       begin
         result:=r;
       end;

   end;

 const
   count = 5;
 var
   s:array [1..count] of shape;
   i,j,k:integer;
 begin
   for i:=1 to count do
     s[i]:= shape.create(Random(400), Random(400), 5+Random(10), Clgreen);
   for j:=1 to 100 do
     for i:= 1 to count do
       s[i].move(-5+Random(10), -5+Random(10));
       s[i].hide;
  end.

