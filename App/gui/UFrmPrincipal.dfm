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
    Caption = 'Iniciar'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 432
    Top = 184
    Width = 75
    Height = 25
    Caption = 'Parar'
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
  object Button4: TButton
    Left = 432
    Top = 8
    Width = 145
    Height = 25
    Caption = 'Conectar com o banco'
    TabOrder = 3
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 536
    Top = 39
    Width = 99
    Height = 25
    Caption = 'Executar select'
    TabOrder = 4
    OnClick = Button5Click
  end
  object MenuPrincipal: TMainMenu
    Left = 40
    Top = 24
    object TMenuItem
    end
    object MenuItemConfiguracoes: TMenuItem
      Caption = 'Configurar'
      OnClick = MenuItemConfiguracoesClick
    end
    object TMenuItem
    end
  end
  object QryPrincipal: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQLConnection = ScnBanco
    Left = 488
    Top = 40
  end
  object ScnBanco: TSQLConnection
    Left = 424
    Top = 40
  end
end
