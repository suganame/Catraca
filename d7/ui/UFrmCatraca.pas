unit UFrmCatraca;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UFuncoesInner, ExtCtrls, StdCtrls, jpeg, UConstantes, DBXpress,
  FMTBcd, DB, SqlExpr;

type
  TFrmCatraca = class(TForm)
    pnStatusCatraca: TPanel;
    pnStatusConexao: TPanel;
    lblStatusConexao: TLabel;
    LblTituloCatraca: TLabel;
    LblTextoCatraca: TLabel;
    LblNome: TLabel;
    EdtNome: TEdit;
    LblCartao: TLabel;
    EdtCartao: TEdit;
    LblTipoPessoa: TLabel;
    LblParcelasVencidas: TLabel;
    EdtParcelasVencidas: TEdit;
    PnBordaImagem: TPanel;
    PnFundoImagem: TPanel;
    ImgFotoAssociado: TImage;
    EdtTipoPessoa: TEdit;
    TmrStatusConexao: TTimer;
    TmrDelayConexao: TTimer;
    scnBanco: TSQLConnection;
    qryPrincipal: TSQLQuery;
    Button2: TButton;
    Edit1: TEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TmrStatusConexaoTimer(Sender: TObject);
    procedure TmrDelayConexaoTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }

    function AbrirConexao() : Byte;
    function TestaConexaoInner( NumInner : Integer) : Byte;
    function ConfigurarEntradaMudancasOnline( NumInner: Integer ): Integer;
    function BinarioParaDecimal(valorBinario: String): String;

    procedure SetStatusCatraca(Status: Integer);
    procedure EsconderFormulario();
    procedure MostrarFormulario();
    procedure SetConfiguracaoInicialInner();
    procedure HabilitarLadoCatraca( Lado : String );

    procedure ConectaBanco();
    function BuscaUsuario( Cartao : String ) : Boolean;
    procedure SetUsuario(Nome: String; Cartao: String; Tipo: String;
      ParcelasAtrasadas: Integer; IdPessoa: Integer);


    procedure MaquinaDeEstados();

    // Procedimentos da maquina de estados
    procedure Conectar();
    procedure Reconectar();
    procedure EnviarConfigOffline();
    procedure EnviarConfigOnline();
    procedure EnviarDataHora();
    procedure EnviarMensagemPadrao();
    procedure ConfigurarEntradasOnline();
    procedure Polling();
    procedure EnviarPingOnline();
    procedure TrataConfigsCartao();
    procedure LiberarCatraca();
    procedure FecharConexao();
    procedure MonitorarGiroCatraca();

  public
    { Public declarations }
  end;

var
  FrmCatraca: TFrmCatraca;
  CorAzul, CorVermelha, CorVerde, CorRoxa: TColor;

  Delay, InnerAtual : Integer;
  Retorno : Byte;

  Parar, LiberaEntrada, LiberaEntradaInvertida,
  LiberaSaida, LiberaSaidaInvertida : Boolean;

  InnerCadastrados: array of typeInner;

implementation

{$R *.dfm}

procedure TFrmCatraca.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  Release;
  FrmCatraca := nil;
end;

procedure TFrmCatraca.TmrStatusConexaoTimer(Sender: TObject);
begin
  lblStatusConexao.Left := lblStatusConexao.Left - 20;

  if (lblStatusConexao.Left <= 0 - lblStatusConexao.Width) then
    lblStatusConexao.Left := pnStatusConexao.Width;
end;

procedure TFrmCatraca.TmrDelayConexaoTimer(Sender: TObject);
begin
  Inc(Delay);

  if (Delay = 3) then
  begin
  
    SetConfiguracaoInicialInner();

    // Tenta abrir conexão com a porta padrão
    Retorno := AbrirConexao();
    // retorno := 0;

    // Caso Consiga, ele entra na maquina de estados
    if (Retorno = RET_OK) then
    begin

      Parar := False;
      MaquinaDeEstados();

    end;

  end;
end;

procedure TFrmCatraca.FormCreate(Sender: TObject);
begin
  CorVermelha := TColor($2E31D3);
  CorRoxa := TColor(clPurple);
  CorVerde := TColor($5CB85C);
  CorAzul := TColor($CA8B42);

  PnStatusConexao.Color := CorVermelha;
  SetStatusCatraca(1);
end;

