unit UFrmConfiguracoes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TFrmConfiguracoes = class(TForm)
    GbConexao: TGroupBox;
    LblNumInner: TLabel;
    EdtNumInner: TEdit;
    LblPorta: TLabel;
    EdtPorta: TEdit;
    GbCartao: TGroupBox;
    LblPadraoCartao: TLabel;
    LblQtdDigitoCartao: TLabel;
    EdtQtdDigitosCartao: TEdit;
    CbxPadraoCartao: TComboBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmConfiguracoes: TFrmConfiguracoes;

implementation

{$R *.dfm}

end.
