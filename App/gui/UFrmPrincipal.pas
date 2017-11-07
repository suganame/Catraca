unit UFrmPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, IWSystem, IniFiles,
  Filectrl, UConstantes, UFuncoes, Vcl.Menus, UFrmCatraca, UFrmConfiguracoes;

type
  TFrmPrincipal = class(TForm)
    MenuPrincipal: TMainMenu;
    MenuItemTelaPrincipal: TMenuItem;
    MenuItemConfiguracoes: TMenuItem;
    Edit1: TEdit;
    Button1: TButton;
    procedure TmrStatusCatracaTimer(Sender: TObject);
    procedure MenuItemTelaPrincipalClick(Sender: TObject);
    procedure MenuItemConfiguracoesClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }

    procedure CarregarIni();
    procedure SetConfiguracaoInicialInner();

    function AbrirConexao() : Integer;

  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;
  ArqIni : TIniFile;
  NumeroInner, Porta, PadraoCartao, QtdDigitoCartao, LadoCatraca : Integer;
  TecladoHabilitado : Boolean;
  Retorno : Byte;
  InnerCadastrados : array of inner;

implementation

{$R *.dfm}

function TFrmPrincipal.AbrirConexao: Integer;
begin

  DefinirTipoConexao(2);
  DefinirPadraoCartao(PadraoCartao);
  FecharPortaComunicacao();

  AbrirConexao := AbrirPortaComunicacao(Porta);

end;

procedure TFrmPrincipal.Button1Click(Sender: TObject);
var
  Dir: String;
begin
  Dir := '';
  if SelectDirectory(
    'Selecione o local aonde ser�o gravados os arquivos de texto:', '', Dir,
    [sdNewUI, sdNewFolder]) then
    Edit1.Text := Dir;

//    Dir := 'C:\Windows';
// if SelectDirectory(Dir, [sdAllowCreate, sdPerformCreate, sdPrompt], 1000) then
//    Edit1.Text := Dir;
end;

procedure TFrmPrincipal.CarregarIni;
var
  retInteiro : Integer;
  retBoolean : Boolean;
begin

  with ArqIni do
  begin

    NumeroInner :=  ReadInteger( 'Catraca', 'Numero',  retInteiro );
    Porta :=   ReadInteger( 'Catraca', 'Porta',  retInteiro );
    PadraoCartao := ReadInteger( 'Catraca', 'PadraoCartao',  retInteiro );
    QtdDigitoCartao :=   ReadInteger( 'Catraca', 'QtdDigitos',  retInteiro );
    LadoCatraca := ReadInteger( 'Catraca', 'LadoDaCatraca',  retInteiro );


    if ( ReadBool('Catraca', 'Teclado',  retBoolean) = True ) then
    begin

      TecladoHabilitado := True;

    end
    else if ( ReadBool('Catraca', 'Teclado',  retBoolean) = False ) then
    begin

      TecladoHabilitado := True;

    end;

  end;

end;

procedure TFrmPrincipal.MenuItemConfiguracoesClick(Sender: TObject);
begin

  Application.CreateForm(TFrmConfiguracoes, FrmConfiguracoes);
  FrmConfiguracoes.Show;

end;

procedure TFrmPrincipal.MenuItemTelaPrincipalClick(Sender: TObject);
begin

  Application.CreateForm(TFrmCatraca, FrmCatraca);
  FrmCatraca.Show;

end;

procedure TFrmPrincipal.SetConfiguracaoInicialInner;
begin

  SetLength(innerCadastrados, 1);

  innerCadastrados[0].Numero := NumeroInner;
  innerCadastrados[0].Catraca := True;
  innerCadastrados[0].Biometrico := False;
  innerCadastrados[0].QtdDigitos := QtdDigitoCartao;
  innerCadastrados[0].CntDoEvents := 0;
  innerCadastrados[0].Teclado := TecladoHabilitado;
  innerCadastrados[0].PadraoCartao := PadraoCartao;
  innerCadastrados[0].ListaBio := False;
  innerCadastrados[0].Lista := False;
  innerCadastrados[0].Verificacao := 0;
  innerCadastrados[0].Identificacao := 0;
  innerCadastrados[0].DoisLeitores := False;
  innerCadastrados[0].CountPingFail := 0;
  innerCadastrados[0].CountTentativasEnvioComando := 0;
  innerCadastrados[0].EstadoAtual := ESTADO_CONECTAR;

end;

procedure TFrmPrincipal.TmrStatusCatracaTimer(Sender: TObject);
begin

//  LblStatus.Left := LblStatus.Left - 20;
//
//  if ( LblStatus.Left <= 0 - LblStatus.Width ) then
//    LblStatus.Left := PnStatusCatraca.Width;

end;

end.