procedure TFrmCatraca.SetStatusCatraca(Status: Integer);
begin
  {
    1 - Aguardando conexão
    2 - Aguardando entrada
    3 - Acesso liberado
    4 - Acesso liberado, mas com atrasado
    5 - Acesso Negado
    6 - Usuário não cadastrado
    7 - Saída liberada
  }

  case Status of

    1:
      begin

        EsconderFormulario();
        PnStatusCatraca.Color := CorVermelha;
        PnBordaImagem.Color := CorVermelha;
        LblTituloCatraca.Caption := 'Aguardando Conexão';
        LblTextoCatraca.Caption := 'Tentando conexão com a catraca.';

      end;

    2:
      begin

        EsconderFormulario();
        PnStatusCatraca.Color := CorAzul;
        PnBordaImagem.Color := CorAzul;
        LblTituloCatraca.Caption := 'Aguardando Entrada.';
        LblTextoCatraca.Caption := 'Passe o cartão ou digite o código.';

      end;

    3:
      begin

        MostrarFormulario();
        LblParcelasVencidas.Visible := False;
        EdtParcelasVencidas.Visible := False;

        PnStatusCatraca.Color := CorVerde;
        PnBordaImagem.Color := CorVerde;
        LblTituloCatraca.Caption := 'Acesso Liberado!';
        LblTextoCatraca.Caption := 'Seja bem vindo! Tenha uma ótima diversão.';

      end;

    4:
      begin

        MostrarFormulario();
        PnStatusCatraca.Color := CorRoxa;
        PnBordaImagem.Color := CorRoxa;
        LblTituloCatraca.Caption := 'Acesso Liberado!';
        LblTextoCatraca.Caption :=
          'Há parcelas atrasadas, verifique com a secretaria. Seja bem vindo!';

      end;

    5:
      begin

        MostrarFormulario();
        PnStatusCatraca.Color := CorVermelha;
        PnBordaImagem.Color := CorVermelha;
        LblTituloCatraca.Caption := 'Acesso Negado';
        LblTextoCatraca.Caption := 'Verique o motivo com a secretaria.';

      end;

    6:
      begin

        EsconderFormulario();
        PnStatusCatraca.Color := CorVermelha;
        PnBordaImagem.Color := CorVermelha;
        LblTituloCatraca.Caption := 'Acesso Negado';
        LblTextoCatraca.Caption :=
          'Usuário não cadastrado, verifique com a secretaria.';

      end;

    7:
      begin

        EsconderFormulario();
        PnStatusCatraca.Color := CorVerde;
        PnBordaImagem.Color := CorVerde;
        LblTituloCatraca.Caption := 'Saída Liberada';
        LblTextoCatraca.Caption := 'Volte sempre!';

      end;

  end;

  Application.ProcessMessages;

end;

procedure TFrmCatraca.FormActivate(Sender: TObject);
begin

  Delay := 0;
  TmrDelayConexao.Enabled := True;
  
end;

procedure TFrmCatraca.Button6Click(Sender: TObject);
begin
  SetStatusCatraca(1);
end;

procedure TFrmCatraca.Button8Click(Sender: TObject);
begin

  SetStatusCatraca(2);

end;

procedure TFrmCatraca.Button9Click(Sender: TObject);
begin

  SetStatusCatraca(3);

end;

procedure TFrmCatraca.Button7Click(Sender: TObject);
begin

    SetStatusCatraca(4);

end;

procedure TFrmCatraca.Button10Click(Sender: TObject);
begin

    SetStatusCatraca(5);

end;

procedure TFrmCatraca.Button11Click(Sender: TObject);
begin

    SetStatusCatraca(6);

end;

procedure TFrmCatraca.Button1Click(Sender: TObject);
begin
  SetStatusCatraca(7);
end;

procedure TFrmCatraca.EsconderFormulario;
begin

  PnBordaImagem.Visible := False;

  LblNome.Visible := False;
  EdtNome.Visible := False;

  LblCartao.Visible := False;
  EdtCartao.Visible := False;

  LblTipoPessoa.Visible := False;
  EdtTipoPessoa.Visible := False;

  LblParcelasVencidas.Visible := False;
  EdtParcelasVencidas.Visible := False;

end;

procedure TFrmCatraca.MostrarFormulario;
begin

  PnBordaImagem.Visible := True;

  LblNome.Visible := True;
  EdtNome.Visible := True;

  LblCartao.Visible := True;
  EdtCartao.Visible := True;

  LblTipoPessoa.Visible := True;
  EdtTipoPessoa.Visible := True;

  LblParcelasVencidas.Visible := True;
  EdtParcelasVencidas.Visible := True;

end;

procedure TFrmCatraca.SetConfiguracaoInicialInner;
begin

  SetLength(InnerCadastrados, 1);

  InnerCadastrados[0].Numero := 1;
  InnerCadastrados[0].Catraca := True;
  InnerCadastrados[0].Biometrico := False;
  InnerCadastrados[0].QtdDigitos := 10;
  InnerCadastrados[0].CntDoEvents := 0;
  InnerCadastrados[0].Teclado := True;
  InnerCadastrados[0].PadraoCartao := 0;
  InnerCadastrados[0].ListaBio := False;
  InnerCadastrados[0].Lista := False;
  InnerCadastrados[0].Verificacao := 0;
  InnerCadastrados[0].Identificacao := 0;
  InnerCadastrados[0].DoisLeitores := False;
  InnerCadastrados[0].CountPingFail := 0;
  InnerCadastrados[0].countTentativasEnvioComando := 0;
  InnerCadastrados[0].EstadoAtual := ESTADO_CONECTAR;

