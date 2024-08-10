unit fmIntuitDemo;

interface

uses
    Winapi.Windows
  , Winapi.Messages
  , System.SysUtils
  , System.Variants
  , System.Classes
  , System.RegularExpressions
  , Vcl.Graphics
  , Vcl.Controls
  , Vcl.Forms
  , Vcl.Dialogs
  , Vcl.ExtCtrls
  , Vcl.ComCtrls
  , Vcl.Mask
  , Vcl.StdCtrls
  , Vcl.FileCtrl
  , Vcl.Grids
  , REST.Types
  , Data.Bind.Components
  , Data.Bind.ObjectScope
  , JSON.InvoiceList
  , JSON.VendorList
  , JSON.ChartOfAccountList
  , JSON.CustomerList
  , JSON.AttachableList
  , InvoiceParserUnit
  , dmIntuit
  ;

type
  TForm1 = class(TForm)
    btnLogin: TButton;
    Button3: TButton;
    btnListCustomer: TButton;
    btnListInvoice: TButton;
    btnAuthWithRefreshToken: TButton;
    btnCreateInvoiceFromObject: TButton;
    GridPanel1: TGridPanel;
    GridPanel2: TGridPanel;
    btnAttachFile: TButton;
    StatusBar1: TStatusBar;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Memo1: TMemo;
    TabSheet2: TTabSheet;
    InvoiceDateDatePicker: TDateTimePicker;
    Label1: TLabel;
    InvoiceDateFromDatePicker: TDateTimePicker;
    Label2: TLabel;
    InvoiceDateToPicker: TDateTimePicker;
    Label3: TLabel;
    edtInvoiceNo: TEdit;
    Label4: TLabel;
    meTotalHours: TEdit;
    meTotalAmount: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    StringGrid1: TStringGrid;
    Label7: TLabel;
    edtClientRef: TEdit;
    Label8: TLabel;
    edtProject: TEdit;
    btnUploadInvoice: TButton;
    btnAddInvoiceLine: TButton;
    FileListBox1: TFileListBox;
    DirectoryListBox1: TDirectoryListBox;
    Button2: TButton;
    GridPanel3: TGridPanel;
    procedure btnAttachFileClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure btnListCustomerClick(Sender: TObject);
    procedure btnListInvoiceClick(Sender: TObject);
    procedure btnAuthWithRefreshTokenClick(Sender: TObject);
    procedure btnCreateInvoiceFromObjectClick(Sender: TObject);
    procedure btnUploadInvoiceClick(Sender: TObject);
    procedure btnAddInvoiceLineClick(Sender: TObject);
    procedure LoginClick(Sender: TObject);
    procedure FileListBoxEx1Change(Sender: TObject);
  private
    FInvoice : TInvoice;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
    Winapi.ShellAPI
  , System.Net.URLClient
  , System.JSON
  , System.IOUtils
  , secrets
  ;

procedure TForm1.btnAttachFileClick(Sender: TObject);
begin
  if FileListBox1.FileName.Length = 0 then
  begin
    ShowMessage('Please Select a file first');
    Exit;
  end;
  dmIntuitAPI.UploadAttachment(FileListBox1.FileName, edtInvoiceNo.Text);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  DirectoryListBox1.Directory := InitialDirectory;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  invoiceObj : TJSONObject;
  invoiceLine : TJSONObject;
  invoiceLines : TJSONArray;
  SalesItemLineDetail : TJSONObject;
  ItemRef : TJSONObject;
  CustomerRef : TJSONObject;
