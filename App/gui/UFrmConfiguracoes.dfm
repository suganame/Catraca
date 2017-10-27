object FrmConfiguracoes: TFrmConfiguracoes
  Left = 0
  Top = 0
  Caption = 'Configura'#231#245'es'
  ClientHeight = 403
  ClientWidth = 761
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object GbConexao: TGroupBox
    Left = 8
    Top = 8
    Width = 297
    Height = 105
    Caption = 'Conex'#227'o'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Trebuchet MS'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object LblNumInner: TLabel
      Left = 12
      Top = 23
      Width = 102
      Height = 18
      Caption = 'N'#250'mero do Inner:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Trebuchet MS'
      Font.Style = []
      ParentFont = False
    end
    object LblPorta: TLabel
      Left = 74
      Top = 55
      Width = 40
      Height = 18
      Caption = 'Porta: '
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Trebuchet MS'
      Font.Style = []
      ParentFont = False
    end
    object EdtNumInner: TEdit
      Left = 120
      Top = 21
      Width = 161
      Height = 26
      TabOrder = 0
    end
    object EdtPorta: TEdit
      Left = 120
      Top = 53
      Width = 161
      Height = 26
      TabOrder = 1
    end
  end
  object GbCartao: TGroupBox
    Left = 327
    Top = 8
    Width = 297
    Height = 105
    Caption = 'Cart'#227'o: '
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Trebuchet MS'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object LblPadraoCartao: TLabel
      Left = 12
      Top = 23
      Width = 104
      Height = 18
      Caption = 'Padr'#227'o do cart'#227'o:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Trebuchet MS'
      Font.Style = []
      ParentFont = False
    end
    object LblQtdDigitoCartao: TLabel
      Left = 20
      Top = 55
      Width = 94
      Height = 18
      Caption = 'Qtd. de D'#237'gitos:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Trebuchet MS'
      Font.Style = []
      ParentFont = False
    end
    object EdtQtdDigitosCartao: TEdit
      Left = 120
      Top = 53
      Width = 161
      Height = 26
      TabOrder = 0
    end
    object CbxPadraoCartao: TComboBox
      Left = 120
      Top = 21
      Width = 161
      Height = 26
      TabOrder = 1
      Items.Strings = (
        'Padr'#227'o TopData'
        'Padr'#227'o Livre')
    end
  end
end
