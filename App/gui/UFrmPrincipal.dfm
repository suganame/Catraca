object FrmPrincipal: TFrmPrincipal
  Left = 0
  Top = 0
  Caption = 'Menu Principal'
  ClientHeight = 311
  ClientWidth = 643
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MenuPrincipal
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lblStatus: TLabel
    Left = 504
    Top = 237
    Width = 32
    Height = 13
    Caption = 'Offline'
  end
  object Button1: TButton
    Left = 328
    Top = 184
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 432
    Top = 184
    Width = 75
    Height = 25
    Caption = 'Button2'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 328
    Top = 232
    Width = 137
    Height = 25
    Caption = 'Habilitar Catraca'
    TabOrder = 2
  end
  object EdtCaminhoBanco: TEdit
    Left = 40
    Top = 186
    Width = 121
    Height = 21
    TabOrder = 3
  end
  object Button4: TButton
    Left = 56
    Top = 219
    Width = 75
    Height = 25
    Caption = 'Button4'
    TabOrder = 4
  end
  object MenuPrincipal: TMainMenu
    Left = 184
    Top = 64
    object TMenuItem
    end
    object MenuItemConfiguracoes: TMenuItem
      Caption = 'Configurar'
      OnClick = MenuItemConfiguracoesClick
    end
    object TMenuItem
    end
  end
end
