const n=20;
type Tsubject=set of char;
type Tstudent=record
name: string;
subject:Tsubject;
end;
var 
student:array[1..n] of Tstudent;
subject:Tsubject;
f:text;
s:string;
i:byte;
subs:char;
begin
subject:=['ф','х','м'];
assign(f,'sub.txt');
reset(f);
i:=1;
while not eof(f) do
begin
readln(f,s);
student[i].name:=copy(s,1,pos(' ',s)-1);
delete(s,1,pos(' ',s));
subs:='';
while not eoln(s)<>0 do
begin
if pos(',',s)=0 then
subs:=copy(s,1,length(s))
else
subs:=copy(s,1,pos(',',s)); 
if subs in subject then
include(student[i],subject,subs);
delete(s,1,pos(',',s));
end;
i:=i+1;
end;
close(f);
end.