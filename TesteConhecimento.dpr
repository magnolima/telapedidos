program TesteConhecimento;

uses
  Vcl.Forms,
  Main in 'Main.pas' {PedidoDeVendas},
  DataModule in 'DataModule.pas' {DM: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TPedidoDeVendas, PedidoDeVendas);
  Application.CreateForm(TDM, DM);
  Application.Run;
end.
