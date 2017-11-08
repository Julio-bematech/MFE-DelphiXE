unit UnitExemploMFESATDelphiXE;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IniFiles, Buttons, UnitConsultarStatusOperacional,
  xmldom, XMLIntf, msxmldom,
  XMLDoc, ComCtrls, FileCtrl, Types, StrUtils, IdBaseComponent,
  IdComponent, IdMessageCoder, IdMessageCoderMIME, IdCoder, IdCoder3to4,
  IdCoderMIME, Grids, ValEdit, ExtCtrls, jpeg, UnitDadoHomolog;

type
  TFormExemploMFEDelphiXE = class(TForm)
    XMLDocument1: TXMLDocument;
    OpenDialog: TOpenDialog;
    TreeView: TTreeView;
    Label4: TLabel;
    Label5: TLabel;
    IdDecoderMIME: TIdDecoderMIME;
    Memo1: TMemo;
    MemoXML: TMemo;
    ValueListEditor: TValueListEditor;
    GroupBox1: TGroupBox;
    EnviarDadosVenda: TButton;
    Abrir: TBitBtn;
    Edit1: TEdit;
    GroupBox2: TGroupBox;
    Edit3: TEdit;
    Label6: TLabel;
    CancelarUltimaVenda: TButton;
    Edit4: TEdit;
    Label7: TLabel;
    GroupBox3: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Edit2: TEdit;
    EditSessao: TEdit;
    EditId: TEdit;
    EditCNPJsh: TEdit;
    Label8: TLabel;
    Label9: TLabel;
    EditAssina: TEdit;
    Image1: TImage;
    ConsultarSAT: TButton;
    ConsultarStatusOperacional: TButton;
    Panel1: TPanel;
    procedure EnviarDadosVendaClick(Sender: TObject);
    procedure AbrirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ValueListEditorClick(Sender: TObject);
    procedure CancelarUltimaVendaClick(Sender: TObject);
    procedure ConsultarSATClick(Sender: TObject);
    procedure ConsultarStatusOperacionalClick(Sender: TObject);
    procedure Panel1Click(Sender: TObject);
  private
    { Private declarations }
    iniConf : TIniFile;
    Function NumSessao(): integer;
    Function NumIdentificador(): integer;
  public
    { Public declarations }
     procedure DomToTree(XmlNode: IXMLNode; TreeNode: TTreeNode);
     function base64Decode(const Text : ansiString): ansiString;
  end;

var
  FormExemploMFEDelphiXE: TFormExemploMFEDelphiXE;
  envia: string;
  caminho, dir,xmlIntegrador : string;
  numeroSessao,numeroId : integer;
  arqBase64,decBase64 : string;
  grava : TStringList;
  strSeparada : TStringDynArray; // Para usar este tipo, insira o valor "Types" no uses
  retorno, sessao : string;
  f : TextFile;
  arquivo, arq: string;
  i: integer;
  sr: TSearchRec;
  searchResult : TSearchRec;
  NodeText : string;
  NewTreeNode: TTreeNode;

implementation

{$R *.dfm}
{-----> Função para gerar número de sessão-------------------------------}
function TFormExemploMFEDelphiXE.NumSessao: integer;
begin
Randomize;
numeroSessao := Random(999999);
Result:= numeroSessao;
end;

procedure TFormExemploMFEDelphiXE.Panel1Click(Sender: TObject);
begin
FormDadoHomolog := TFormDadoHomolog.Create(Application);
FormDadoHomolog.ShowModal;
end;

procedure TFormExemploMFEDelphiXE.ValueListEditorClick(Sender: TObject);
begin

end;

{------------------------------------------------------------------------}
{-----> Função para gerar número de identificação-------------------------------}
//Nesse caso estou gerando um núumero aleatório de 6 digitos, como fiz no número de sessão

function TFormExemploMFEDelphiXE.numIdentificador: integer;
begin
Randomize;
numeroId := Random(999999);
Result:= numeroId;
end;
{------------------------------------------------------------------------}

