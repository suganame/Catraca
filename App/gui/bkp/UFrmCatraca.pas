unit UFrmCatraca;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, IWSystem, IniFiles,
  UConstantes, UFuncoes;

type
  TFrmCatraca = class(TForm)
    PnStatusCatraca: TPanel;
    LblStatus: TLabel;
    Image1: TImage;
    TmrStatusCatraca: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure TmrStatusCatracaTimer(Sender: TObject);
  private
    { Private declarations }

    procedure CarregarIni();
    procedure SetConfiguracaoInicialInner();
    procedure MaquinaDeEstados();

    function AbrirConexao() : Integer;

  public
    { Public declarations }
  end;

var
  FrmCatraca: TFrmCatraca;
  ArqIni : TIniFile;
  NumeroInner, Porta, PadraoCartao, QtdDigitoCartao, LadoCatraca : Integer;
  TecladoHabilitado : Boolean;
  Retorno : Byte;
  InnerCadastrados : array of inner;

implementation

{$R *.dfm}

function TFrmCatraca.AbrirConexao: Integer;
begin

  DefinirTipoConexao(2);
  DefinirPadraoCartao(PadraoCartao);
  FecharPortaComunicacao();

  AbrirConexao := AbrirPortaComunicacao(Porta);

end;

procedure TFrmCatraca.CarregarIni;
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

procedure TFrmCatraca.FormCreate(Sender: TObject);
begin

  LblStatus.Left := PnStatusCatraca.Width;
  ArqIni := TIniFile.Create( gsAppPath + 'ini.ini' );

  if not( FileExists( gsAppPath + 'ini.ini' ) ) then
  begin

    LblStatus.Caption := 'Efetuar configura��o.';

  end
  else
  begin

    CarregarIni();
    SetConfiguracaoInicialInner();

    // Tenta abrir conex�o com a porta padr�o
    retorno := AbrirConexao();
    //    retorno := 0;

    // Caso Consiga, ele entra na maquina de estados
    if ( retorno = RET_OK )then
    begin

//      parar := False;
//      MaquinaDeEstados();

    end
    else
    begin
      PnStatusCatraca.Color := clRed;
      LblStatus.Caption := 'N�o foi poss�vel efetuar conex�o com o inner';

    end;


  end;

end;

procedure TFrmCatraca.SetConfiguracaoInicialInner;
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

procedure TFrmCatraca.TmrStatusCatracaTimer(Sender: TObject);
begin

  LblStatus.Left := LblStatus.Left - 20;

  if ( LblStatus.Left <= 0 - LblStatus.Width ) then
    LblStatus.Left := PnStatusCatraca.Width;

end;

end.
