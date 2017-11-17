object FrmConfiguracoes: TFrmConfiguracoes
  Left = 296
  Top = 173
  Width = 766
  Height = 675
  Caption = 'Configura'#231#245'es'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  DesignSize = (
    758
    648)
  PixelsPerInch = 96
  TextHeight = 13
  object gbInner: TGroupBox
    Left = 16
    Top = 16
    Width = 721
    Height = 217
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Catraca'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Trebuchet MS'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      721
      217)
    object gbConexao: TGroupBox
      Left = 16
      Top = 24
      Width = 313
      Height = 105
      Caption = 'Conex'#227'o'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Trebuchet MS'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object lblNumInner: TLabel
        Left = 16
        Top = 25
        Width = 102
        Height = 18
        Caption = 'N'#250'mero do inner:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Trebuchet MS'
        Font.Style = []
        ParentFont = False
      end
      object lblPorta: TLabel
        Left = 80
        Top = 60
        Width = 36
        Height = 18
        Caption = 'Porta:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Trebuchet MS'
        Font.Style = []
        ParentFont = False
      end
      object edtNumInner: TEdit
        Left = 128
        Top = 20
        Width = 121
        Height = 28
        TabOrder = 0
      end
      object edtPorta: TEdit
        Left = 128
        Top = 56
        Width = 121
        Height = 28
        TabOrder = 1
      end
    end
    object gbCartao: TGroupBox
      Left = 344
      Top = 23
      Width = 361
      Height = 107
      Anchors = [akLeft, akTop, akRight]
      Caption = 'Cart'#227'o'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Trebuchet MS'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      object lblPadraoCartao: TLabel
        Left = 16
        Top = 25
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
      object lblQtdDigitos: TLabel
        Left = 24
        Top = 61
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
      object edtQtdDigitos: TEdit
        Left = 128
        Top = 56
        Width = 201
        Height = 28
        TabOrder = 0
      end
      object cbxPadraoCartao: TComboBox
        Left = 128
        Top = 19
        Width = 201
        Height = 28
        ItemHeight = 20
        TabOrder = 1
        Text = 'cbxPadraoCartao'
      end
    end
    object gbLadoCatraca: TGroupBox
      Left = 16
      Top = 136
      Width = 217
      Height = 57
      Caption = 'Lado da catraca'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Trebuchet MS'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      object rdbEsquerdo: TRadioButton
        Left = 24
        Top = 26
        Width = 113
        Height = 17
        Caption = 'Esquerdo'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Trebuchet MS'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object rdbDireito: TRadioButton
        Left = 136
        Top = 26
        Width = 65
        Height = 17
        Caption = 'Direito'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Trebuchet MS'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
    end
    object gbTeclado: TGroupBox
      Left = 248
      Top = 136
      Width = 257
      Height = 57
      Caption = 'Teclado'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Trebuchet MS'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      object rdbHabilitado: TRadioButton
        Left = 24
        Top = 26
        Width = 113
        Height = 17
        Caption = 'Habilitado'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Trebuchet MS'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object rdbDesabilitado: TRadioButton
        Left = 120
        Top = 26
        Width = 97
        Height = 17
        Caption = 'Desabilitado'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Trebuchet MS'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
    end
    object btnTestarConexao: TButton
      Left = 574
      Top = 154
      Width = 131
      Height = 39
      Caption = 'Testar Conex'#227'o'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Trebuchet MS'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
  end
  object gbBanco: TGroupBox
    Left = 16
    Top = 256
    Width = 721
    Height = 73
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Banco de dados'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Trebuchet MS'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      721
      73)
    object lblCaminhoBanco: TLabel
      Left = 16
      Top = 32
      Width = 112
      Height = 18
      Caption = 'Caminho do banco:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Trebuchet MS'
      Font.Style = []
      ParentFont = False
    end
    object edtCaminhoBanco: TEdit
      Left = 136
      Top = 27
      Width = 564
      Height = 28
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
    end
  end
  object gbImagens: TGroupBox
    Left = 16
    Top = 352
    Width = 721
    Height = 73
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Imagens'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Trebuchet MS'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    DesignSize = (
      721
      73)
    object lblCaminhoFotos: TLabel
      Left = 16
      Top = 32
      Width = 114
      Height = 18
      Caption = 'Caminho das fotos:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Trebuchet MS'
      Font.Style = []
      ParentFont = False
    end
    object edtCaminhoFotos: TEdit
      Left = 136
      Top = 27
      Width = 564
      Height = 28
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
    end
  end
end