end;

function TFrmCatraca.AbrirConexao: Byte;
begin

  DefinirTipoConexao(2);
  DefinirPadraoCartao(1);
  FecharPortaComunicacao();

  AbrirConexao := AbrirPortaComunicacao(3570);

end;

procedure TFrmCatraca.MaquinaDeEstados;
begin

  while (not Parar) do
  begin

    with InnerCadastrados[InnerAtual] do
    begin

      case InnerCadastrados[InnerAtual].EstadoAtual of

        ESTADO_CONECTAR:
          Conectar();

       // ESTADO_ENVIAR_CFG_OFFLINE:
         // EnviarConfigOffline;

        // ESTADO_COLETAR_BILHETES: ;

        ESTADO_ENVIAR_CFG_ONLINE:
          EnviarConfigOnline();

        ESTADO_ENVIAR_DATA_HORA:
          EnviarDataHora();

        ESTADO_ENVIAR_MSG_PADRAO:
          EnviarMensagemPadrao();

        ESTADO_CONFIGURAR_ENTRADAS_ONLINE:
          ConfigurarEntradasOnline();

        ESTADO_POLLING:
          Polling();

        ESTADO_LIBERAR_CATRACA:
          LiberarCatraca();

        ESTADO_ENVIAR_BIPCURTO:
          MonitorarGiroCatraca();

        PING_ONLINE:
          EnviarPingOnline();

        ESTADO_RECONECTAR:
          Reconectar();

        // AGUARDA_TEMPO_MENSAGEM: ;
        // ESTADO_DEFINICAO_TECLADO: ;
        // ESTADO_AGUARDAR_DEFINICAO_TECLADO: ;
        // ESTADO_ENVIA_MSG_URNA: ;
        // ESTADO_MONITORA_URNA: ;
        // ESTADO_ENVIAR_MENSAGEM: ;
        // ESTADO_ENVIAR_HORARIOS: ;
        // ESTADO_ENVIAR_CONFIGS_ONLINE_OFFLINE: ;
        // ESTADO_ENVIAR_MSG_ACESSO_NEGADO: ;

        ESTADO_TRATA_CARTAO_TRATA_CONFIGS:
          TrataConfigsCartao();

        // ESTADO_VALIDAR_ACESSO: ;
        // ESTADO_VERIFICAR_SENHA: ;
        // ESTADO_ENVIAR_CONFIGMUD_ONLINE_OFFLINE: ;
      end;
    end;
  end;

end;

procedure TFrmCatraca.Conectar;
var
  count : integer;
begin

  count := 0;

  SetStatusCatraca(1);
  Application.ProcessMessages;

  with InnerCadastrados[InnerAtual] do
  begin

    try

      repeat

        // Tenta efetuar uma conexão com o Inner, tenta retornar a data atual
        // ShowMessage('Passo de conexão OK');
        Retorno := TestaConexaoInner(InnerCadastrados[InnerAtual].Numero);
        Sleep(20);
        Inc(count);

      until ((count > 30) or (Retorno = RET_OK));

      if Retorno = RET_OK then
      begin

        // Caso o retorno seja positivo, entra no estado de envio de configuração

        lblStatusConexao.Caption := 'Conectado';
        InnerCadastrados[InnerAtual].EstadoAtual := ESTADO_ENVIAR_CFG_ONLINE;
        Application.ProcessMessages;

      end
      else
      begin

        // Caso o resultado seja negativo tenta enviar mais 3 vezes
        // Se mesmo assim continuar negativo, entra em estado de reconexão

        if (countTentativasEnvioComando >= 3) then
        begin

          InnerCadastrados[InnerAtual].EstadoAtual := ESTADO_RECONECTAR;

        end;

        Inc(InnerCadastrados[InnerAtual].countTentativasEnvioComando);

      end;
    except

      EstadoAtual := ESTADO_CONECTAR;

    end;

  end;

end;

procedure TFrmCatraca.ConfigurarEntradasOnline;
var
  ValorDecimal: Integer;
