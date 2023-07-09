program sortirovka1;

type Nvector = record
	vector: array [0..100000] of  longint;
end;

var
	y,y1: Nvector;
	n: longint;
	comp,ex,t: integer;

//Надо вывести время, количество сравнений, количество обменов

procedure choice (var time: integer; var comparison: integer; var exchange: integer; var x: Nvector);
var 
	min, key: longint;

begin
	time:=Milliseconds();
	for var i := 1 to n - 1 do 
	begin
	    min := i;
	    for var j := i + 1 to n do
	    	begin
	    		inc(comparison);
		        if x.vector[min] > x.vector[j] then
		            min := j;
	        end;
	    if min<>i then 
	    	begin
	        	key := x.vector[i];
	        	x.vector[i] := x.vector[min];
	        	x.vector[min] := key;
	        	inc(exchange);
	    	end;
	end;
	
	time:=Milliseconds()-time;

	writeln('Отсортированный массив:');
	//for var i:= 1 to n do 
	//	write(y.vector[i], ' | ');

	writeln();

	write('Время сортировки: ', time/1000, ' | Количество сравнений: ', comparison, ' | Количество обменов: ', exchange);

end;

procedure binary (var time: integer; var comparison: integer; var exchange: integer; var x: Nvector);
	var 
	left, right, sred, op: longint;

begin
	comparison:=0;
	exchange:=0;
	time:=Milliseconds();
	for var i:=2 to n do
		begin
	  		op:=x.vector[i];{запомним элемент}
	   		left:=1;{левый край}
	   		right:=i-1;{правый}
	   		while left <= right do {пока левый не больше правого}
	    		begin
	     			sred:=(left+right) div 2;{находим середину}
	     			if op < x.vector[sred] then 
	     				begin
	     					right:=sred-1;{если элемент меньше среднего, правый край левее середины}
	     					inc(comparison);
	     				end
	    			else 
	    				begin
	    					left:=sred+1;{иначе левый правее середины}
	    					inc(comparison);
	    				end;
	    		end;
	   		for var j:=i-1 downto left do 
	   			begin
	   				x.vector[j+1]:=x.vector[j];{сдвигаем массив вправо на 1}
	   				inc(exchange);
	   			end;
	   		if x.vector[left] <> op then
	   			begin
	   				x.vector[left]:=op;{вставляем элемент на место}
	   				inc(exchange);
	   			end;
	  	end;
	
	time:=Milliseconds()-time;

	writeln('Отсортированный массив:');
	for var i:= 1 to n do 
		write(y.vector[i], ' | ');

	writeln();

	write('Время сортировки: ', time/1000, ' | Количество сравнений: ', comparison, ' | Количество обменов: ', exchange);

end;


begin
	readln(n);
	t:=milliseconds();
	for var i:= 1 to n do 
		begin
			readln(y1.vector[i]);
			//y1.vector[i]:= random(n);
			//write(y1.vector[i], ' | ');
		end;
	writeln();
	t:=milliseconds()-t;
	writeln();
	writeln('ВРЕМЯ: ', t/1000);
	writeln('----------------------------------------------------------------------------------------------------');
	writeln();

	y:=y1;

	choice(t,comp,ex,y);
	writeln();
	
	y:=y1;
	writeln('-----------------------------------------------------------------------------------------------------------');
	binary(t,comp,ex,y);
end.

