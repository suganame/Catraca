unit UFrmConfigCatraca;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, UFrmFuncoes, UFrmConstantes;

type
  TFrmConfigurarCatraca = class(TForm)
    gpbConexao: TGroupBox;
    cbxTipoConexao: TComboBox;
    lblTipoConexao: TLabel;
    lblPorta: TLabel;
    edtPorta: TEdit;
    lblCodCatraca: TLabel;
    edtCodCatraca: TEdit;
    gbpPadraoCartao: TGroupBox;
    lblPadraoCartao: TLabel;
    lblNumeroDigitos: TLabel;
    cbxPadraoCartao: TComboBox;
    edtNumeroDigitos: TEdit;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }

    // MAQUINA DE ESTADOS
    procedure maquinaDeEstados();

    // Passos da maquina de estados
    procedure 	PASSO_ESTADO_CONECTAR();
    procedure 	PASSO_ESTADO_ENVIAR_CFG_OFFLINE();
    procedure 	PASSO_ESTADO_CONFIGURAR_ENTRADAS_ONLINE();
    procedure 	PASSO_ESTADO_COLETAR_BILHETES();
    procedure 	PASSO_ESTADO_ENVIAR_CFG_ONLINE();
    procedure 	PASSO_ESTADO_ENVIAR_DATA_HORA();
    procedure 	PASSO_ESTADO_ENVIA_MSG_URNA();
    procedure 	PASSO_ESTADO_MONITORA_URNA();
    procedure 	PASSO_ESTADO_ENVIAR_MSG_PADRAO();
    procedure 	PASSO_ESTADO_POLLING();
    procedure 	PASSO_ESTADO_ENVIA_PING_ONLINE();
    procedure 	PASSO_AGUARDA_TEMPO_MENSAGEM();
    procedure 	PASSO_LIBERA_GIRO_CATRACA();
    procedure 	PASSO_MONITORA_GIRO_CATRACA();
    procedure 	PASSO_ESTADO_RECONECTAR();
    procedure 	PASSO_ESTADO_DEFINICAO_TECLADO();
    procedure 	PASSO_ESTADO_AGUARDAR_DEFINICAO_TECLADO();
    procedure 	PASSO_ESTADO_ENVIAR_MSG_OFFLINE();
    procedure 	PASSO_ESTADO_ENVIAR_HORARIOS();
    procedure 	PASSO_ESTADO_ENVIAR_CONFIGMUD_ONLINE_OFFLINE();

  public
    { Public declarations }
  end;

var
  FrmConfigurarCatraca: TFrmConfigurarCatraca;

  Retorno : Byte;
  Parar : Boolean;

  InnersCadastrados : Array of inner;

implementation

{$R *.dfm}

procedure TFrmConfigurarCatraca.Button1Click(Sender: TObject);
begin

  InnersCadastrados[0].Numero := edtCodCatraca.Text;
  InnersCadastrados[0].Catraca := True;
  InnersCadastrados[0].Biometrico := False;
  InnersCadastrados[0].QtdDigitos := 10;
  InnersCadastrados[0].CntDoEvents := 0;
  InnersCadastrados[0].Teclado := True;
  InnersCadastrados[0].PadraoCartao := 0;
  InnersCadastrados[0].ListaBio := False;
  InnersCadastrados[0].Lista := False;
  InnersCadastrados[0].Verificacao := 0;
  InnersCadastrados[0].Identificacao := 0;
  InnersCadastrados[0].DoisLeitores := False;
  InnersCadastrados[0].CountPingFail := 0;
  InnersCadastrados[0].CountTentativasEnvioComando := 0;
  InnersCadastrados[0].EstadoAtual := ESTADO_CONECTAR;

  // define qual o tipo de conexao a ser feito
  DefinirTipoConexao(cbxTipoConexao.ItemIndex);

  // define o tipo padrao de cartao
  DefinirPadraoCartao(cbxPadraoCartao.ItemIndex);

  // Fechar qualquer porta de conexao aberta
  FecharPortaComunicacao();

  // Abre a porta de comunica��o com a catraca
  retorno := AbrirPortaComunicacao(StrToInt(edtPorta.Text));

  // Testa o retorno da tentativa de conexao.
  // Caso o retorno seja ok, inicia a maquina de estados.
  if (Retorno = RET_OK) then begin
    Parar := False;
    MaquinaDeEstados();
  end;


