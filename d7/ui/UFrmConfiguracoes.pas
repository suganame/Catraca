unit UFrmConfiguracoes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFrmConfiguracoes = class(TForm)
    gbInner: TGroupBox;
    gbConexao: TGroupBox;
    lblNumInner: TLabel;
    lblPorta: TLabel;
    edtNumInner: TEdit;
    edtPorta: TEdit;
    gbCartao: TGroupBox;
    lblPadraoCartao: TLabel;
    lblQtdDigitos: TLabel;
    edtQtdDigitos: TEdit;
    gbLadoCatraca: TGroupBox;
    gbTeclado: TGroupBox;
    rdbEsquerdo: TRadioButton;
    rdbDireito: TRadioButton;
    rdbHabilitado: TRadioButton;
    rdbDesabilitado: TRadioButton;
    btnTestarConexao: TButton;
    gbBanco: TGroupBox;
    gbImagens: TGroupBox;
    lblCaminhoBanco: TLabel;
    lblCaminhoFotos: TLabel;
    edtCaminhoBanco: TEdit;
    edtCaminhoFotos: TEdit;
    cbxPadraoCartao: TComboBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmConfiguracoes: TFrmConfiguracoes;

implementation

uses UFrmCatraca;

{$R *.dfm}

procedure TFrmConfiguracoes.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
  Release;
  FrmCatraca := nil;
end;

end.
