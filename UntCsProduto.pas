unit UntCsProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UntPadraoCs, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls, Vcl.Buttons;

type
  TfrmCsProduto = class(TfrmPadraoCs)
    procedure FormActivate(Sender: TObject);
    procedure btn_filtrar_ftClick(Sender: TObject);
    procedure btn_filtrar_scClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCsProduto: TfrmCsProduto;

implementation

{$R *.dfm}

procedure TfrmCsProduto.btn_filtrar_ftClick(Sender: TObject);
var str, dataAte, dataDe, op:string;
begin
  //� isso que acontece quando deixamos pra fazer de ultima hora...
  inherited;
  str:= DateToStr(dtpDe.Date);
  dataDe:= copy(str,7,4)+'-'+copy(str,4,2)+'-'+copy(str,1,2)+'T00:59:00.000';
  str:= DateToStr(dtpAte.Date);
  dataAte:= copy(str,7,4)+'-'+copy(str,4,2)+'-'+copy(str,1,2)+'T00:59:00.000';

  if RadioGroup1.ItemIndex = 1 then
    op := 'data_alt'
  else op := 'data_inc';
  FDQryCons.Close;
  with FDQryCons.SQL do
    begin
      Clear;
      Add('select * from Produto WHERE '+op+'>= '+QuotedStr(dataDe)+ ' AND '
      + op+ '<= ' +QuotedStr(dataAte));
      showmessage(text);
    end;
  FDQryCons.Open();
end;


procedure TfrmCsProduto.btn_filtrar_scClick(Sender: TObject);
begin
  inherited;
  FDQryCons.Close;
  with FDQryCons.SQL do
    begin
      Clear;
      Add('select * from Produto WHERE Produto.Nome LIKE ''%'+edt_nome.Text+'%''');
      showmessage(text);
    end;
  FDQryCons.Open();
end;

procedure TfrmCsProduto.FormActivate(Sender: TObject);
begin
  inherited;
  FDQryCons.Open();
  RadioGroup1.ItemIndex:=0;
end;

end.
