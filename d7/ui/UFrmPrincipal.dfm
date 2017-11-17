object FrmPrincipal: TFrmPrincipal
  Left = 292
  Top = 123
  Width = 706
  Height = 541
  Caption = 'Catraca'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MenuPrincipal
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object MenuPrincipal: TMainMenu
    Left = 152
    Top = 152
    object MenuCatraca: TMenuItem
      Caption = 'Catraca'
      OnClick = MenuCatracaClick
    end
    object MenuConfiguracoes: TMenuItem
      Caption = 'Configura'#231#245'es'
      OnClick = MenuConfiguracoesClick
    end
  end
end
