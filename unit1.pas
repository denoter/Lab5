unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, TAGraph, TASeries, Forms, Controls, Graphics,
  Dialogs, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Chart1: TChart;
    Chart1LineSeries1: TLineSeries;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);

  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;
  x,a,b,e,h,y,del:real;

implementation
{$R *.lfm}
{ TForm1 }
function f1(z:real):real;
 begin
   f1:=sqr(z)+ln(z)-4;
 end;
function f2(z:real):real; // производная  f(a) * f(b) >0 net korney
 begin
    f2:=2*z+1/z;
 end;
function FV(x:real):real;
begin
Fv:=sqr(x)*arctan(x)-1;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
a:=StrToFloat(edit1.text);
b:=StrToFloat(edit2.text);
e:=StrToFloat(edit3.text);
h:=abs((a-b)/10);
x:=a;
while x<=b do
      begin
       y:=f1(x);
       Chart1LineSeries1.addXY(x,y, '',clBlack);
       x:=x+h;
      end;
if f1(a)*f1(b)>0 then
memo1.lines.add('Корней нет')
else

if f1(a)*f2(a)>0 then x:=a
    else x:=b;
del:=1;
 while del>e do
    begin
       y:=x-f1(x)/f2(x);        // h=|a-b|/10 y=f1(x) x:=x+h
       del:=abs(y-x);
         x:=y;
       memo1.lines.add(floattostrf(x,fffixed,6,5)+' '+' '+floattostrf(f1(x),fffixed,6,5));

    end;
 memo1.lines.add(('Конечный корень'+' '+floattostrf(x,fffixed,6,5)));


end;

procedure TForm1.Button2Click(Sender: TObject);
var a,b,c,x:real;
    code:integer;
begin
val(Edit1.text,a,code);
if code=0 then
   begin
   val(Edit2.text,b,code);
   if code=0 then
      begin
//a:=strtofloat(Edit1.text);
//b:=strtofloat(Edit2.text);
      memo1.lines.add('Отрезок ['+floattostr(a)+';'+floattostr(b)+']');

      if Fv(a)*Fv(b)<0 then
      begin
      //Рисуем график
      x:=a;
      while x<b do
         begin
         Chart1LineSeries1.AddXY(x,Fv(x));
         x:=x+abs(b-a)/12;
         end;

      memo1.lines.add('Промежуточные корни');
      repeat
         c:=(a+b)/2;
         memo1.lines.add(floattostr(c));
         if Fv(a)*Fv(c)<0 then b:=c
                        else a:=c;
      until b-a<e ;
      x:=(a+b)/2;
      end
      else x:=a-1;
      if x<a then memo1.lines.add('На данном интервале нету корней')
             else memo1.lines.add('Ответ: '+floattostr(x));
      end
   else ShowMessage('Данные введены не корректно');
   end
else ShowMessage('Данные введены не корректно');
end;

end.

