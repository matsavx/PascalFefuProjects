Type student=record
Surname:string[20];
Name: string[10];
Secondname:string[50];
End;
var
s:student;
a:array[1..100] of student;
for i:=1 to N-1
for j:=1 to N-i
if (a[j].surname>a[j+1].surname) or ((a[j].surname=a[j+1].surname)and(a[j].name>a[j+1].name))or((a[j].surname=a[j+1].surname)and(a[j].name=a[j+1].name)and(a[j].secondname>a[j+1].secondname)) then
swap(a[j],a[j+1]);
end.
