object FrmPrincipal: TFrmPrincipal
  Left = 0
  Top = 0
  Caption = 'Menu principal'
  ClientHeight = 544
  ClientWidth = 959
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = menuPrincipal
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object menuPrincipal: TMainMenu
    Left = 40
    Top = 48
    object menuItemConfiguracoes: TMenuItem
      Caption = 'Configurar'
      OnClick = menuItemConfiguracoesClick
    end
  end
end