begin

  lblStatusConexao.Caption := 'Configurando entrada Online';

  with InnerCadastrados[InnerAtual] do
  begin

    try

      ValorDecimal := ConfigurarEntradaMudancasOnline(InnerAtual);

      Retorno := EnviarFormasEntradasOnLine(InnerCadastrados[InnerAtual].Numero,
                                            InnerCadastrados[InnerAtual].QtdDigitos,
                                            1, ValorDecimal, 15, 17);

      if (Retorno = RET_OK) then
      begin
      
        InnerCadastrados[InnerAtual].TempoInicialPingOnLine := Now;
        InnerCadastrados[InnerAtual].countTentativasEnvioComando := 0;
        InnerCadastrados[InnerAtual]. EstadoAtual := ESTADO_POLLING;

      end
      else
      begin

        if (InnerCadastrados[InnerAtual].countTentativasEnvioComando >= 3) then
          InnerCadastrados[InnerAtual].EstadoAtual := ESTADO_RECONECTAR;

        Inc(InnerCadastrados[InnerAtual].countTentativasEnvioComando);

      end;

    except

      InnerCadastrados[InnerAtual].EstadoAtual := ESTADO_CONECTAR;

    end;

  end;

end;

procedure TFrmCatraca.EnviarConfigOffline;
begin

end;

procedure TFrmCatraca.EnviarConfigOnline;
begin

  lblStatusConexao.Caption := 'Enviando Configurações online';
  Application.ProcessMessages;

  with InnerCadastrados[InnerAtual] do
  begin

    try

      DefinirPadraoCartao(1);
      ConfigurarInnerOnLine();
      ConfigurarAcionamento1(1, 5);
      ConfigurarAcionamento2(0, 0);
      ConfigurarLeitor1(3);
      ConfigurarLeitor2(0);
      ConfigurarTipoLeitor(0);
      DefinirQuantidadeDigitosCartao(10);
      HabilitarTeclado(1, 0);
      RegistrarAcessoNegado(1);
      DefinirFuncaoDefaultLeitoresProximidade(12);
      DefinirFuncaoDefaultSensorBiometria(0);
      ReceberDataHoraDadosOnLine(1);

      Retorno := EnviarConfiguracoes(InnerCadastrados[InnerAtual].Numero);

      if ( Retorno = RET_OK ) then
      begin

        lblStatusConexao.Caption := 'Configurações enviadas';
        InnerCadastrados[InnerAtual].countTentativasEnvioComando := 0;
        InnerCadastrados[InnerAtual].EstadoAtual := ESTADO_ENVIAR_DATA_HORA;

      end
      else
      begin

        if (InnerCadastrados[InnerAtual].countTentativasEnvioComando >= 3) then
          InnerCadastrados[InnerAtual].EstadoAtual := ESTADO_RECONECTAR;

        Inc(InnerCadastrados[InnerAtual].countTentativasEnvioComando);

      end;
    Except
      InnerCadastrados[InnerAtual].EstadoAtual := ESTADO_CONECTAR;
    end;

  end;

end;

procedure TFrmCatraca.EnviarDataHora;
var
  Dia, Mes, Ano, Hora, Minuto, Segundo: Integer;
begin

  lblStatusConexao.Caption := 'Enviando data e hora';
  Application.ProcessMessages;


  with InnerCadastrados[InnerAtual] do
  begin

    try

      Dia := StrToInt(FormatDateTime('dd', Now));
      Mes := StrToInt(FormatDateTime('mm', Now));
      Ano := StrToInt(FormatDateTime('yy', Now));
      Hora := StrToInt(FormatDateTime('hh', Now));
      Minuto := StrToInt(FormatDateTime('nn', Now));
      Segundo := StrToInt(FormatDateTime('ss', Now));

      Retorno := EnviarRelogio(InnerCadastrados[InnerAtual].Numero, Dia, Mes,
                                Ano, Hora, Minuto, Segundo);

      if (Retorno = RET_OK) then
      begin

        InnerCadastrados[InnerAtual].countTentativasEnvioComando := 0;
        InnerCadastrados[InnerAtual].EstadoAtual := ESTADO_ENVIAR_MSG_PADRAO;

      end
      else
      begin

        if (InnerCadastrados[InnerAtual].countTentativasEnvioComando >= 3) then
        begin

          InnerCadastrados[InnerAtual].EstadoAtual := ESTADO_RECONECTAR;

        end;

        Inc(InnerCadastrados[InnerAtual].countTentativasEnvioComando);

      end;

    Except

      InnerCadastrados[InnerAtual].EstadoAtual := ESTADO_CONECTAR;

    end;

  end;

end;