// CANCELAR ULTIMA VENDA ====================================================
procedure TFormExemploMFEDelphiXE.AbrirClick(Sender: TObject);
begin
//Abro o conteúdo do xml selecionado no Treeview
//OpenDialog.DefaultExt:= 'xml*';
OpenDialog.Title := 'Selecione o CF-e da venda';
OpenDialog.InitialDir := ExtractFilePath(Application.Name);
if OpenDialog.Execute then
  Edit1.Text := OpenDialog.FileName;
  Memo1.Lines.LoadFromFile(OpenDialog.FileName);  
  XMLDocument1.Active := False;
  XMLDocument1.LoadFromFile(OpenDialog.FileName);
  XMLDocument1.Active := True;
  Treeview.Items.Clear;
  DomToTree(XMLDocument1.DocumentElement, nil);
  TreeView.FullExpand;
end;

//Procedure para organizar o Treeview
function TFormExemploMFEDelphiXE.base64Decode(
  const Text: ansiString): ansiString;
var
  Decoder : TIdDecoderMime;
begin
  Decoder := TIdDecoderMime.Create(nil);
  try
    Result := Decoder.DecodeString(Text);
  finally
    FreeAndNil(Decoder)
  end
end;

// CANCELAR ULTIMA VENDA====================================================
procedure TFormExemploMFEDelphiXE.CancelarUltimaVendaClick(Sender: TObject);
var
canc, cancInt : string;
retorno : string;
f : TextFile;
arquivo, arq: string;
i: integer;
sr: TSearchRec;
searchResult : TSearchRec;

begin

canc := '<?xml version="1.0"encoding="UTF-8"?><CFeCanc><infCFe chCanc="'+Edit3.Text+'"><ide><CNPJ>'+EditCNPJsh.Text+'</CNPJ><signAC>SGR-SAT SISTEMA DE GESTAO E RETAGUARDA DO SAT</signAC><numeroCaixa>123</numeroCaixa></ide><emit/><dest>'+Edit4.Text+'</dest><total/><infAdic/></infCFe></CFeCanc>';

cancInt :=  '<Integrador>'+
            '<Identificador>'+
            '<Valor>'+EditId.Text+'</Valor>'+
            '</Identificador>'+
            '<Componente Nome="MF-e">'+
            '<Metodo Nome="CancelarUltimaVenda">'+
            '<Parametros>'+
            '<Parametro>'+
            '<Nome>numeroSessao</Nome>'+
            '<Valor>'+EditSessao.Text+'</Valor>'+
            '</Parametro>'+
            '<Parametro>'+
            '<Nome>codigoDeAtivacao</Nome>'+
            '<Valor>'+Edit2.Text+'</Valor>'+
            '</Parametro>'+
            '<Parametro>'+
            '<Nome>chave</Nome>'+
            '<Valor>'+Edit3.Text+'</Valor>'+
            '</Parametro>'+
            '<Parametro>'+
            '<Nome>dadosCancelamento</Nome>'+
            '<Valor><![CDATA['+canc+']]></Valor>'+
            '</Parametro>'+
            '</Parametros>'+
            '</Metodo>'+
            '</Componente>'+
            '</Integrador>';

arquivo := 'C:/Integrador/Input/CancelarUltimaVenda.xml';

if not FileExists(arquivo) then
  DeleteFile(arquivo);

