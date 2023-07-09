type
  poezd = record
    Nomer, Nazvanie, VremiaPrib, VremiaOtpr: string;
  end;

var
  f: text; 
  s: string; 
  duck: poezd;
  i, ChasPrib, MinPrib, ChasOtpr, MinOtpr, err, 
  Chas, Min: integer; 
  c: char;

function Vremia(vr: string; var ch, min: integer): integer;
//функция выделяет из строки со временем часы и минуты.Возвращает коды ошибок полученные из val; ноль, если всё хорошо 
var
  err1, err2: integer;
begin
  val(copy(vr, 1, 2), ch, err1); 
  val(copy(vr, 4, 2), min, err2); 
  Vremia := err1 + err2; 
end;

begin
  readln(s); 
  if Vremia(s, Chas, Min) > 0 
    then writeln() 
  else begin
    assign(f, 'data.txt'); 
    reset(f);  
    while not eof(f) do 
    begin
      readln(f, s);  
      i := pos(',', s);  
      duck.Nomer := copy(s, 1, i - 1); 
      delete(s, 1, i); 
      i := pos(',', s);  
      duck.Nazvanie := copy(s, 1, i - 1); 
      delete(s, 1, i); 
      i := pos(',', s); 
      duck.VremiaPrib := copy(s, 1, i - 1); 
      delete(s, 1, i); 
      duck.VremiaOtpr := s; 
      err := Vremia(duck.VremiaPrib, ChasPrib, MinPrib); 
      err := err + Vremia(duck.VremiaOtpr, ChasOtpr, MinOtpr);  
      if err = 0 then 
        if ((Chas > ChasPrib) or ((Chas = ChasPrib) and (Min >= MinPrib))) and 
        ((Chas < ChasOtpr) or ((Chas = ChasOtpr) and (Min < MinOtpr)))  
        then 
        begin
          writeln(duck.Nomer, ' ', duck.Nazvanie); 
        end; 
    end; 
    close(f); 
  end; 
end.
