unit Bilhete;

interface
type
  TitleArr = array[0..15] of char;
  TBilhete = class(TObject)
  private

  protected
    FTipo         : Byte;
    FDia          : Byte;
    FMes          : Byte;
    FAno          : Byte;
    FHora         : Byte;
    FMinuto       : Byte;
    FSegundo      : Byte;
    FOrigem       : Byte;
    FComplemento  : Byte;
    FCartao       : TitleArr;


  public
    property Tipo: Byte read FTipo write FTipo;
    property Dia: Byte read FDia write FDia;
    property Mes: Byte read FMes write FMes;
    property Ano: Byte read FAno write FAno;
    property Hora: Byte read FHora write FHora;
    property Minuto: Byte read FMinuto write FMinuto;
    property Segundo: Byte read FSegundo write FSegundo;
    property Cartao: TitleArr read FCartao write FCartao;
    property Origem: Byte read FOrigem write FOrigem;
    property Complemento: Byte read FComplemento write FComplemento;
  end;

implementation

end.
