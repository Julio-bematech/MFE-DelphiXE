object FormAbreXML: TFormAbreXML
  Left = 0
  Top = 0
  Caption = 'FormAbreXML'
  ClientHeight = 386
  ClientWidth = 658
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object TreeView1: TTreeView
    Left = 447
    Top = 152
    Width = 194
    Height = 169
    Indent = 19
    TabOrder = 0
  end
  object Memo1: TMemo
    Left = 8
    Top = 8
    Width = 417
    Height = 370
    Lines.Strings = (
      'Memo1')
    TabOrder = 1
  end
  object Fechar: TBitBtn
    Left = 448
    Top = 336
    Width = 193
    Height = 33
    Caption = '&Fechar'
    DoubleBuffered = True
    Kind = bkClose
    NumGlyphs = 2
    ParentDoubleBuffered = False
    TabOrder = 2
  end
  object XMLDocument1: TXMLDocument
    Left = 560
    Top = 88
    DOMVendorDesc = 'MSXML'
  end
end