AssignFile(f,arquivo);
Rewrite(f);
Writeln(f,cancInt);
CloseFile(f);            

            
//Apaga conteúdo da pasta OUTPUT
I := FindFirst('C:\Integrador\Output\*.*', faAnyFile, SR);
while I = 0 do
begin
  DeleteFile('C:\Integrador\Output\' + SR.Name);
  I := FindNext(SR);  
end;
//---

//Cria uma pasta no C: com o nome XML-NFE para guardar o arquivo
//CancelarUltimaVenda.xml que foi enviado
dir := 'C:\XML-MFE\xml-de-envio';
if not DirectoryExists(dir) then
  ForceDirectories(dir);
  arquivo := 'C:\XML-MFE\xml-de-envio\CancelarUltimaVenda.xml';
  
  if not FileExists(arquivo) then
    DeleteFile(arquivo);

  AssignFile(f,arquivo);
  Rewrite(f);
  Writeln(f,cancInt);
  CloseFile(f);
  ShowMessage('Arquivo XML de cancelamento enviado com sucesso, aguarde o retorno...');
  //Após enviado o xml do cancelamento, aguardar 3 segundos para capturar o retorno da pasta Output
  Sleep(3000);
//Pega o retorno da venda na pasta OUTPUT
try
  begin
  if (FindFirst('C:\Integrador\Output\*.xml', faAnyFile, searchResult)) = 0 then
  repeat
  //insere o arquivo de retorno em uma string
  MemoXML.Clear;
  MemoXML.Lines.LoadFromFile('C:\Integrador\Output\'+searchResult.Name);
  retorno := MemoXML.Text;

  //Separa o retorno pelo delimitador pipe ("|") conforme descrito acima
  strSeparada := SplitString(retorno, '|');

  //Se o retorno não for de sucesso (EEEEE diferente de 07000) mostra o retorno 
  if strSeparada[1] <> '07000' then
  begin
    ShowMessage('Erro no cancelamento: ' + strSeparada[1]);
  end else
  //Caso a venda for realizada com sucesso, proceda:
  begin
    //Mostra a chave de acesso no campo Edit
    Edit3.Text := strSeparada[8];
    arqBase64 := strSeparada[6];
    ValueListEditor.Strings.Clear;
    ValueListEditor.Values ['Número de Sessão']:= strSeparada[0];
    ValueListEditor.Values ['Código de retorno']:= strSeparada[1];
    ValueListEditor.Values ['Código de Cancelamento']:= strSeparada[2];
    ValueListEditor.Values ['Descrição do Erro']:= strSeparada[3];
    ValueListEditor.Values ['Cód. Referência SEFAZ']:= strSeparada[4];
    ValueListEditor.Values ['Mensagem SEFAZ']:= strSeparada[5];
    ValueListEditor.Values ['Data e Hora de Emissão']:= strSeparada[7];
    ValueListEditor.Values ['Chave de Acesso']:= strSeparada[8];
    ValueListEditor.Values ['Valor Total']:= strSeparada[9];
    ValueListEditor.Values ['CPF ou CNPJ']:= strSeparada[10];
    ValueListEditor.Values ['Assinatura QR-Code']:= strSeparada[11];

    //Decodifica o CF-e de retorno para xml
    decBase64 := base64Decode(arqBase64);
    grava := TStringList.Create;
    grava.Add(decBase64);
    
    //Cria uma pasta no C:/XML-NFE com o nome cfe-retorno para guardar o CF-e de retorno
    dir := 'C:\XML-MFE\cfe-retorno';
    if not DirectoryExists(dir) then
      ForceDirectories(dir);      
    grava.SaveToFile('C:\XML-MFE\cfe-retorno\'+strSeparada[8]+'canc.xml');    
    end;
      until FindNext(searchResult) <> 0;
        FindClose(searchResult);
end;
except
  ShowMessage('Erro ao obter o retorno, verifique o arquivo da pasta C:/Integrador/Output');
end;
end;

procedure TFormExemploMFEDelphiXE.ConsultarStatusOperacionalClick(
  Sender: TObject);
begin
//Apaga conteúdo da pasta OUTPUT
I := FindFirst('C:\Integrador\Output\*.*', faAnyFile, SR);
while I = 0 do
begin
  DeleteFile('C:\Integrador\Output\' + SR.Name);
  I := FindNext(SR);
end;
//---
EditSessao.Text := IntToStr(NumSessao);
EditId.Text := IntToStr(NumIdentificador);

xmlIntegrador := '<?xml version="1.0" encoding="utf-8" ?>'+
                  '<Integrador>'+
                  '<Identificador>'+
                  '<Valor>'+EditId.Text+'</Valor>'+
                  '</Identificador>'+
                  '<Componente Nome="MF-e">'+
                  '<Metodo Nome="ConsultarStatusOperacional">'+
                  '<Parametros>'+
                  '<Parametro>'+
                  '<Nome>numeroSessao</Nome>'+
                  '<Valor>'+EditSessao.Text+'</Valor>'+
                  '</Parametro>'+
                  '<Parametro>'+
                  '<Nome>codigoDeAtivacao</Nome>'+
                  '<Valor>'+Edit2.Text+'</Valor>'+
                  '</Parametro>'+
                  '</Parametros>'+
                  '</Metodo>'+
                  '</Componente>'+
                  '</Integrador>';

arquivo := 'C:/Integrador/Input/consultarstatusoperacional.xml';

if not FileExists(arquivo) then
  DeleteFile(arquivo);

AssignFile(f,arquivo);
Rewrite(f);
Writeln(f,xmlIntegrador);
CloseFile(f);
ShowMessage('Aguarde...');
Sleep(3000);
FormConsultaStatusOperacional := TFormConsultaStatusOperacional.Create(Application);
FormConsultaStatusOperacional.ShowModal;

end;

procedure TFormExemploMFEDelphiXE.ConsultarSATClick(Sender: TObject);
var
mensagem : string;
begin
//Apaga conteúdo da pasta OUTPUT
I := FindFirst('C:\Integrador\Output\*.*', faAnyFile, SR);
while I = 0 do
begin
  DeleteFile('C:\Integrador\Output\' + SR.Name);
  I := FindNext(SR);
end;
//---
EditSessao.Text := IntToStr(NumSessao);
EditId.Text := IntToStr(NumIdentificador);

  xmlIntegrador := '<?xml version="1.0" encoding="utf-8" ?>'+
                  '<Integrador>'+
                  '<Identificador>'+
                  '<Valor>'+EditId.Text+'</Valor>'+
                  '</Identificador>'+
                  '<Componente Nome="MF-e">'+
                  '<Metodo Nome="ConsultarMFe">'+
                  '<Parametros>'+
                  '<Parametro>'+
                  '<Nome>numeroSessao</Nome>'+
                  '<Valor>'+EditSessao.Text+'</Valor>'+
                  '</Parametro>'+
                  '</Parametros>'+
                  '</Metodo>'+
                  '</Componente>'+
                  '</Integrador>';
  arquivo := 'C:/Integrador/Input/consultarsat.xml';

//Se o arquivo consultarsat.xml já existir no C:/Integrador/Input/ ele é apagado
if not FileExists(arquivo) then
  DeleteFile(arquivo);

//
AssignFile(f,arquivo);
Rewrite(f);
Writeln(f,xmlIntegrador);
CloseFile(f);
ShowMessage('Consultando o SAT, aguarde...');

Sleep(3000);
//Pega o retorno da venda na pasta OUTPUT
try
begin
  if (FindFirst('C:\Integrador\Output\*.xml', faAnyFile, searchResult)) = 0 then
  repeat
    MemoXML.Clear;
    MemoXML.Lines.LoadFromFile('C:\Integrador\Output\'+searchResult.Name);

    //insere o arquivo de retorno em uma string
    retorno := MemoXML.Text;
    //Separa o retorno pelo delimitador pipe ("|")
    strSeparada := SplitString(retorno, '|');

    ShowMessage('Código de status: '+strSeparada[1]+Char(10)+Char(13)+
                'Mensagem: '+strSeparada[2]);
  until FindNext(searchResult) <> 0;
  FindClose(searchResult);
end;
except
  ShowMessage('Erro ao obter o retorno, verifique o arquivo da pasta C:/Integrador/Output');
end;
end;

//Procedure para fazer parse do xml e invocar no Treeview
procedure TFormExemploMFEDelphiXE.DomToTree(XmlNode: IXMLNode;
  TreeNode: TTreeNode);
var
  I: Integer;
  NewTreeNode: TTreeNode;
  NodeText: string;
  AttrNode: IXMLNode;
begin
  // skip text nodes and other special cases
  if not (XmlNode.NodeType = ntElement) then 
    Exit;
  // add the node itself 
  NodeText := XmlNode.NodeName;
  if XmlNode.IsTextElement then 
    NodeText := NodeText + ' = ' + XmlNode.NodeValue;
  NewTreeNode := TreeView.Items.AddChild(TreeNode, NodeText);
  // add attributes 
  for I := 0 to xmlNode.AttributeNodes.Count - 1 do
  begin 
    AttrNode := xmlNode.AttributeNodes.Nodes[I];
    TreeView.Items.AddChild(NewTreeNode, 
      '[' + AttrNode.NodeName + ' = "' + AttrNode.Text + '"]');
  end;
  // add each child node
  if XmlNode.HasChildNodes then
    for I := 0 to xmlNode.ChildNodes.Count - 1 do
      DomToTree (xmlNode.ChildNodes.Nodes [I], NewTreeNode);
end;

// ENVIAR DADOS VENDA====================================================
procedure TFormExemploMFEDelphiXE.EnviarDadosVendaClick(Sender: TObject);
begin
//Apaga conteúdo da pasta OUTPUT
I := FindFirst('C:\Integrador\Output\*.*', faAnyFile, SR);
while I = 0 do
begin
  DeleteFile('C:\Integrador\Output\' + SR.Name);
  I := FindNext(SR);  
end;
//---

EditSessao.Text := IntToStr(NumSessao);
EditId.Text := IntToStr(NumIdentificador);

envia := '<?xml version="1.0" encoding="utf-8" ?>'+
		'<Integrador>'+
		  '<Identificador>'+
			'<Valor>'+EditId.Text+'</Valor>'+
		  '</Identificador>'+
		  '<Componente Nome="MF-e">'+
			'<Metodo Nome="EnviarDadosVenda">'+
			  '<Parametros>'+
				'<Parametro>'+
				  '<Nome>numeroSessao</Nome>'+
				  '<Valor>'+EditSessao.Text+'</Valor>'+
				'</Parametro>'+
				'<Parametro>'+
				  '<Nome>codigoDeAtivacao</Nome>'+
				  '<Valor>'+Edit2.Text+'</Valor>'+
				'</Parametro>'+
				'<Parametro>'+
				  '<Nome>dadosVenda</Nome>'+
				  '<Valor><![CDATA['+Memo1.Text+']]></Valor>'+
				'</Parametro>'+
				'<Parametro>'+
				  '<Nome>nrDocumento</Nome>'+
				  '<Valor>01</Valor>'+
				'</Parametro>'+
			  '</Parametros>'+
			'</Metodo>'+
		  '</Componente>'+
		'</Integrador>';

arquivo := 'C:/Integrador/Input/enviardadosvenda.xml';

if not FileExists(arquivo) then
  DeleteFile(arquivo);

AssignFile(f,arquivo);
Rewrite(f);
Writeln(f,envia);
CloseFile(f);
//Cria uma pasta no C: com o nome XML-MFE\xml-de-envio para guardar o arquivo
//EnviarDadosVenda.xml que foi enviado
dir := 'C:\XML-MFE\xml-de-envio';
if not DirectoryExists(dir) then
  ForceDirectories(dir);
  arquivo := 'C:\XML-MFE\xml-de-envio\enviardadosvenda.xml';
  
  if not FileExists(arquivo) then
    DeleteFile(arquivo);

  AssignFile(f,arquivo);
  Rewrite(f);
  Writeln(f,envia);
  CloseFile(f);
  ShowMessage('Arquivo XML de Venda enviado com sucesso, aguarde o retorno...');
  //Após enviado o xml da venda, aguardar 3 segundos para capturar o retorno da pasta Output
  Sleep(3000);

//Pega o retorno da venda na pasta OUTPUT
try
begin
  if (FindFirst('C:\Integrador\Output\*.xml', faAnyFile, searchResult)) = 0 then
  repeat
    MemoXML.Clear;
    MemoXML.Lines.LoadFromFile('C:\Integrador\Output\'+searchResult.Name);

    //insere o arquivo de retorno em uma string
    retorno := MemoXML.Text;

    //Separa o retorno pelo delimitador pipe ("|") conforme descrito acima
    strSeparada := SplitString(retorno, '|');

    //Se o retorno não for de sucesso (EEEEE diferente de 0600) mostra o retorno
    if strSeparada[1] <> '06000' then
    begin
      ShowMessage('Erro na venda: ' + strSeparada[1]);
    end else
    //Caso a venda for realizada com sucesso, proceda:
    begin
        //Mostra a chave de acesso no campo Edit
        Edit3.Text := strSeparada[8];

        //Salva o CF-e de retorno em Base64 em uma string
        arqBase64 := strSeparada[6];

        //==--RETORNO--================================================================//
        {
        Posição[0] - numeroSessao - Número aleatório gerado pelo aplicativo comercial para controle da comunicação.
        Posição[1] - EEEEE - Código de retorno.
        Posição[2] - CCCC - Código de retorno de cancelamento.
        Posição[3] - mensagem - Descrições dos códigos EEEEE.
        Posição[4] - cod - Código de referência de cada "mensagemSEFAZ".
        Posição[5] - mensagemSEFAZ - Mensagem de texto enviada pela SEFAZ referente ao "Envio de avisos ao usuário".
        Posição[6] - arquivoCFeBase64 - Arquivo em XML assinado pelo SAT em formato idêntico ao que o SAT enviará para a SEFAZ.
        Posição[7] - timeStamp - Data e hora da emissão no formato: AAAAMMDDHHMMSS.
        Posição[8] - chaveConsulta - Chave de acesso do CF-e-SAT.
        Posição[9] - valorTotalCFe - Valor total do CF-e calculado pelo SAT.
        Posição[10] - CPFCNPJValue - Número do CPF ou CNPJ do adquirente sem pontos, traços e barras.
        Posição[11] - assinaturaQRCODE - Conteúdo do Campo ?assinaturaQRCODE? presente no leiaute do arquivo de venda/cancelamento.

        *Obs.: Em caso de erro na venda (EEEEE diferente de 06000) o retorno será somente
        até a posição[5]!
        }
        //==================================================================//
        {ShowMessage(strSeparada[0]+Char(10)+Char(13)+
                    strSeparada[1]+Char(10)+Char(13)+
                    strSeparada[2]+Char(10)+Char(13)+
                    strSeparada[3]+Char(10)+Char(13)+
                    strSeparada[4]+Char(10)+Char(13)+
                    strSeparada[5]+Char(10)+Char(13)+
                    strSeparada[7]+Char(10)+Char(13)+
                    strSeparada[8]+Char(10)+Char(13)+
                    strSeparada[9]+Char(10)+Char(13)+
                    strSeparada[10]+Char(10)+Char(13)+
                    strSeparada[11]);}

        //Inserindo os valores separados do retorno no ValueListEditor
        ValueListEditor.Strings.Clear;
        sessao := Copy(strSeparada[0],261,266);
        ValueListEditor.Values ['Número de Sessão']:= sessao;
        ValueListEditor.Values ['Código de retorno']:= strSeparada[1];
        ValueListEditor.Values ['Código de Cancelamento']:= strSeparada[2];
        ValueListEditor.Values ['Descrição do Erro']:= strSeparada[3];
        ValueListEditor.Values ['Cód. Referência SEFAZ']:= strSeparada[4];
        ValueListEditor.Values ['Mensagem SEFAZ']:= strSeparada[5];
        ValueListEditor.Values ['Data e Hora de Emissão']:= strSeparada[7];
        ValueListEditor.Values ['Chave de Acesso']:= strSeparada[8];
        ValueListEditor.Values ['Valor Total']:= strSeparada[9];
        ValueListEditor.Values ['CPF ou CNPJ']:= strSeparada[10];
        ValueListEditor.Values ['Assinatura QR-Code']:= strSeparada[11];

        //Decodifica o CF-e de retorno para xml e coloca em uma lista
        decBase64 := base64Decode(arqBase64);
        grava := TStringList.Create;
        grava.Add(decBase64);

        //Cria uma pasta no C:/XML-NFE com o nome cfe-retorno para guardar o CF-e de retorno
        dir := 'C:\XML-MFE\cfe-retorno';
        if not DirectoryExists(dir) then
          ForceDirectories(dir);
        grava.SaveToFile('C:\XML-MFE\cfe-retorno\'+strSeparada[8]+'.xml');
      end;
      until FindNext(searchResult) <> 0;
        FindClose(searchResult);
end;
except
  ShowMessage('Erro ao obter o retorno, verifique o arquivo da pasta C:/Integrador/Output');
end;
end;

procedure TFormExemploMFEDelphiXE.FormCreate(Sender: TObject);
var
sr: TSearchRec;
searchResult : TSearchRec;

begin
dir := 'C:\XML-MFE';
if not DirectoryExists(dir) then
  ForceDirectories(dir);
end;

end.
