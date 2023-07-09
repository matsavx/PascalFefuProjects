type NodePtr=^node;
	node = record
	data: integer;
	next: NodePtr;
	end;
Var
  sourse, given: NodePtr;

function CommonSequence(sourse, given: NodePtr):boolean;
var Black, BlueFirst, BlueSecond:BeginNodePrt;
begin
	CommonSequence:=false;
	Black:=sourse;
	BlueSecond:=given;//Если BlueSecond=nil, то нашли, если BlueFirst=nil, то гг, Если BlueSecond<>nil, то нет
	while (CommonSequence=false)or((BlueFirst=nil)and(BlueSecond<>nil)) do
	  begin
	    BlueFirst:=Black;
	    BlueSecond:=given;
	    while (BlueFirst<>nil)and(BlueSecond<>nil) do
	      begin
	        if (BlueFirst.data = BlueSecond.data) and ((BlueFirst.next<>nil) and (BlueSecond.next<>nil)) then
	          begin
	            BlueFirst = BlueFirst.next;
