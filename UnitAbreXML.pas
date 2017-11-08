unit UnitAbreXML;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, xmldom, XMLIntf, StdCtrls, Buttons, msxmldom, XMLDoc, ComCtrls;

type
  TFormAbreXML = class(TForm)
    TreeView1: TTreeView;
    XMLDocument1: TXMLDocument;
    Memo1: TMemo;
    Fechar: TBitBtn;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure GenereteTree(XMLNode: IXMLNode; TreeNode: TTreeNode);
  public
    { Public declarations }
  end;

var
  FormAbreXML: TFormAbreXML;

implementation

{$R *.dfm}

{ TForm2 }

procedure TFormAbreXML.FormShow(Sender: TObject);
begin
XMLDocument1.LoadFromFile (); // pegando o conteúdo da variável Caminho.
    TreeView1.Items.Clear; //limpa o conteúdo que estiver na TreeView
    XMLDocument1.Active:= True; // ativa o XMLDocument
    GenereteTree(XMLDocument1.DocumentElement, nil); //Monta a TreeView
    with Memo1.Lines do
     begin
      Clear; //limpa o memo para receber as informações do arquivo XML
      Add('Versão : ' + XMLDocument1.Version);
      Add('Encoding : ' + XMLDocument1.Encoding);
      Add('FileName : ' + XMLDocument1.FileName);
    end;
end;

procedure TFormAbreXML.GenereteTree(XMLNode: IXMLNode; TreeNode: TTreeNode);
var
NodeText : string;
NewTreeNode: TTreeNode;
I : Integer;
begin
 if XMLNode.NodeType <> ntElement then
 Exit;

 NodeText := XMLNode.NodeName;
 if XMLNode.IsTextElement then
  NodeText := NodeText + '=' + XMLNode.NodeValue;
  NewTreeNode := TreeView1.Items.AddChild(TreeNode,NodeText);
  if XMLNode.HasChildNodes then
    for i := 0 to XMLNode.ChildNodes.Count -1 do
      GenereteTree(XMLNode.ChildNodes[i],NewTreeNode);

end;

end.
