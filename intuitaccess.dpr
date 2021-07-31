program intuitaccess;

uses
  Vcl.Forms,
  fmIntuitDemo in 'fmIntuitDemo.pas' {Form1},
  OAuth2.Intuit in 'OAuth2.Intuit.pas',
  JSON.InvoiceList in 'JSON.InvoiceList.pas',
  JSON.VendorList in 'JSON.VendorList.pas',
  JSON.AttachableList in 'JSON.AttachableList.pas',
  JSON.ChartOfAccountList in 'JSON.ChartOfAccountList.pas',
  JSON.CustomerList in 'JSON.CustomerList.pas',
  secrets in 'secrets.pas',
  pdfinvoice in '..\tcginvoices\pdfinvoice.pas',
  DebenuPDFLibraryDLL0916 in '..\components\QuickPDF\DLL\Import\Delphi\DebenuPDFLibraryDLL0916.pas',
  fmLogin in 'fmLogin.pas' {frmLogin};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
