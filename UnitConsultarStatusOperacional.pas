unit UnitConsultarStatusOperacional;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, ValEdit, Types, StdCtrls, StrUtils, xmldom, XMLIntf, msxmldom,
  XMLDoc;

type
  TFormConsultaStatusOperacional = class(TForm)
    ValueListEditor: TValueListEditor;
    Memo1: TMemo;
    Fechar: TButton;
    XMLDocument: TXMLDocument;
    procedure FormCreate(Sender: TObject);
    procedure FecharClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormConsultaStatusOperacional: TFormConsultaStatusOperacional;

implementation

{$R *.dfm}

procedure TFormConsultaStatusOperacional.FecharClick(Sender: TObject);
begin
Close;
end;

procedure TFormConsultaStatusOperacional.FormCreate(Sender: TObject);
var
mensagem, xmlIntegrador,
arquivo, retorno, sessao, statusStr : string;
status : integer;
searchResult : TSearchRec;
strSeparada : TStringDynArray;
p1, p2 : integer;

begin

//Pega o retorno da venda na pasta OUTPUT
try
begin
  if (FindFirst('C:\Integrador\Output\*.xml', faAnyFile, searchResult)) = 0 then
  repeat
    Memo1.Clear;
    Memo1.Lines.LoadFromFile('C:\Integrador\Output\'+searchResult.Name);

    //insere o arquivo de retorno em uma string
    retorno := Memo1.Text;

    //Separa o retorno pelo delimitador pipe ("|") conforme descrito acima
    strSeparada := SplitString(retorno, '|');
    sessao := Copy(strSeparada[0],261,266);

    {Estado de Opera��o do SAT (vide 2.1.14 da especifica��o de requisitos do SAT)
      0= DESBLOQUEADO
      1= BLOQUEIO SEFAZ
      2= BLOQUEIO CONTRIBUINTE
      3= BLOQUEIO AUT�NOMO
      4= BLOQUEIO PARA DESATIVA��O
    }

    statusStr := Copy(strSeparada[27],1,1);
    status := StrToInt(statusStr);
    case status of
      0:begin
        statusStr := 'DESBLOQUEADO';
      end;
      1:begin
        statusStr := 'BLOQUEIO SEFAZ';
      end;
      2:begin
        statusStr := 'BLOQUEIO CONTRIBUINTE';
      end;
      3:begin
        statusStr := 'BLOQUEIO AUT�NOMO';
      end;
      4:begin
        statusStr := 'BLOQUEIO PARA DESATIVA��O';
      end;
    end;
    ValueListEditor.Values ['N�mero de Sess�o']:= sessao;
    ValueListEditor.Values ['C�digo de Retorno']:= strSeparada[1];
    ValueListEditor.Values ['Mensagem de Retorno']:= strSeparada[2];
    ValueListEditor.Values ['C�digo Mensagem SEFAZ']:= strSeparada[3];
    ValueListEditor.Values ['Mensagem da Sefaz']:= strSeparada[4];
    ValueListEditor.Values ['N�mero de S�rie']:= strSeparada[5];
    ValueListEditor.Values ['Tipo da Lan']:= strSeparada[6];
    ValueListEditor.Values ['IP']:= strSeparada[7];
    ValueListEditor.Values ['Mac Address']:= strSeparada[8];
    ValueListEditor.Values ['M�scara de Rede']:= strSeparada[9];
    ValueListEditor.Values ['Gateway']:= strSeparada[10];
    ValueListEditor.Values ['DNS Prim�rio']:= strSeparada[11];
    ValueListEditor.Values ['DNS Secund�rio']:= strSeparada[12];
    ValueListEditor.Values ['Status da Lan']:= strSeparada[13];
    ValueListEditor.Values ['N�vel da Bateria']:= strSeparada[14];
    ValueListEditor.Values ['Total de Mem�ria']:= strSeparada[15];
    ValueListEditor.Values ['Mem�ria Utilizada']:= strSeparada[16];
    ValueListEditor.Values ['Data e Hora Atual']:= strSeparada[17];
    ValueListEditor.Values ['Vers�o Software B�sico']:= strSeparada[18];
    ValueListEditor.Values ['Vers�o do Layout']:= strSeparada[19];
    ValueListEditor.Values ['�ltimo CF-e Enviado']:= strSeparada[20];
    ValueListEditor.Values ['Primeiro CF-e Armazenado']:= strSeparada[21];
    ValueListEditor.Values ['�ltimo CF-e Armazenado']:= strSeparada[22];
    ValueListEditor.Values ['�ltima Transmiss�o de CF-e']:= strSeparada[23];
    ValueListEditor.Values ['�ltima Comunica��o com SEFAZ']:= strSeparada[24];
    ValueListEditor.Values ['Emiss�o do Certificado']:= strSeparada[25];
    ValueListEditor.Values ['Vencimento do Certificado']:= strSeparada[26];
    ValueListEditor.Values ['Estado de Opera��o do MFE']:= statusStr;

  until FindNext(searchResult) <> 0;
  FindClose(searchResult);
end;
except
  ShowMessage('Erro ao obter o retorno, verifique o arquivo da pasta C:/Integrador/Output');
end;

end;

end.