procedure TFrmCatraca.EnviarMensagemPadrao;
begin

  lblStatusConexao.Caption := 'Enviando Mensagem Padrao';
  Application.ProcessMessages;

  with InnerCadastrados[InnerAtual] do
  begin

    try

      Retorno := EnviarMensagemPadraoOnLine(Numero, 1, 'Modo Online');

      if (Retorno = RET_OK) then
      begin

        InnerCadastrados[InnerAtual].countTentativasEnvioComando := 0;
        InnerCadastrados[InnerAtual].EstadoAtual := ESTADO_CONFIGURAR_ENTRADAS_ONLINE;

      end
      else
      begin

        if (InnerCadastrados[InnerAtual].countTentativasEnvioComando >= 3) then
        begin

          InnerCadastrados[InnerAtual].EstadoAtual := ESTADO_RECONECTAR;

        end;

        Inc(InnerCadastrados[InnerAtual].countTentativasEnvioComando);

      end;

    except

      InnerCadastrados[InnerAtual].EstadoAtual := ESTADO_CONECTAR;

    end;
  end;
  
end;

procedure TFrmCatraca.EnviarPingOnline;
begin

  lblStatusConexao.Caption := 'Ping Online';
  Application.ProcessMessages;

  with InnerCadastrados[InnerAtual] do
  begin

    Retorno := PingOnLine(Numero);

    try

      if (Retorno = RET_OK) then
      begin

        InnerCadastrados[InnerAtual].EstadoAtual := EstadoSolicitacaoPingOnLine;

      end
      else
      begin

        if (InnerCadastrados[InnerAtual].countTentativasEnvioComando >= 3) then
          InnerCadastrados[InnerAtual].EstadoAtual := ESTADO_RECONECTAR;

        Inc(InnerCadastrados[InnerAtual].countTentativasEnvioComando);

      end;

      InnerCadastrados[InnerAtual].TempoInicialPingOnLine := Now;

    except

      InnerCadastrados[InnerAtual].EstadoAtual := ESTADO_CONECTAR;

    end;

  end;

end;

procedure TFrmCatraca.FecharConexao;
begin

end;

procedure TFrmCatraca.LiberarCatraca;
begin

  with InnerCadastrados[InnerAtual] do
  begin

    TRY
      // Envia comando de liberar a catraca para Entrada.
      if (LiberaEntrada) then
      begin
        EnviarMensagemPadraoOnLine(InnerCadastrados[InnerAtual].Numero, 0,'ENTRADA LIBERADA');
        LiberaEntrada := False;
        Retorno := LiberarCatracaEntrada(InnerCadastrados[InnerAtual].Numero);
      end
      else if (LiberaEntradaInvertida) then
      begin
        EnviarMensagemPadraoOnLine(Numero, 0, 'ENTRADA LIBERADA');
        LiberaEntradaInvertida := False;
        Retorno := LiberarCatracaEntradaInvertida( InnerCadastrados[InnerAtual].Numero );
      end
      else if (LiberaSaida) then
      begin
        EnviarMensagemPadraoOnLine(InnerCadastrados[InnerAtual].Numero, 0,'SAIDA LIBERADA');
        LiberaSaida := False;
        Retorno := LiberarCatracaSaida( InnerCadastrados[InnerAtual].Numero );
      end
      else if (LiberaSaidaInvertida) then
      begin
        EnviarMensagemPadraoOnLine(Numero, 0, 'SAIDA LIBERADA');
        LiberaSaidaInvertida := False;
        Retorno := LiberarCatracaSaidaInvertida( InnerCadastrados[InnerAtual].Numero );
      end
      else
      begin
        EnviarMensagemPadraoOnLine(Numero, 0, 'LIBERADO DOIS SENTIDOS');
        Retorno := LiberarCatracadoisSentidos( InnerCadastrados[InnerAtual].Numero );
      end;

      // Testa Retorno do comando..
      if (Retorno = RET_OK) then
      begin
        AcionarBipCurto( InnerCadastrados[InnerAtual].Numero );
        InnerCadastrados[InnerAtual].CountPingFail := 0;
        InnerCadastrados[InnerAtual].CountTentativasEnvioComando := 0;
        InnerCadastrados[InnerAtual].TempoInicialPingOnLine := Now;
        InnerCadastrados[InnerAtual].EstadoAtual := ESTADO_MONITORA_GIRO_CATRACA;
      end
      else
      begin
        // Se o retorno for diferente de 0 tenta liberar a catraca 3 vezes, caso não consiga enviar o comando volta para o passo reconectar.
        if ( InnerCadastrados[InnerAtual].CountTentativasEnvioComando >= 3 ) then
        begin
          InnerCadastrados[InnerAtual].CountTentativasEnvioComando := 0;
          InnerCadastrados[InnerAtual].EstadoAtual := ESTADO_RECONECTAR;
        end;

        // Adiciona 1 ao contador de tentativas
        Inc( InnerCadastrados[InnerAtual].CountTentativasEnvioComando );
      end;
    except
      InnerCadastrados[InnerAtual].EstadoAtual := ESTADO_CONECTAR;
    end;
  end;

end;

