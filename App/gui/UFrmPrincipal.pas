unit UFrmPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, UConstantes, UFuncoes, UFrmConfiguracoes,
  Vcl.Menus;

type
  TFrmPrincipal = class(TForm)
    Button1: TButton;
    lblStatus: TLabel;
    Button2: TButton;
    Button3: TButton;
    EdtCaminhoBanco: TEdit;
    Button4: TButton;
    MenuPrincipal: TMainMenu;
    MenuItemConfiguracoes: TMenuItem;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure MenuItemConfiguracoesClick(Sender: TObject);
  private
    { Private declarations }
    
    function TestaConexaoInner( NumInner : Integer) : Integer;
    function 	BinarioParaDecimal(valorBinario: String) : String;
    function AbrirConexao : Integer;
    function ConfigurarEntradaMudancasOnline( NumInner : Integer) : Integer;

    procedure SetConfiguracaoInicialInner();
    procedure MaquinaDeEstados();
    procedure SetConfiguracaoInner( Modo : Integer);
    procedure HabilitarLadoCatraca( lado: String );


  //  Procedimentos da maquina de estados
    procedure Conectar();
    procedure Reconectar();
    procedure EnviarConfigOffline();
    procedure EnviarConfigOnline();
    procedure EnviarDataHora();
    procedure EnviarMensagemPadrado();
    procedure ConfigurarEntradasOnline();
    procedure Pooling();
    procedure PingOnline();
    procedure TrataConfigsCartao();
    procedure LiberarCatraca();

  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

  InnerCadastrados : array of inner;
  TotalInners, InnerAtual : Integer;
  Retorno : Byte;
  Parar, LiberaEntrada, LiberaEntradaInvertida, LiberaSaida, LiberaSaidaInvertida : Boolean;

implementation

{$R *.dfm}

function TFrmPrincipal.BinarioParaDecimal(valorBinario: String): String;
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

procedure TFrmPrincipal.Button1Click(Sender: TObject);
var
  origem, complemento, dia, mes, ano, hora, minuto, segundo : Byte;
  cartao : array[0..10] of Char;
  count, countTentativasEnvioComando : Integer;
begin

  // Seta Configur��es Padr�es do Inner
  SetConfiguracaoInicialInner();

  // Tenta abrir conex�o com a porta padr�o
  retorno := AbrirConexao();

  // Caso Consiga, ele entra na maquina de estados
  if ( retorno = RET_OK )then
  begin

    parar := False;
    MaquinaDeEstados();

  end;


end;

function TFrmPrincipal.AbrirConexao: Integer;
var
  Porta : Integer;
  PadraoCartao : Integer;
begin

  Porta := StrToInt( FrmConfiguracoes.EdtPorta.Text );
  PadraoCartao := FrmConfiguracoes.CbxPadraoCartao.ItemIndex;

  DefinirTipoConexao(2);
  DefinirPadraoCartao(1);
  FecharPortaComunicacao();

  AbrirConexao := AbrirPortaComunicacao(3570);

end;

procedure TFrmPrincipal.SetConfiguracaoInner(Modo: Integer);
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

procedure TFrmPrincipal.Button2Click(Sender: TObject);
begin
  lblStatus.Caption := 'Parado';
  Parar := True;
end;

procedure TFrmPrincipal.EnviarMensagemPadrado;
begin

  lblStatus.Caption := 'Enviando Mensagem Padrao';

  with InnerCadastrados[InnerAtual] do
  begin

    try

      Retorno := EnviarMensagemPadraoOnLine(Numero, 1, 'Modo online');

      if ( Retorno = RET_OK ) then
      begin
      
        CountTentativasEnvioComando := 0;
        EstadoAtual := ESTADO_CONFIGURAR_ENTRADAS_ONLINE;
      
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

procedure TFrmPrincipal.HabilitarLadoCatraca(lado: String);
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

procedure TFrmPrincipal.LiberarCatraca;
begin

  lblStatus.Caption := 'Liberando Giro da catraca';

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

procedure TFrmPrincipal.SetConfiguracaoInicialInner;
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

procedure TFrmPrincipal.MaquinaDeEstados;
begin
  while ( not parar ) do
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

//        ESTADO_ENVIAR_MSG_PADRAO: ;
        ESTADO_CONFIGURAR_ENTRADAS_ONLINE: 
          ConfigurarEntradasOnline();
          
        ESTADO_POLLING: 
          Pooling();
        
        ESTADO_LIBERAR_CATRACA: 
          LiberarCatraca();
        
        
//        ESTADO_ENVIAR_BIPCURTO: ;
//        ESTADO_MONITORA_GIRO_CATRACA: ;
//        PING_ONLINE: ;

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

procedure TFrmPrincipal.MenuItemConfiguracoesClick(Sender: TObject);
begin
  FrmConfiguracoes.Show;