end;

procedure TFrmConfigurarCatraca.FormCreate(Sender: TObject);
begin
  // Tipo de conex�o
  cbxTipoConexao.Items.Add('Serial');
  cbxTipoConexao.Items.Add('TCP/IP');
  cbxTipoConexao.Items.Add('TCP/IP com porta fixa');
  cbxTipoConexao.ItemIndex := 2; // Padr�o

  // Padr�o do cart�o
  cbxPadraoCartao.Items.Add('Padr�o TopData');
  cbxPadraoCartao.Items.Add('Padr�o livre');
  cbxPadraoCartao.ItemIndex := 1; // Padr�o

end;

procedure TFrmConfigurarCatraca.maquinaDeEstados;
begin
//  while not Parar do
//  begin
//    case estadoAtual of
//      ESTADO_CONECTAR:
//        PASSO_ESTADO_CONECTAR();
//
//      ESTADO_ENVIAR_CFG_OFFLINE:
//        PASSO_ESTADO_ENVIAR_CFG_OFFLINE();
//
//      ESTADO_COLETAR_BILHETES:
//        PASSO_ESTADO_COLETAR_BILHETES();
//
//      ESTADO_ENVIAR_CFG_ONLINE:
//        PASSO_ESTADO_ENVIAR_CFG_ONLINE();
//
//      ESTADO_ENVIAR_DATA_HORA:
//        PASSO_ESTADO_ENVIAR_DATA_HORA();
//
//      ESTADO_ENVIAR_MSG_PADRAO:
//        PASSO_ESTADO_ENVIAR_MSG_PADRAO();
//
//      ESTADO_CONFIGURAR_ENTRADAS_ONLINE:
//        PASSO_ESTADO_CONFIGURAR_ENTRADAS_ONLINE();
//
//      ESTADO_POLLING:
//        PASSO_ESTADO_POLLING();
//
//      ESTADO_LIBERAR_CATRACA:
//        PASSO_LIBERA_GIRO_CATRACA();
//
//      ESTADO_MONITORA_GIRO_CATRACA:
//        PASSO_MONITORA_GIRO_CATRACA();
//
//      PING_ONLINE:
//        PASSO_ESTADO_ENVIA_PING_ONLINE();
//
//      ESTADO_RECONECTAR:
//        PASSO_ESTADO_RECONECTAR();
//
//      AGUARDA_TEMPO_MENSAGEM:
//        PASSO_AGUARDA_TEMPO_MENSAGEM();
//
//      ESTADO_DEFINICAO_TECLADO:
//        PASSO_ESTADO_DEFINICAO_TECLADO();
//
//      ESTADO_AGUARDAR_DEFINICAO_TECLADO:
//        PASSO_ESTADO_AGUARDAR_DEFINICAO_TECLADO();
//
//      ESTADO_ENVIA_MSG_URNA:
//        PASSO_ESTADO_ENVIA_MSG_URNA();
//
//      ESTADO_MONITORA_URNA:
//        PASSO_ESTADO_MONITORA_URNA();
//
//      ESTADO_ENVIAR_MENSAGEM:
//        PASSO_ESTADO_ENVIAR_MSG_OFFLINE();
//
//      ESTADO_ENVIAR_HORARIOS:
//        PASSO_ESTADO_ENVIAR_HORARIOS();
//
//      ESTADO_ENVIAR_CONFIGS_ONLINE_OFFLINE :
//        PASSO_ESTADO_ENVIAR_CONFIGMUD_ONLINE_OFFLINE();
//
//      ESTADO_ENVIAR_MSG_ACESSO_NEGADO:
//        PASSO_ESTADO_ENVIAR_MSG_ACESSO_NEGADO();
//
//      {****************** Novos estados verifica senha *******************}
//      ESTADO_TRATA_CARTAO_TRATA_CONFIGS:
//          PASSO_ESTADO_TRATA_CARTAO_TRATA_CONFIGS();
//
//
//
//    end;
//
//    if Parar then
//    begin
//      BilheteInner.Destroy;
//      break;
//    end;
//
//    Inc(CntdoEvents);
//
//    if (CntdoEvents > 10) then
//    begin
//      CntdoEvents := 0;
//      Application.ProcessMessages;
//      Sleep(1);
//    end;
//
//    end;
//
//    // INCREMENTA A varI�VEL QUE FAZ A CONTAGEM DE INNERS..
//    lngInnerAtual := lngInnerAtual + 1;
//
//    // CASO O VALOR INCREMENTAL for MAIOR QUE A QUANTIDADE TOTAL, REATRIBUI 0
//    // PARA varI�VEL..
//    if ((lngInnerAtual + 1) > TotalInners) then
//    begin
//      lngInnerAtual := 0;
//    end;
//
//    {Se a vari�vel parar for igual a False, a maquina inicia o
//                    processo novamente com outro Inner da Lista..}
//  end;
//  // Fecha a porta de Comunica��o quando sai da maquina de estados..
//  FecharPortaComunicacao();
//
//  if (Fechar = true) then
//    CloseQuery;
//    end;
//  end;
end;