procedure TFrmCatraca.MonitorarGiroCatraca;
var
  Inner, Origem, Complemento, Dia, Mes, Ano, Hora, Minuto, Segundo : Byte;
  Cartao : array[0..10] of Char;
  Tempo: TDateTime;
begin

  with InnerCadastrados[InnerAtual] do
  begin

    TRY

      Origem := 0;
      Complemento := 0;
      Dia := 0;
      Mes := 0;
      Ano := 0;
      Hora := 0;
      Minuto := 0;
      Segundo := 0;

      // Monitora o giro da catraca..
      Retorno := ReceberDadosOnLine(Numero, @Origem, @Complemento,
                                @Cartao, @Dia, @Mes, @Ano, @Hora,
                                @Minuto, @Segundo);

      // Testa o retorno do comando..
      if (Retorno = RET_OK) then
      begin

        InnerCadastrados[InnerAtual].EstadoAtual := ESTADO_ENVIAR_MSG_PADRAO;
        
      end
      else
      begin
        // Caso o tempo que estiver monitorando o giro chegue a 3 segundos,
        // deverá enviar o ping on line para manter o equipamento em modo on line
        tempo := Now - InnerCadastrados[InnerAtual].TempoInicialPingOnLine;
        if StrtoInt(formatDateTime('ss', tempo)) >= 3 then
        begin
          InnerCadastrados[InnerAtual].EstadoSolicitacaoPingOnLine := EstadoAtual;
          InnerCadastrados[InnerAtual].CountTentativasEnvioComando := 0;
          InnerCadastrados[InnerAtual].TempoInicialPingOnLine := Now;
          InnerCadastrados[InnerAtual].EstadoAtual := PING_ONLINE;
        end;
      end;
    except
      InnerCadastrados[InnerAtual].EstadoAtual := ESTADO_CONECTAR;
    end;
  end;

end;

procedure TFrmCatraca.Polling;
var
  Inner, Origem, Complemento, Dia, Mes, Ano, Hora, Minuto, Segundo : Byte;
  Cartao : array[0..10] of Char;
  count: Byte;
  Tempo: TDateTime;
  Retorno : Byte;
begin

  lblStatusConexao.Caption := 'Estado de polling';
  SetStatusCatraca(2);
  Application.ProcessMessages;

  Origem := 0;
  Complemento := 0;
  Dia := 0;
  Mes := 0;
  Hora := 0;
  Minuto := 0;
  Segundo := 0;

  {if ( BuscaUsuario('0101015627') = True ) then
  begin
    ShowMessage('Usuario encontrado');
  end; }


  with InnerCadastrados[InnerAtual] do
  begin

    try

        Retorno := ReceberDadosOnLine(InnerCadastrados[InnerAtual].Numero, @Origem, @Complemento, @Cartao,
                                      @Dia, @Mes, @Ano, @Hora, @Minuto, @Segundo);

        if (Retorno = RET_OK) then
        begin

          if (      (Complemento = 5)
                 OR (Complemento = 6)
                 OR (Complemento = 65)
                 OR (Complemento = 42)
                 OR (Cartao = '') ) then
          begin
				    InnerCadastrados[InnerAtual].CountTentativasEnvioComando := 0;
				    InnerCadastrados[InnerAtual].EstadoAtual := ESTADO_ENVIAR_MSG_PADRAO;
				    Exit;
			    end;

        ShowMessage('Polling True');

        ShowMessage(Cartao);


        if ( complemento = 1 ) then
          HabilitarLadoCatraca('Entrada')
        else
          HabilitarLadoCatraca('Saida');


        InnerCadastrados[InnerAtual].EstadoAtual := ESTADO_LIBERAR_CATRACA;

        end
        else
        begin

        Tempo := Now - InnerCadastrados[InnerAtual].TempoInicialPingOnLine;

          if (StrToInt(FormatDateTime('ss', Tempo)) >= 3) then
          begin

            InnerCadastrados[InnerAtual].EstadoSolicitacaoPingOnLine := EstadoAtual;
            InnerCadastrados[InnerAtual].countTentativasEnvioComando := 0;
            InnerCadastrados[InnerAtual].TempoInicialPingOnLine := Now;
            InnerCadastrados[InnerAtual].EstadoAtual := PING_ONLINE;

          end;

        end;
    except

        InnerCadastrados[InnerAtual].EstadoAtual := ESTADO_CONECTAR;

    end;

  end;

end;

procedure TFrmCatraca.Reconectar;
begin

  SetStatusCatraca(1);

  Application.ProcessMessages;

  // Estado de reconexão, fica tentando conectar até que consiga uma resposta

  with InnerCadastrados[InnerAtual] do
  begin

    Retorno := TestaConexaoInner(InnerCadastrados[InnerAtual].Numero);

    if Retorno = RET_OK then
    begin

      // Caso consiga uma conexão entra no estado de enviar configurações online

      lblStatusConexao.Caption := 'Conectado';
      Application.ProcessMessages;
      
      InnerCadastrados[InnerAtual].countTentativasEnvioComando := 0;
      InnerCadastrados[InnerAtual].EstadoAtual := ESTADO_ENVIAR_CFG_ONLINE;

    end

  end;

