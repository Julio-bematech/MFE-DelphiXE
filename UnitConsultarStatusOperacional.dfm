object FormConsultaStatusOperacional: TFormConsultaStatusOperacional
  Left = 0
  Top = 0
  Caption = 'ConsultarStatusOperacional'
  ClientHeight = 601
  ClientWidth = 539
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object ValueListEditor: TValueListEditor
    Left = 0
    Top = 0
    Width = 537
    Height = 553
    Color = clMoneyGreen
    DrawingStyle = gdsGradient
    ScrollBars = ssNone
    Strings.Strings = (
      'N'#250'mero de Sess'#227'o='
      'C'#243'digo de Retorno='
      'Mensagem de Retorno='
      'C'#243'digo Mensagem SEFAZ='
      'Mensagem da Sefaz='
      'N'#250'mero de S'#233'rie='
      'Tipo da Lan='
      'IP='
      'Mac Address='
      'M'#225'scara de Rede='
      'Gateway='
      'DNS Prim'#225'rio='
      'DNS Secund'#225'rio='
      'Status da Lan='
      'N'#237'vel da Bateria='
      'Total de Mem'#243'ria='
      'Mem'#243'ria Utilizada='
      'Data e Hora Atual='
      'Vers'#227'o Software B'#225'sico='
      'Vers'#227'o do Layout='
      #218'ltimo CF-e Enviado='
      'Primeiro CF-e Armazenado='
      #218'ltimo CF-e Armazenado='
      #218'ltima Transmiss'#227'o de CF-e='
      #218'ltima Comunica'#231#227'o com SEFAZ='
      'Emiss'#227'o do Certificado='
      'Vencimento do Certificado='
      'Estado de Opera'#231#227'o do MFE=')
    TabOrder = 0
    TitleCaptions.Strings = (
      'Descri'#231#227'o'
      'Retorno')
    ColWidths = (
      158
      373)
  end
  object Memo1: TMemo
    Left = 346
    Top = 448
    Width = 185
    Height = 89
    Lines.Strings = (
      'Memo1')
    TabOrder = 1
    Visible = False
  end
  object Fechar: TButton
    Left = 354
    Top = 568
    Width = 177
    Height = 25
    Caption = 'Fechar'
    TabOrder = 2
    OnClick = FecharClick
  end
  object XMLDocument: TXMLDocument
    Active = True
    Left = 208
    Top = 560
    DOMVendorDesc = 'MSXML'
  end
end
