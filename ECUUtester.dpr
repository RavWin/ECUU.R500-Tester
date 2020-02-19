program ECUUtester;

uses
  Vcl.Forms,
  fuMain in 'fuMain.pas' {fECUU},
  uFVIN in 'uFVIN.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfECUU, fECUU);
  Application.Run;
end.
