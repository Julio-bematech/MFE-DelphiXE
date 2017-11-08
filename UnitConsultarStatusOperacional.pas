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

    {Estado de Operação do SAT (vide 2.1.14 da especificação de requisitos do SAT)
      0= DESBLOQUEADO
      1= BLOQUEIO SEFAZ
      2= BLOQUEIO CONTRIBUINTE
      3= BLOQUEIO AUTÔNOMO
      4= BLOQUEIO PARA DESATIVAÇÃO
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
        statusStr := 'BLOQUEIO AUTÔNOMO';
      end;
      4:begin
        statusStr := 'BLOQUEIO PARA DESATIVAÇÃO';
      end;
    end;
    ValueListEditor.Values ['Número de Sessão']:= sessao;
    ValueListEditor.Values ['Código de Retorno']:= strSeparada[1];
    ValueListEditor.Values ['Mensagem de Retorno']:= strSeparada[2];
    ValueListEditor.Values ['Código Mensagem SEFAZ']:= strSeparada[3];
    ValueListEditor.Values ['Mensagem da Sefaz']:= strSeparada[4];
    ValueListEditor.Values ['Número de Série']:= strSeparada[5];
    ValueListEditor.Values ['Tipo da Lan']:= strSeparada[6];
    ValueListEditor.Values ['IP']:= strSeparada[7];
    ValueListEditor.Values ['Mac Address']:= strSeparada[8];
    ValueListEditor.Values ['Máscara de Rede']:= strSeparada[9];
    ValueListEditor.Values ['Gateway']:= strSeparada[10];
    ValueListEditor.Values ['DNS Primário']:= strSeparada[11];
    ValueListEditor.Values ['DNS Secundário']:= strSeparada[12];
    ValueListEditor.Values ['Status da Lan']:= strSeparada[13];
    ValueListEditor.Values ['Nível da Bateria']:= strSeparada[14];
    ValueListEditor.Values ['Total de Memória']:= strSeparada[15];
    ValueListEditor.Values ['Memória Utilizada']:= strSeparada[16];
    ValueListEditor.Values ['Data e Hora Atual']:= strSeparada[17];
    ValueListEditor.Values ['Versão Software Básico']:= strSeparada[18];
    ValueListEditor.Values ['Versão do Layout']:= strSeparada[19];
    ValueListEditor.Values ['Último CF-e Enviado']:= strSeparada[20];
    ValueListEditor.Values ['Primeiro CF-e Armazenado']:= strSeparada[21];
    ValueListEditor.Values ['Último CF-e Armazenado']:= strSeparada[22];
    ValueListEditor.Values ['Última Transmissão de CF-e']:= strSeparada[23];
    ValueListEditor.Values ['Última Comunicação com SEFAZ']:= strSeparada[24];
    ValueListEditor.Values ['Emissão do Certificado']:= strSeparada[25];
    ValueListEditor.Values ['Vencimento do Certificado']:= strSeparada[26];
    ValueListEditor.Values ['Estado de Operação do MFE']:= statusStr;

  until FindNext(searchResult) <> 0;
  FindClose(searchResult);
end;
except
  ShowMessage('Erro ao obter o retorno, verifique o arquivo da pasta C:/Integrador/Output');
end;

end;

end.
