unit UnitDadoHomolog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFormDadoHomolog = class(TForm)
    Memo: TMemo;
    Fechar: TButton;
    Memo2: TMemo;
    Label1: TLabel;
    Label2: TLabel;
    procedure FecharClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormDadoHomolog: TFormDadoHomolog;

implementation

{$R *.dfm}

procedure TFormDadoHomolog.FecharClick(Sender: TObject);
begin
Close;
end;

end.
