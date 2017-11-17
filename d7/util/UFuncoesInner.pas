unit UFuncoesInner;

interface

//m�todos novos usados para vers�o do firmware Inner Acesso 5.x.x

  Function ReceberRespostaRequisicaoBio(Inner:Longint; TamResposta: Pointer): Byte; stdcall; external 'EasyInner.dll';

  Function SolicitarDigitalUsuario(Inner: Longint; Usuario:AnsiString): Byte;stdcall; external 'EasyInner.dll';

  Function SolicitarListaUsuariosComDigital(Inner:Longint): Byte;stdcall; external 'EasyInner.dll';

  Function ReceberDigitalUsuario(Tipo: Longint; Digital : Pointer; Tamanho : Integer): Byte;stdcall; external 'EasyInner.dll';

  Function ReceberUsuarioComDigital (Usuario:Pointer): Byte;stdcall; external 'EasyInner.dll';

  Function EnviarDigitalUsuario(Inner:Integer; Usuario:AnsiString; Digital1:Pointer; Digital2:Pointer): Byte;stdcall; external 'EasyInner.dll';

  Function SolicitarListaUsuariosBioVariavel( Inner:Integer):Byte; stdcall; external 'EasyInner.dll';
  {Solicita o pacote(a parte) atual da lista de usu�rios do Inner bio. Somente Inner Acesso vers�o superior 5.x.x
    Inner:
         1 a 32 � Para comunica��o serial.
         1 a 99 � Para comunica��o TCP/IP com porta vari�vel.
         1 a ... � Para comunica��o TCP/IP porta fixa.}

  Function ReceberQuantidadeBilhetes(Inner:Longint; Quantidade: Pointer): Byte; stdcall; external 'EasyInner.dll';

  Function DefinirNumeroCartaoMaster( Master:String):Byte; stdcall; external 'EasyInner.dll';

  Procedure SetarBioVariavel(maior: Integer); stdcall; external 'EasyInner.dll';
  {Define que o Inner utilizado no momento � um Inner com vers�o do firware superior ou igual 5.xx.
   Essa fun��o dever� ser chamada sempre que necess�rio antes das fun��es
    SolicitarExclusaoUsuario,
    maior:
      1 � � um Inner versao superio 5.x.x
      0 � � um Inner ersao inferior 5.x.x(valor default)}

  Function DefinirTipoConexao(Tipo:Byte):Byte; stdcall; external 'EasyInner.dll';
  {Define qual ser� o tipo de conex�o(meio de comunica��o) que ser� utilizada pela dll para
  comunicar com os Inners. Essa fun��o dever� ser chamada antes de iniciar o processo de comunica��o
  e antes da fun��o AbrirPortaComunicacao.
      0 - Comunica��o serial, RS-232/485.
      1 - Comunica��o TCP/IP com porta vari�vel.
      2 - Comunica��o TCP/IP com porta fixa (Default).
      3 - Comunica��o via modem.
      4 � Comunica��o via TopPendrive.}

  Function AcionarRele1( Inner:Integer):Byte; stdcall; external 'EasyInner.dll';
  //aciona rele 1 para coletor

  Function AcionarRele2( Inner:Integer):Byte; stdcall; external 'EasyInner.dll';
  //aciona rele 2 para coletor

  Function AbrirPortaComunicacao(Porta:Integer):Byte; stdcall; external 'EasyInner.dll';
  {Abre a porta de comunica��o desejada, essa fun��o dever� ser chamada antes de iniciar
  qualquer processo de transmiss�o ou recep��o de dados com o Inner.Esta fun��o deve ser chamada apenas uma vez e no in�cio da comunica��o, e n�o deve ser chamada
  para cada Inner.
      - N�mero da porta serial ou TCP/IP.
      - Para comunica��o TCP/IP o valor padr�o da porta � 3570 (Default).
      - Para comunica��o Serial/Modem o valor padr�o da porta � 1, COM 1(Default).
      - Para a comunica��o TopPendrive o valor � 3 (Default).}

  Procedure FecharPortaComunicacao(); stdcall; external 'EasyInner.dll';
  {Fecha a porta de comunica��o previamente aberta, seja ela serial, Modem ou TCP/IP.
  Em modo Off-Line normalmente � chamada ap�s enviar/receber todos os dados do Inner.
  Em modo On-Line � chamada somente no ecerramento do software do software. }

  Function DefinirPadraoCartao(Padrao:Byte):Byte; stdcall; external 'EasyInner.dll';
  {Define qual padr�o de cart�o ser� utilizado pelos Inners, padr�o Topdata ou padr�o livre. O
  padr�o Topdata de cart�o est� descrito no manual dos equipamentos e � utilizado somente com os
  Inners em modo Off-Line. No padr�o livre todos os d�gitos do cart�o s�o considerados como matr�cula,
  ele pode ser utilizado no modo On Line ou no modo Off Line.
  Ao chamar essa fun��o, a quantidade de d�gitos � setada para 14.
      0 - Padr�o Topdata.
      1 - Padr�o livre (Default). }

  Function AcionarBipCurto( Inner:Integer):Byte; stdcall; external 'EasyInner.dll';
  Function AcionarBipLongo( Inner:Integer):Byte; stdcall; external 'EasyInner.dll';
  //Faz com que o Inner emita um bip curto(aviso sonoro).

  Function Ping( Inner:Integer):Byte; stdcall; external 'EasyInner.dll';
  {Testa a comunica��o com o Inner, tamb�m utilizado para efetuar a conex�o com o Inner.
  Para efetuar a conex�o com o Inner, essa fun��o deve ser executada em um loop at� retornar 0(zero),
  executado com sucesso.}

  Function PingOnLine(Inner: Integer):Byte; stdcall; external 'EasyInner.dll';
  {Testa comunica��o com o Inner e mant�m o Inner em OnLine quando a mudan�a autom�tica
  est� configurada. Especialmente indicada para a verifica��o da conex�o em comunica��o TCP/IP.  }

  Function LigarBackLite( Inner:Integer):Byte; stdcall; external 'EasyInner.dll';
  //Liga a luz emitida pelo display do Inner. Essa fun��o n�o deve ser utilizada nas catracas.

  Function HabilitarTeclado( Habilita,  Ecoar:Byte):Byte; stdcall; external 'EasyInner.dll';
  {Permite que os dados sejam inseridos no Inner atrav�s do teclado do equipamento.
  Habilitando o par�metro ecoar, o teclado ir� ecoar asteriscos no display do Inner.
  Habilita
      0 - Desabilita o teclado (Default).
      1 - Habilita o teclado.
  Ecoar
      0 � Ecoa o que � digitado no display do Inner (Default).
      1 � Ecoa asteriscos no display do Inner. }

  Function DesligarBackLite( Inner:Integer):Byte; stdcall; external 'EasyInner.dll';
  //Desliga a luz emitida pelo display do Inner. Essa fun��o n�o deve ser utilizada nas catracas.

  Function ReceberVersaoFirmware(Inner:Integer; Linha:Pointer; Variacao:Pointer; VersaoAlta:Pointer; VersaoBaixa:Pointer; VersaoSufixo:Pointer; InnerAcessoBio:Pointer):Byte; stdcall; external 'EasyInner.dll';
  {Solicita a vers�o do firmware do Inner e dados como o Idioma, se � uma vers�o especial.
  Inner
  N�mero do Inner desejado.
  Linha
      01 � Inner Plus.
      02 � Inner Disk.
      03 � Inner Verid.
      06 � Inner Bio.
      07 � Inner NET.
  Variacao - Depende da vers�o, existe somente em vers�es customizadas.
  VersaoAlta - 00 a 99
  VersaoBaixa - 00 a 99
  VersaoSufixo - Indica o idioma do firmware:
      01 � Portugu�s.
      02 � Espanhol.
      03 � Ingl�s.
      04 � Franc�s.  }

  Function ConfigurarAcionamento1( Funcao,Tempo:Byte):Byte; stdcall; external 'EasyInner.dll';
  {Configura como ir� funcionar o acionamento(rele) 1 do Inner, e por quanto tempo ele ser� acionado.
  Funcao
      0 � N�o utilizado(Default).
      1 � Aciona ao registrar uma entrada ou sa�da.
      2 � Aciona ao registrar uma entrada.
      3 � Aciona ao registrar uma sa�da.
      4 � Est� conectado a uma sirene(Ver as fun��es de sirene).
      5 � Utilizado para a revista de usu�rios(Ver a fun��o DefinirPorcentagemRevista).
      6 � Catraca com a sa�da liberada.
      7 � Catraca com a entrada liberada
      8 � Catraca liberada nos dois sentidos.
      9 � Catraca liberada nos dois sentidos e a marca��o(registro) � gerada de acordo com o sentido do giro.
  Tempo - 0 a 50 segundos. 0(Default).   }

  Function ConfigurarAcionamento2( Funcao,Tempo:Byte):Byte; stdcall; external 'EasyInner.dll';
  {Configura como ir� funcionar o acionamento(rele) 2 do Inner, e por quanto tempo ele ser� acionado.
  Funcao
      0 � N�o utilizado(Default).
      1 � Aciona ao registrar uma entrada ou sa�da.
      2 � Aciona ao registrar uma entrada.
      3 � Aciona ao registrar uma sa�da.
      4 � Est� conectado a uma sirene(Ver as fun��es de sirene).
      5 � Utilizado para a revista de usu�rios(Ver a fun��o DefinirPorcentagemRevista).
      6 � Catraca com a sa�da liberada.
      7 � Catraca com a entrada liberada
      8 � Catraca liberada nos dois sentidos.
      9 � Catraca liberada nos dois sentidos e a marca��o(registro) � gerada de acordo com o sentido do giro.
  Tempo - 0 a 50 segundos. 0(Default). }

  Function ConfigurarTipoLeitor( Tipo:Byte):Byte; stdcall; external 'EasyInner.dll';
  {Configura o tipo do leitor que o Inner est� utilizando, se � um leitor de c�digo de barras,
  magn�tico ou proximidade.
  Tipo
      0 � Leitor de c�digo de barras(Default).
      1 � Leitor Magn�tico.
      2 � Leitor proximidade AbaTrack2.
      3 � Leitor proximidade Wiegand e Wiegand Facility Code.
      4 � Leitor proximidade Smart Card. }

  Function ConfigurarLeitor1( Operacao:Byte):Byte; stdcall; external 'EasyInner.dll';
  {Configura as opera��es que o leitor ir� executar. Se ir� registrar os dados somente como
  entrada independente do sentido em que o cart�o for passado, somente como sa�da ou como entrada e sa�da.
  Operacao
      0 � Leitor desativado(Default).
      1 � Somente para entrada.
      2 � Somente para sa�da.
      3 � Entrada e sa�da.
      4 � Entrada e sa�da invertidas.  }

  Function ConfigurarLeitor2( Operacao:Byte):Byte; stdcall; external 'EasyInner.dll';
  {Configura as opera��es que o leitor ir� executar. Se ir� registrar os dados somente como
  entrada independente do sentido em que o cart�o for passado, somente como sa�da ou como entrada e sa�da.
  Operacao
      0 � Leitor desativado(Default).
      1 � Somente para entrada.
      2 � Somente para sa�da.
      3 � Entrada e sa�da.
      4 � Entrada e sa�da invertidas.}

  Function DefinirQuantidadeDigitosCartao( Quantidade:Byte):Byte; stdcall; external 'EasyInner.dll';
  {Define a quantidade de d�gitos dos cart�es a serem lidos pelo Inner.
  Quantidade - 1 a 16 d�gitos. 14(Default).  }

  Function InserirQuantidadeDigitoVariavel( Digito:Byte):Byte; stdcall; external 'EasyInner.dll';
  //Para usar cartoes de diferentes digitos

  Function RegistrarAcessoNegado( TipoRegistro:Byte):Byte; stdcall; external 'EasyInner.dll';
  {Configura o Inner para registrar as tentativa de acesso negado. O Inner ir� rgistrar apenas os
  acessos negados em rela��o a lista de acesso configurada para o modo Off-Line, ver as fun��es
  DefinirTipoListaAcesso e ColetarBilhete.
  TipoRegistro
      0 � N�o registrar o acesso negado.
      1 � Apenas o acesso negado.
      2 � Falha na valida��o da digital.
      3 � Acesso negado e falha na valida��o da digital. }

  Function DefinirFuncaoDefaultLeitoresProximidade( Funcao:Byte):Byte; stdcall; external 'EasyInner.dll';
  {Define qual ser� o tipo do registro realizado pelo Inner ao aproximar um cart�o do tipo
  proximidade no leitor do Inner, sem que o usu�rio tenha pressionado a tecla entrada, sa�da ou fun��o.
  Funcao
      0 � Desablitado(Default).
      1 a 9 � Registrar como uma fun��o do teclado do Inner.
      10 � Registrar sempre como entrada.
      11 � Registrar sempre como sa�da.
      12 � Libera a catraca nos dois sentidos e registra o bilhete conforme o sentido giro.    }

  Function ConfigurarWiegandDoisLeitores( Habilita,ExibirMensagem:Byte):Byte; stdcall; external 'EasyInner.dll';
  {Habilita os leitores wiegand para o primeiro leitor e o segundo leitor do Inner, e configura se o
  segundo leitor ir� exibir as mensagens configuradas.
  Habilita
      0 � N�o habilita o segundo leitor como wiegand(Default).
      1 � Habilita o segundo leitor como wiegand.
  ExibirMensagem
      0 � N�o exibe mensagem segundo leitor(Default).
      1 � Exibe mensagem segundo leitor. }

  Function DefinirFuncaoDefaultSensorBiometria( Funcao:Byte):Byte; stdcall; external 'EasyInner.dll';
  {Configura o tipo de registro que ser� associado a uma marca��o, quando for inserido o dedo
  no Inner bio sem que o usu�rio tenha definido se � um entrada, sa�da, fun��o, etc.
  Funcao
      0 � desabilitada(Default).
      1 a 9 � fun��es de 1 a 9.
      10 � entrada.
      11 � sa�da.
      12 � libera catraca para os dois lados e registra bilhete conforme o giro.}

  Function EnviarConfiguracoes( Inner:Integer):Byte; stdcall; external 'EasyInner.dll';
  {Envia o buffer interno da dll que cont�m todas as configura��es das fun��es anteriores para
  o Inner, ap�s o envio esse buffer � limpo sendo necess�rio chamar novamentes as fun��es acima para
  reconfigur�-lo.
  Inner
      1 a 32 � Para comunica��o serial.
      1 a 99 � Para comunica��o TCP/IP com porta vari�vel.
      1 a ... � Para comunica��o TCP/IP porta fixa.  }

  Function EnviarRelogio( Inner:Integer;
                        Dia,Mes,Ano,
                        Hora,Minuto,Segundo:Byte):Byte; stdcall; external 'EasyInner.dll';
  {Configura o rel�gio(data/hora) do Inner.
  Inner
      1 a 32 � Para comunica��o serial.
      1 a 99 � Para comunica��o TCP/IP com porta vari�vel.
      1 a ... � Para comunica��o TCP/IP porta fixa.
  Dia - 1 a 31
  Mes - 1 a 12.
  Ano - 0 a 99
  Hora - 0 a 23
  Minuto - 0 a 59
  Segundo - 0 a 59   }

  Function InserirHorarioSirene( Hora,  Minuto,
   Segunda,  Terca,  Quarta,  Quinta,
   Sexta,  Sabado,  DomingoFeriado:Byte):Byte; stdcall; external 'EasyInner.dll';
  {Insere um hor�rio de toque de sirene e configura em quais dias da semana esses hor�rio
  ir�o tocar. � poss�vel inserir no m�ximo 100 hor�rios para a sirene.
  Hora - 0 a 23
  Minuto - 0 a 59
  Segunda
      0 � Desabilita o toque nesse dia.
      1 � Habilita o toque nesse dia.
  Terca
      0 � Desabilita o toque nesse dia.
      1 � Habilita o toque nesse dia.
  Quarta
      0 � Desabilita o toque nesse dia.
      1 � Habilita o toque nesse dia.
  Quinta
      0 � Desabilita o toque nesse dia.
      1 � Habilita o toque nesse dia.
  Sexta
      0 � Desabilita o toque nesse dia.
      1 � Habilita o toque nesse dia.
  Sabado
      0 � Desabilita o toque nesse dia.
      1 � Habilita o toque nesse dia.
  DomingoFeriado
      0 � Desabilita o toque nesse dia.
      1 � Habilita o toque nesse dia.  }

  Function EnviarHorariosSirene( Inner:Integer):Byte; stdcall; external 'EasyInner.dll';
  {Envia o buffer com os hor�rio de sirene cadastrados para o Inner. Ap�s executar a fun��o o
  buffer � limpo automaticamente pela dll.
  Inner
      1 a 32 � Para comunica��o serial.
      1 a 99 � Para comunica��o TCP/IP com porta vari�vel.
      1 a ... � Para comunica��o TCP/IP porta fixa. }

  Function LiberarCatracaSaida( Inner:Integer):Byte; stdcall; external 'EasyInner.dll';
  {Libera a catraca no sentido de sa�da padr�o do Inner, para o usu�rio poder efetuar o giro na
  catraca. Em modo On-Line, na fun��o ReceberDadosOnLine o valor retornado no par�metro
  �Complemento� ser� do tipo sa�da.
  Essa fun��o deve ser utilizada somente com Inners Catraca. }

  Function LiberarCatracaSaidaInvertida( Inner:Integer):Byte; stdcall; external 'EasyInner.dll';
  {Libera a catraca no sentido contr�rio a sa�da padr�o do Inner, para o usu�rio poder efetuar o
  giro na catraca. Em modo On-Line, na fun��o ReceberDadosOnLine o valor retornado no par�metro
  �Complemento� ser� do tipo entrada.
  Essa fun��o deve ser utilizada somente com Inners Catraca. }

  Function LiberarCatracaEntrada( Inner:Integer):Byte; stdcall; external 'EasyInner.dll';
  {Libera a catraca no sentido de entrada padr�o do Inner, para o usu�rio poder efetuar o giro
  na catraca. Em modo On-Line, na fun��o ReceberDadosOnLine o valor retornado no par�metro
  �Complemento� ser� do tipo entrada.  }

  Function LiberarCatracaEntradaInvertida( Inner:Integer):Byte; stdcall; external 'EasyInner.dll';
  {Libera a catraca no sentido contr�rio a entrada padr�o do Inner, para o usu�rio poder efetuar
  o giro na catraca. Em modo On-Line, na fun��o ReceberDadosOnLine o valor retornado no par�metro
  �Complemento� ser� do tipo sa�da.
   Essa fun��o deve ser utilizada somente com Inners Catraca. }

  Function LiberarCatracaDoisSentidos( Inner:Integer):Byte; stdcall; external 'EasyInner.dll';
  {Libera a catraca para o usu�rio pode efetuar o giro na catraca em ambos os sentidos. Em
  modo On-Line, na fun��o ReceberDadosOnLine o valor retornado no par�metro �Complemento� ser�
  do tipo entrada ou sa�da, dependendo do sentido em que o usu�rio passar pela catraca.
  Essa fun��o deve ser utilizada somente com Inners Catraca.  }

  Function ConfigurarInnerOffLine():Byte; stdcall; external 'EasyInner.dll';
  {Prepara o Inner para trabalhar no modo Off-Line, por�m essa fun��o ainda n�o envia essa
  informa��o para o equipamento. }

  Function DefinirMensagemEntradaOffLine( ExibirData:Byte;  Mensagem:String):Byte; stdcall; external 'EasyInner.dll';
  {Configura a mensagem a ser exibida quando o usu�rio passar o cart�o no sentido de entrada
  do Inner. Caso a mensagem passe de 32 caracteres a DLL ir� utilizar os primeiros 32 caracteres.
  O Inner n�o aceita caracteres com acentua��o, padr�o UNICODE ou padr�o ANSI.
  O Inner aceita apenas os caracteres do padr�o ASCII.
  ExibirData
      0 � N�o exibe a data/hora na linha superior do display.
      1 � Exibe a data/hora na linha superior do display(Default).
  Mensagem
  String com a mensagem a ser exibida. Caso esteja exibindo a data/hora o tamanho da mensagem passa a ser
  16 ao inv�s de 32. Caso seja passado uma string vazia o Inner exibir� a mensagem em branco no display.
  Entrada OK(Default). }

  Function DefinirMensagemSaidaOffLine( ExibirData:Byte;  Mensagem:String):Byte; stdcall; external 'EasyInner.dll';
  {Configura a mensagem a ser exibida quando o usu�rio passar o cart�o no sentido de sa�da
  do Inner. Caso a mensagem passe de 32 caracteres a DLL ir� utilizar os primeiros 32 caracteres.
  O Inner n�o aceita caracteres com acentua��o, padr�o UNICODE ou padr�o ANSI.
  O Inner aceita apenas os caracteres do padr�o ASCII.
  ExibirData
      0 � N�o exibe a data/hora na linha superior do display.
      1 � Exibe a data/hora na linha superior do display(Default).
  Mensagem
  String com a mensagem a ser exibida. Caso esteja exibindo a data/hora o tamanho da mensagem passa a ser
  16 ao inv�s de 32. Caso seja passado uma string vazia o Inner exibir� a mensagem em branco no display.
  Entrada OK(Default). }

  Function DefinirMensagemPadraoOffLine( ExibirData:Byte;  Mensagem:String):Byte; stdcall; external 'EasyInner.dll';
  {Configura a mensagem a ser exibida pelo Inner quando ele estiver ocioso.
  Caso a mensagem passe de 32 caracteres a DLL ir� utilizar os primeiros 32 caracteres.
  O Inner n�o aceita caracteres com acentua��o, padr�o UNICODE ou padr�o ANSI.
  O Inner aceita apenas os caracteres do padr�o ASCII.
  ExibirData
  0 � N�o exibe a data/hora na linha superior do display.
  1 � Exibe a data/hora na linha superior do display(Default).
  Mensagem
  String com a mensagem a ser exibida. Caso esteja exibindo a data/hora o tamanho da mensagem passa a ser
  16 ao inv�s de 32. Caso seja passado uma string vazia o Inner exibir� a mensagem em branco no display.
  Passe o cart�o(Default).  }

  Function EnviarMensagensOffLine( Inner:Integer):Byte; stdcall; external 'EasyInner.dll';
  {Envia o buffer com todas as mensagens off line configuradas anteriormente, para o Inner.
  Ap�s executar a fun��o, o buffer com as mensagens � limpo automaticamente pela dll.
  Inner
      1 a 32 � Para comunica��o serial.
      1 a 99 � Para comunica��o TCP/IP com porta vari�vel.
      1 a ... � Para comunica��o TCP/IP porta fixa. }

  Function HabilitarMudancaOnLineOffLine( Habilita, Tempo:Byte):Byte; stdcall; external 'EasyInner.dll';
  {Habilita/Desabilita a mudan��o autom�tica do modo OffLine do Inner para OnLine e viceversa.
  Configura o tempo ap�s a comunica��o ser interrompida que est� mudan�a ir� ocorrer.
  Habilita
      0 � Desabilita a mudan�a(Default).
      1 � Habilita a mudan�a.
      2 � Habilita a mudan�a autom�tica para o modo OnLine TCP com Ping,
  Onde o Inner precisa receber o comando PingOnLine para manter-se OnLine.
  Tempo - Tempo em segundos para ocorrer a mudan�a.
  1 a 50.    }

  Function DefinirEntradasMudancaOffLine( Teclado, Leitor1, Leitor2, Catraca:Byte):Byte; stdcall; external 'EasyInner.dll';
  {Configura as formas de entradas de dados para quando o Inner mudar para o modo Off-Line.
  Para aplica��es com biometria verifique a pr�xima fun��o �DefinirEntradasMudan�aOffLineComBiometria�.
  Teclado
      0 � N�o aceita dados pelo teclado.
      1 � Aceita dados pelo teclado.
  Leitor1
      0 � desativado
      1 � somente para entrada
      2 � somente para sa�da
      3 � entrada e sa�da
      4 � sa�da e entrada
  Leitor2
      0 � desativado
      1 � somente para entrada
      2 � somente para sa�da
      3 � entrada e sa�da
      4 � sa�da e entrada
  Catraca - 0 � reservado para uso futuro.  }

  Function DefinirEntradasMudancaOffLineComBiometria( Teclado,Leitor1,Leitor2,Verificacao,identificacao:Byte):Byte; stdcall; external 'EasyInner.dll';
  {Configura as formas de entradas de dados para quando o Inner mudar para o modo Off-Line.
  Esse comando difere do anterior por permitir a configura��o de biometria. Atrav�s dessa fun��o o Inner
  pode ser configurado para trabalhar com verifica��o ou identifica��o biom�trica, quando ocorrer uma
  mudan�a autom�tica de On-Line para Off-Line.
  Teclado - 0 � N�o aceita dados pelo teclado.
      1 � Aceita dados pelo teclado.
  Leitor1
      0 � desativado
      3 � entrada e sa�da
      4 � sa�da e entrada (nesse caso for�a Leitor2 igual a zero)
  Leitor2
      0 � desativado
      3 � entrada e sa�da
  Verificacao
      0 � desativada
      1 � ativada
  Identificacao
      0 � desativada
      1 � ativada    }

  Function DefinirMensagemPadraoMudancaOnLine( ExibirData:Byte;  Mensagem:String):Byte; stdcall; external 'EasyInner.dll';
  Function DefinirMensagemPadraoMudancaOffLine( ExibirData:Byte;  Mensagem:String):Byte; stdcall; external 'EasyInner.dll';
  {Configura a mensagem padr�o a ser exibida pelo Inner quando ele mudar para Off-line.
  ExibirData
      0 � N�o exibe a data/hora na linha superior do display.
      1 � Exibe a data/hora na linha superior do display.
  Mensagem
  String com a mensagem a ser exibida. Caso esteja exibindo a data/hora o
  tamanho da mensagem passa a ser 16 ao inv�s de 32. Caso seja passado
  uma string vazia o Inner n�o exibir� a mensagem no display  }

  Function EnviarConfiguracoesMudancaAutomaticaOnLineOffLine( Inner:Integer):Byte; stdcall; external 'EasyInner.dll';
  {Envia o buffer com as configura��es de mudan�a autom�tica do modo OnLine para OffLine .
  Inner
      1 a 32 � Para comunica��o serial.
      1 a 99 � Para comunica��o TCP/IP com porta vari�vel.
      1 a ... � Para comunica��o TCP/IP porta fixa.       }

  Function LigarLedVermelho (Inner :Integer) :Byte; stdcall; external 'EasyInner.dll';
  //Liga led vermelho. Somente para Inner Acesso.

  Function DesligarLedVermelho (Inner :Integer) :Byte; stdcall; external 'EasyInner.dll';
  //Desliga led vermelho. Somente para Inner Acesso.

  Function ColetarBilhete( Inner:Integer; Tipo, Dia, Mes, Ano, Hora, Minuto: Pointer; Cartao:PChar):Byte; stdcall; external 'EasyInner.dll';
  {Coleta um bilhete Off-Line que est� armazenado na mem�ria do Inner, os dados do bilhete
  s�o retornados por refer�ncia nos par�metros da fun��o. Ates de chamar esta fun��o pela primeira vez �
  preciso chamar obrigatoriamente as fun��es DefinirPadraoCartao e DefinirQuantidadeDigitosCartao
  nessa ordem para que o n�mero do cart�o seja calculado de forma correta.
  Inner
      1 a 32 � Para comunica��o serial.
      1 a 99 � Para comunica��o TCP/IP com porta vari�vel.
      1 a ... � Para comunica��o TCP/IP porta fixa.
  Tipo - Tipo da marca��o registrada.
      0 a 9 � Fun��es registradas pelo cart�o.
      10 � Entrada pelo cart�o.
      11 � Sa�da pelo cart�o.
      12 � Tentativa de entrada negada pelo cart�o.
      13 � Tentativa de sa�da negada pelo cart�o.
      100 a 109 � Fun��es registradas pelo teclado.
      110 � Entrada pelo teclado.
      111 � Sa�da pelo teclado.
      112 � Tentativa de entrada negada pelo teclado.
      113 � Tentativa de sa�da negada pelo teclado.
  Dia - 1 a 31
  Mes - 1 a 12
  Ano - 0 a 99
  Hora - 0 a 23
  Minuto - 0 a 59
  Cartao - N�mero do cart�o do usu�rio. }

  Function ConfigurarInnerOnLine():Byte; stdcall; external 'EasyInner.dll';
  {Prepara o Inner para trabalhar no modo On-Line, por�m essa fun��o ainda n�o envia essa
  informa��o para o equipamento.  }

  Function ReceberDataHoraDadosOnLine( Recebe:Byte):Byte; stdcall; external 'EasyInner.dll';
  {Configura o Inner para enviar as informa��es de data/hora nos bilhete on line, esses dados
  ser�o retornados nos par�metros da fun��o ReceberDadosOnLine.
  Recebe
      0 � N�o receber a data/hora do bilhete(Default).
      1 � Recebe a data/hora do bilhete.  }

  Function EnviarMensagemPadraoOnLine( Inner:Integer; ExibirData:Byte;  Mensagem:String):Byte; stdcall; external 'EasyInner.dll';
  {Envia para o Inner a mensagem padr�o(fixa) que ser� sempre exibida pelo Inner. Essa
  mensagem � exibida enquanto o Inner estiver ocioso. Caso a mensagem passe de 32 caracteres a DLL
  ir� utilizar os primeiros 32 caracteres.
  O Inner n�o aceita caracteres com acentua��o, padr�o UNICODE ou padr�o ANSI.
  O Inner aceita apenas os caracteres do padr�o ASCII.
  Inner
      1 a 32 � Para comunica��o serial.
      1 a 99 � Para comunica��o TCP/IP com porta vari�vel.
      1 a ... � Para comunica��o TCP/IP porta fixa.
  ExibirData
      0 � N�o exibe a data/hora na linha superior do display.
      1 � Exibe a data/hora na linha superior do display.
  Mensagem - String com a mensagem a ser exibida. Caso esteja
  exibindo a data/hora o tamanho da mensagem passa a ser
  16 ao inv�s de 32. Caso seja passado uma string vazia o
  Inner exibir� a mensagem em branco no display.      }

  Function EnviarFormasEntradasOnLine( Inner:Integer;QtdeDigitosTeclado,EcoTeclado,FormaEntrada,TempoTeclado,PosicaoCursorTeclado:Byte):Byte; stdcall; external 'EasyInner.dll';
  {Configura as formas de entrada de dados do Inner no modo OnLine. Cada vez que alguma
  informa��o for recebida no modo OnLine atrav�s da fun��o ReceberDadosOnLine, a fun��o
  EnviarFormasEntradasOnLine dever� ser chamada novamente para reconfigurar o Inner.
  Inner
      1 a 32 � Para comunica��o serial.
      1 a 99 � Para comunica��o TCP/IP com porta vari�vel.
      1 a ... � Para comunica��o TCP/IP porta fixa.
  QtdeDigitosTeclado - 0 a 20 d�gitos.
  EcoTeclado
      0 � para n�o
      1 � para sim
      2 � ecoar *
  FormaEntrada
      0 � n�o aceita entrada de dados
      1 � aceita teclado
      2 � aceita leitura no leitor 1
      3 � aceita leitura no leitor 2
      4 � teclado e leitor 1
      5 � teclado e leitor 2
      6 � leitor 1 e leitor 2
      7 � teclado, leitor 1 e leitor 2
      10 � teclado + verifica��o biom�trica
      11 � leitor1 + verifica��o biom�trica
      12 � teclado + leitor1 + verifica��o biom�trica
      13 � leitor1 com verifica��o biom�trica + leitor2 sem verifica��o biom�trica
      14 � leitor1 com verifica��o biom�trica + leitor2 sem verifica��o biom�trica + teclado sem verifica��o biom�trica
      100 � Leitor 1 + Identifica��o Biom�trica (sem Verifica��o)
      101 � Leitor 1 + Teclado + Identifica��o Biom�trica (sem Verifica��o)
      102 � Leitor 1 + Leitor 2 + Identifica��o Biom�trica (sem Verifica��o)
      103 � Leitor 1 + Leitor 2 + Teclado + Identifica��o Biom�trica (sem Verifica��o)
      104 � Leitor 1 invertido + Identifica��o Biom�trica (sem Verifica��o)
      105 � Leitor 1 invertido + Teclado + Identifica��o Biom�trica (sem Verifica��o)
  TempoTeclado - 1 a 50
  PosicaoCursorTeclado - 1 a 32   }

  Function ReceberDadosOnLine( Inner:Integer; Origem, Complemento: Pointer; Cartao: PChar; Dia, Mes, Ano, Hora, Minuto, Segundo:Pointer):Byte; stdcall; external 'EasyInner.dll';
  {Coleta um bilhete OnLine, caso o usu�rio tenha passado ou digitado algum cart�o no Inner
  retorna as informa��es do cart�o nos par�metros da fun��o. Para que a data/hora do bilhete OnLine seja
  retornada, o Inner dever� ter sido previamente configurado atrav�s da fun��o
  ReceberDataHoraDadosOnLine.
  Inner
      1 a 32 � Para comunica��o serial.
      1 a 99 � Para comunica��o TCP/IP com porta vari�vel.
      1 a ... � Para comunica��o TCP/IP porta fixa.
  Origem - Origem dos dados recebidos.
      1 � via teclado
      2 � via leitor 1
      3 � via leitor 2
      4 � sensor da catraca(obsoleto)
      5 � fim do tempo de acionamento
      6 � giro da catraca Topdata (sensor �tico)
      7 � Urna (catraca Millenium)
      8 � Evento no Sensor 1
      9 � Evento no Sensor 2
      10 � Evento no Sensor 3
  Complemento - Informa��es adicionais sobre os dados recebidos.
      0 � sa�da (com cart�o)
      1 � entrada (com cart�o)
      35 � # via teclado (1� tecla)
      42 � * via teclado (1� tecla)
      65 � �Fun��o� via teclado
      66 � �Entrada� via teclado
      67 � �Sa�da� via teclado
      255 � Inseriu todos os d�gitos permitidos pelo teclado.
  Evento do Sensor
      0/1 � N�vel atual do sensor
  Cartao">N�mero do cart�o recebido.
  Dia - 1 a 31.
  Mes - 1 a 12.
  Ano - 0 a 99
  Hora - 0 a 23
  Minuto - 0 a 59
  Segundo - 0 a 59    }

  Function DefinirEntradasMudancaOnLine( Entrada:Byte):Byte; stdcall; external 'EasyInner.dll';
  {Configura as formas de entrada dos dados quando o Inner voltar para o modo On Line ap�s
  uma queda para OffLine.
  Entrada
      0 � N�o aceita entrada de dados.
      1 � Aceita teclado.
      2 � Aceita leitor 1.
      3 � Aceita leitor 2.
      4 � Teclado e leitor 1.
      5 � Teclado e leitor 2.
      6 � Leitor 1 e leitor 2.
      7 � Teclado, leitor 1 e 2.
      8 � Sensor da catraca.   }

  Function DefinirConfiguracaoTecladoOnLine( Digitos, EcoDisplay, Tempo, PosicaoCursor:Byte):Byte; stdcall; external 'EasyInner.dll';
  {Configura o teclado para quando o Inner voltar para OnLine ap�s uma queda para OffLine.
  Digitos
      0 a 20 d�gitos.
  EcoDisplay
      0 � para n�o ecoar
      1 � para sim
      2 � ecoar '*'
  Tempo - 1 a 50.
  PosicaoCursor - 1 a 32.  }

  Function SolicitarModeloBio( Inner:Integer):Byte; stdcall; external 'EasyInner.dll';
  {Solicita o modelo do Inner bio. Para receber o resultado dessa opera��o voc� dever� chamar
  a fun��o ReceberModeloBio enquanto o retorno for processando a opera��o.
  Inner
      1 a 32 � Para comunica��o serial.
      1 a 99 � Para comunica��o TCP/IP com porta vari�vel.
      1 a ... � Para comunica��o TCP/IP porta fixa.  }

  Function ReceberModeloBio( Inner:Integer; OnLine:Byte; Modelo:Pointer):Byte; stdcall; external 'EasyInner.dll';
  {Retorna o resultado do comando SolicitarModeloBio, o modelo do Inner Bio � retornado por
  refer�ncia no par�metro da fun��o.
  Inner
      1 a 32 � Para comunica��o serial.
      1 a 99 � Para comunica��o TCP/IP com porta vari�vel.
      1 a ... � Para comunica��o TCP/IP porta fixa.
  OnLine
      0 � O comando foi utilizado com o Inner em OffLine.
      1 � O comando foi utilizado com o Inner em OnLine
  Modelo
      2 � Bio Light 100 usu�rios.
      4 � Bio 1000/4000 usu�rios.
      255 � Vers�o desconhecida.    }

  Function ReceberVersaoBio( Inner:Integer; OnLine:Byte; VersaoAlta, VersaoBaixa:Pointer):Byte; stdcall; external 'EasyInner.dll';
  {Retorna o resultado do comando SolicitarVersaoBio, a vers�o do Inner Bio � retornado por
  refer�ncia nos par�metros da fun��o.
  Inner
      1 a 32 � Para comunica��o serial.
      1 a 99 � Para comunica��o TCP/IP com porta vari�vel.
      1 a ... � Para comunica��o TCP/IP porta fixa.
  OnLine
      0 � O comando foi utilizado com o Inner em OffLine.
      1 � O comando foi utilizado com o Inner em OnLine
  VersaoAlta - Parte alta da vers�o.
  VersaoBaixa - Parte baixa da vers�o.  }

  Function InserirUsuarioListaAcesso( Cartao:String;  Horario:Byte):Byte; stdcall; external 'EasyInner.dll';
  {Insere no buffer da dll um usu�rio da lista e a qual hor�rio de acesso ele est� associado. Os
  hor�rios j� dever�o ter sido cadastrados atrav�s das fun��es InserirHorarioAcesso e enviados atrav�s
  da fun��o EnviarHorariosAcesso para a lista ter o efeito correto.
  Cartao - 1 a ... � Dependo do padr�o de cart�o definido e da quantidade de d�gitos definida.
  Horario - 1 a 100 � N�mero do hor�rio j� cadastrado no Inner.
  101 � Acesso sempre liberado para o usu�rio.
  102 � Acesso sempre negado para o usu�rio.    }

  Function InserirHorarioAcesso( Horario,DiaSemana,FaixaDia,Hora,Minuto:Byte):Byte; stdcall; external 'EasyInner.dll';
  {Insere no buffer da dll um hor�rio de acesso. O Inner possui uma tabela de 100 hor�rios de
  acesso, para cada hor�rio � poss�vel definir 4 faixas de acesso para cada dia da semana.
  Horario - 1 a 100 � N�mero da tabela de hor�rios.
  DiaSemana - 1 a 7 � Dia da semana a qual pertence a faixa de hor�rio.
  FaixaDia - 1 a 4 � Para cada dia da semana existem 4 faixas de hor�rio.
  Hora - 0 a 23
  Minuto - 0 a 59     }

  Function ApagarListaAcesso( Inner:Integer):Byte; stdcall; external 'EasyInner.dll';
  {Limpar o buffer com a lista de usu�rios cadastrados e envia automaticamente para o Inner.
  Inner
      1 a 32 � Para comunica��o serial.
      1 a 99 � Para comunica��o TCP/IP com porta vari�vel.
      1 a ... � Para comunica��o TCP/IP porta fixa. }

  Function EnviarListaAcesso( Inner:Integer):Byte; stdcall; external 'EasyInner.dll';
  {Envia o buffer com os usu�rios da lista de acesso para o Inner, ap�s executar o comando o
  buffer � limpo pela dll automaticamente.
  Inner
      1 a 32 � Para comunica��o serial.
      1 a 99 � Para comunica��o TCP/IP com porta vari�vel.
      1 a ... � Para comunica��o TCP/IP porta fixa.  }

  Function ApagarHorariosAcesso( Inner:Integer):Byte; stdcall; external 'EasyInner.dll';
  {Apaga o buffer com a lista de hor�rios de acesso e envia automaticamente para o Inner.
  Inner
      1 a 32 � Para comunica��o serial.
      1 a 99 � Para comunica��o TCP/IP com porta vari�vel.
      1 a ... � Para comunica��o TCP/IP porta fixa.  }

  Function EnviarHorariosAcesso( Inner:Integer):Byte; stdcall; external 'EasyInner.dll';
  {Envia para o Inner o buffer com a lista de hor�rios de acesso, ap�s executar o comando o
  buffer � limpo pela dll automaticamente.
  Inner
      1 a 32 � Para comunica��o serial.
      1 a 99 � Para comunica��o TCP/IP com porta vari�vel.
      1 a ... � Para comunica��o TCP/IP porta fixa. }

  Function DefinirTipoListaAcesso( Tipo:Byte):Byte; stdcall; external 'EasyInner.dll';
  {Define qual tipo de lista(controle) de acesso o Inner vai utilizar. Ap�s habilitar a lista de
  acesso � necess�rio preencher a lista e os hor�rios de acesso, verificar os as fun��es de �Hor�rios de
  Acesso� e as fun��es da �Lista de Acesso�.
  Tipo
      0 � N�o utilizar a lista de acesso.
      1 � Utilizar lista branca(cart�es fora da lista tem o acesso negado).
      2 � Utilizar lista negra(bloqueia apenas os cart�es da lista). }

  Function EnviarListaUsuariosSemDigitalBio( Inner:Integer):Byte; stdcall; external 'EasyInner.dll';
  Function EnviarListaUsuariosSemDigitalBioVariavel(Inner:Integer; QtdDigitos: Integer):Byte; stdcall; external 'EasyInner.dll';

  {Envia o buffer com a lista de usu�rios sem digital para o Inner. Ap�s a execu��o do
  comando, o buffer � limpo pela dll.
  Inner
      1 a 32 � Para comunica��o serial.
      1 a 99 � Para comunica��o TCP/IP com porta vari�vel.
      1 a ... � Para comunica��o TCP/IP porta fixa.      }
  Function EnviarListaUsuariosSemDigitalBioInnerAcesso( Inner:Integer):Byte; stdcall; external 'EasyInner.dll';

  Function SolicitarVersaoBio( Inner:Integer):Byte; stdcall; external 'EasyInner.dll';
  {Solicita a vers�o do firmware da placa do Inner Bio, a placa que armazena as digitais.
  Inner
      1 a 32 � Para comunica��o serial.
      1 a 99 � Para comunica��o TCP/IP com porta vari�vel.
      1 a ... � Para comunica��o TCP/IP porta fixa.     }

  Function IncluirUsuarioSemDigitalBio( Cartao:String):Byte; stdcall; external 'EasyInner.dll';
  {Insere o n�mero do cart�o na lista de usu�rios sem digital do Inner bio. Este n�mero ficara
  armazenado em um buffer interno dentro da dll e somente ser� enviado para o Inner ap�s a chamada a
  fun��o EnviarListaUsuariosSemDigitalBio. O n�mero m�ximo de d�gitos para o cart�o � 10, caso os
  cart�es tenham mais de 10 d�gitos, utilizar os 10 d�gitos menos significativos do cart�o.
  Cartao - 1 a 9999999999 � N�mero do cart�o do usu�rio.     }
  Function IncluirUsuarioSemDigitalBioInnerAcesso( Cartao:AnsiString):Byte; stdcall; external 'EasyInner.dll';

  Function ConfigurarBio(Inner:Integer; HabilitaIdentificacao, HabilitaVerificacao:Byte):Byte; stdcall; external 'EasyInner.dll';
  {Habilita/Desabilita a identifica��o biom�trica e/ou a verifica��o biom�trica do Inner bio. O
  resultado da configura��o deve ser obtivo atrav�s do comando ResultadoConfiguracaoBio.
  Inner
      1 a 32 � Para comunica��o serial.
      1 a 99 � Para comunica��o TCP/IP com porta vari�vel.
      1 a ... � Para comunica��o TCP/IP porta fixa.
  HabilitaIdentificacao
      0 � Desabilita.
      1 � Habilita.
  HabilitaVerificacao
      0 � Desabilita.
      1 � Habilita.                    }

  Function ResultadoConfiguracaoBio( Inner:Integer; OnLine:Byte):Byte; stdcall; external 'EasyInner.dll';
  {Retorna o resultado da configura��o do Inner Bio, fun��o ConfigurarBio. Se o retorno for
  igual a 0 � poque o Inner bio foi configurado com sucesso.
  Inner
      1 a 32 � Para comunica��o serial.
      1 a 99 � Para comunica��o TCP/IP com porta vari�vel.
      1 a ... � Para comunica��o TCP/IP porta fixa.
  OnLine
      0 � O comando foi utilizado com o Inner em OffLine.
      1 � O comando foi utilizado com o Inner em OnLine.   }

  Function DefinirMensagemFuncaoOffLine( Mensagem:String;  Funcao,Habilitada:Byte):Byte; stdcall; external 'EasyInner.dll';
  {Configura a mensagem a ser exibida quando o usu�rio passar o cart�o utilizando uma das
  fun��es do Inner(de 0 a 9) e a habilita ou desabilita essas fun��es. Caso a mensagem passe de 32
  caracteres a DLL ir� utilizar os primeiros 32 caracteres.
  O Inner n�o aceita caracteres com acentua��o, padr�o UNICODE ou padr�o ANSI.
  O Inner aceita apenas os caracteres do padr�o ASCII.
  Mensagem
  String com a mensagem a ser exibida. Caso esteja
  exibindo a data/hora o tamanho da mensagem passa a ser
  16 ao inv�s de 32. Caso seja passado uma string vazia o
  Inner n�o exibir� a mensagem no display.
  Funcao - 0 a 9.
  Habilitada
      0 � Desabilita a fun��o do Inner(Default).
      1 � Habilita a fun��o do Inner.            }

  Function ReceberRelogio(Inner: Integer;
                        Dia, Mes, Ano, Hora,
                        Minuto, Segundo: Pointer):Byte; stdcall; external 'EasyInner.dll';
  {Solicita a data/hora atualmente configurada no Inner. Os dados s�o retornados por refer�ncia
  nos par�metros da fun��o.
  Inner
      1 a 32 � Para comunica��o serial.
      1 a 99 � Para comunica��o TCP/IP com porta vari�vel.
      1 a ... � Para comunica��o TCP/IP porta fixa.
  Dia - 1 a 31
  Mes - 1 a 12
  Ano - 0 a 99
  Hora - 0 a 23
  Minuto - 0 a 59
  Segundo - 0 a 59                             }

  Function SolicitarQuantidadeUsuariosBio( Inner:Integer):Byte; stdcall; external 'EasyInner.dll';
  //Solicita a quantidade de usu�rios cadastrados no Inner Bio.

  Function ReceberQuantidadeUsuariosBio( Inner:Integer;  OnLine:Byte; Quantidade:Pointer):Byte; stdcall; external 'EasyInner.dll';
  {Retorna o resultado do comando SolicitarQuantidadeUsuariosBio, a quantidade de
    usu�rios cadastrados no Inner Bio � retornado por refer�ncia nos par�metros da fun��o.
    Inner:
         1 a 32 � Para comunica��o serial.
         1 a 99 � Para comunica��o TCP/IP com porta vari�vel.
         1 a ... � Para comunica��o TCP/IP porta fixa.
    OnLine:
         0 � O comando foi utilizado com o Inner em OffLine.
         1 � O comando foi utilizado com o Inner em OnLine
    Quantidade - Total de usu�rios cadastrados no Inner Bio.}

  Procedure InicializarColetaListaUsuariosBio(); stdcall; external 'EasyInner.dll';
  {Prepara a dll para iniciar a coleta dos usu�rios do Inner bio, essa fun��o deve ser chamada
    obrigatoriamente no in�cio do processo.}

  Function TemProximoPacote():Integer; stdcall; external 'EasyInner.dll';
  //Retorna 1 se ainda existe mais pacotes da lista de usu�rios, a ser recebido do Inner Bio.

  Function SolicitarListaUsuariosBio( Inner:Integer):Byte; stdcall; external 'EasyInner.dll';
  {Solicita o pacote(a parte) atual da lista de usu�rios do Inner bio.
    Inner:
         1 a 32 � Para comunica��o serial.
         1 a 99 � Para comunica��o TCP/IP com porta vari�vel.
         1 a ... � Para comunica��o TCP/IP porta fixa.}

  Function ReceberPacoteListaUsuariosBio( Inner:Integer):Byte; stdcall; external 'EasyInner.dll';
  {Receber o pacote solicitado pela fun��o SolicitarListaUsuariosBio.
    Inner:
         1 a 32 � Para comunica��o serial.
         1 a 99 � Para comunica��o TCP/IP com porta vari�vel.
         1 a ... � Para comunica��o TCP/IP porta fixa.}

  Function TemProximoUsuario():Integer; stdcall; external 'EasyInner.dll';
  //Retorna 1 se ainda existe usu�rios no pacote recebido da lista.

  Function ReceberUsuarioLista( Inner:Integer; Usuario:Pointer):Byte; stdcall; external 'EasyInner.dll';
  {Recebe um usu�rio por vez do pacote recebido anteriormente. O n�mero do usu�rio �
    retornado pelo par�metro da fun��o.
    Inner:
         1 a 32 � Para comunica��o serial.
         1 a 99 � Para comunica��o TCP/IP com porta vari�vel.
         1 a ... � Para comunica��o TCP/IP porta fixa.
    Usuario - N�mero do cart�o do usu�rio cadastrado.}

  Function SolicitarExclusaoUsuario( Inner:Integer;  Usuario:AnsiString):Byte; stdcall; external 'EasyInner.dll';
  {Solicita para o Inner bio excluir o cadastro do usu�rio desejado. O Retorno da exclus�o �
    verificado atrav�s da fun��o UsuarioFoiExcluido
    Inner:
         1 a 32 � Para comunica��o serial.
         1 a 99 � Para comunica��o TCP/IP com porta vari�vel.
         1 a ... � Para comunica��o TCP/IP porta fixa.
    Usuario - N�mero do cart�o do usu�rio cadastrado.}

  Function UsuarioFoiExcluido( Inner:Integer;  OnLine:Byte):Byte; stdcall; external 'EasyInner.dll';
  {Retorna o resultado do comando SolicitarExclusaoUsuario, se o retorno da fun��o for igual
    a 0 � porque o usu�rio foi exclu�do com sucesso.
    Inner:
         1 a 32 � Para comunica��o serial.
         1 a 99 � Para comunica��o TCP/IP com porta vari�vel.
         1 a ... � Para comunica��o TCP/IP porta fixa.
    OnLine:
         0 � O comando foi utilizado com o Inner em OffLine.
         1 � O comando foi utilizado com o Inner em OnLine.}

  Function SolicitarUsuarioCadastradoBio( Inner:Integer;  Usuario:String):Byte; stdcall; external 'EasyInner.dll';
  {Solicita do Inner Bio, o template com as duas digitais do Usuario desejado.
    Inner:
         1 a 32 � Para comunica��o serial.
         1 a 99 � Para comunica��o TCP/IP com porta vari�vel.
         1 a ... � Para comunica��o TCP/IP porta fixa.
    Usuario - N�mero do cart�o do usu�rio cadastrado.}

  Function ReceberUsuarioCadastradoBio( Inner:Integer; OnLine:Byte;  Template:Pointer):Byte; stdcall; external 'EasyInner.dll';
  {Retorna o resultado do comando SolicitarUsuarioCadastradoBio e o template com as duas
    digitais do usu�rio cadastrado no Inner Bio. O template � retornado por refer�ncia nos par�metros da
    fun��o.
    Inner:
         1 a 32 � Para comunica��o serial.
         1 a 99 � Para comunica��o TCP/IP com porta vari�vel.
         1 a ... � Para comunica��o TCP/IP porta fixa.
    OnLine:
         0 � O comando foi utilizado com o Inner em OffLine.
         1 � O comando foi utilizado com o Inner em OnLine
    Template: Cadastro do usu�rio com as duas digitais, o dado est� em bin�rio e n�o
    deve ser alterado nunca. O tamanho do template � de 844 bytes.}

  Function SolicitarTemplateLeitor( Inner:Integer):Byte; stdcall; external 'EasyInner.dll';
  {Solicita diretamente do Inner bio um template com apenas uma digital, ao executar essa
    fun��o o leitor biom�trico do Inner bio ir� acender e a digital que for inserida ser� enviada diretamente
    para a aplica��o, a digital n�o ficar� armazenada no banco de dado do equipamento.
    Para receber a digital � necess�rio chamar a fun��o ReceberTemplateLeitor.
    Inner:
         1 a 32 � Para comunica��o serial.
         1 a 99 � Para comunica��o TCP/IP com porta vari�vel.
         1 a ... � Para comunica��o TCP/IP porta fixa.  }

  Function ReceberTemplateLeitor( Inner:Integer; OnLine:Byte; Template:Pointer):Byte; stdcall; external 'EasyInner.dll';
  {Retorna o resultado do comando SolicitarTemplateLeitor. Se o retorno for igual a 0 �
    porque o template foi recebido com sucesso. O template ser� retornado por refer�ncia no par�metro da fun��o.
    Inner:
         1 a 32 � Para comunica��o serial.
         1 a 99 � Para comunica��o TCP/IP com porta vari�vel.
         1 a ... � Para comunica��o TCP/IP porta fixa.
    OnLine:
         0 � O comando foi utilizado com o Inner em OffLine.
         1 � O comando foi utilizado com o Inner em OnLine.
    Template: Digital recebida pelo leitor biom�trico. � um array de bytes e seu conte�do
    n�o deve ser alterado nunca, seu tamanho � de 404 bytes.}

  Function EnviarUsuarioBio( Inner:Integer; Template:Pointer):Byte; stdcall; external 'EasyInner.dll';
  {Envia um template com duas digitais para o Inner Bio cadastrar no seu banco de dados. O
    resultado do cadastro deve ser verificado no retorno da fun��o UsuarioFoiEnviado.
    Inner:
         1 a 32 � Para comunica��o serial.
         1 a 99 � Para comunica��o TCP/IP com porta vari�vel.
         1 a ... � Para comunica��o TCP/IP porta fixa.
    Template: O cadastro do usu�rio j� contendo as duas digitais e o n�mero do usu�rio.
    � um array de bytes com o tamanho de 844 bytes.}

  Function UsuarioFoiEnviado( Inner:Integer; OnLine:Byte):Byte; stdcall; external 'EasyInner.dll';
  {Retorna o resultado do cadastro do Template no Inner Bio, atrav�s da fun��o
    EnviarUsuarioBio. Se o retorno for igual a 0 � porque o template foi cadastrado com sucesso.
    Inner:
         1 a 32 � Para comunica��o serial.
         1 a 99 � Para comunica��o TCP/IP com porta vari�vel.
         1 a ... � Para comunica��o TCP/IP porta fixa.
    OnLine:
         0 � O comando foi utilizado com o Inner em OffLine.
         1 � O comando foi utilizado com o Inner em OnLine.}

  Function CompararDigitalLeitor( Inner:Integer; Template:Pointer):Byte; stdcall; external 'EasyInner.dll';
  {Ao executar essa fun��o o Inner bio ir� acender o leitor biom�trico solicitando a digital do
    usu�rio, na sequ�ncia ir� comparar a digital inserida pelo usu�rio com a digital enviada pela fun��o no
    par�metro Template. O resultado da compara��o � retornado pela fun��o ResultadoComparacaoDigitalLeitor.
    Inner:
         1 a 32 � Para comunica��o serial.
         1 a 99 � Para comunica��o TCP/IP com porta vari�vel.
         1 a ... � Para comunica��o TCP/IP porta fixa.
    Template: Digital a ser comparada. Array de bytes de 404 bytes.}

  Function ResultadoComparacaoDigitalLeitor( Inner:Integer;  OnLine:Byte):Byte; stdcall; external 'EasyInner.dll';
  {Retorna o resultado da compara��o da digital do usu�rio com o template enviado para o
  Inner Bio, atrav�s da fun��o CompararDigitalLeitor. Se o retorno for igual a 0 � poque a digital inserida
    � a mesma da enviada.
    Inner:
         1 a 32 � Para comunica��o serial.
         1 a 99 � Para comunica��o TCP/IP com porta vari�vel.
         1 a ... � Para comunica��o TCP/IP porta fixa.
    OnLine:
         0 � O comando foi utilizado com o Inner em OffLine.
         1 � O comando foi utilizado com o Inner em OnLine.}

  Function InserirUsuarioLeitorBio( Inner:Integer; Tipo:Byte; Usuario:String):Byte; stdcall; external 'EasyInner.dll';
  {Solicita para o Inner Bio inserir um usu�rio diretamente pelo leitor biom�trico. O leitor ir�
    acender a luz vermelho e ap�s o usu�rio inserir a digital, automaticamente o usu�rio ser� cadastrado no
    nner bio com o n�mero do cart�o passado no par�metro Usu�rio.
    Inner:
         1 a 32 � Para comunica��o serial.
         1 a 99 � Para comunica��o TCP/IP com porta vari�vel.
         1 a ... � Para comunica��o TCP/IP porta fixa.
    Tipo:
         0 � para solicitar o primeiro template
         1 � para solicitar o segundo template (mesmo dedo) e salvar.
         2 � para solicitar o segundo template (outro dedo) e salvar.
    Usuario - N�mero do cart�o que o usu�rio ter�.}

  Function ResultadoInsercaoUsuarioLeitorBio( Inner:Integer; OnLine:Byte):Byte; stdcall; external 'EasyInner.dll';
  {Retorna o resultado do comando InserirUsuarioLeitorBio. Se o retorno for igual a 0 �
    porque o usu�rio foi cadastrado com sucesso.
    Inner:
         1 a 32 � Para comunica��o serial.
         1 a 99 � Para comunica��o TCP/IP com porta vari�vel.
         1 a ... � Para comunica��o TCP/IP porta fixa.
    OnLine:
         0 � O comando foi utilizado com o Inner em OffLine.
         1 � O comando foi utilizado com o Inner em OnLine.}

  Procedure SetarBioLight(Light: Integer); stdcall; external 'EasyInner.dll';
  {Define que o Inner utilizado no momento � um Inner bio light ao inv�s de um Inner bio
    1000/4000. Essa fun��o dever� ser chamada sempre que necess�rio antes das fun��es
    SolicitarUsuarioCadastradoBio, SolicitarExclusaoUsuario, InserirUsuarioLeitorBio e
    FazerVerificacaoBiometricaBio.
    Light:
      1 � � um Inner bio light
      0 � � um Inner bio 1000/4000(valor default)}

  Procedure ConfigurarBioVariavel(valor: Integer); stdcall; external 'EasyInner.dll';

  Function GetTickCount(): longint; stdcall; external 'kernel32.dll';
  //M�todo que retorna os segundos do Sistema.

  Procedure Sleep(ms: longint); stdcall; external 'kernel32.dll';

implementation

end.
