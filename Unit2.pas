unit Unit2;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Platform,
  FMX.Controls.Presentation, FMX.Edit, FMX.StdCtrls, FMX.Layouts;

type
  TForm2 = class(TForm)
    Edit1: TEdit;
    Panel1: TPanel;
    ScrollBox1: TScrollBox;
    Edit2: TEdit;
    procedure Panel1DragOver(Sender: TObject; const Data: TDragObject;
      const Point: TPointF; var Operation: TDragOperation);
    procedure ScrollBox1DragOver(Sender: TObject; const Data: TDragObject;
      const Point: TPointF; var Operation: TDragOperation);
    procedure Edit2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure Panel1DragDrop(Sender: TObject; const Data: TDragObject;
      const Point: TPointF);
    procedure ScrollBox1DragDrop(Sender: TObject; const Data: TDragObject;
      const Point: TPointF);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.fmx}

procedure TForm2.Edit2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
Var Svc:         IFMXDragDropService;
  DragData:    TDragObject;
  DragBmp:     TBitmap;
begin
  if Button = TMouseButton.mbLeft then
  begin
    if TPlatformServices.Current.SupportsPlatformService(IFMXDragDropService, Svc) then
    begin
      DragBmp := TEdit(Sender).MakeScreenshot;
      DragData.Source := Sender;
      DragData.Data := DragBmp;
      Svc.BeginDragDrop(Self,DragData,DragBmp);

    end;
  end;
end;

procedure TForm2.Panel1DragDrop(Sender: TObject; const Data: TDragObject;
  const Point: TPointF);
begin
  //Showmessage(TComponent(Sender).Name + ' - ' + TComponent(Data.Source).Name);
  TControl(Data.Source).Parent := TControl(Sender);
end;

procedure TForm2.Panel1DragOver(Sender: TObject; const Data: TDragObject;
  const Point: TPointF; var Operation: TDragOperation);
begin
  Operation := TDragOperation.move;
end;

procedure TForm2.ScrollBox1DragDrop(Sender: TObject; const Data: TDragObject;
  const Point: TPointF);
begin
  TControl(Data.Source).Parent := TControl(Sender);
end;

procedure TForm2.ScrollBox1DragOver(Sender: TObject; const Data: TDragObject;
  const Point: TPointF; var Operation: TDragOperation);
begin
  Operation := TDragOperation.Copy;
end;

end.