begin
  dmIntuitAPI.RESTRequest1.Resource := '/v3/company/{RealmId}/invoice';
  dmIntuitAPI.RESTRequest1.AddParameter('RealmId', dmIntuitAPI.RealmId, pkURLSEGMENT);
  invoiceObj := TJSONObject.Create;
  invoiceLines := TJSONArray.Create;

  invoiceLine := TJSONObject.Create;
  invoiceLine.AddPair('Amount', TJSONNumber.Create(100.00));
  invoiceLine.AddPair('DetailType', 'SalesItemLineDetail');

  SalesItemLineDetail := TJSONObject.Create;

  ItemRef := TJSONObject.Create;
  ItemRef.AddPair('value', '1');
  ItemRef.AddPair('name', 'Services');

  SalesItemLineDetail.AddPair('ItemRef', ItemRef);
  invoiceLine.AddPair('SalesItemLineDetail', SalesItemLineDetail);

  invoiceLines.AddElement(invoiceLine);
  invoiceLines.AddElement(invoiceLine.Clone as TJSONValue);

  invoiceObj.AddPair('Line', invoiceLines);

  CustomerRef := TJSONObject.Create;
  CustomerRef.AddPair('value', '2');

  invoiceObj.AddPair('CustomerRef', CustomerRef);

  dmIntuitAPI.RESTRequest1.Method := rmPOST;
  dmIntuitAPI.RESTRequest1.Execute;
  Memo1.Lines.Add(dmIntuitAPI.RESTRequest1.Response.Content);
end;

procedure TForm1.btnListCustomerClick(Sender: TObject);
var
  customers : TCustomerListClass;
  i : Integer;
begin
  dmIntuitAPI.RESTRequest1.ResetToDefaults;
  dmIntuitAPI.RESTRequest1.Method := rmGET;
  dmIntuitAPI.RESTRequest1.Resource := '/v3/company/{RealmId}/query?query=select * from Customer Where Metadata.LastUpdatedTime > ' + QuotedStr('2015-03-01');
  dmIntuitAPI.RESTRequest1.AddParameter('RealmId', dmIntuitAPI.RealmId, pkURLSEGMENT);
  dmIntuitAPI.RESTRequest1.AddParameter('minorversion', '73', TRESTRequestParameterKind.pkQUERY);
  dmIntuitAPI.RESTRequest1.Execute;

  customers := TCustomerListClass.FromJsonString(dmIntuitAPI.RESTRequest1.Response.Content);

  for i := 0 to Length(customers.QueryResponse.Customer) - 1 do
  begin
    Memo1.Lines.Add('Id: ' + customers.QueryResponse.Customer[i].Id);
    Memo1.Lines.Add('DisplayName: ' + customers.QueryResponse.Customer[i].DisplayName);
    Memo1.Lines.Add('Balance: ' + customers.QueryResponse.Customer[i].Balance.ToString)
  end;
end;

procedure TForm1.btnListInvoiceClick(Sender: TObject);
var
  invoiceList : TJSONInvoiceListClass;
  invoice : TInvoiceClass;
  i: Integer;
begin
{
Id: 90
DisplayName: TEST
Balance: 0
}
  dmIntuitAPI.RESTRequest1.Method := rmGET;
  dmIntuitAPI.RESTRequest1.Resource := '/v3/company/{RealmId}/query?query=select * from Invoice Where Id > ' + QuotedStr('166');
  dmIntuitAPI.RESTRequest1.AddParameter('RealmId', dmIntuitAPI.RealmId, pkURLSEGMENT);
  dmIntuitAPI.RESTRequest1.Execute;
  try
    invoiceList := TJSONInvoiceListClass.FromJsonString(dmIntuitAPI.RESTRequest1.Response.Content);
    Memo1.Lines.Add('Invoice Count: ' + Length(invoiceList.QueryResponse.Invoice).ToString);
    for i := 0 to Length(invoiceList.QueryResponse.Invoice) - 1 do
    begin
      invoice := invoiceList.QueryResponse.Invoice[i];
      Memo1.Lines.Add('Invoice No: ' + invoice.Id);
      Memo1.Lines.Add('Invoice Date: ' + invoice.TxnDate);
      Memo1.Lines.Add('Invoice Total:' + FloatToStr(invoice.TotalAmt));
      Memo1.Lines.Add(invoice.ToJsonString);
      Memo1.Lines.Add('===============');
    end;
  finally
    FreeAndNil(invoiceList);
  end;
end;

