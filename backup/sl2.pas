unit SL2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, Grids, ComCtrls, fpspreadsheetgrid, fpspreadsheet,
  fpspreadsheetctrls, xlsbiff8, LazUTF8, fpsTypes, dateutils, strutils;

type

  { Txls }

  Txls = class(TForm)
    ApplicationProperties1: TApplicationProperties;
    boton_archivo_1: TButton;
    Button1: TButton;
    Button2: TButton;
    grilla2: TStringGrid;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    OpenDialog1: TOpenDialog;
    grilla1: TStringGrid;
    procedure boton_archivo_1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Label1Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  xls: Txls;
  Mitrabajo: TsWorkbook;
  Miplanilla: TsWorksheet;


implementation

{$R *.lfm}

{ Txls }

procedure Txls.boton_archivo_1Click(Sender: TObject);


var
    nombre_de_archivo_1 , tmp1 , tmp2:         string;
    scan_fila , x , y , filas_grilla2 ,lugar:  integer;
    Archivo_1_de_excel: TsWorkbook;
    planilla_dentro_de_Archivo_1_de_excel: TsWorksheet;



begin

  opendialog1.execute;

  if opendialog1.FileName <>'' then begin
  xls.Height:=565;
  xls.top:=160;
                                         nombre_de_archivo_1 :=opendialog1.FileName ;
                                         label2.caption:='Archivo: '+(ExtractFilename(opendialog1.Filename));
                                         Archivo_1_de_excel := TsWorkbook.Create;

                                         Archivo_1_de_excel.Options := Archivo_1_de_excel.Options + [boReadFormulas];

                                         Archivo_1_de_excel.ReadFromFile(nombre_de_archivo_1, sfExcel8);    //sfOOxml
                                         planilla_dentro_de_Archivo_1_de_excel := Archivo_1_de_excel.GetWorksheetByName('Sheet');

                                         scan_fila:=0;

                                          button1.Visible:=true;
                                          boton_archivo_1.visible:=false;


                                         ////////////ENCUENTRA LA CANTIDAD MAXIMA DE FILAS/////////////////////////
                                          repeat
                                          inc(scan_fila);
                                          until (planilla_dentro_de_Archivo_1_de_excel.ReadAsUTF8Text(scan_fila+1,0)='')and(scan_fila>30);


                                         //   if planilla_dentro_de_Archivo_1_de_excel.ReadAsUTF8Text(4,0)='' then lugar:=10 else lugar:=8;
                                              if planilla_dentro_de_Archivo_1_de_excel.ReadAsUTF8Text(7,0)='Fecha Hora' then lugar:=7 else
                                              if planilla_dentro_de_Archivo_1_de_excel.ReadAsUTF8Text(8,0)='Fecha Hora' then lugar:=8 else
                                              if planilla_dentro_de_Archivo_1_de_excel.ReadAsUTF8Text(9,0)='Fecha Hora' then lugar:=9 else
                                              if planilla_dentro_de_Archivo_1_de_excel.ReadAsUTF8Text(10,0)='Fecha Hora' then lugar:=10 else
                                              if planilla_dentro_de_Archivo_1_de_excel.ReadAsUTF8Text(11,0)='Fecha Hora' then lugar:=11 else
                                              if planilla_dentro_de_Archivo_1_de_excel.ReadAsUTF8Text(12,0)='Fecha Hora' then lugar:=12   ;



                                          //    label9.caption:=planilla_dentro_de_Archivo_1_de_excel.ReadAsUTF8Text(8,0);
                                              scan_fila:=scan_fila-lugar;
                                         ////////////ENCUENTRA LA CANTIDAD MAXIMA DE FILAS/////////////////////////
                                         label1.caption:='Filas: '+inttostr(scan_fila);
                                          ///////////////ACOMODA TAMA??O DE LA GRILLA/////////////////////////////////////////////
                                          grilla1.rowcount:=scan_fila+1;
                                          grilla1.colcount:=4;
                                          ///////////////ACOMODA TAMA??O DE LA GRILLA/////////////////////////////////////////////


                                          //=====================PASA LOS DATOS A LA GRILLA1 =====================

                                          for y:=0 to scan_fila do
                                          begin

                                            grilla1.Cells[0,y]:=planilla_dentro_de_Archivo_1_de_excel.ReadAsUTF8Text(y+lugar,0);
                                            tmp1:=grilla1.Cells[0,y][1]+grilla1.Cells[0,y][2]+grilla1.Cells[0,y][3]+grilla1.Cells[0,y][4]+grilla1.Cells[0,y][5]+grilla1.Cells[0,y][6]+'20'+grilla1.Cells[0,y][7]+grilla1.Cells[0,y][8];
                                            tmp2:=grilla1.Cells[0,y][10]+grilla1.Cells[0,y][11]+grilla1.Cells[0,y][12]+grilla1.Cells[0,y][13]+grilla1.Cells[0,y][14];
                                            grilla1.Cells[0,y]:=tmp1;
                                            grilla1.Cells[1,y]:=tmp2+':00';
                                            grilla1.Cells[2,y]:=planilla_dentro_de_Archivo_1_de_excel.ReadAsUTF8Text(y+lugar,9);
                                            grilla1.Cells[3,y]:=planilla_dentro_de_Archivo_1_de_excel.ReadAsUTF8Text(y+lugar,11);
                                           end;



                                             grilla1.Cells[0,0]:='Fecha';
                                             grilla1.Cells[1,0]:='Hora';
                                           //=====================PASA LOS DATOS A LA GRILLA1 =====================

