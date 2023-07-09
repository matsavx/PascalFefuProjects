program laba6;

type tNode=^elem;
elem = record
next: tNode;
prev: tNode;
data:integer;
end;

var p,e,v:tNode;
    head,tail: tNode;
    h1,h2:tNode;
    n,i,z,j:integer;

procedure fill(var p: tNode);//Создание и заполнение списка
	var k:integer;
	begin 
	  k:=n;
	  p:=nil;
	  new(v);
	  e:=v;
	  head:=e;
	  tail:=e;
	  e^.next:=e;//Закольцовываем
	  e^.prev:=e;
	  for k:=1 to k do//непосредственно цикл заполения не нарушая закольцованности
	    begin
          writeln('Введите элемент номер ', k, ':');
              new(p);
              readln(e^.data);
              head:=p;
              p^.next:=e;
              e^.prev:=head;
              p^.prev:=tail;
              tail^.next:=head;
              e:=p;
        end;
    end;

procedure delete(var h1,h2:tNode);//Удаление указанного количества элементов списка
	var i:integer;
    begin
      h1:=tail;
      for i:=1 to i do
        begin
          h2:=h1^.prev;
          dispose(h1);
        end;
    end; 

procedure added(var p:tNode);//добавление после каждого вхождения заданного
  var j1,z1:integer;
  begin
    j1:=j;
    z1:=z;
    e:=head;
    e:=e^.next;
      for var m:=1 to n do
        begin
        if e^.data=z1 then
          for j1:=1 to j1 do
          begin
            new(p);
            writeln('Введите новый элемент списка номер ', j1, ':');
            readln(p^.data);
            p^.next:=e^.next;
            p^.prev:=e;
            e^.next:=p;
            e^.next^.prev:=p;
            e:=p;
          end
        else
          e:=e^.next;
      end;
  end;      

  begin
    writeln('Введите количество элементов списка: ');
  	readln(n);
    fill(p);
    e:=e^.next;
    for n:=1 to n do
      begin
      write(e^.data, ' ');
      e:=e^.next;
      end;
    writeln;
    writeln('Введите количество элементов, которые Вы хотите удалить с конца списка: ');
    readln(i);
    delete(h1,h2);
    e:=e^.next;
    for n:=1 to n-i do
      begin
      write(e^.data, ' ');
      e:=e^.next;
      end;
    writeln;
    writeln('Введите элемент, после которого хотите вводить новые элементы списка: ');
    readln(z);
    writeln('Введите количество элементов: ');
    readln(j);
    added(p);
    e:=head;
    e:=e^.next;
    for n:=1 to n+j do
    begin
    write(e^.data, ' ');
    e:=e^.next;
    end;
  end.