procedure TForm1.btnAuthWithRefreshTokenClick(Sender: TObject);
begin
  dmIntuitAPI.ChangeRefreshTokenToAccessToken;
end;

procedure TForm1.btnCreateInvoiceFromObjectClick(Sender: TObject);
var
  invoice : TInvoiceClass;
  lineItems : TArray<TLineClass>;
  lineItem : TLineClass;
  invoiceID : string;
  TxnDate : TDateTime;
begin
  invoice := TInvoiceClass.Create;

  TxnDate := now;
  invoiceID := '12345';
  dmIntuitAPI.SetupInvoice(invoice, TxnDate, invoiceID);

  lineItems := TArray<TLineClass>.Create();
  setlength(lineItems, 3);
  lineItem := TLineClass.Create;
  lineItem.Amount := 60;
  lineItem.Description := 'Test Description11';
  lineItem.DetailType := 'SalesItemLineDetail';
  lineItem.Id := '1';
  lineItem.LineNum := 1;

  lineItem.SalesItemLineDetail.ItemRef.name := 'Services';
  lineItem.SalesItemLineDetail.ItemRef.value := '1';
  lineItem.SalesItemLineDetail.qty := 2;
  lineItem.SalesItemLineDetail.unitPrice := 60;
  lineItem.Amount := 120;
  lineItems[0] := lineItem;

  lineItem := TLineClass.Create;
  lineItem.Amount := 60;
  lineItem.Description := 'Test Description22';
  lineItem.DetailType := 'SalesItemLineDetail';
  lineItem.Id := '2';
  lineItem.LineNum := 2;

  lineItem.SalesItemLineDetail.ItemRef.name := 'Services';
  lineItem.SalesItemLineDetail.ItemRef.value := '1';
  lineItem.SalesItemLineDetail.qty := 20;
  lineItem.SalesItemLineDetail.unitPrice := 50;
  lineItem.Amount := 1000;
  lineItems[1] := lineItem;

  lineItem := TLineClass.Create;
  lineItem.Amount := 1120;
  lineItem.Description := '';
  lineItem.DetailType := 'SubTotalLineDetail';
  lineItem.LineNum := 0;
  lineItem.Id := '0';

  lineItem.SalesItemLineDetail.ItemRef.name := '';
  lineItem.SalesItemLineDetail.ItemRef.value := '';
  lineItem.SalesItemLineDetail.qty := 0;
  lineItem.SalesItemLineDetail.unitPrice := 0;
  lineItems[2] := lineItem;

  invoice.Line := lineItems;
  dmIntuitAPI.CreateInvoice(invoice);
end;

procedure TForm1.btnUploadInvoiceClick(Sender: TObject);
var
  invoice : TInvoiceClass;
  lineItems : TArray<TLineClass>;
  lineItem : TLineClass;
  invoiceID : string;
  TxnDate : TDateTime;
  cnt : Integer;
  i : Integer;
  returnedInvoice : TInvoiceClass;