end;

procedure TFrmPrincipal.PingOnline;
begin

  lblStatus.Caption := 'Ping Online';

  with InnerCadastrados[InnerAtual] do
  begin
  
//    Retorno := PingOnLine(Numero);

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

procedure TFrmPrincipal.Pooling;
var
  Inner, Origem, Complemento, Dia, Mes, Ano, Hora, Minuto, Segundo : Byte; 
  Cartao : array[0..10] of Char;
  tempo : TDateTime;
begin

  lblStatus.Caption := 'Estado de polling';

  with InnerCadastrados[InnerAtual] do
  begin

    try
    
      Retorno := ReceberDadosOnLine(Numero, @Origem, @Complemento, @Cartao, @Dia, @Mes, @Ano, @Hora, @Minuto, @Segundo);

      if ( Retorno = RET_OK ) then
      begin
      
        EstadoAtual := ESTADO_TRATA_CARTAO_TRATA_CONFIGS;
      
      end
      else
      begin

        tempo := Now - TempoInicialPingOnLine;

        if ( StrToInt( FormatDateTime('ss', tempo) ) >= 3 ) then
        begin    
        
          EstadoSolicitacaoPingOnLine := EstadoAtual;
          CountTentativasEnvioComando := 0;
          TempoInicialPingOnLine := Now;
          EstadoAtual := PING_ONLINE;
          
        end;
      
      end;
    
    except

    end;
  
  end;

end;

procedure TFrmPrincipal.Conectar;
var
  Count : Integer;
begin

  Count := 0;

  lblStatus.Caption := 'Tentando conectar ao inner';

  with InnerCadastrados[InnerAtual] do
  begin

    try

      repeat

        //Tenta efetuar uma conex�o com o Inner, tenta retornar a data atual
        Retorno := TestaConexaoInner(Numero);
        Sleep(20);
        Inc(Count);

      until ( (Count > 30) or (retorno = RET_OK) );


      if retorno = RET_OK then
      begin

        //Caso o retorno seja positivo, entra no estado de envio de configura��o

        lblStatus.Caption := 'Conectado, enviando configura��es';
        EstadoAtual := ESTADO_ENVIAR_CFG_ONLINE;

      end
      else
      begin

        // Caso o resultado seja negativo tenta enviar mais 3 vezes
        // Se mesmo assim continuar negativo, entra em estado de reconex�o

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

function TFrmPrincipal.ConfigurarEntradaMudancasOnline(NumInner: Integer) : Integer;
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

    Result := StrToInt(BinarioParaDecimal(Configuracao));

  end;

end;

procedure TFrmPrincipal.ConfigurarEntradasOnline;
var
  ValorDecimal : Integer;
begin

  lblStatus.Caption := 'Configurando entrada Online';
  
  with InnerCadastrados[InnerAtual] do
  begin

    try

//      ValorDecimal := ConfigurarEntradaMudancasOnline(InnerAtual);

      Retorno := EnviarFormasEntradasOnLine(Numero, QtdDigitos, 1, ValorDecimal, 15, 17);

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

procedure TFrmPrincipal.EnviarConfigOffline;
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

procedure TFrmPrincipal.EnviarConfigOnline;
begin

  // Pega as configura��es setadas e tenta enviar para o inner
  // Modo online

  lblStatus.Caption := 'Enviando Configura��es online';

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

        lblStatus.Caption := 'Configura��es enviadas';
        EstadoAtual := ESTADO_ENVIAR_DATA_HORA;

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

procedure TFrmPrincipal.EnviarDataHora;
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

        ShowMessage('Data e hora atualizados!');
        EstadoAtual := ESTADO_ENVIAR_MSG_PADRAO;

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

procedure TFrmPrincipal.Reconectar;
begin
  lblStatus.Caption := 'Estado de reconexao';

  // Estado de reconex�o, fica tentando conectar at� que consiga uma resposta

  with InnerCadastrados[InnerAtual] do
  begin

    Retorno := TestaConexaoInner(Numero);

    if retorno = RET_OK then
    begin

      // Caso consiga uma conex�o entra no estado de enviar configura��es online

      lblStatus.Caption := 'Conectado';
      CountTentativasEnvioComando := 0;
      EstadoAtual := ESTADO_ENVIAR_CFG_ONLINE;

    end

  end;
end;

function TFrmPrincipal.TestaConexaoInner(NumInner: Integer): Integer;
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

  // Tenta conex�o pedindo as configura��es de data e hora do inner.

   TestaConexaoInner := ReceberRelogio(NumInner, @Dia, @Mes, @Ano, @Hora, @Minuto, @Segundo);

   Application.ProcessMessages;

end;

procedure TFrmPrincipal.TrataConfigsCartao;
begin

end;

end.