{-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=}
{-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=}
{-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=}
{-=-=-=-=-=-=-=-=-=-=-=-=-=-=-     AHORA EMPIEZA LA GRILLA 2       -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=}
{-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=}
{-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=}
x:=3;

{-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- }
                                          filas_grilla2:=1;
                                          grilla2.rowcount:=scan_fila+50000;
                                          grilla2.colcount:=4;
                                          grilla2.Cells[1,0]:=timetostr(INCMINUTE(strtotime(grilla1.Cells[1,1]),-15));
                                          grilla2.Cells[0,0]:=grilla1.Cells[0,1];
                                          y:=1;
                                          repeat
                                            begin                         for x:=0 to 3 do  grilla2.Cells[x,filas_grilla2]:=grilla1.Cells[x,y];

                                                                          if strtodate(grilla2.Cells[0,filas_grilla2])=strtodate(grilla2.Cells[0,filas_grilla2-1])then BEGIN     //si los dias son =

                                                                          if ((strtotime(grilla2.Cells[1,filas_grilla2])-strtotime(grilla2.Cells[1,filas_grilla2-1])=strtotime('00:00:00')))then grilla2.Cells[1,filas_grilla2]:=timetostr((strtotime(grilla2.Cells[1,filas_grilla2-1]))) else

                                                                          if ((strtotime(grilla2.Cells[1,filas_grilla2])-strtotime(grilla2.Cells[1,filas_grilla2-1])<strtotime('00:00:00')))then begin   if (grilla2.Cells[1,filas_grilla2])<>'00:00:00' then grilla2.Cells[1,filas_grilla2]:=grilla2.Cells[1,filas_grilla2-1];
                                                                                                                                                                                                 end else

                                                                          if ((strtotime(grilla2.Cells[1,filas_grilla2])-strtotime(grilla2.Cells[1,filas_grilla2-1])>strtotime('00:15:10')))then  begin
                                                                                                                                                                                                       for x:=0 to 3 do  grilla2.Cells[x,filas_grilla2+1]:=grilla2.Cells[x,filas_grilla2];
                                                                                                                                                                                                       grilla2.Cells[1,filas_grilla2]:=timetostr(INCMINUTE(strtotime(grilla2.Cells[1,filas_grilla2-1]),15));
                                                                                                                                                                                                       for x:=2 to 3 do  grilla2.Cells[x,filas_grilla2+1]:='0';
                                                                                                                                                                                                       for x:=2 to 3 do  grilla2.Cells[x,filas_grilla2]:='0';
                                                                                                                                                                                                       dec(y);

                                                                                                                                                                                                  end;
                                                                                                                                                                         END else      //si los dias son distintos



                                                                                                                                                                         BEGIN                         if (grilla2.Cells[1,filas_grilla2])='00:00:00'then        else
                                                                                                                                                                                                      if (((strtotime(grilla2.Cells[1,filas_grilla2])-strtotime(grilla2.Cells[1,filas_grilla2-1])<>strtotime('00:15:00')))) then  begin


                                                                                                                                                                                                      for x:=0 to 3 do  grilla2.Cells[x,filas_grilla2+1]:=grilla2.Cells[x,filas_grilla2];



                                                                                                                                                                                                      repeat

                                                                                                                                                                                                    //  grilla2.Cells[0,filas_grilla2]:=grilla2.Cells[0,filas_grilla2-1];
                                                                                                                                                                                                      grilla2.Cells[1,filas_grilla2]:=timetostr(INCMINUTE(strtotime(grilla2.Cells[1,filas_grilla2-1]),15));
                                                                                                                                                                                                      grilla2.Cells[0,filas_grilla2]:=grilla2.Cells[0,filas_grilla2-1];
                                                                                                                                                                                                      for x:=2 to 3 do  grilla2.Cells[x,filas_grilla2]:='0';
                                                                                                                                                                                                      inc(filas_grilla2);
                                                                                                                                                                                                      until grilla2.Cells[1,filas_grilla2-1]='23:45:00';


                                                                                                                                                                                                   //   grilla2.Cells[0,filas_grilla2]:=grilla2.Cells[0,filas_grilla2-1];
                                                                                                                                                                                                      grilla2.Cells[1,filas_grilla2]:='00:00:00';
                                                                                                                                                                                                      for x:=2 to 3 do  grilla2.Cells[x,filas_grilla2]:='0';
                                                                                                                                                                                                      grilla2.Cells[0,filas_grilla2]:=datetostr(INCday(strtodate(grilla2.Cells[0,filas_grilla2-1]),1));     //repetido
                                                                                                                                                                                                      inc(filas_grilla2);

                                                                                                                                                                                                      for x:=0 to 3 do  grilla2.Cells[x,filas_grilla2]:=grilla2.Cells[x,filas_grilla2];


                                                                                                                                                                                                      grilla2.Cells[0,filas_grilla2]:=datetostr(INCday(strtodate(grilla2.Cells[0,filas_grilla2-1]),0));
                                                                                                                                                                                                      grilla2.Cells[1,filas_grilla2]:='00:15:00';
                                                                                                                                                                                                      for x:=2 to 3 do  grilla2.Cells[x,filas_grilla2]:='0';
                                                                                                                                                                                                      dec(y);




                                                                                                                                                                                                                                                                                                                                end;

                                                                                                                                                                        END;
                                                                          inc(filas_grilla2);
                                                                          inc(y);
                                            end;
                                       until y=scan_fila+1;



     grilla2.rowcount:=filas_grilla2;




  grilla2.Cells[0,0]:='Fecha';
  grilla2.Cells[1,0]:='Hora';
  grilla2.Cells[2,0]:='Wh';
  grilla2.Cells[3,0]:='VARh';

  label3.caption:='TERMINAL: '+planilla_dentro_de_Archivo_1_de_excel.ReadAsUTF8Text(2,1);
  label4.caption:='DOMICILIO: '+planilla_dentro_de_Archivo_1_de_excel.ReadAsUTF8Text(3,1);
  label5.caption:='SERVICIO: '+planilla_dentro_de_Archivo_1_de_excel.ReadAsUTF8Text(4,1);
  label6.caption:='TITULAR: '+planilla_dentro_de_Archivo_1_de_excel.ReadAsUTF8Text(2,10);

  label7.caption:='PERIODO: '+planilla_dentro_de_Archivo_1_de_excel.ReadAsUTF8Text(3,10);

  label8.caption:='Antes: '+inttostr(scan_fila)+', despues: '+inttostr(filas_grilla2-1);

     end;

end;

procedure Txls.Button1Click(Sender: TObject);


   var GR: TGridRect;
   begin
   GR.Left:=0;
   GR.Right:=4;
   GR.Top:=0;
   GR.Bottom:=grilla2.rowcount;
   grilla2.Selection:=GR;

   grilla2.CopyToClipboard(True);

end;

procedure Txls.Button2Click(Sender: TObject);
begin
     label1.caption:='';
   label2.caption:='';
   label3.caption:='';
   label4.caption:='';
   label5.caption:='';
   label6.caption:='';
   label7.caption:='';
      grilla1.Clean;
       grilla2.Clean;
       boton_archivo_1.visible:=true;
        xls.Height:=44;
        opendialog1.FileName:='';

end;

procedure Txls.FormCreate(Sender: TObject);
begin
  xls.Height:=44;
  label1.caption:='';
   label2.caption:='';
   label3.caption:='';
   label4.caption:='';
   label5.caption:='';
   label6.caption:='';
   label7.caption:='';
end;

procedure Txls.Label1Click(Sender: TObject);
begin

end;





end.

