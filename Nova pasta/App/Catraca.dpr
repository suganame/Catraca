program Catraca;

uses
  Vcl.Forms,
  UFrmCatraca in 'gui\UFrmCatraca.pas' {FrmCatraca},
  UFuncoes in 'utilidades\UFuncoes.pas',
  UConstantes in 'utilidades\UConstantes.pas',
  UFrmConfiguracoes in 'gui\UFrmConfiguracoes.pas' {FrmConfiguracoes},
  Bilhete in 'objetos\Bilhete.pas',
  UFrmPrincipal in 'gui\UFrmPrincipal.pas' {FrmPrincipal};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.Run;
end.
