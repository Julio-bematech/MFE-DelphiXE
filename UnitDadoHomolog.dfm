object FormDadoHomolog: TFormDadoHomolog
  Left = 0
  Top = 0
  BorderStyle = bsSizeToolWin
  Caption = 'Dados de Homologa'#231#227'o MFE '
  ClientHeight = 345
  ClientWidth = 447
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 315
    Width = 134
    Height = 13
    Caption = 'Bematech Hardware Ltda '#174
  end
  object Label2: TLabel
    Left = 12
    Top = 126
    Width = 67
    Height = 13
    Caption = 'Dados no XML'
  end
  object Memo: TMemo
    Left = 8
    Top = 8
    Width = 431
    Height = 113
    Color = clGradientInactiveCaption
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    Lines.Strings = (
      'Dados Software House'
      'CNPJ: 16716114000172'
      'Assinatura: SGR-SAT SISTEMA DE GESTAO E RETAGUARDA DO SAT'
      ''
      'Dados Emitente'
      'CNPJ: 08723218000186'
      'IE: 562377111111')
    ParentFont = False
    ReadOnly = True
    TabOrder = 0
  end
  object Fechar: TButton
    Left = 248
    Top = 310
    Width = 191
    Height = 25
    Caption = 'Fechar'
    TabOrder = 1
    OnClick = FecharClick
  end
  object Memo2: TMemo
    Left = 8
    Top = 141
    Width = 431
    Height = 153
    Color = clCream
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clOlive
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Lines.Strings = (
      '<ide>'
      #9'<CNPJ>16716114000172</CNPJ>'
      #9'<signAC>SGR-SAT SISTEMA DE GESTAO E RETAGUARDA DO SAT</signAC>'
      #9'<numeroCaixa>123</numeroCaixa>'
      '</ide>'
      '<emit>'
      #9'<CNPJ>08723218000186</CNPJ>'
      #9'<IE>562377111111</IE>'
      #9'<IM>123123</IM>'
      #9'<indRatISSQN>N</indRatISSQN>'
      '</emit>')
    ParentFont = False
    ReadOnly = True
    TabOrder = 2
  end
end
