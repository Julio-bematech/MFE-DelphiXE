program ExemploMFESATDelphiXE;

uses
  Forms,
  UnitExemploMFESATDelphiXE in 'UnitExemploMFESATDelphiXE.pas' {FormExemploMFEDelphiXE},
  UnitAbreXML in 'UnitAbreXML.pas' {FormAbreXML},
  UnitConsultarStatusOperacional in 'UnitConsultarStatusOperacional.pas' {FormConsultaStatusOperacional},
  UnitDadoHomolog in 'UnitDadoHomolog.pas' {FormDadoHomolog};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormExemploMFEDelphiXE, FormExemploMFEDelphiXE);
  Application.CreateForm(TFormAbreXML, FormAbreXML);
  Application.CreateForm(TFormConsultaStatusOperacional, FormConsultaStatusOperacional);
  Application.CreateForm(TFormDadoHomolog, FormDadoHomolog);
  Application.Run;
end.
