object FrmPrincipal: TFrmPrincipal
  Left = 0
  Top = 0
  Anchors = [akLeft, akTop, akRight, akBottom]
  Caption = 'Catraca'
  ClientHeight = 390
  ClientWidth = 730
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MenuPrincipal
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object MenuPrincipal: TMainMenu
    Left = 304
    Top = 224
    object MenuItemTelaPrincipal: TMenuItem
      Caption = 'Catraca'
      OnClick = MenuItemTelaPrincipalClick
    end
    object MenuItemConfiguracoes: TMenuItem
      Caption = 'Configurar'
      OnClick = MenuItemConfiguracoesClick
    end
    object TMenuItem
    end
  end
end
