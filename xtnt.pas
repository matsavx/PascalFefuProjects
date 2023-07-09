program laba6;
type tNode=^elem;
elem = record
next: tNode;
prev: tNode;
data:integer;
end;

var p,e,v:tNode;
    head,tail: tNode;
    h1,h2,runner,list:tNode;
    n,i,j,k,l,u,size:integer;
    param:byte;

procedure fill(var p: tNode);//Создание и заполнение списка
  var n:integer;
  runner:tNode;
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
    writeln('Список:');
    for var q:=1 to k do
      begin
      write(runner^.data, ' ');
      runner:=runner^.next;
      end;
    writeln;
    end;

procedure delete(var h1,h2:tNode);//Удаление указанного количества элементов списка
    begin
      e:=head;
      k:=k;
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
        for var q:=1 to k do
          begin
          write(e^.data, ' ');
          e:=e^.next;
          end;
      writeln;
    end; 

procedure AddElement(var runner: tnode; var head: tnode; var list: tnode; var size: integer; var param: byte);
	var
		i: integer;
		command: byte;
		number, valueAdd: Integer;
		temp: tnode;
	begin
	    size:=k;
		runner:= head;
		  case param of
			1: if size = 0 then
				writeln('Список пуст, добавление элемента невозможно!')
				else
			      begin
					writeln('Введите значение: ');
					read(valueAdd);

						for var j:= 1 to (size - 1) do
							runner:= runner^.next;	
							temp:= runner;
							New(list);
							temp^.next:= list;
							list^.next:= head;
							list^.data:= valueAdd;
							size:= size + 1;
							writeln('Элемент добавлен!');
						end;
			2: if size = 0 then
				writeln('Список пуст, добавление элемента невозможно!')
				else
				  begin
					writeln('Введите значение, которое нужно добавить: ');
					read(valueAdd);
					writeln('Введите значение элемента, перед которым нужно добавить: ');
					read(number);

					while i <> size do
					  begin
						if runner^.next^.data = number then
						  begin
							  temp:= runner^.next;
							  New(list);
							  runner^.next:= list;
							  list^.next:= temp;
							  list^.data:= valueAdd;
							  size:= size + 1;
							  runner:= runner^.next^.next;
							  i:= i + 1;
						  end
					    else
						  runner:= runner^.next;	
					    i:= i + 1;
				      end;
					  writeln('Элементы добавлены!');
				      end;
			end; 
	end;

procedure maximum(var e:tNode);
    var n:integer;
        max:tNode;
    begin
      e:=head;
      max:=e;
      n:=0;
      while e<>tail do 
      begin
        n:=n+1;
        e:=e^.next;
      end;
      e:=head^.next;
      for var q:=1 to n do
        begin
          if e^.data>max^.data then
            begin
              max:=e;
              e:=e^.next;
            end
          else
            e:=e^.next;
        end;
      writeln('Максимальный элемент данного списка:');
      writeln(max^.data);
    end; 

procedure change (tail,head:tNode);
  var m1,m2,temp:tNode;
      n:integer;
  begin
    k:=k;
    i:=l;
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
    writeln(head^.data, ' ', tail^.data);
    writeln('Список с измененными первым и последним элементами:');
    e:=head;
    for var q:=1 to k do
      begin
        write(e^.data, ' ');
        e:=e^.next;
      end;
    writeln;
  end;

procedure clean(var h1:tNode);
  begin
    i:=l;
    j:=u;
    for var y:=1 to k+j-i do 
      begin
        h1:=head;
        head:=head^.next;
        dispose(h1);
      end;
  end;

  begin
    writeln('Введите количество элементов списка: ');
    readln(k);
    fill(p);
    maximum(e);
    writeln('Введите количество элементов, которые Вы хотите удалить с конца списка: ');
    readln(l);
    delete(h1,h2);
    maximum(e);
    //added(p);
    AddElement(runner, head, list, size, param);
    maximum(e);
    change(tail,head);
    writeln('Список был автоматически очищен.')
  end.
