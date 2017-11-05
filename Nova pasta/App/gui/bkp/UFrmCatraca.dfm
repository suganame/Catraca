object FrmCatraca: TFrmCatraca
  Left = 0
  Top = 0
  Anchors = [akLeft, akTop, akRight, akBottom]
  BorderStyle = bsNone
  Caption = 'Catraca'
  ClientHeight = 436
  ClientWidth = 738
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poDesigned
  WindowState = wsMaximized
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 32
    Top = 71
    Width = 185
    Height = 186
  end
  object PnStatusCatraca: TPanel
    Left = 0
    Top = 395
    Width = 738
    Height = 41
    Align = alBottom
    Color = clActiveCaption
    ParentBackground = False
    TabOrder = 0
    ExplicitLeft = -3
    ExplicitWidth = 741
    object LblStatus: TLabel
      Left = 380
      Top = 2
      Width = 186
      Height = 35
      Caption = 'N'#227'o conectado'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -27
      Font.Name = 'Trebuchet MS'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object TmrStatusCatraca: TTimer
    Interval = 300
    OnTimer = TmrStatusCatracaTimer
    Left = 8
    Top = 8
  end
end
