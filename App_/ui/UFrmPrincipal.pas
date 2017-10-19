unit UFrmPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, UFrmConfigCatraca;

type
  TFrmPrincipal = class(TForm)
    menuPrincipal: TMainMenu;
    menuItemConfiguracoes: TMenuItem;
    procedure menuItemConfiguracoesClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.dfm}

procedure TFrmPrincipal.menuItemConfiguracoesClick(Sender: TObject);
begin
  Application.CreateForm(TFrmConfigurarCatraca, FrmConfigurarCatraca);
  FrmConfigurarCatraca.Show;
end;

end.
