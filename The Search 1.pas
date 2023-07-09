program TheSearch1;

const N = 5;

type
	matrix = array [1..N, 1..N] of integer;
	vector = array [1..N] of integer;
	vector2 = array [1..N+1] of integer;

var
	f: text;
	str: string;
	i,j, err1, data, run, key, glob: integer;
	x: matrix;
	y: vector;
	z: vector2;


function Fill(var x1: matrix): boolean;
	begin
		for var i:= 1 to N do
			begin
				for var j:= 1 to N do
					begin
						readln(f,str);
						val(str, data, err1);
						x1[i,j]:=data;
					end;
			end;

		for var i:= 1 to N do
			begin
				for var j:=1 to N do
					begin
						write(x1[i,j]);
						write(' ');
					end;
				writeln();
			end;
	Fill:= true;
	end;


function line_poisk (y2:vector; run2: integer; key2: integer): integer;
var count: integer;
	check:boolean;
begin
	count:= 1;

	while (check = false) and (count <= run2) do
		begin
			if (y2[count] = key2) then check:= true
			else inc(count);
		end;
	if count <= run2 
	   then line_poisk := count
		 else line_poisk := 0;
		
end;


function line(var y1:vector; run1: integer; key1: integer): boolean;
	var j0: integer;
		yes: boolean;
	begin
		j0:=1;
		line:=false; 
		for run1:= 1 to N do
			begin
				i:= N;
				j:= run1;
				for var z:= 1 to run1 do
					begin
						y1[z]:=x[i,j];
						dec(i);
						dec(j);
					end;

				writeln('Найдено совпадение в диагонали, параллельной главной, номер: ', run1, ' Номер элемента в данной диагонали: ', line_poisk(y1,run1,key1));
		      	line:=true;
			end;

		for run1:= (N-1) downto 1 do
			begin
				i:= run1;
				j:= N;
				for var z:= 1 to run1 do
					begin
						y1[z]:=x[i,j];
						dec(i);
						dec(j);
					end;
						writeln('Найдено совпадение в диагонали, параллельной главной, номер: ', run1, ' Номер элемента в данной диагонали: ', line_poisk(y1,run1,key1));
						line:=true;
			end;
end;

function barrier_poisk(z2:vector2; run2:integer; key2:integer):integer;
var count:integer;
begin
	count:= 1;
	z2[N+1]:=key2;
	while (z2[count] <> key2) do
		inc(count);
	if count <= run2
		then barrier_poisk := count
		 else barrier_poisk := 0;
end;

function barrier (var z1:vector2; run1: integer; key1: integer): boolean;
	var count, j0: integer;
	yes: boolean;
	begin
		j0:=1;
		barrier:=false; 
		for run1:= 1 to N do
			begin
				i:= N;
				j:= run1;
				for var z:= 1 to run1 do
					begin
						z1[z]:=x[i,j];
						dec(i);
						dec(j);
					end;
				writeln('Найдено совпадение в диагонали, параллельной главной, номер: ', run1, ' Номер элемента в данной диагонали: ', barrier_poisk(z1,run1,key1));
				barrier:=true;
			end;

		for run1:= (N-1) downto 1 do
			begin
				i:= run1;
				j:= N;
				for var z:= 1 to run1 do
					begin
						z1[z]:=x[i,j];
						dec(i);
						dec(j);
					end;
				writeln('Найдено совпадение в диагонали, параллельной главной, номер: ', run1, ' Номер элемента в данной диагонали: ', barrier_poisk(z1,run1,key1));
				barrier:=true;
			end;
end;	

begin
	assign(f, 'searchmatrix.txt');
	reset(f);

		Fill(x);

		writeln('Ключ: ');
		readln(key);
		writeln('Линейный поиск:');
		if not line(y,run,key) then
			writeln('Не нашла');
		writeln();
		writeln('Линейный поиск с барьером:');
		if not barrier(z,run,key) then
			writeln('Не нашла');
		close(f);
end.