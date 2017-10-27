program Catraca;

uses
  Vcl.Forms,
  UFrmPrincipal in 'gui\UFrmPrincipal.pas' {FrmPrincipal},
  UFuncoes in 'utilidades\UFuncoes.pas',
  UConstantes in 'utilidades\UConstantes.pas',
  UFrmConfiguracoes in 'gui\UFrmConfiguracoes.pas' {FrmConfiguracoes},
  Bilhete in 'objetos\Bilhete.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.CreateForm(TFrmConfiguracoes, FrmConfiguracoes);
  Application.Run;
end.