end;

procedure TFrmCatraca.TrataConfigsCartao;
begin

end;

function TFrmCatraca.TestaConexaoInner(NumInner: Integer): Byte;
var
  Dia, Mes, Ano, Hora, Minuto, Segundo : Byte;
begin

  Dia := 0;
  Mes := 0;
  Ano := 0;
  Hora := 0;
  Minuto := 0;
  Segundo := 0;

  TestaConexaoInner := ReceberRelogio(NumInner, @Dia, @Mes, @Ano, @Hora,
                                      @Minuto, @Segundo);

end;

function TFrmCatraca.ConfigurarEntradaMudancasOnline(
  NumInner: Integer): Integer;
var
  Configuracao, Leitor: String;
begin

  with InnerCadastrados[NumInner] do
  begin
    if (InnerCadastrados[InnerAtual].Teclado) then
      Configuracao := '1'
    else
      Configuracao := '0';

    if not(InnerCadastrados[InnerAtual].Biometrico) then
    begin

      if (InnerCadastrados[InnerAtual].DoisLeitores) then
        Configuracao := '010' + '001' + Configuracao
      else
        Configuracao := '000' + '011' + Configuracao;

      Configuracao := '1' + Configuracao;

    end
    else
    begin

      if (InnerCadastrados[InnerAtual].DoisLeitores) then
        Leitor := '11'
      else
        Leitor := '10';

      Configuracao := '0' + '1' + IntToStr(InnerCadastrados[InnerAtual].Identificacao) +
        IntToStr(InnerCadastrados[InnerAtual].Verificacao) + '0' + Leitor + Configuracao;

    end;

    ConfigurarEntradaMudancasOnline :=
      StrToInt(BinarioParaDecimal(Configuracao));

  end;

end;

function TFrmCatraca.BinarioParaDecimal(valorBinario: String): String;
var
  Decimal: Real;
  x, y: Integer;
begin

  Decimal := 0;
  y := 0;

  for x := Length(valorBinario) doWNTO 1 do
  begin

    Decimal := Decimal + (StrToFloat(valorBinario[x])) * Exp(y * Ln(2));
    y := y + 1;

  end;

  BinarioParaDecimal := FloatToStr(Decimal);

end;

procedure TFrmCatraca.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin

  Parar := True;
  MaquinaDeEstados();

  CanClose := True;
  
end;

procedure TFrmCatraca.HabilitarLadoCatraca(Lado: String);
begin

  if ( UpperCase( Lado ) = 'ENTRADA' ) then
  begin

    LiberaEntradaInvertida := True;
    LiberaEntrada := False;

  end
  else
  begin

    LiberaSaidaInvertida := True;
    LiberaSaida := False;

  end;

end;

procedure TFrmCatraca.ConectaBanco;
begin

  with ScnBanco do
  begin

    try

      Close;
      ConnectionName := 'FBConnection';
      LibraryName := 'dbexpint.dll';
      GetDriverFunc := 'getSQLDriverINTERBASE';
      DriverName := 'Firebird';
      VendorLib := 'fbclient.dll';
      Params.Values['DriverName'] := 'Firebird';
      //Params.Values['DataBase'] := 'C:\Users\Gui\Desktop\Catraca\ASSOCIADOS.FDB';
      Params.Values['DataBase'] := 'Z:\Usr\DB\ASSOCIADOS.FDB';
      Params.Values['RoleName'] := '';
      Params.Values['User_Name'] := 'SYSDBA';
      Params.Values['Password'] := 'masterkey';
      Params.Values['ServerCharSet'] := '';
      Params.Values['SQLDialect'] := '3';
      Params.Values['ErrorResourceFile'] := '';
      Params.Values['LocaleCode'] := '0000';
      Params.Values['BlobSize'] := '-1';
      Params.Values['CommitRetain'] := 'False';
      Params.Values['WaitOnLocks'] := 'True';
      Params.Values['InterBase TransIsolation'] := 'ReadCommited';
      Params.Values['Trim Char'] := 'False';
      Open;

    except

      on Erro: Exception do
        raise Exception.Create('Erro ao conectar ao banco de dados: ' +
          Erro.Message);

    end;

  end;

end;

procedure TFrmCatraca.Button2Click(Sender: TObject);
begin
  BuscaUsuario( Edit1.text );
end;

