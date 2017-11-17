unit UFuncoesInner;

interface

//métodos novos usados para versão do firmware Inner Acesso 5.x.x

  Function ReceberRespostaRequisicaoBio(Inner:Longint; TamResposta: Pointer): Byte; stdcall; external 'EasyInner.dll';

  Function SolicitarDigitalUsuario(Inner: Longint; Usuario:AnsiString): Byte;stdcall; external 'EasyInner.dll';

  Function SolicitarListaUsuariosComDigital(Inner:Longint): Byte;stdcall; external 'EasyInner.dll';

  Function ReceberDigitalUsuario(Tipo: Longint; Digital : Pointer; Tamanho : Integer): Byte;stdcall; external 'EasyInner.dll';

  Function ReceberUsuarioComDigital (Usuario:Pointer): Byte;stdcall; external 'EasyInner.dll';

  Function EnviarDigitalUsuario(Inner:Integer; Usuario:AnsiString; Digital1:Pointer; Digital2:Pointer): Byte;stdcall; external 'EasyInner.dll';

  Function SolicitarListaUsuariosBioVariavel( Inner:Integer):Byte; stdcall; external 'EasyInner.dll';
  {Solicita o pacote(a parte) atual da lista de usuários do Inner bio. Somente Inner Acesso versão superior 5.x.x
    Inner:
         1 a 32 – Para comunicação serial.
         1 a 99 – Para comunicação TCP/IP com porta variável.
         1 a ... – Para comunicação TCP/IP porta fixa.}

  Function ReceberQuantidadeBilhetes(Inner:Longint; Quantidade: Pointer): Byte; stdcall; external 'EasyInner.dll';

  Function DefinirNumeroCartaoMaster( Master:String):Byte; stdcall; external 'EasyInner.dll';

  Procedure SetarBioVariavel(maior: Integer); stdcall; external 'EasyInner.dll';
  {Define que o Inner utilizado no momento é um Inner com versão do firware superior ou igual 5.xx.
   Essa função deverá ser chamada sempre que necessário antes das funções
    SolicitarExclusaoUsuario,
    maior:
      1 – É um Inner versao superio 5.x.x
      0 – É um Inner ersao inferior 5.x.x(valor default)}

  Function DefinirTipoConexao(Tipo:Byte):Byte; stdcall; external 'EasyInner.dll';
  {Define qual será o tipo de conexão(meio de comunicação) que será utilizada pela dll para
  comunicar com os Inners. Essa função deverá ser chamada antes de iniciar o processo de comunicação
  e antes da função AbrirPortaComunicacao.
      0 - Comunicação serial, RS-232/485.
      1 - Comunicação TCP/IP com porta variável.
      2 - Comunicação TCP/IP com porta fixa (Default).
      3 - Comunicação via modem.
      4 – Comunicação via TopPendrive.}

  Function AcionarRele1( Inner:Integer):Byte; stdcall; external 'EasyInner.dll';
  //aciona rele 1 para coletor

  Function AcionarRele2( Inner:Integer):Byte; stdcall; external 'EasyInner.dll';
  //aciona rele 2 para coletor

  Function AbrirPortaComunicacao(Porta:Integer):Byte; stdcall; external 'EasyInner.dll';
  {Abre a porta de comunicação desejada, essa função deverá ser chamada antes de iniciar
  qualquer processo de transmissão ou recepção de dados com o Inner.Esta função deve ser chamada apenas uma vez e no início da comunicação, e não deve ser chamada
  para cada Inner.
      - Número da porta serial ou TCP/IP.
      - Para comunicação TCP/IP o valor padrão da porta é 3570 (Default).
      - Para comunicação Serial/Modem o valor padrão da porta é 1, COM 1(Default).
      - Para a comunicação TopPendrive o valor é 3 (Default).}

  Procedure FecharPortaComunicacao(); stdcall; external 'EasyInner.dll';
  {Fecha a porta de comunicação previamente aberta, seja ela serial, Modem ou TCP/IP.
  Em modo Off-Line normalmente é chamada após enviar/receber todos os dados do Inner.
  Em modo On-Line é chamada somente no ecerramento do software do software. }

  Function DefinirPadraoCartao(Padrao:Byte):Byte; stdcall; external 'EasyInner.dll';
  {Define qual padrão de cartão será utilizado pelos Inners, padrão Topdata ou padrão livre. O
  padrão Topdata de cartão está descrito no manual dos equipamentos e é utilizado somente com os
  Inners em modo Off-Line. No padrão livre todos os dígitos do cartão são considerados como matrícula,
  ele pode ser utilizado no modo On Line ou no modo Off Line.
  Ao chamar essa função, a quantidade de dígitos é setada para 14.
      0 - Padrão Topdata.
      1 - Padrão livre (Default). }

  Function AcionarBipCurto( Inner:Integer):Byte; stdcall; external 'EasyInner.dll';
  Function AcionarBipLongo( Inner:Integer):Byte; stdcall; external 'EasyInner.dll';
  //Faz com que o Inner emita um bip curto(aviso sonoro).

  Function Ping( Inner:Integer):Byte; stdcall; external 'EasyInner.dll';
  {Testa a comunicação com o Inner, também utilizado para efetuar a conexão com o Inner.
  Para efetuar a conexão com o Inner, essa função deve ser executada em um loop até retornar 0(zero),
  executado com sucesso.}

  Function PingOnLine(Inner: Integer):Byte; stdcall; external 'EasyInner.dll';
  {Testa comunicação com o Inner e mantém o Inner em OnLine quando a mudança automática
  está configurada. Especialmente indicada para a verificação da conexão em comunicação TCP/IP.  }

  Function LigarBackLite( Inner:Integer):Byte; stdcall; external 'EasyInner.dll';
  //Liga a luz emitida pelo display do Inner. Essa função não deve ser utilizada nas catracas.

  Function HabilitarTeclado( Habilita,  Ecoar:Byte):Byte; stdcall; external 'EasyInner.dll';
  {Permite que os dados sejam inseridos no Inner através do teclado do equipamento.
  Habilitando o parâmetro ecoar, o teclado irá ecoar asteriscos no display do Inner.
  Habilita
      0 - Desabilita o teclado (Default).
      1 - Habilita o teclado.
  Ecoar
      0 – Ecoa o que é digitado no display do Inner (Default).
      1 – Ecoa asteriscos no display do Inner. }

  Function DesligarBackLite( Inner:Integer):Byte; stdcall; external 'EasyInner.dll';
  //Desliga a luz emitida pelo display do Inner. Essa função não deve ser utilizada nas catracas.

  Function ReceberVersaoFirmware(Inner:Integer; Linha:Pointer; Variacao:Pointer; VersaoAlta:Pointer; VersaoBaixa:Pointer; VersaoSufixo:Pointer; InnerAcessoBio:Pointer):Byte; stdcall; external 'EasyInner.dll';
  {Solicita a versão do firmware do Inner e dados como o Idioma, se é uma versão especial.
  Inner
  Número do Inner desejado.
  Linha
      01 – Inner Plus.
      02 – Inner Disk.
      03 – Inner Verid.
      06 – Inner Bio.
      07 – Inner NET.
  Variacao - Depende da versão, existe somente em versões customizadas.
  VersaoAlta - 00 a 99
  VersaoBaixa - 00 a 99
  VersaoSufixo - Indica o idioma do firmware:
      01 – Português.
      02 – Espanhol.
      03 – Inglês.
      04 – Francês.  }

  Function ConfigurarAcionamento1( Funcao,Tempo:Byte):Byte; stdcall; external 'EasyInner.dll';
  {Configura como irá funcionar o acionamento(rele) 1 do Inner, e por quanto tempo ele será acionado.
  Funcao
      0 – Não utilizado(Default).
      1 – Aciona ao registrar uma entrada ou saída.
      2 – Aciona ao registrar uma entrada.
      3 – Aciona ao registrar uma saída.
      4 – Está conectado a uma sirene(Ver as funções de sirene).
      5 – Utilizado para a revista de usuários(Ver a função DefinirPorcentagemRevista).
      6 – Catraca com a saída liberada.
      7 – Catraca com a entrada liberada
      8 – Catraca liberada nos dois sentidos.
      9 – Catraca liberada nos dois sentidos e a marcação(registro) é gerada de acordo com o sentido do giro.
  Tempo - 0 a 50 segundos. 0(Default).   }

  Function ConfigurarAcionamento2( Funcao,Tempo:Byte):Byte; stdcall; external 'EasyInner.dll';
  {Configura como irá funcionar o acionamento(rele) 2 do Inner, e por quanto tempo ele será acionado.
  Funcao
      0 – Não utilizado(Default).
      1 – Aciona ao registrar uma entrada ou saída.
      2 – Aciona ao registrar uma entrada.
      3 – Aciona ao registrar uma saída.
      4 – Está conectado a uma sirene(Ver as funções de sirene).
      5 – Utilizado para a revista de usuários(Ver a função DefinirPorcentagemRevista).
      6 – Catraca com a saída liberada.
      7 – Catraca com a entrada liberada
      8 – Catraca liberada nos dois sentidos.
      9 – Catraca liberada nos dois sentidos e a marcação(registro) é gerada de acordo com o sentido do giro.
  Tempo - 0 a 50 segundos. 0(Default). }

  Function ConfigurarTipoLeitor( Tipo:Byte):Byte; stdcall; external 'EasyInner.dll';
  {Configura o tipo do leitor que o Inner está utilizando, se é um leitor de código de barras,
  magnético ou proximidade.
  Tipo
      0 – Leitor de código de barras(Default).
      1 – Leitor Magnético.
      2 – Leitor proximidade AbaTrack2.
      3 – Leitor proximidade Wiegand e Wiegand Facility Code.
      4 – Leitor proximidade Smart Card. }

  Function ConfigurarLeitor1( Operacao:Byte):Byte; stdcall; external 'EasyInner.dll';
  {Configura as operações que o leitor irá executar. Se irá registrar os dados somente como
  entrada independente do sentido em que o cartão for passado, somente como saída ou como entrada e saída.
  Operacao
      0 – Leitor desativado(Default).
      1 – Somente para entrada.
      2 – Somente para saída.
      3 – Entrada e saída.
      4 – Entrada e saída invertidas.  }

  Function ConfigurarLeitor2( Operacao:Byte):Byte; stdcall; external 'EasyInner.dll';
  {Configura as operações que o leitor irá executar. Se irá registrar os dados somente como
  entrada independente do sentido em que o cartão for passado, somente como saída ou como entrada e saída.
  Operacao
      0 – Leitor desativado(Default).
      1 – Somente para entrada.
      2 – Somente para saída.
      3 – Entrada e saída.
      4 – Entrada e saída invertidas.}

  Function DefinirQuantidadeDigitosCartao( Quantidade:Byte):Byte; stdcall; external 'EasyInner.dll';
  {Define a quantidade de dígitos dos cartões a serem lidos pelo Inner.
  Quantidade - 1 a 16 dígitos. 14(Default).  }

  Function InserirQuantidadeDigitoVariavel( Digito:Byte):Byte; stdcall; external 'EasyInner.dll';
  //Para usar cartoes de diferentes digitos

  Function RegistrarAcessoNegado( TipoRegistro:Byte):Byte; stdcall; external 'EasyInner.dll';
  {Configura o Inner para registrar as tentativa de acesso negado. O Inner irá rgistrar apenas os
  acessos negados em relação a lista de acesso configurada para o modo Off-Line, ver as funções
  DefinirTipoListaAcesso e ColetarBilhete.
  TipoRegistro
      0 – Não registrar o acesso negado.
      1 – Apenas o acesso negado.
      2 – Falha na validação da digital.
      3 – Acesso negado e falha na validação da digital. }

  Function DefinirFuncaoDefaultLeitoresProximidade( Funcao:Byte):Byte; stdcall; external 'EasyInner.dll';
  {Define qual será o tipo do registro realizado pelo Inner ao aproximar um cartão do tipo
  proximidade no leitor do Inner, sem que o usuário tenha pressionado a tecla entrada, saída ou função.
  Funcao
      0 – Desablitado(Default).
      1 a 9 – Registrar como uma função do teclado do Inner.
      10 – Registrar sempre como entrada.
      11 – Registrar sempre como saída.
      12 – Libera a catraca nos dois sentidos e registra o bilhete conforme o sentido giro.    }

  Function ConfigurarWiegandDoisLeitores( Habilita,ExibirMensagem:Byte):Byte; stdcall; external 'EasyInner.dll';
  {Habilita os leitores wiegand para o primeiro leitor e o segundo leitor do Inner, e configura se o
  segundo leitor irá exibir as mensagens configuradas.
  Habilita
      0 – Não habilita o segundo leitor como wiegand(Default).
      1 – Habilita o segundo leitor como wiegand.
  ExibirMensagem
      0 – Não exibe mensagem segundo leitor(Default).
      1 – Exibe mensagem segundo leitor. }

  Function DefinirFuncaoDefaultSensorBiometria( Funcao:Byte):Byte; stdcall; external 'EasyInner.dll';
  {Configura o tipo de registro que será associado a uma marcação, quando for inserido o dedo
  no Inner bio sem que o usuário tenha definido se é um entrada, saída, função, etc.
  Funcao
      0 – desabilitada(Default).
      1 a 9 – funções de 1 a 9.
      10 – entrada.
      11 – saída.
      12 – libera catraca para os dois lados e registra bilhete conforme o giro.}

  Function EnviarConfiguracoes( Inner:Integer):Byte; stdcall; external 'EasyInner.dll';
  {Envia o buffer interno da dll que contém todas as configurações das funções anteriores para
  o Inner, após o envio esse buffer é limpo sendo necessário chamar novamentes as funções acima para
  reconfigurá-lo.
  Inner
      1 a 32 – Para comunicação serial.
      1 a 99 – Para comunicação TCP/IP com porta variável.
      1 a ... – Para comunicação TCP/IP porta fixa.  }

  Function EnviarRelogio( Inner:Integer;
                        Dia,Mes,Ano,
                        Hora,Minuto,Segundo:Byte):Byte; stdcall; external 'EasyInner.dll';
  {Configura o relógio(data/hora) do Inner.
  Inner
      1 a 32 – Para comunicação serial.
      1 a 99 – Para comunicação TCP/IP com porta variável.
      1 a ... – Para comunicação TCP/IP porta fixa.
  Dia - 1 a 31
  Mes - 1 a 12.
  Ano - 0 a 99
  Hora - 0 a 23
  Minuto - 0 a 59
  Segundo - 0 a 59   }

  Function InserirHorarioSirene( Hora,  Minuto,
   Segunda,  Terca,  Quarta,  Quinta,
   Sexta,  Sabado,  DomingoFeriado:Byte):Byte; stdcall; external 'EasyInner.dll';
  {Insere um horário de toque de sirene e configura em quais dias da semana esses horário
  irão tocar. É possível inserir no máximo 100 horários para a sirene.
  Hora - 0 a 23
  Minuto - 0 a 59
  Segunda
      0 – Desabilita o toque nesse dia.
      1 – Habilita o toque nesse dia.
  Terca
      0 – Desabilita o toque nesse dia.
      1 – Habilita o toque nesse dia.
  Quarta
      0 – Desabilita o toque nesse dia.
      1 – Habilita o toque nesse dia.
  Quinta
      0 – Desabilita o toque nesse dia.
      1 – Habilita o toque nesse dia.
  Sexta
      0 – Desabilita o toque nesse dia.
      1 – Habilita o toque nesse dia.
  Sabado
      0 – Desabilita o toque nesse dia.
      1 – Habilita o toque nesse dia.
  DomingoFeriado
      0 – Desabilita o toque nesse dia.
      1 – Habilita o toque nesse dia.  }

  Function EnviarHorariosSirene( Inner:Integer):Byte; stdcall; external 'EasyInner.dll';
  {Envia o buffer com os horário de sirene cadastrados para o Inner. Após executar a função o
  buffer é limpo automaticamente pela dll.
  Inner
      1 a 32 – Para comunicação serial.
      1 a 99 – Para comunicação TCP/IP com porta variável.
      1 a ... – Para comunicação TCP/IP porta fixa. }

  Function LiberarCatracaSaida( Inner:Integer):Byte; stdcall; external 'EasyInner.dll';
  {Libera a catraca no sentido de saída padrão do Inner, para o usuário poder efetuar o giro na
  catraca. Em modo On-Line, na função ReceberDadosOnLine o valor retornado no parâmetro
  “Complemento” será do tipo saída.
  Essa função deve ser utilizada somente com Inners Catraca. }

  Function LiberarCatracaSaidaInvertida( Inner:Integer):Byte; stdcall; external 'EasyInner.dll';
  {Libera a catraca no sentido contrário a saída padrão do Inner, para o usuário poder efetuar o
  giro na catraca. Em modo On-Line, na função ReceberDadosOnLine o valor retornado no parâmetro
  “Complemento” será do tipo entrada.
  Essa função deve ser utilizada somente com Inners Catraca. }

  Function LiberarCatracaEntrada( Inner:Integer):Byte; stdcall; external 'EasyInner.dll';
  {Libera a catraca no sentido de entrada padrão do Inner, para o usuário poder efetuar o giro
  na catraca. Em modo On-Line, na função ReceberDadosOnLine o valor retornado no parâmetro
  “Complemento” será do tipo entrada.  }

  Function LiberarCatracaEntradaInvertida( Inner:Integer):Byte; stdcall; external 'EasyInner.dll';
  {Libera a catraca no sentido contrário a entrada padrão do Inner, para o usuário poder efetuar
  o giro na catraca. Em modo On-Line, na função ReceberDadosOnLine o valor retornado no parâmetro
  “Complemento” será do tipo saída.
   Essa função deve ser utilizada somente com Inners Catraca. }

  Function LiberarCatracaDoisSentidos( Inner:Integer):Byte; stdcall; external 'EasyInner.dll';
  {Libera a catraca para o usuário pode efetuar o giro na catraca em ambos os sentidos. Em
  modo On-Line, na função ReceberDadosOnLine o valor retornado no parâmetro “Complemento” será
  do tipo entrada ou saída, dependendo do sentido em que o usuário passar pela catraca.
  Essa função deve ser utilizada somente com Inners Catraca.  }

  Function ConfigurarInnerOffLine():Byte; stdcall; external 'EasyInner.dll';
  {Prepara o Inner para trabalhar no modo Off-Line, porém essa função ainda não envia essa
  informação para o equipamento. }

  Function DefinirMensagemEntradaOffLine( ExibirData:Byte;  Mensagem:String):Byte; stdcall; external 'EasyInner.dll';
  {Configura a mensagem a ser exibida quando o usuário passar o cartão no sentido de entrada
  do Inner. Caso a mensagem passe de 32 caracteres a DLL irá utilizar os primeiros 32 caracteres.
  O Inner não aceita caracteres com acentuação, padrão UNICODE ou padrão ANSI.
  O Inner aceita apenas os caracteres do padrão ASCII.
  ExibirData
      0 – Não exibe a data/hora na linha superior do display.
      1 – Exibe a data/hora na linha superior do display(Default).
  Mensagem
  String com a mensagem a ser exibida. Caso esteja exibindo a data/hora o tamanho da mensagem passa a ser
  16 ao invés de 32. Caso seja passado uma string vazia o Inner exibirá a mensagem em branco no display.
  Entrada OK(Default). }

  Function DefinirMensagemSaidaOffLine( ExibirData:Byte;  Mensagem:String):Byte; stdcall; external 'EasyInner.dll';
  {Configura a mensagem a ser exibida quando o usuário passar o cartão no sentido de saída
  do Inner. Caso a mensagem passe de 32 caracteres a DLL irá utilizar os primeiros 32 caracteres.
  O Inner não aceita caracteres com acentuação, padrão UNICODE ou padrão ANSI.
  O Inner aceita apenas os caracteres do padrão ASCII.
  ExibirData
      0 – Não exibe a data/hora na linha superior do display.
      1 – Exibe a data/hora na linha superior do display(Default).
  Mensagem
  String com a mensagem a ser exibida. Caso esteja exibindo a data/hora o tamanho da mensagem passa a ser
  16 ao invés de 32. Caso seja passado uma string vazia o Inner exibirá a mensagem em branco no display.
  Entrada OK(Default). }

  Function DefinirMensagemPadraoOffLine( ExibirData:Byte;  Mensagem:String):Byte; stdcall; external 'EasyInner.dll';
  {Configura a mensagem a ser exibida pelo Inner quando ele estiver ocioso.
  Caso a mensagem passe de 32 caracteres a DLL irá utilizar os primeiros 32 caracteres.
  O Inner não aceita caracteres com acentuação, padrão UNICODE ou padrão ANSI.
  O Inner aceita apenas os caracteres do padrão ASCII.
  ExibirData
  0 – Não exibe a data/hora na linha superior do display.
  1 – Exibe a data/hora na linha superior do display(Default).
  Mensagem
  String com a mensagem a ser exibida. Caso esteja exibindo a data/hora o tamanho da mensagem passa a ser
  16 ao invés de 32. Caso seja passado uma string vazia o Inner exibirá a mensagem em branco no display.
  Passe o cartão(Default).  }

  Function EnviarMensagensOffLine( Inner:Integer):Byte; stdcall; external 'EasyInner.dll';
  {Envia o buffer com todas as mensagens off line configuradas anteriormente, para o Inner.
  Após executar a função, o buffer com as mensagens é limpo automaticamente pela dll.
  Inner
      1 a 32 – Para comunicação serial.
      1 a 99 – Para comunicação TCP/IP com porta variável.
      1 a ... – Para comunicação TCP/IP porta fixa. }

  Function HabilitarMudancaOnLineOffLine( Habilita, Tempo:Byte):Byte; stdcall; external 'EasyInner.dll';
  {Habilita/Desabilita a mudanção automática do modo OffLine do Inner para OnLine e viceversa.
  Configura o tempo após a comunicação ser interrompida que está mudança irá ocorrer.
  Habilita
      0 – Desabilita a mudança(Default).
      1 – Habilita a mudança.
      2 – Habilita a mudança automática para o modo OnLine TCP com Ping,
  Onde o Inner precisa receber o comando PingOnLine para manter-se OnLine.
  Tempo - Tempo em segundos para ocorrer a mudança.
  1 a 50.    }

  Function DefinirEntradasMudancaOffLine( Teclado, Leitor1, Leitor2, Catraca:Byte):Byte; stdcall; external 'EasyInner.dll';
  {Configura as formas de entradas de dados para quando o Inner mudar para o modo Off-Line.
  Para aplicações com biometria verifique a próxima função “DefinirEntradasMudançaOffLineComBiometria”.
  Teclado
      0 – Não aceita dados pelo teclado.
      1 – Aceita dados pelo teclado.
  Leitor1
      0 – desativado
      1 – somente para entrada
      2 – somente para saída
      3 – entrada e saída
      4 – saída e entrada
  Leitor2
      0 – desativado
      1 – somente para entrada
      2 – somente para saída
      3 – entrada e saída
      4 – saída e entrada
  Catraca - 0 – reservado para uso futuro.  }

  Function DefinirEntradasMudancaOffLineComBiometria( Teclado,Leitor1,Leitor2,Verificacao,identificacao:Byte):Byte; stdcall; external 'EasyInner.dll';
  {Configura as formas de entradas de dados para quando o Inner mudar para o modo Off-Line.
  Esse comando difere do anterior por permitir a configuração de biometria. Através dessa função o Inner
  pode ser configurado para trabalhar com verificação ou identificação biométrica, quando ocorrer uma
  mudança automática de On-Line para Off-Line.
  Teclado - 0 – Não aceita dados pelo teclado.
      1 – Aceita dados pelo teclado.
  Leitor1
      0 – desativado
      3 – entrada e saída
      4 – saída e entrada (nesse caso força Leitor2 igual a zero)
  Leitor2
      0 – desativado
      3 – entrada e saída
  Verificacao
      0 – desativada
      1 – ativada
  Identificacao
      0 – desativada
      1 – ativada    }

  Function DefinirMensagemPadraoMudancaOnLine( ExibirData:Byte;  Mensagem:String):Byte; stdcall; external 'EasyInner.dll';
  Function DefinirMensagemPadraoMudancaOffLine( ExibirData:Byte;  Mensagem:String):Byte; stdcall; external 'EasyInner.dll';
  {Configura a mensagem padrão a ser exibida pelo Inner quando ele mudar para Off-line.
  ExibirData
      0 – Não exibe a data/hora na linha superior do display.
      1 – Exibe a data/hora na linha superior do display.
  Mensagem
  String com a mensagem a ser exibida. Caso esteja exibindo a data/hora o
  tamanho da mensagem passa a ser 16 ao invés de 32. Caso seja passado
  uma string vazia o Inner não exibirá a mensagem no display  }

  Function EnviarConfiguracoesMudancaAutomaticaOnLineOffLine( Inner:Integer):Byte; stdcall; external 'EasyInner.dll';
  {Envia o buffer com as configurações de mudança automática do modo OnLine para OffLine .
  Inner
      1 a 32 – Para comunicação serial.
      1 a 99 – Para comunicação TCP/IP com porta variável.
      1 a ... – Para comunicação TCP/IP porta fixa.       }

  Function LigarLedVermelho (Inner :Integer) :Byte; stdcall; external 'EasyInner.dll';
  //Liga led vermelho. Somente para Inner Acesso.

  Function DesligarLedVermelho (Inner :Integer) :Byte; stdcall; external 'EasyInner.dll';
  //Desliga led vermelho. Somente para Inner Acesso.

  Function ColetarBilhete( Inner:Integer; Tipo, Dia, Mes, Ano, Hora, Minuto: Pointer; Cartao:PChar):Byte; stdcall; external 'EasyInner.dll';
  {Coleta um bilhete Off-Line que está armazenado na memória do Inner, os dados do bilhete
  são retornados por referência nos parâmetros da função. Ates de chamar esta função pela primeira vez é
  preciso chamar obrigatoriamente as funções DefinirPadraoCartao e DefinirQuantidadeDigitosCartao
  nessa ordem para que o número do cartão seja calculado de forma correta.
  Inner
      1 a 32 – Para comunicação serial.
      1 a 99 – Para comunicação TCP/IP com porta variável.
      1 a ... – Para comunicação TCP/IP porta fixa.
  Tipo - Tipo da marcação registrada.
      0 a 9 – Funções registradas pelo cartão.
      10 – Entrada pelo cartão.
      11 – Saída pelo cartão.
      12 – Tentativa de entrada negada pelo cartão.
      13 – Tentativa de saída negada pelo cartão.
      100 a 109 – Funções registradas pelo teclado.
      110 – Entrada pelo teclado.
      111 – Saída pelo teclado.
      112 – Tentativa de entrada negada pelo teclado.
      113 – Tentativa de saída negada pelo teclado.
  Dia - 1 a 31
  Mes - 1 a 12
  Ano - 0 a 99
  Hora - 0 a 23
  Minuto - 0 a 59
  Cartao - Número do cartão do usuário. }

  Function ConfigurarInnerOnLine():Byte; stdcall; external 'EasyInner.dll';
  {Prepara o Inner para trabalhar no modo On-Line, porém essa função ainda não envia essa
  informação para o equipamento.  }

  Function ReceberDataHoraDadosOnLine( Recebe:Byte):Byte; stdcall; external 'EasyInner.dll';
  {Configura o Inner para enviar as informações de data/hora nos bilhete on line, esses dados
  serão retornados nos parâmetros da função ReceberDadosOnLine.
  Recebe
      0 – Não receber a data/hora do bilhete(Default).
      1 – Recebe a data/hora do bilhete.  }

  Function EnviarMensagemPadraoOnLine( Inner:Integer; ExibirData:Byte;  Mensagem:String):Byte; stdcall; external 'EasyInner.dll';
  {Envia para o Inner a mensagem padrão(fixa) que será sempre exibida pelo Inner. Essa
  mensagem é exibida enquanto o Inner estiver ocioso. Caso a mensagem passe de 32 caracteres a DLL
  irá utilizar os primeiros 32 caracteres.
  O Inner não aceita caracteres com acentuação, padrão UNICODE ou padrão ANSI.
  O Inner aceita apenas os caracteres do padrão ASCII.
  Inner
      1 a 32 – Para comunicação serial.
      1 a 99 – Para comunicação TCP/IP com porta variável.
      1 a ... – Para comunicação TCP/IP porta fixa.
  ExibirData
      0 – Não exibe a data/hora na linha superior do display.
      1 – Exibe a data/hora na linha superior do display.
  Mensagem - String com a mensagem a ser exibida. Caso esteja
  exibindo a data/hora o tamanho da mensagem passa a ser
  16 ao invés de 32. Caso seja passado uma string vazia o
  Inner exibirá a mensagem em branco no display.      }

  Function EnviarFormasEntradasOnLine( Inner:Integer;QtdeDigitosTeclado,EcoTeclado,FormaEntrada,TempoTeclado,PosicaoCursorTeclado:Byte):Byte; stdcall; external 'EasyInner.dll';
  {Configura as formas de entrada de dados do Inner no modo OnLine. Cada vez que alguma
  informação for recebida no modo OnLine através da função ReceberDadosOnLine, a função
  EnviarFormasEntradasOnLine deverá ser chamada novamente para reconfigurar o Inner.
  Inner
      1 a 32 – Para comunicação serial.
      1 a 99 – Para comunicação TCP/IP com porta variável.
      1 a ... – Para comunicação TCP/IP porta fixa.
  QtdeDigitosTeclado - 0 a 20 dígitos.
  EcoTeclado
      0 – para não
      1 – para sim
      2 – ecoar *
  FormaEntrada
      0 – não aceita entrada de dados
      1 – aceita teclado
      2 – aceita leitura no leitor 1
      3 – aceita leitura no leitor 2
      4 – teclado e leitor 1
      5 – teclado e leitor 2
      6 – leitor 1 e leitor 2
      7 – teclado, leitor 1 e leitor 2
      10 – teclado + verificação biométrica
      11 – leitor1 + verificação biométrica
      12 – teclado + leitor1 + verificação biométrica
      13 – leitor1 com verificação biométrica + leitor2 sem verificação biométrica
      14 – leitor1 com verificação biométrica + leitor2 sem verificação biométrica + teclado sem verificação biométrica
      100 – Leitor 1 + Identificação Biométrica (sem Verificação)
      101 – Leitor 1 + Teclado + Identificação Biométrica (sem Verificação)
      102 – Leitor 1 + Leitor 2 + Identificação Biométrica (sem Verificação)
      103 – Leitor 1 + Leitor 2 + Teclado + Identificação Biométrica (sem Verificação)
      104 – Leitor 1 invertido + Identificação Biométrica (sem Verificação)
      105 – Leitor 1 invertido + Teclado + Identificação Biométrica (sem Verificação)
  TempoTeclado - 1 a 50
  PosicaoCursorTeclado - 1 a 32   }

  Function ReceberDadosOnLine( Inner:Integer; Origem, Complemento: Pointer; Cartao: PChar; Dia, Mes, Ano, Hora, Minuto, Segundo:Pointer):Byte; stdcall; external 'EasyInner.dll';
  {Coleta um bilhete OnLine, caso o usuário tenha passado ou digitado algum cartão no Inner
  retorna as informações do cartão nos parâmetros da função. Para que a data/hora do bilhete OnLine seja
  retornada, o Inner deverá ter sido previamente configurado através da função
  ReceberDataHoraDadosOnLine.
  Inner
      1 a 32 – Para comunicação serial.
      1 a 99 – Para comunicação TCP/IP com porta variável.
      1 a ... – Para comunicação TCP/IP porta fixa.
  Origem - Origem dos dados recebidos.
      1 – via teclado
      2 – via leitor 1
      3 – via leitor 2
      4 – sensor da catraca(obsoleto)
      5 – fim do tempo de acionamento
      6 – giro da catraca Topdata (sensor ótico)
      7 – Urna (catraca Millenium)
      8 – Evento no Sensor 1
      9 – Evento no Sensor 2
      10 – Evento no Sensor 3
  Complemento - Informações adicionais sobre os dados recebidos.
      0 – saída (com cartão)
      1 – entrada (com cartão)
      35 – # via teclado (1° tecla)
      42 – * via teclado (1° tecla)
      65 – “Função” via teclado
      66 – “Entrada” via teclado
      67 – “Saída” via teclado
      255 – Inseriu todos os dígitos permitidos pelo teclado.
  Evento do Sensor
      0/1 – Nível atual do sensor
  Cartao">Número do cartão recebido.
  Dia - 1 a 31.
  Mes - 1 a 12.
  Ano - 0 a 99
  Hora - 0 a 23
  Minuto - 0 a 59
  Segundo - 0 a 59    }

  Function DefinirEntradasMudancaOnLine( Entrada:Byte):Byte; stdcall; external 'EasyInner.dll';
  {Configura as formas de entrada dos dados quando o Inner voltar para o modo On Line após
  uma queda para OffLine.
  Entrada
      0 – Não aceita entrada de dados.
      1 – Aceita teclado.
      2 – Aceita leitor 1.
      3 – Aceita leitor 2.
      4 – Teclado e leitor 1.
      5 – Teclado e leitor 2.
      6 – Leitor 1 e leitor 2.
      7 – Teclado, leitor 1 e 2.
      8 – Sensor da catraca.   }

  Function DefinirConfiguracaoTecladoOnLine( Digitos, EcoDisplay, Tempo, PosicaoCursor:Byte):Byte; stdcall; external 'EasyInner.dll';
  {Configura o teclado para quando o Inner voltar para OnLine após uma queda para OffLine.
  Digitos
      0 a 20 dígitos.
  EcoDisplay
      0 – para não ecoar
      1 – para sim
      2 – ecoar '*'
  Tempo - 1 a 50.
  PosicaoCursor - 1 a 32.  }

  Function SolicitarModeloBio( Inner:Integer):Byte; stdcall; external 'EasyInner.dll';
  {Solicita o modelo do Inner bio. Para receber o resultado dessa operação você deverá chamar
  a função ReceberModeloBio enquanto o retorno for processando a operação.
  Inner
      1 a 32 – Para comunicação serial.
      1 a 99 – Para comunicação TCP/IP com porta variável.
      1 a ... – Para comunicação TCP/IP porta fixa.  }

  Function ReceberModeloBio( Inner:Integer; OnLine:Byte; Modelo:Pointer):Byte; stdcall; external 'EasyInner.dll';
  {Retorna o resultado do comando SolicitarModeloBio, o modelo do Inner Bio é retornado por
  referência no parâmetro da função.
  Inner
      1 a 32 – Para comunicação serial.
      1 a 99 – Para comunicação TCP/IP com porta variável.
      1 a ... – Para comunicação TCP/IP porta fixa.
  OnLine
      0 – O comando foi utilizado com o Inner em OffLine.
      1 – O comando foi utilizado com o Inner em OnLine
  Modelo
      2 – Bio Light 100 usuários.
      4 – Bio 1000/4000 usuários.
      255 – Versão desconhecida.    }

  Function ReceberVersaoBio( Inner:Integer; OnLine:Byte; VersaoAlta, VersaoBaixa:Pointer):Byte; stdcall; external 'EasyInner.dll';
  {Retorna o resultado do comando SolicitarVersaoBio, a versão do Inner Bio é retornado por
  referência nos parâmetros da função.
  Inner
      1 a 32 – Para comunicação serial.
      1 a 99 – Para comunicação TCP/IP com porta variável.
      1 a ... – Para comunicação TCP/IP porta fixa.
  OnLine
      0 – O comando foi utilizado com o Inner em OffLine.
      1 – O comando foi utilizado com o Inner em OnLine
  VersaoAlta - Parte alta da versão.
  VersaoBaixa - Parte baixa da versão.  }

  Function InserirUsuarioListaAcesso( Cartao:String;  Horario:Byte):Byte; stdcall; external 'EasyInner.dll';
  {Insere no buffer da dll um usuário da lista e a qual horário de acesso ele está associado. Os
  horários já deverão ter sido cadastrados através das funções InserirHorarioAcesso e enviados através
  da função EnviarHorariosAcesso para a lista ter o efeito correto.
  Cartao - 1 a ... – Dependo do padrão de cartão definido e da quantidade de dígitos definida.
  Horario - 1 a 100 – Número do horário já cadastrado no Inner.
  101 – Acesso sempre liberado para o usuário.
  102 – Acesso sempre negado para o usuário.    }

  Function InserirHorarioAcesso( Horario,DiaSemana,FaixaDia,Hora,Minuto:Byte):Byte; stdcall; external 'EasyInner.dll';
  {Insere no buffer da dll um horário de acesso. O Inner possui uma tabela de 100 horários de
  acesso, para cada horário é possível definir 4 faixas de acesso para cada dia da semana.
  Horario - 1 a 100 – Número da tabela de horários.
  DiaSemana - 1 a 7 – Dia da semana a qual pertence a faixa de horário.
  FaixaDia - 1 a 4 – Para cada dia da semana existem 4 faixas de horário.
  Hora - 0 a 23
  Minuto - 0 a 59     }

  Function ApagarListaAcesso( Inner:Integer):Byte; stdcall; external 'EasyInner.dll';
  {Limpar o buffer com a lista de usuários cadastrados e envia automaticamente para o Inner.
  Inner
      1 a 32 – Para comunicação serial.
      1 a 99 – Para comunicação TCP/IP com porta variável.
      1 a ... – Para comunicação TCP/IP porta fixa. }

  Function EnviarListaAcesso( Inner:Integer):Byte; stdcall; external 'EasyInner.dll';
  {Envia o buffer com os usuários da lista de acesso para o Inner, após executar o comando o
  buffer é limpo pela dll automaticamente.
  Inner
      1 a 32 – Para comunicação serial.
      1 a 99 – Para comunicação TCP/IP com porta variável.
      1 a ... – Para comunicação TCP/IP porta fixa.  }

  Function ApagarHorariosAcesso( Inner:Integer):Byte; stdcall; external 'EasyInner.dll';
  {Apaga o buffer com a lista de horários de acesso e envia automaticamente para o Inner.
  Inner
      1 a 32 – Para comunicação serial.
      1 a 99 – Para comunicação TCP/IP com porta variável.
      1 a ... – Para comunicação TCP/IP porta fixa.  }

  Function EnviarHorariosAcesso( Inner:Integer):Byte; stdcall; external 'EasyInner.dll';
  {Envia para o Inner o buffer com a lista de horários de acesso, após executar o comando o
  buffer é limpo pela dll automaticamente.
  Inner
      1 a 32 – Para comunicação serial.
      1 a 99 – Para comunicação TCP/IP com porta variável.
      1 a ... – Para comunicação TCP/IP porta fixa. }

  Function DefinirTipoListaAcesso( Tipo:Byte):Byte; stdcall; external 'EasyInner.dll';
  {Define qual tipo de lista(controle) de acesso o Inner vai utilizar. Após habilitar a lista de
  acesso é necessário preencher a lista e os horários de acesso, verificar os as funções de “Horários de
  Acesso” e as funções da “Lista de Acesso”.
  Tipo
      0 – Não utilizar a lista de acesso.
      1 – Utilizar lista branca(cartões fora da lista tem o acesso negado).
      2 – Utilizar lista negra(bloqueia apenas os cartões da lista). }

  Function EnviarListaUsuariosSemDigitalBio( Inner:Integer):Byte; stdcall; external 'EasyInner.dll';
  Function EnviarListaUsuariosSemDigitalBioVariavel(Inner:Integer; QtdDigitos: Integer):Byte; stdcall; external 'EasyInner.dll';

  {Envia o buffer com a lista de usuários sem digital para o Inner. Após a execução do
  comando, o buffer é limpo pela dll.
  Inner
      1 a 32 – Para comunicação serial.
      1 a 99 – Para comunicação TCP/IP com porta variável.
      1 a ... – Para comunicação TCP/IP porta fixa.      }
  Function EnviarListaUsuariosSemDigitalBioInnerAcesso( Inner:Integer):Byte; stdcall; external 'EasyInner.dll';

  Function SolicitarVersaoBio( Inner:Integer):Byte; stdcall; external 'EasyInner.dll';
  {Solicita a versão do firmware da placa do Inner Bio, a placa que armazena as digitais.
  Inner
      1 a 32 – Para comunicação serial.
      1 a 99 – Para comunicação TCP/IP com porta variável.
      1 a ... – Para comunicação TCP/IP porta fixa.     }

  Function IncluirUsuarioSemDigitalBio( Cartao:String):Byte; stdcall; external 'EasyInner.dll';
  {Insere o número do cartão na lista de usuários sem digital do Inner bio. Este número ficara
  armazenado em um buffer interno dentro da dll e somente será enviado para o Inner após a chamada a
  função EnviarListaUsuariosSemDigitalBio. O número máximo de dígitos para o cartão é 10, caso os
  cartões tenham mais de 10 dígitos, utilizar os 10 dígitos menos significativos do cartão.
  Cartao - 1 a 9999999999 – Número do cartão do usuário.     }
  Function IncluirUsuarioSemDigitalBioInnerAcesso( Cartao:AnsiString):Byte; stdcall; external 'EasyInner.dll';

  Function ConfigurarBio(Inner:Integer; HabilitaIdentificacao, HabilitaVerificacao:Byte):Byte; stdcall; external 'EasyInner.dll';
  {Habilita/Desabilita a identificação biométrica e/ou a verificação biométrica do Inner bio. O
  resultado da configuração deve ser obtivo através do comando ResultadoConfiguracaoBio.
  Inner
      1 a 32 – Para comunicação serial.
      1 a 99 – Para comunicação TCP/IP com porta variável.
      1 a ... – Para comunicação TCP/IP porta fixa.
  HabilitaIdentificacao
      0 – Desabilita.
      1 – Habilita.
  HabilitaVerificacao
      0 – Desabilita.
      1 – Habilita.                    }

  Function ResultadoConfiguracaoBio( Inner:Integer; OnLine:Byte):Byte; stdcall; external 'EasyInner.dll';
  {Retorna o resultado da configuração do Inner Bio, função ConfigurarBio. Se o retorno for
  igual a 0 é poque o Inner bio foi configurado com sucesso.
  Inner
      1 a 32 – Para comunicação serial.
      1 a 99 – Para comunicação TCP/IP com porta variável.
      1 a ... – Para comunicação TCP/IP porta fixa.
  OnLine
      0 – O comando foi utilizado com o Inner em OffLine.
      1 – O comando foi utilizado com o Inner em OnLine.   }

  Function DefinirMensagemFuncaoOffLine( Mensagem:String;  Funcao,Habilitada:Byte):Byte; stdcall; external 'EasyInner.dll';
  {Configura a mensagem a ser exibida quando o usuário passar o cartão utilizando uma das
  funções do Inner(de 0 a 9) e a habilita ou desabilita essas funções. Caso a mensagem passe de 32
  caracteres a DLL irá utilizar os primeiros 32 caracteres.
  O Inner não aceita caracteres com acentuação, padrão UNICODE ou padrão ANSI.
  O Inner aceita apenas os caracteres do padrão ASCII.
  Mensagem
  String com a mensagem a ser exibida. Caso esteja
  exibindo a data/hora o tamanho da mensagem passa a ser
  16 ao invés de 32. Caso seja passado uma string vazia o
  Inner não exibirá a mensagem no display.
  Funcao - 0 a 9.
  Habilitada
      0 – Desabilita a função do Inner(Default).
      1 – Habilita a função do Inner.            }

  Function ReceberRelogio(Inner: Integer;
                        Dia, Mes, Ano, Hora,
                        Minuto, Segundo: Pointer):Byte; stdcall; external 'EasyInner.dll';
  {Solicita a data/hora atualmente configurada no Inner. Os dados são retornados por referência
  nos parâmetros da função.
  Inner
      1 a 32 – Para comunicação serial.
      1 a 99 – Para comunicação TCP/IP com porta variável.
      1 a ... – Para comunicação TCP/IP porta fixa.
  Dia - 1 a 31
  Mes - 1 a 12
  Ano - 0 a 99
  Hora - 0 a 23
  Minuto - 0 a 59
  Segundo - 0 a 59                             }

  Function SolicitarQuantidadeUsuariosBio( Inner:Integer):Byte; stdcall; external 'EasyInner.dll';
  //Solicita a quantidade de usuários cadastrados no Inner Bio.

  Function ReceberQuantidadeUsuariosBio( Inner:Integer;  OnLine:Byte; Quantidade:Pointer):Byte; stdcall; external 'EasyInner.dll';
  {Retorna o resultado do comando SolicitarQuantidadeUsuariosBio, a quantidade de
    usuários cadastrados no Inner Bio é retornado por referência nos parâmetros da função.
    Inner:
         1 a 32 – Para comunicação serial.
         1 a 99 – Para comunicação TCP/IP com porta variável.
         1 a ... – Para comunicação TCP/IP porta fixa.
    OnLine:
         0 – O comando foi utilizado com o Inner em OffLine.
         1 – O comando foi utilizado com o Inner em OnLine
    Quantidade - Total de usuários cadastrados no Inner Bio.}

  Procedure InicializarColetaListaUsuariosBio(); stdcall; external 'EasyInner.dll';
  {Prepara a dll para iniciar a coleta dos usuários do Inner bio, essa função deve ser chamada
    obrigatoriamente no início do processo.}

  Function TemProximoPacote():Integer; stdcall; external 'EasyInner.dll';
  //Retorna 1 se ainda existe mais pacotes da lista de usuários, a ser recebido do Inner Bio.

  Function SolicitarListaUsuariosBio( Inner:Integer):Byte; stdcall; external 'EasyInner.dll';
  {Solicita o pacote(a parte) atual da lista de usuários do Inner bio.
    Inner:
         1 a 32 – Para comunicação serial.
         1 a 99 – Para comunicação TCP/IP com porta variável.
         1 a ... – Para comunicação TCP/IP porta fixa.}

  Function ReceberPacoteListaUsuariosBio( Inner:Integer):Byte; stdcall; external 'EasyInner.dll';
  {Receber o pacote solicitado pela função SolicitarListaUsuariosBio.
    Inner:
         1 a 32 – Para comunicação serial.
         1 a 99 – Para comunicação TCP/IP com porta variável.
         1 a ... – Para comunicação TCP/IP porta fixa.}

  Function TemProximoUsuario():Integer; stdcall; external 'EasyInner.dll';
  //Retorna 1 se ainda existe usuários no pacote recebido da lista.

  Function ReceberUsuarioLista( Inner:Integer; Usuario:Pointer):Byte; stdcall; external 'EasyInner.dll';
  {Recebe um usuário por vez do pacote recebido anteriormente. O número do usuário é
    retornado pelo parâmetro da função.
    Inner:
         1 a 32 – Para comunicação serial.
         1 a 99 – Para comunicação TCP/IP com porta variável.
         1 a ... – Para comunicação TCP/IP porta fixa.
    Usuario - Número do cartão do usuário cadastrado.}

  Function SolicitarExclusaoUsuario( Inner:Integer;  Usuario:AnsiString):Byte; stdcall; external 'EasyInner.dll';
  {Solicita para o Inner bio excluir o cadastro do usuário desejado. O Retorno da exclusão é
    verificado através da função UsuarioFoiExcluido
    Inner:
         1 a 32 – Para comunicação serial.
         1 a 99 – Para comunicação TCP/IP com porta variável.
         1 a ... – Para comunicação TCP/IP porta fixa.
    Usuario - Número do cartão do usuário cadastrado.}

  Function UsuarioFoiExcluido( Inner:Integer;  OnLine:Byte):Byte; stdcall; external 'EasyInner.dll';
  {Retorna o resultado do comando SolicitarExclusaoUsuario, se o retorno da função for igual
    a 0 é porque o usuário foi excluído com sucesso.
    Inner:
         1 a 32 – Para comunicação serial.
         1 a 99 – Para comunicação TCP/IP com porta variável.
         1 a ... – Para comunicação TCP/IP porta fixa.
    OnLine:
         0 – O comando foi utilizado com o Inner em OffLine.
         1 – O comando foi utilizado com o Inner em OnLine.}

  Function SolicitarUsuarioCadastradoBio( Inner:Integer;  Usuario:String):Byte; stdcall; external 'EasyInner.dll';
  {Solicita do Inner Bio, o template com as duas digitais do Usuario desejado.
    Inner:
         1 a 32 – Para comunicação serial.
         1 a 99 – Para comunicação TCP/IP com porta variável.
         1 a ... – Para comunicação TCP/IP porta fixa.
    Usuario - Número do cartão do usuário cadastrado.}

  Function ReceberUsuarioCadastradoBio( Inner:Integer; OnLine:Byte;  Template:Pointer):Byte; stdcall; external 'EasyInner.dll';
  {Retorna o resultado do comando SolicitarUsuarioCadastradoBio e o template com as duas
    digitais do usuário cadastrado no Inner Bio. O template é retornado por referência nos parâmetros da
    função.
    Inner:
         1 a 32 – Para comunicação serial.
         1 a 99 – Para comunicação TCP/IP com porta variável.
         1 a ... – Para comunicação TCP/IP porta fixa.
    OnLine:
         0 – O comando foi utilizado com o Inner em OffLine.
         1 – O comando foi utilizado com o Inner em OnLine
    Template: Cadastro do usuário com as duas digitais, o dado está em binário e não
    deve ser alterado nunca. O tamanho do template é de 844 bytes.}

  Function SolicitarTemplateLeitor( Inner:Integer):Byte; stdcall; external 'EasyInner.dll';
  {Solicita diretamente do Inner bio um template com apenas uma digital, ao executar essa
    função o leitor biométrico do Inner bio irá acender e a digital que for inserida será enviada diretamente
    para a aplicação, a digital não ficará armazenada no banco de dado do equipamento.
    Para receber a digital é necessário chamar a função ReceberTemplateLeitor.
    Inner:
         1 a 32 – Para comunicação serial.
         1 a 99 – Para comunicação TCP/IP com porta variável.
         1 a ... – Para comunicação TCP/IP porta fixa.  }

  Function ReceberTemplateLeitor( Inner:Integer; OnLine:Byte; Template:Pointer):Byte; stdcall; external 'EasyInner.dll';
  {Retorna o resultado do comando SolicitarTemplateLeitor. Se o retorno for igual a 0 é
    porque o template foi recebido com sucesso. O template será retornado por referência no parâmetro da função.
    Inner:
         1 a 32 – Para comunicação serial.
         1 a 99 – Para comunicação TCP/IP com porta variável.
         1 a ... – Para comunicação TCP/IP porta fixa.
    OnLine:
         0 – O comando foi utilizado com o Inner em OffLine.
         1 – O comando foi utilizado com o Inner em OnLine.
    Template: Digital recebida pelo leitor biométrico. É um array de bytes e seu conteúdo
    não deve ser alterado nunca, seu tamanho é de 404 bytes.}

  Function EnviarUsuarioBio( Inner:Integer; Template:Pointer):Byte; stdcall; external 'EasyInner.dll';
  {Envia um template com duas digitais para o Inner Bio cadastrar no seu banco de dados. O
    resultado do cadastro deve ser verificado no retorno da função UsuarioFoiEnviado.
    Inner:
         1 a 32 – Para comunicação serial.
         1 a 99 – Para comunicação TCP/IP com porta variável.
         1 a ... – Para comunicação TCP/IP porta fixa.
    Template: O cadastro do usuário já contendo as duas digitais e o número do usuário.
    É um array de bytes com o tamanho de 844 bytes.}

  Function UsuarioFoiEnviado( Inner:Integer; OnLine:Byte):Byte; stdcall; external 'EasyInner.dll';
  {Retorna o resultado do cadastro do Template no Inner Bio, através da função
    EnviarUsuarioBio. Se o retorno for igual a 0 é porque o template foi cadastrado com sucesso.
    Inner:
         1 a 32 – Para comunicação serial.
         1 a 99 – Para comunicação TCP/IP com porta variável.
         1 a ... – Para comunicação TCP/IP porta fixa.
    OnLine:
         0 – O comando foi utilizado com o Inner em OffLine.
         1 – O comando foi utilizado com o Inner em OnLine.}

  Function CompararDigitalLeitor( Inner:Integer; Template:Pointer):Byte; stdcall; external 'EasyInner.dll';
  {Ao executar essa função o Inner bio irá acender o leitor biométrico solicitando a digital do
    usuário, na sequência irá comparar a digital inserida pelo usuário com a digital enviada pela função no
    parâmetro Template. O resultado da comparação é retornado pela função ResultadoComparacaoDigitalLeitor.
    Inner:
         1 a 32 – Para comunicação serial.
         1 a 99 – Para comunicação TCP/IP com porta variável.
         1 a ... – Para comunicação TCP/IP porta fixa.
    Template: Digital a ser comparada. Array de bytes de 404 bytes.}

  Function ResultadoComparacaoDigitalLeitor( Inner:Integer;  OnLine:Byte):Byte; stdcall; external 'EasyInner.dll';
  {Retorna o resultado da comparação da digital do usuário com o template enviado para o
  Inner Bio, através da função CompararDigitalLeitor. Se o retorno for igual a 0 é poque a digital inserida
    é a mesma da enviada.
    Inner:
         1 a 32 – Para comunicação serial.
         1 a 99 – Para comunicação TCP/IP com porta variável.
         1 a ... – Para comunicação TCP/IP porta fixa.
    OnLine:
         0 – O comando foi utilizado com o Inner em OffLine.
         1 – O comando foi utilizado com o Inner em OnLine.}

  Function InserirUsuarioLeitorBio( Inner:Integer; Tipo:Byte; Usuario:String):Byte; stdcall; external 'EasyInner.dll';
  {Solicita para o Inner Bio inserir um usuário diretamente pelo leitor biométrico. O leitor irá
    acender a luz vermelho e após o usuário inserir a digital, automaticamente o usuário será cadastrado no
    nner bio com o número do cartão passado no parâmetro Usuário.
    Inner:
         1 a 32 – Para comunicação serial.
         1 a 99 – Para comunicação TCP/IP com porta variável.
         1 a ... – Para comunicação TCP/IP porta fixa.
    Tipo:
         0 – para solicitar o primeiro template
         1 – para solicitar o segundo template (mesmo dedo) e salvar.
         2 – para solicitar o segundo template (outro dedo) e salvar.
    Usuario - Número do cartão que o usuário terá.}

  Function ResultadoInsercaoUsuarioLeitorBio( Inner:Integer; OnLine:Byte):Byte; stdcall; external 'EasyInner.dll';
  {Retorna o resultado do comando InserirUsuarioLeitorBio. Se o retorno for igual a 0 é
    porque o usuário foi cadastrado com sucesso.
    Inner:
         1 a 32 – Para comunicação serial.
         1 a 99 – Para comunicação TCP/IP com porta variável.
         1 a ... – Para comunicação TCP/IP porta fixa.
    OnLine:
         0 – O comando foi utilizado com o Inner em OffLine.
         1 – O comando foi utilizado com o Inner em OnLine.}

  Procedure SetarBioLight(Light: Integer); stdcall; external 'EasyInner.dll';
  {Define que o Inner utilizado no momento é um Inner bio light ao invés de um Inner bio
    1000/4000. Essa função deverá ser chamada sempre que necessário antes das funções
    SolicitarUsuarioCadastradoBio, SolicitarExclusaoUsuario, InserirUsuarioLeitorBio e
    FazerVerificacaoBiometricaBio.
    Light:
      1 – É um Inner bio light
      0 – É um Inner bio 1000/4000(valor default)}

  Procedure ConfigurarBioVariavel(valor: Integer); stdcall; external 'EasyInner.dll';

  Function GetTickCount(): longint; stdcall; external 'kernel32.dll';
  //Método que retorna os segundos do Sistema.

  Procedure Sleep(ms: longint); stdcall; external 'kernel32.dll';

implementation

end.
