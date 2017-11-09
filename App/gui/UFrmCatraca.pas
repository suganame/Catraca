unit UFrmCatraca;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, UConstantes, UFuncoes, UFrmConfiguracoes,
  Vcl.Menus, Data.DB, Data.SqlExpr, DBXFirebird, Data.FMTBcd, Vcl.ExtCtrls, IWSystem, IniFiles,
  Vcl.Imaging.jpeg, Bilhete;

type
  TFrmCatraca = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    QryPrincipal: TSQLQuery;
    ScnBanco: TSQLConnection;
    PnStatusConexao: TPanel;
    LblStatus: TLabel;
    TmrStatusCatraca: TTimer;
    PnStatusCatraca: TPanel;
    LblTituloCatraca: TLabel;
    LblTextoCatraca: TLabel;
    TmrDelay: TTimer;
    PnBordaImagem: TPanel;
    PnFundoImagem: TPanel;
    ImgFotoAssociado: TImage;
    LblNome: TLabel;
    EdtNome: TEdit;
    LblCartao: TLabel;
    EdtCartao: TEdit;
    LblParcelasVencidas: TLabel;
    EdtParcelasVencidas: TEdit;
    LblTipoPessoa: TLabel;
    EdtTipoPessoa: TEdit;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Button10: TButton;
    Button11: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TmrStatusCatracaTimer(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TmrDelayTimer(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }

    function TestaConexaoInner( NumInner : Integer) : Integer;
    function BinarioParaDecimal(valorBinario: String) : String;
    function AbrirConexao : Integer;
    function ConfigurarEntradaMudancasOnline( NumInner : Integer) : Integer;

    procedure SetConfiguracaoInicialInner();
    procedure MaquinaDeEstados();
    procedure SetConfiguracaoInner( Modo : Integer);
    procedure HabilitarLadoCatraca( lado: String );

    procedure SetStatusCatraca( Status: Integer );
    procedure EsconderFormulario();
    procedure MostrarFormulario();

    procedure ConectaBanco();
    procedure BuscaUsuario();

    procedure GravaIni();
    procedure CarregaIni();


  //  Procedimentos da maquina de estados
    procedure Conectar();
    procedure Reconectar();
    procedure EnviarConfigOffline();
    procedure EnviarConfigOnline();
    procedure EnviarDataHora();
    procedure EnviarMensagemPadrao();
    procedure ConfigurarEntradasOnline();
    procedure Pooling();
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

  InnerCadastrados : array of inner;
  TotalInners, InnerAtual, Delay : Integer;
  Retorno : Byte;
  Parar, LiberaEntrada, LiberaEntradaInvertida, LiberaSaida, LiberaSaidaInvertida : Boolean;
  ArqIni : TIniFile;
  CorAzul, CorVermelha, CorVerde, CorRoxa : TColor;

implementation

{$R *.dfm}

uses UFrmPrincipal;

function TFrmCatraca.BinarioParaDecimal(valorBinario: String): String;
var
  Decimal : Real;
  x, y: Integer;
begin

  decimal := 0;
  y := 0;
  
  for x := Length(valorBinario) doWNTO 1 do
  begin
  
    decimal := decimal + (StrToFloat(valorBinario[x])) * Exp(y * Ln(2));
    y := y + 1;
    
  end;
  
  BinarioParaDecimal := FloatToStr(decimal);
  
end;

procedure TFrmCatraca.BuscaUsuario;
begin

  with QryPrincipal do
  Begin

    Close;
    SQL.Clear;

  End;

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
var
  origem, complemento, dia, mes, ano, hora, minuto, segundo : Byte;
  cartao : array[0..10] of Char;
  count, countTentativasEnvioComando : Integer;
begin

  // Seta Configurções Padrões do Inner
  SetConfiguracaoInicialInner();

  // Tenta abrir conexão com a porta padrão
  retorno := AbrirConexao();
//  retorno := 0;

  // Caso Consiga, ele entra na maquina de estados
  if ( retorno = RET_OK )then
  begin

    parar := False;
    MaquinaDeEstados();

  end;


end;

function TFrmCatraca.AbrirConexao: Integer;
var
  Porta : Integer;
  PadraoCartao : Integer;
begin

//  Porta := StrToInt( FrmConfiguracoes.EdtPorta.Text );
//  PadraoCartao := FrmConfiguracoes.CbxPadraoCartao.ItemIndex;

  DefinirTipoConexao(2);
  DefinirPadraoCartao(1);
  FecharPortaComunicacao();

  AbrirConexao := AbrirPortaComunicacao(3570);

end;

procedure TFrmCatraca.SetConfiguracaoInner(Modo: Integer);
begin
  with InnerCadastrados[InnerAtual] do
  begin

    DefinirPadraoCartao(PadraoCartao);

    if ( Modo = MODO_OFFLINE ) then
      ConfigurarInnerOffLine()
    else
      ConfigurarInnerOnLine();

    ConfigurarAcionamento1(6, 5);
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

  end;

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
        LblTextoCatraca.Caption := 'Há parcelas atrasadas, verifique com a secretaria. Seja bem vindo!';

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
        LblTextoCatraca.Caption := 'Usuário não cadastrado, verifique com a secretaria.';

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

end;

procedure TFrmCatraca.Button2Click(Sender: TObject);
begin
  lblStatus.Caption := 'Parado';
  Parar := True;
  Application.ProcessMessages;
end;

procedure TFrmCatraca.Button4Click(Sender: TObject);
begin
  ConectaBanco();
end;

procedure TFrmCatraca.Button5Click(Sender: TObject);
begin

  with QryPrincipal do
  begin

    Try

      Try

        Close;
        SQL.Clear;

        SQL.Add('SELECT * FROM SOCIOS WHERE TITULO = 0');

        Open;
        First;

        if ( RecordCount = 0 ) then
        begin

          SetStatusCatraca(6);
        
        end;
    
      Except

        Showmessage( 'Erro ao conectar com o banco' );
    
      End;

    
    Finally

      Close;

    End;
  
    

  end;
  


end;

procedure TFrmCatraca.Button6Click(Sender: TObject);
begin

  SetStatusCatraca(1);

end;

procedure TFrmCatraca.Button7Click(Sender: TObject);
begin

  SetStatusCatraca(4);

end;

procedure TFrmCatraca.Button8Click(Sender: TObject);
begin

  SetStatusCatraca(2);

end;



procedure TFrmCatraca.Button9Click(Sender: TObject);
begin

  SetStatusCatraca(3);

end;

procedure TFrmCatraca.EnviarMensagemPadrao;
begin

  lblStatus.Caption := 'Enviando Mensagem Padrao';
  Application.ProcessMessages;

  with InnerCadastrados[InnerAtual] do
  begin

    try

      Retorno := EnviarMensagemPadraoOnLine(Numero, 1, 'MODO ONLINE');

      if ( Retorno = RET_OK ) then
      begin

        EstadoAtual := ESTADO_CONFIGURAR_ENTRADAS_ONLINE;
        CountTentativasEnvioComando := 0;
      
      end
      else
      begin

        if ( CountTentativasEnvioComando >= 3 ) then
        begin

          EstadoAtual := ESTADO_RECONECTAR;
          
        end;

        Inc(CountTentativasEnvioComando);
        
      end;
  
    except

      EstadoAtual := ESTADO_CONECTAR;
    
    end;
    
  end;
end;

procedure TFrmCatraca.HabilitarLadoCatraca(lado: String);
begin

  if ( UpperCase(lado) = 'ENTRADA' ) then
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

procedure TFrmCatraca.CarregaIni;
var
  ArqIni : TIniFile;
  aTexto : String;
begin

//  if not ( FileExists(gsAppPath + 'ini.ini') )  then
//  begin
//
//    ShowMessage('Arquivo inexistente');
//
//  end
//  else
//  begin
//
//    ShowMessage('Arquivo existente');
//
//  end;



  try

//    aTexto := ArqIni.ReadString('Dados', 'Texto', aTexto);

//    ShowMessage(aTexto);

  finally

    ArqIni.Free;

  end;


end;

procedure TFrmCatraca.LiberarCatraca;
begin

  lblStatus.Caption := 'Liberando Giro da catraca';
  Application.ProcessMessages;

  with InnerCadastrados[InnerAtual] do
  begin
  
    try   

      if( LiberaEntrada ) then
      begin
      
        EnviarMensagemPadraoOnLine( Numero, 0, 'ENTRADA LIBERADA' );
        LiberaEntrada := False;
        Retorno := LiberarCatracaEntrada( Numero );
        
      end
      else if ( LiberaEntradaInvertida ) then
      begin
      
        EnviarMensagemPadraoOnLine( Numero, 0, 'ENTRADA LIBERADA' );
        LiberaEntradaInvertida := False;
        Retorno := LiberarCatracaEntradaInvertida( Numero );
      
      end
      else if ( LiberaSaida ) then
      begin

        EnviarMensagemPadraoOnLine(Numero, 0, 'SAIDA LIBERADA');
        LiberaSaida := False;
        Retorno := LiberarCatracaSaida(Numero);
      
      end
      else if ( LiberaSaidaInvertida ) then           
      begin

        EnviarMensagemPadraoOnLine( Numero, 0, 'SAIDA LIBERADA' );
        LiberaSaidaInvertida := False;
        Retorno := LiberarCatracaSaidaInvertida( Numero );
      
      end
      else
      begin
      
        EnviarMensagemPadraoOnLine( Numero, 0, 'LIBERADO DOIS SENTIDOS' );
        Retorno := LiberarCatracaDoisSentidos(Numero);
      
      end;

      if ( Retorno = RET_OK ) then
      begin

        ShowMessage('Liberando Catraca');
        AcionarBipCurto( Numero );
        CountPingFail := 0;
        CountTentativasEnvioComando := 0;
        TempoInicialPingOnLine := Now;
        EstadoAtual := ESTADO_MONITORA_GIRO_CATRACA;

      end
      else
      begin
      
        if ( CountTentativasEnvioComando >= 3 ) then
        begin
        
          CountTentativasEnvioComando := 0;
          EstadoAtual := ESTADO_RECONECTAR;
        
        end;

        Inc(CountTentativasEnvioComando);
      
      end;

    except

      EstadoAtual := ESTADO_CONECTAR;
    
    end;
  
  end;

  

end;

procedure TFrmCatraca.SetConfiguracaoInicialInner;
begin

  SetLength(innerCadastrados, 1);

  innerCadastrados[0].Numero := 1;
  innerCadastrados[0].Catraca := True;
  innerCadastrados[0].Biometrico := False;
  innerCadastrados[0].QtdDigitos := 10;
  innerCadastrados[0].CntDoEvents := 0;
  innerCadastrados[0].Teclado := True;
  innerCadastrados[0].PadraoCartao := 0;
  innerCadastrados[0].ListaBio := False;
  innerCadastrados[0].Lista := False;
  innerCadastrados[0].Verificacao := 0;
  innerCadastrados[0].Identificacao := 0;
  innerCadastrados[0].DoisLeitores := False;
  innerCadastrados[0].CountPingFail := 0;
  innerCadastrados[0].CountTentativasEnvioComando := 0;
  innerCadastrados[0].EstadoAtual := ESTADO_CONECTAR;

end;

procedure TFrmCatraca.MaquinaDeEstados;
begin
  while ( not Parar ) do
  begin

    with innerCadastrados[innerAtual] do
    begin

      case EstadoAtual of

        ESTADO_CONECTAR:
          Conectar();

        ESTADO_ENVIAR_CFG_OFFLINE:
          EnviarConfigOffline;

//        ESTADO_COLETAR_BILHETES: ;

        ESTADO_ENVIAR_CFG_ONLINE:
          EnviarConfigOnline();

        ESTADO_ENVIAR_DATA_HORA:
          EnviarDataHora();

        ESTADO_ENVIAR_MSG_PADRAO:
          EnviarMensagemPadrao();

        ESTADO_CONFIGURAR_ENTRADAS_ONLINE: 
          ConfigurarEntradasOnline();
          
        ESTADO_POLLING: 
          Pooling();
        
        ESTADO_LIBERAR_CATRACA: 
          LiberarCatraca();

        ESTADO_ENVIAR_BIPCURTO:
          MonitorarGiroCatraca();

        PING_ONLINE:
          EnviarPingOnline();

        ESTADO_RECONECTAR:
          Reconectar();

//        AGUARDA_TEMPO_MENSAGEM: ;
//        ESTADO_DEFINICAO_TECLADO: ;
//        ESTADO_AGUARDAR_DEFINICAO_TECLADO: ;
//        ESTADO_ENVIA_MSG_URNA: ;
//        ESTADO_MONITORA_URNA: ;
//        ESTADO_ENVIAR_MENSAGEM: ;
//        ESTADO_ENVIAR_HORARIOS: ;
//        ESTADO_ENVIAR_CONFIGS_ONLINE_OFFLINE: ;
//        ESTADO_ENVIAR_MSG_ACESSO_NEGADO: ;

        ESTADO_TRATA_CARTAO_TRATA_CONFIGS: 
          TrataConfigsCartao();

//        ESTADO_VALIDAR_ACESSO: ;
//        ESTADO_VERIFICAR_SENHA: ;
//        ESTADO_ENVIAR_CONFIGMUD_ONLINE_OFFLINE: ;
      end;
    end;
  end;
end;


procedure TFrmCatraca.MonitorarGiroCatraca;
var
  Bilhete : TBilhete;
  Cartao : array[0..10] of Char;
  CartaoRecebido : string;
  Tempo : TDateTime;
begin

  LblStatus.Caption := 'Monitorando Giro';
  Application.ProcessMessages;

  with InnerCadastrados[InnerAtual] do
  begin

    try

      Bilhete := TBilhete.Create;
      Bilhete.Origem := 0;
      Bilhete.Complemento := 0;
      Bilhete.Dia := 0;
      Bilhete.Mes := 0;
      Bilhete.Ano := 0;
      Bilhete.Hora := 0;
      Bilhete.Minuto := 0;
      Bilhete.Segundo := 0;


      Retorno := ReceberDadosOnLine(Numero, @Bilhete.Origem, @Bilhete.Complemento,
                                    @Bilhete.Cartao, @Bilhete.Dia,
                                    @Bilhete.Mes, @Bilhete.Ano,
                                    @Bilhete.Hora, @Bilhete.Minuto, @Bilhete.Segundo);

      if (Retorno = RET_OK) then
      begin

        if( Bilhete.Origem = 5 ) then
        begin

          ShowMessage('Não girou');

        end
        else if( Bilhete.Origem = 6 ) then
        begin

          if( Bilhete.Complemento = 1 ) then
          begin

            ShowMessage('Girou para entrada');

          end
          else
          begin

            ShowMessage('Girou para saída');

          end;

        end;

        EstadoAtual := ESTADO_ENVIAR_MSG_PADRAO;

      end
      else
      begin

        Tempo := Now - TempoInicialPingOnLine;

        if( StrToInt( FormatDateTime('ss', Tempo) ) >= 3 ) then
        begin

          EstadoSolicitacaoPingOnLine := EstadoAtual;
          CountTentativasEnvioComando := 0;
          TempoInicialPingOnLine := Now;
          EstadoAtual := PING_ONLINE

        end;

      end;

    Except

      ShowMessage('Deu problema');

      EstadoAtual := ESTADO_CONECTAR;

    end;



  end;

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

procedure TFrmCatraca.EnviarPingOnline;
begin

  lblStatus.Caption := 'Ping Online';
  Application.ProcessMessages;

  with InnerCadastrados[InnerAtual] do
  begin

    Retorno := PingOnLine(Numero);

    try

      if ( Retorno = RET_OK ) then
      begin

        EstadoAtual := EstadoSolicitacaoPingOnline;

      end
      else
      begin

        if( CountTentativasEnvioComando >= 3 ) then
          EstadoAtual := ESTADO_RECONECTAR;

        Inc( CountTentativasEnvioComando );

      end;

      TempoInicialPingOnLine := Now;

    except

      EstadoAtual := ESTADO_CONECTAR;

    end;

  end;

end;

procedure TFrmCatraca.EsconderFormulario;
begin

  PnBordaImagem.Visible := False;
//  PnFundoImagem.Visible := False;
//  ImgFotoAssociado.Visible := False;

  LblNome.Visible := False;
  EdtNome.Visible := False;

  LblCartao.Visible := False;
  EdtCartao.Visible := False;

  LblTipoPessoa.Visible := False;
  EdtTipoPessoa.Visible := False;

  LblParcelasVencidas.Visible := False;
  EdtParcelasVencidas.Visible := False;

end;

procedure TFrmCatraca.FecharConexao;
begin

  lblStatus.Caption := 'Fechando Conexão';

  with InnerCadastrados[InnerAtual] do
  begin

    EstadoAtual := ESTADO_FECHAR_CONEXAO;

    Retorno := PingOnLine(Numero);

    try

      if ( Retorno = RET_OK ) then
      begin

        EstadoAtual := EstadoSolicitacaoPingOnline;

      end
      else
      begin

        if( CountTentativasEnvioComando >= 3 ) then
          EstadoAtual := ESTADO_RECONECTAR;

        Inc( CountTentativasEnvioComando );

      end;

      TempoInicialPingOnLine := Now;

    except

      EstadoAtual := ESTADO_CONECTAR;

    end;

  end;

end;

procedure TFrmCatraca.FormActivate(Sender: TObject);
begin

  SetStatusCatraca(1);

  Delay := 0;
  TmrDelay.Enabled := True;

end;

procedure TFrmCatraca.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  Action := caFree;
  Release;
  FrmCatraca := nil;

end;

procedure TFrmCatraca.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin

  Parar := True;
  MaquinaDeEstados();

  CanClose := True;

end;

procedure TFrmCatraca.FormCreate(Sender: TObject);
begin

  CorVermelha := TColor($2E31D3);
  CorRoxa := TColor(clPurple);
  CorVerde := TColor($5CB85C);
  CorAzul := TColor($CA8B42);

  PnStatusConexao.Color := CorVermelha;
  ArqIni := TIniFile.Create( gsAppPath + 'ini.ini' );

end;

procedure TFrmCatraca.GravaIni;
var
  ArqIni : TIniFile;
begin

  ArqIni := TIniFile.Create(gsAppPath + 'ini.ini');
  ShowMessage(gsAppPath);

  try

    ArqIni.WriteString('Dados', 'Texto', 'Teste');

  finally

    ArqIni.Free;

  end;


end;

procedure TFrmCatraca.Pooling;
var
//  Inner, Origem, Complemento, Dia, Mes, Ano, Hora, Minuto, Segundo : Byte;
//  Cartao : array[0..10] of Char;
  sBilheteRecebido : string;
  CartaoRecebido : string;
  strCartao : string;
  sNumCartao : string;
  tam : Byte;
  count : Byte;
  Tempo : TDateTime;
begin

  lblStatus.Caption := 'Estado de polling';
  SetStatusCatraca(2);
  Application.ProcessMessages;
//  PnStatusConexao.Visible := False;

//  Origem := 0;
//  Complemento := 0;
//  Dia := 0;
//  Mes := 0;
//  Hora := 0;
//  Minuto := 0;
//  Segundo := 0;

  with InnerCadastrados[InnerAtual] do
  begin

    try
    
      Retorno := ReceberDadosOnLine(Numero, @BilheteInner.Origem,
                                    @BilheteInner.Complemento, @BilheteInner.Cartao,
                                    @BilheteInner.Dia, @BilheteInner.Mes,
                                    @BilheteInner.Ano, @BilheteInner.Hora,
                                    @BilheteInner.Minuto, @BilheteInner.Segundo);

      if ( Retorno = RET_OK ) then
      begin

//        EstadoAtual := ESTADO_TRATA_CARTAO_TRATA_CONFIGS;
        ShowMessage( IntToStr( BilheteInner.Dia ) );
        ShowMessage( IntToStr( BilheteInner.Mes ) );
        ShowMessage( IntToStr( BilheteInner.Ano ) );

        ShowMessage( IntToStr( BilheteInner.Hora ) );
        ShowMessage( IntToStr( BilheteInner.Minuto ) );
        ShowMessage( IntToStr( BilheteInner.Segundo ) );

        for Count := 0 to Length( BilheteInner.Cartao ) do
        begin
          if( BilheteInner.Cartao[Count] = #0 )then
          begin
            Break;
          end;
          sBilheteRecebido := sBilheteRecebido + BilheteInner.Cartao[Count];
        end;

        if ( QtdDigitos > Length( sBilheteRecebido ) ) then
        begin

          tam := Length( sBilheteRecebido );

        end
        else
        begin

          tam := QtdDigitos;

        end;

        strCartao := '';

        for Count := 0 to tam - 1 do
        begin

          strCartao := strCartao + BilheteInner.Cartao[Count];

        end;

        sNumCartao := strCartao;

        ShowMessage('Estado de pooling OK');
        ShowMessage( sNumCartao );
        HabilitarLadoCatraca('Entrada');
        EstadoAtual := ESTADO_LIBERAR_CATRACA;

      end
      else
      begin

        Tempo := Now - TempoInicialPingOnLine;

        if ( StrToInt( FormatDateTime('ss', Tempo) ) >= 3 ) then
        begin    
        
          EstadoSolicitacaoPingOnLine := EstadoAtual;
          CountTentativasEnvioComando := 0;
          TempoInicialPingOnLine := Now;
          EstadoAtual := PING_ONLINE;
          
        end;
      
      end;
    
    except

      if not( BilheteInner = nil ) then
      begin

        BilheteInner.Destroy;

      end;

      EstadoAtual := ESTADO_CONECTAR;

    end;
  
  end;

end;

procedure TFrmCatraca.ConectaBanco;
begin

  with ScnBanco do
  begin

    try

      Close;
      ConnectionName := 'FBConnection';
      LibraryName := 'dbxfb.dll';
      GetDriverFunc := 'getSQLDriverINTERBASE';
      DriverName := 'Firebird';
      VendorLib := 'fbclient.dll';
      Params.Values['DriverName'] := 'Firebird';
      Params.Values['DataBase'] := 'C:\Users\Gui\Desktop\Catraca\ASSOCIADOS.FDB';
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

      ShowMessage('Conectado');

    except

      on Erro:Exception do
        raise Exception.Create('Erro ao conectar ao banco de dados: ' + Erro.Message);

    end;


  end;

end;

procedure TFrmCatraca.Conectar;
var
  Count : Integer;
begin

  Count := 0;

  LblStatus.Caption := 'Tentando conectar ao inner';
  PnStatusConexao.Color := CorVermelha;
  PnStatusConexao.Visible := True;
  SetStatusCatraca(1);
  Application.ProcessMessages;


  with InnerCadastrados[InnerAtual] do
  begin

    try

      repeat

        //Tenta efetuar uma conexão com o Inner, tenta retornar a data atual
//        ShowMessage('Passo de conexão OK');
        Retorno := TestaConexaoInner(1);
        Sleep(20);
        Inc(Count);

      until ( (Count > 30) or (retorno = RET_OK) );


      if retorno = RET_OK then
      begin

        //Caso o retorno seja positivo, entra no estado de envio de configuração

        lblStatus.Caption := 'Conectado';
//        Parar := True;
        EstadoAtual := ESTADO_ENVIAR_CFG_ONLINE;
        Application.ProcessMessages;


      end
      else
      begin

        // Caso o resultado seja negativo tenta enviar mais 3 vezes
        // Se mesmo assim continuar negativo, entra em estado de reconexão

        if ( CountTentativasEnvioComando >= 3 ) then
        begin

          EstadoAtual := ESTADO_RECONECTAR;

        end;

        inc(CountTentativasEnvioComando);

      end;
    except

      EstadoAtual := ESTADO_CONECTAR;

    end;

  end;

end;

function TFrmCatraca.ConfigurarEntradaMudancasOnline(NumInner: Integer) : Integer;
var
  Configuracao, Leitor : String;
begin

  with InnerCadastrados[NumInner] do
  begin
    if ( Teclado ) then
      Configuracao := '1'
    else
      Configuracao := '0';

    if not( Biometrico ) then
    begin

      if( DoisLeitores ) then
        Configuracao := '010' + '001' + Configuracao
      else
        Configuracao := '000' + '011' + Configuracao;

      Configuracao := '1' + Configuracao;
      
    end
    else
    begin
    
      if( DoisLeitores ) then
        Leitor := '11'
      else
        Leitor := '10';

      Configuracao := '0' + '1' + IntToStr(Identificacao) + IntToStr(Verificacao) + '0' + Leitor + Configuracao;
    
    end;

    ConfigurarEntradaMudancasOnline := StrToInt( BinarioParaDecimal( Configuracao ) );

  end;

end;

procedure TFrmCatraca.ConfigurarEntradasOnline;
var
  ValorDecimal : Integer;
begin

  lblStatus.Caption := 'Configurando entrada Online';
  
  with InnerCadastrados[InnerAtual] do
  begin

    try

      ValorDecimal := ConfigurarEntradaMudancasOnline(InnerAtual);

      Retorno := EnviarFormasEntradasOnLine(Numero, QtdDigitos, 1, ValorDecimal, 15, 1);

      if ( Retorno = RET_OK ) then
      begin

        TempoInicialPingOnLine := Now;
        CountTentativasEnvioComando := 0;
        EstadoAtual := ESTADO_POLLING;

      end
      else
      begin

        if ( CountTentativasEnvioComando >= 3 ) then
          EstadoAtual := ESTADO_RECONECTAR;

        inc(CountTentativasEnvioComando);
        
      end;
          
    except

      EstadoAtual := ESTADO_CONECTAR;
    
    end;
    
  end;

  
end;

procedure TFrmCatraca.EnviarConfigOffline;
begin
  with InnerCadastrados[InnerAtual] do
  begin

      try
        SetConfiguracaoInner(MODO_OFFLINE);

        Retorno := EnviarConfiguracoes(Numero);

        if( Retorno = RET_OK ) then
        begin

          EstadoAtual := ESTADO_ENVIAR_MENSAGEM;

        end
        else
        begin

          if (CountTentativasEnvioComando >= 3) then
          begin
            EstadoAtual := ESTADO_RECONECTAR;
          end;

          inc(CountTentativasEnvioComando);

        end;

      except

        EstadoAtual := ESTADO_CONECTAR;

      end;

  end;
end;

procedure TFrmCatraca.EnviarConfigOnline;
begin

  // Pega as configurações setadas e tenta enviar para o inner
  // Modo online

  lblStatus.Caption := 'Enviando Configurações online';

  with InnerCadastrados[InnerAtual] do
  begin

    try

      retorno := TestaConexaoInner(Numero);

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

      retorno := EnviarConfiguracoes(1);

      if retorno = RET_OK then
      begin

        lblStatus.Caption := 'Configurações enviadas';
        EstadoAtual := ESTADO_ENVIAR_DATA_HORA;
        CountTentativasEnvioComando := 0;

      end
      else
      begin

        if(CountTentativasEnvioComando >= 3) then
          EstadoAtual := ESTADO_RECONECTAR;

        inc(CountTentativasEnvioComando);

      end;
    Except
      EstadoAtual := ESTADO_CONECTAR;
    end;

  end;

end;

procedure TFrmCatraca.EnviarDataHora;
var
  Dia, Mes, Ano, Hora, Minuto, Segundo : Integer;
begin

  lblStatus.Caption := 'Enviando data e hora';

  with InnerCadastrados[InnerAtual] do
  begin

    try
    
      Dia := StrtoInt(formatDateTime('dd', Now));
      Mes := StrtoInt(formatDateTime('mm', Now));
      Ano := StrtoInt(formatDateTime('yy', Now));
      Hora := StrtoInt(formatDateTime('hh', Now));
      Minuto := StrtoInt(formatDateTime('nn', Now));
      Segundo := StrtoInt(formatDateTime('ss', Now));

      Retorno := EnviarRelogio(Numero, Dia, Mes, Ano, Hora, Minuto, Segundo);

      if( retorno = RET_OK ) then
      begin

//        ShowMessage('Enviado Novo Relógio OK');

        EstadoAtual := ESTADO_ENVIAR_MSG_PADRAO;
        CountTentativasEnvioComando := 0;

      end
      else
      begin

        if ( CountTentativasEnvioComando >= 3 ) then
        begin

          EstadoAtual := ESTADO_RECONECTAR;

        end;

        Inc(CountTentativasEnvioComando);

      end;
    
    Except

      EstadoAtual := ESTADO_CONECTAR;
    
    end;

  end;


end;

procedure TFrmCatraca.Reconectar;
begin

  lblStatus.Caption := 'Tentando conectar ao inner';
  PnStatusConexao.Color := CorVermelha;
  PnStatusConexao.Visible := True;

  Application.ProcessMessages;

  // Estado de reconexão, fica tentando conectar até que consiga uma resposta

  with InnerCadastrados[InnerAtual] do
  begin

    Retorno := TestaConexaoInner(Numero);

    if retorno = RET_OK then
    begin

      // Caso consiga uma conexão entra no estado de enviar configurações online

      lblStatus.Caption := 'Conectado';
//      Parar := True;
      Application.ProcessMessages;
      CountTentativasEnvioComando := 0;
      EstadoAtual := ESTADO_ENVIAR_CFG_ONLINE;

    end

  end;
end;

function TFrmCatraca.TestaConexaoInner(NumInner: Integer): Integer;
var
  Dia     : Byte;
  Mes     : Byte;
  Ano     : Byte;
  Hora    : Byte;
  Minuto  : Byte;
  Segundo : Byte;
begin
   Dia     := 0;
   Mes     := 0;
   Ano     := 0;
   Hora    := 0;
   Minuto  := 0;
   Segundo := 0;

  // Tenta conexão pedindo as configurações de data e hora do inner.

   TestaConexaoInner := ReceberRelogio(NumInner, @Dia, @Mes, @Ano, @Hora, @Minuto, @Segundo);

   Application.ProcessMessages;

end;

procedure TFrmCatraca.TmrDelayTimer(Sender: TObject);
begin

  inc( Delay );

  if ( Delay = 3 ) then
  begin

    SetConfiguracaoInicialInner();

    // Tenta abrir conexão com a porta padrão
    retorno := AbrirConexao();
  //  retorno := 0;

    // Caso Consiga, ele entra na maquina de estados
    if ( retorno = RET_OK )then
    begin

      parar := False;
      MaquinaDeEstados();

    end;


  end;

end;

procedure TFrmCatraca.TmrStatusCatracaTimer(Sender: TObject);
begin

  LblStatus.Left := LblStatus.Left - 20;

  if ( LblStatus.Left <= 0 - LblStatus.Width ) then
    LblStatus.Left := PnStatusCatraca.Width;

end;

procedure TFrmCatraca.TrataConfigsCartao;
begin

end;

end.
