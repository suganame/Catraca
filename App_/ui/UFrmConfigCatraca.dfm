object FrmConfigurarCatraca: TFrmConfigurarCatraca
  Left = 0
  Top = 0
  Caption = 'Configurar Catraca'
  ClientHeight = 407
  ClientWidth = 646
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object gpbConexao: TGroupBox
    Left = 8
    Top = 8
    Width = 305
    Height = 113
    Caption = 'Conex'#227'o'
    TabOrder = 0
    DesignSize = (
      305
      113)
    object lblTipoConexao: TLabel
      Left = 21
      Top = 51
      Width = 83
      Height = 13
      Caption = 'Tipo de conex'#227'o:'
    end
    object lblPorta: TLabel
      Left = 74
      Top = 78
      Width = 30
      Height = 13
      Caption = 'Porta:'
    end
    object lblCodCatraca: TLabel
      Left = 13
      Top = 24
      Width = 91
      Height = 13
      Caption = 'Codigo da catraca:'
    end
    object cbxTipoConexao: TComboBox
      Left = 110
      Top = 48
      Width = 179
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
      ExplicitWidth = 123
    end
    object edtPorta: TEdit
      Left = 110
      Top = 75
      Width = 51
      Height = 21
      TabOrder = 1
    end
    object edtCodCatraca: TEdit
      Left = 110
      Top = 21
      Width = 51
      Height = 21
      TabOrder = 2
    end
  end
  object gbpPadraoCartao: TGroupBox
    Left = 319
    Top = 8
    Width = 316
    Height = 113
    Caption = 'Cart'#227'o'
    TabOrder = 1
    object lblPadraoCartao: TLabel
      Left = 19
      Top = 24
      Width = 87
      Height = 13
      Caption = 'Padr'#227'o do cart'#227'o:'
    end
    object lblNumeroDigitos: TLabel
      Left = 16
      Top = 51
      Width = 90
      Height = 13
      Caption = 'N'#250'mero de d'#237'gitos:'
    end
    object cbxPadraoCartao: TComboBox
      Left = 112
      Top = 21
      Width = 164
      Height = 21
      TabOrder = 0
    end
    object edtNumeroDigitos: TEdit
      Left = 112
      Top = 48
      Width = 161
      Height = 21
      TabOrder = 1
    end
  end
  object Button1: TButton
    Left = 416
    Top = 256
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 2
    OnClick = Button1Click
  end
end