begin
  invoice := TInvoiceClass.Create;

  TxnDate := InvoiceDateDatePicker.Date;
  invoiceID := edtInvoiceNo.Text;
  dmIntuitAPI.SetupInvoice(invoice, TxnDate, invoiceID);

  lineItems := TArray<TLineClass>.Create();
  cnt := 1; // skip heading
  while True do
  begin
    StringGrid1.Cells[0, cnt];
    if StringGrid1.Cells[0, cnt] = '' then
      Break;

    Inc(cnt);
  end;

  SetLength(lineItems, cnt - 1);
  for i := 1 to cnt - 2 do
  begin
    lineItem := TLineClass.Create;
    lineItem.Amount := StrToFloat(StringGrid1.Cells[4, i]);
    lineItem.Description := StringGrid1.Cells[1, i];
    lineItem.DetailType := 'SalesItemLineDetail';
    lineItem.Id := StringGrid1.Cells[0, i];
    lineItem.LineNum := StrToFloat(StringGrid1.Cells[0, i]);

    lineItem.SalesItemLineDetail.ItemRef.name := 'Services';
    lineItem.SalesItemLineDetail.ItemRef.value := '1';
    lineItem.SalesItemLineDetail.qty := StrToFloat(StringGrid1.Cells[2, i]);
    lineItem.SalesItemLineDetail.unitPrice := StrToFloat(StringGrid1.Cells[3, i]);
    lineItems[i - 1] := lineItem;
  end;

  i := cnt - 1;
  lineItem := TLineClass.Create;
  lineItem.Amount := StrToFloat(StringGrid1.Cells[4, i]);
  lineItem.Description := '';
  lineItem.DetailType := 'SubTotalLineDetail';
  lineItem.Id := '0';
  lineItem.LineNum := 0;

  lineItem.SalesItemLineDetail.ItemRef.name := '';
  lineItem.SalesItemLineDetail.ItemRef.value := '';
  lineItem.SalesItemLineDetail.qty := 0;
  lineItem.SalesItemLineDetail.unitPrice := 0;
  lineItems[i - 1] := lineItem;

  invoice.Line := lineItems;
  Memo1.Lines.Add(invoice.ToJsonString);
  returnedInvoice := dmIntuitAPI.CreateInvoice(invoice);

  if returnedInvoice.Id.Length > 0 then
    dmIntuitAPI.UploadAttachment(FileListBox1.FileName, returnedInvoice.Id);
end;

procedure TForm1.btnAddInvoiceLineClick(Sender: TObject);
begin
  StringGrid1.RowCount := StringGrid1.RowCount + 1;
end;

procedure TForm1.LoginClick(Sender: TObject);
begin
  dmIntuitAPI.ShowLoginForm;
end;

procedure ResetGrid(Grid: TStringGrid);
begin
  Grid.RowCount := 1;  // Set the RowCount to 1
  Grid.ColCount := 5;//
  Grid.Rows[0].Clear;  // Clear the first row
  Grid.Cells[0, 0] := 'LineNo';
  Grid.Cells[1, 0] := 'Description';
  Grid.Cells[2, 0] := 'Qty';
  Grid.Cells[3, 0] := 'Rate';
  Grid.Cells[4, 0] := 'Amount';
  Grid.ColWidths[1] := 600;
end;

procedure TForm1.FileListBoxEx1Change(Sender: TObject);
var
  i : Integer;
begin
  ResetGrid(StringGrid1);
  if Assigned(FInvoice) then
    FreeAndNil(FInvoice);
  if FileListBox1.FileName = '' then
    Exit;

  if not TFile.Exists(ChangeFileExt(FileListBox1.FileName, '.json')) then
    Exit;


  FInvoice := ParseInvoiceJsonFile(ChangeFileExt(FileListBox1.FileName, '.json'));

  InvoiceDateDatePicker.Date := FInvoice.Date;
  edtInvoiceNo.Text := FInvoice.InvoiceNumber;
  InvoiceDateFromDatePicker.Date := FInvoice.PeriodFrom;
  InvoiceDateToPicker.Date := FInvoice.PeriodTo;
  meTotalHours.Text := FInvoice.TotalHours.ToString;
  meTotalAmount.Text := FInvoice.Total;
  edtClientRef.Text := FInvoice.ClientRef;
  edtProject.Text := FInvoice.ClientRef.Substring(0,3);


//  for i := 0 to FInvoice.FPages.Count - 1 do
  begin
    for i := 0 to FInvoice.LineItems.Count - 1 do
    begin
      StringGrid1.Cells[0, i + 1] := (i + 1).ToString;//FInvoice.LineItems.LineNo.ToString;
      StringGrid1.Cells[1, i + 1] := FInvoice.LineItems[i].Description;
      StringGrid1.Cells[2, i + 1] := FInvoice.LineItems[i].Quantity.ToString;
      StringGrid1.Cells[3, i + 1] := FloatToStr(FInvoice.LineItems[i].Rate);
      StringGrid1.Cells[4, i + 1] := CurrToStr(FInvoice.LineItems[i].Amount);
    end;
    StringGrid1.RowCount := FInvoice.LineItems.Count + 1;
  end;
end;

end.