procedure TFrmConfigurarCatraca.PASSO_AGUARDA_TEMPO_MENSAGEM;
begin

end;

procedure TFrmConfigurarCatraca.PASSO_ESTADO_AGUARDAR_DEFINICAO_TECLADO;
begin

end;

procedure TFrmConfigurarCatraca.PASSO_ESTADO_COLETAR_BILHETES;
begin

end;

procedure TFrmConfigurarCatraca.PASSO_ESTADO_CONECTAR;
begin

end;

procedure TFrmConfigurarCatraca.PASSO_ESTADO_CONFIGURAR_ENTRADAS_ONLINE;
begin

end;

procedure TFrmConfigurarCatraca.PASSO_ESTADO_DEFINICAO_TECLADO;
begin

end;

procedure TFrmConfigurarCatraca.PASSO_ESTADO_ENVIAR_CFG_OFFLINE;
begin

end;

procedure TFrmConfigurarCatraca.PASSO_ESTADO_ENVIAR_CFG_ONLINE;
begin

end;

procedure TFrmConfigurarCatraca.PASSO_ESTADO_ENVIAR_CONFIGMUD_ONLINE_OFFLINE;
begin

end;

procedure TFrmConfigurarCatraca.PASSO_ESTADO_ENVIAR_DATA_HORA;
begin

end;

procedure TFrmConfigurarCatraca.PASSO_ESTADO_ENVIAR_HORARIOS;
begin

end;

procedure TFrmConfigurarCatraca.PASSO_ESTADO_ENVIAR_MSG_OFFLINE;
begin

end;

procedure TFrmConfigurarCatraca.PASSO_ESTADO_ENVIAR_MSG_PADRAO;
begin

end;

procedure TFrmConfigurarCatraca.PASSO_ESTADO_ENVIA_MSG_URNA;
begin

end;

procedure TFrmConfigurarCatraca.PASSO_ESTADO_ENVIA_PING_ONLINE;
begin

end;

procedure TFrmConfigurarCatraca.PASSO_ESTADO_MONITORA_URNA;
begin

end;

procedure TFrmConfigurarCatraca.PASSO_ESTADO_POLLING;
begin

end;

procedure TFrmConfigurarCatraca.PASSO_ESTADO_RECONECTAR;
begin

end;

procedure TFrmConfigurarCatraca.PASSO_LIBERA_GIRO_CATRACA;
begin

end;

procedure TFrmConfigurarCatraca.PASSO_MONITORA_GIRO_CATRACA;
begin

end;

end.
