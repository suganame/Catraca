unit UFrmPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, UFrmCatraca, UFrmConfiguracoes;

type
  TFrmPrincipal = class(TForm)
    MenuPrincipal: TMainMenu;
    MenuCatraca: TMenuItem;
    MenuConfiguracoes: TMenuItem;
    procedure MenuCatracaClick(Sender: TObject);
    procedure MenuConfiguracoesClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.dfm}

procedure TFrmPrincipal.MenuCatracaClick(Sender: TObject);
begin
  Application.CreateForm(TFrmCatraca, FrmCatraca);
  FrmCatraca.Show();
end;

procedure TFrmPrincipal.MenuConfiguracoesClick(Sender: TObject);
begin
  Application.CreateForm(TFrmConfiguracoes, FrmConfiguracoes);
  FrmConfiguracoes.Show();
end;

end.
