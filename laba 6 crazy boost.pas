program laba6;

type tNode=^elem;
elem = record
next: tNode;
prev: tNode;
data:integer;
end;

var head,tail: tNode;//начало и конец списка соответственно
    k,l:integer;//k - текущий размер списка, l - количество элементов для удаления

procedure fill(var p: tNode; k:integer);//Создание и заполнение списка
  var runner,v,e:tNode;//бегунок, e - бегунок, p,v - переменные для добавления элементов в список
  begin 
    p:=nil;
    new(e);
    tail:=e;
    writeln('Введите элемент номер ', 1, ':');
    readln(tail^.data);
    runner:=tail;
    for var i:=2 to k do//непосредственно цикл заполения не нарушая закольцованности
      begin
          writeln('Введите элемент номер ', i, ':');
              new(v);
              runner^.prev:=v;
              readln(runner^.prev^.data);
              runner^.prev^.next:=runner;
              runner:=runner^.prev;
              runner^.prev:=nil;
      end;
    head:=runner;
    head^.prev:=tail;
    tail^.next:=head;
    runner:=head;
    writeln('---------------------------------------------------');
    writeln('Список:');
    for var q:=1 to k do//вывод списка
      begin
      write(runner^.data, ' ');
      runner:=runner^.next;
      end;
    writeln;
    writeln('Размер данного списка: ', k);
    writeln('Первый и последний элементы списка соответственно: ', head^.data, ' ', tail^.data);
    end;

procedure delete(var h1,h2:tNode; l:integer);//Удаление указанного количества элементов списка
    var e:tNode;
    begin
      writeln('---------------------------------------------------');
      e:=head;
      for var q:=1 to l do
        begin
          h1:=tail;
          h2:=h1^.prev;
          h2^.next:=head;
          head^.prev:=h2;
          dispose(h1);
          tail:=h2;
          h1:=h2;
          h2:=h2^.prev;  
        end;
        writeln('Список:');
        e:=head;
        k:=k-l;
        while e<>tail do begin
          write(e^.data, ' ');
          e:=e^.next;
        end;
        write(e^.data, ' ');        
      writeln;
      writeln('Размер данного списка: ', k);
      writeln('Первый и последний элементы списка соответственно: ', head^.data, ' ', tail^.data);
    end; 

procedure added(var p:tNode);//добавление после каждого вхождения заданного
  var z,f:integer;//z - число после которого вводится элемент, f - элемент
      e:tNode;
  begin
    writeln('Введите элемент, после которого хотите вводить новые элементы списка: ');
    readln(z);
    e:=head;
    writeln('Введите новый элемент списка');
    readln(f);
    writeln('---------------------------------------------------');
      while e<>tail do
        begin
          if e^.data=z then
          begin
            new(p);
            p^.data:=f;
            p^.next:=e^.next;
            e^.next^.prev:=p;
            p^.prev:=e;
            e^.next:=p;
            e:=p;
            k:=k+1;
            e:=e^.next;
          end
        else
          e:=e^.next;
      end;
     if e^.data=z then
          begin
            new(p);
            p^.data:=f;
            p^.next:=e^.next;
            e^.next^.prev:=p;
            p^.prev:=e;
            e^.next:=p;
            e:=p;
            k:=k+1;
          end;
    p:=e;
    e:=head;
    while e<>tail do 
      begin
        write(e^.data, ' ');
        e:=e^.next;
      end;
    write(e^.data, ' ');
    write(p^.data, ' ');
    writeln;
    e:=head;
    tail:=e^.prev;
    writeln('Размер данного списка: ', k);
    writeln('Первый и последний элементы списка соответственно: ', head^.data, ' ', tail^.data);
  end; 

procedure maximum(var e:tNode);//Нахождение максимального элемента в текущем списке
    var max:tNode;
    begin
      e:=head;
      max:=e;
      e:=head^.next;
      while e<>head do 
        begin
          if e^.data>max^.data then
            begin
              max:=e;
              e:=e^.next;
            end
          else
            e:=e^.next;
        end;
      write('Максимальный элемент данного списка: ');
      writeln(max^.data);
      writeln('---------------------------------------------------');
    end; 

procedure change (tail,head:tNode);//Смена мест первого и последнего элементов списка
  var m1,m2,temp,e:tNode;
  begin
    m1:=tail^.prev; 
    m2:=head^.next;
    temp:= tail;
    tail:= head;
    head:= temp;
    m1^.next:=tail;
    tail^.prev:=m1;
    tail^.next:=head;
    head^.prev:=tail;
    head^.next:=m2;
    writeln('Список с измененными первым и последним элементами:');
    e:=head;
    while e<>tail do begin
        write(e^.data, ' ');
        e:=e^.next;
      end;
    write(e^.data, ' ');
    writeln;
    writeln('Размер данного списка: ', k);
    writeln('Первый и последний элементы списка соответственно: ', head^.data, ' ', tail^.data);
  end;

procedure clean(var h1:tNode);//Удаление списка
  var e:tNode;
  begin
    while head<>nil do 
      begin
        e:=head;
        head:=head^.next;
        dispose(e);
      end;
    writeln('---------------------------------------------------');
  end;

var e,p:tNode;//e - бегунок, p,v - переменные для добавления элементов в список
    h1,h2:tNode;//переменные для удаления элементов списка
begin
    writeln('Введите количество элементов списка: ');
    readln(k);
    fill(p,k);
    maximum(e);
    writeln('Введите количество элементов, которые Вы хотите удалить с конца списка: ');
    readln(l);
    delete(h1,h2,l);
    maximum(e);
    added(p);
    maximum(e);
    change(tail,head);
    clean(e);
    writeln('Список был автоматически очищен.');
end.
