unit UFrmPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, UConstantes, UFuncoes;

type
  TFrmPrincipal = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

  innerCadastrados : array of inner;

  retorno : Byte;

implementation

{$R *.dfm}

procedure TFrmPrincipal.Button1Click(Sender: TObject);
begin
//  innerCadastrados[0].Numero := 1;
//  innerCadastrados[0].Catraca := True;
//  innerCadastrados[0].Biometrico := False;
//  innerCadastrados[0].QtdDigitos := 10;
//  innerCadastrados[0].CntDoEvents := 0;
//  innerCadastrados[0].Teclado := True;
//  innerCadastrados[0].PadraoCartao := 0;
//  innerCadastrados[0].ListaBio := False;
//  innerCadastrados[0].Lista := False;
//  innerCadastrados[0].Verificacao := 0;
//  innerCadastrados[0].Identificacao := 0;
//  innerCadastrados[0].DoisLeitores := False;
//  innerCadastrados[0].CountPingFail := 0;
//  innerCadastrados[0].CountTentativasEnvioComando := 0;
//  innerCadastrados[0].EstadoAtual := ESTADO_CONECTAR;

  DefinirTipoConexao(2);
  DefinirPadraoCartao(0);
  FecharPortaComunicacao();

  retorno := AbrirPortaComunicacao(3570);

  if retorno = RET_OK then begin
    // ESTADO CONECTAR
    // ESTADO_ENVIAR_CFG_OFFLINE
//      ShowMessage('ENVIAR CONFG_OFFLINE');
//      DefinirPadraoCartao(0);
//      ConfigurarInnerOffLine();
//      ConfigurarAcionamento1(2, 5);
//      ConfigurarAcionamento2(0, 0);
//      ConfigurarLeitor1(0);
//      ConfigurarLeitor2(0);
//      DefinirQuantidadeDigitosCartao(10);
//      HabilitarTeclado(0, 0);
//      DefinirFuncaoDefaultLeitoresProximidade(10);
//      DefinirFuncaoDefaultSensorBiometria(0);
//      ReceberDataHoraDadosOnLine(0);

    // ESTADO_ENVIAR_CFG_ONLINE
      ShowMessage('ENVIAR CONFG_ONLINE');
      DefinirPadraoCartao(0);
      ConfigurarInnerOnLine();
      ConfigurarAcionamento1(1, 5);
      ConfigurarAcionamento2(0, 0);
      ConfigurarLeitor1(1);
      ConfigurarLeitor2(0);
      ConfigurarTipoLeitor(0);
      DefinirQuantidadeDigitosCartao(10);
      HabilitarTeclado(1, 0);
      RegistrarAcessoNegado(1);
      DefinirFuncaoDefaultLeitoresProximidade(10);
      DefinirFuncaoDefaultSensorBiometria(0);
      ReceberDataHoraDadosOnLine(1);

      ShowMessage('ENVIAR CONFIG');

      retorno := EnviarConfiguracoes(1);

      ShowMessage( IntToStr(EnviarConfiguracoes(1)));

      if( retorno = RET_OK ) then begin
        ShowMessage('Configurações online enviadas');
      end;
  end;


end;

end.