function TFrmCatraca.BuscaUsuario(Cartao: String): Boolean;
var
  QtdDados: Byte;
  Nome, Tipo: String;
  ParcelasAtrasadas, IdPessoa: Integer;
begin

  ConectaBanco();

  with QryPrincipal do

  Begin

    try

      Try

        SQLConnection := scnBanco;

        SQL.Clear;

        SQL.ADD('SELECT');
        SQL.ADD('    COUNT(*) QTD_DADOS');
        SQL.ADD('FROM');
        SQL.ADD('    ACC_PESSOA_CARTAO CARTAO');
        SQL.ADD('INNER JOIN');
        SQL.ADD('    VW_DADOS_PESSOAS DADOS');
        SQL.ADD('ON');
        SQL.ADD('    CARTAO.PESSOA_ID = DADOS.PESSOA_ID');
        SQL.ADD('LEFT JOIN');
        SQL.ADD('    PROC_CALC_DEB_TITULO(DADOS.TITULO) PARCELAS');
        SQL.ADD('ON');
        SQL.ADD('    1 = 1');
        SQL.ADD('WHERE');
        SQL.ADD('    CARTAO.CODIGO_CARTAO = ''' + Cartao + ''' ');

        Open;
        First;

        QtdDados := FieldByName('QTD_DADOS').AsInteger;

        Close;
        SQL.Clear;

        SQL.ADD('SELECT');
        SQL.ADD('    CARTAO.CODIGO_CARTAO CARTAO,');
        SQL.ADD('    DADOS.NOME NOME,');
        SQL.ADD('    DADOS.TITULO TITULO,');
        SQL.ADD('    DADOS.PESSOA_ID ID_PESSOA,');
        SQL.ADD('    DADOS.VINCULO_DEPENDENCIA TIPO,');
        SQL.ADD('    COALESCE(PARCELAS.MESES_ATRASADOS, 0) PARCELAS_ATRASADAS');
        SQL.ADD('FROM');
        SQL.ADD('    ACC_PESSOA_CARTAO CARTAO');
        SQL.ADD('INNER JOIN');
        SQL.ADD('    VW_DADOS_PESSOAS DADOS');
        SQL.ADD('ON');
        SQL.ADD('    CARTAO.PESSOA_ID = DADOS.PESSOA_ID');
        SQL.ADD('LEFT JOIN');
        SQL.ADD('    PROC_CALC_DEB_TITULO(DADOS.TITULO) PARCELAS');
        SQL.ADD('ON');
        SQL.ADD('    1 = 1');
        SQL.ADD('WHERE');
        SQL.ADD('    CARTAO.CODIGO_CARTAO = ''' + Cartao + ''' ');

        Open;
        First;

          Nome := FieldByName('NOME').AsString;
          Tipo := FieldByName('TIPO').AsString;
          ParcelasAtrasadas := FieldByName('PARCELAS_ATRASADAS').AsInteger;
          IdPessoa := FieldByName('ID_PESSOA').AsInteger;

        if (QtdDados = 0) then
        begin

          SetStatusCatraca(6);
          BuscaUsuario := False;

        end
        else
        begin

          if (FieldByName('PARCELAS_ATRASADAS').AsInteger = 1) then
          begin

            SetStatusCatraca(4);

          end
          else if (FieldByName('PARCELAS_ATRASADAS').AsInteger = 0) then
          begin

            SetStatusCatraca(3);

          end
          else
          begin

            SetStatusCatraca(5);

            SetUsuario(Nome, Cartao, Tipo, ParcelasAtrasadas, IdPessoa);

            BuscaUsuario := False;

          end;


          SetUsuario(Nome, Cartao, Tipo, ParcelasAtrasadas, IdPessoa);
          BuscaUsuario := True;

        end;

       Except on E : Exception do
        ShowMessage( E.Message );

        //ShowMessage('Não foi possível conectar com o banco');

      End;

    finally
      Close;
    end;

  End;

end;

procedure TFrmCatraca.SetUsuario(Nome, Cartao, Tipo: String;
  ParcelasAtrasadas, IdPessoa: Integer);
begin

  EdtNome.text := Nome;
  EdtCartao.text := Cartao;

  if (Tipo <> 'TITULAR') then
  begin

    EdtTipoPessoa.text := 'DEPENDENTE';

  end
  else
  begin

    EdtTipoPessoa.text := Tipo;

  end;

  EdtParcelasVencidas.text := IntToStr(ParcelasAtrasadas);

  ImgFotoAssociado.Picture.LoadFromFile('Z:\Usr\DB\Fotos\' + IntToStr(IdPessoa) + '.JPG' );

  //ImgFotoAssociado.Picture.LoadFromFile('C:\Users\Gui\Desktop\Catraca\Fotos\' + IntToStr(IdPessoa) + '.JPG' );


end;

end.
