unit fmIntuitDemo;

interface

uses
    Winapi.Windows
  , Winapi.Messages
  , System.SysUtils
  , System.Variants
  , System.Classes
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
  , AdvSmoothEdit
  , AdvSmoothEditButton
  , AdvSmoothDatePicker
  , MoneyEdit
  , AdvUtil
  , AdvObj
  , BaseGrid
  , AdvGrid
  , JSON.InvoiceList
  , JSON.VendorList
  , JSON.ChartOfAccountList
  , JSON.CustomerList
  , JSON.AttachableList
  , PDFInvoices
  , dmIntuit
  ;

type
  TForm1 = class(TForm)
    Button1: TButton;
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
    InvoiceDateDatePicker: TAdvSmoothDatePicker;
    Label1: TLabel;
    InvoiceDateFromDatePicker: TAdvSmoothDatePicker;
    Label2: TLabel;
    InvoiceDateToPicker: TAdvSmoothDatePicker;
    Label3: TLabel;
    edtInvoiceNo: TEdit;
    Label4: TLabel;
    meTotalHours: TMoneyEdit;
    meTotalAmount: TMoneyEdit;
    Label5: TLabel;
    Label6: TLabel;
    StringGrid1: TAdvStringGrid;
    Label7: TLabel;
    edtClientRef: TEdit;
    Label8: TLabel;
    edtProject: TEdit;
    btnUploadInvoice: TButton;
    btnAddInvoiceLine: TButton;
    FileListBox1: TFileListBox;
    DirectoryListBox1: TDirectoryListBox;
    procedure btnAttachFileClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure btnListCustomerClick(Sender: TObject);
    procedure btnListInvoiceClick(Sender: TObject);
    procedure btnAuthWithRefreshTokenClick(Sender: TObject);
    procedure btnCreateInvoiceFromObjectClick(Sender: TObject);
    procedure btnUploadInvoiceClick(Sender: TObject);
    procedure btnAddInvoiceLineClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FileListBoxEx1Change(Sender: TObject);
  private
    FInvoice : TPDFInvoice;
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

procedure TForm1.Button2Click(Sender: TObject);
begin
  dmIntuitAPI.ShowLoginForm;
end;

procedure TForm1.FileListBoxEx1Change(Sender: TObject);
var
  i : Integer;
  l : Integer;
  j : Integer;
begin
  if Assigned(FInvoice) then
    FreeAndNil(FInvoice);
  if FileListBox1.FileName = '' then
    Exit;


  FInvoice := TPDFInvoice.Create(FileListBox1.FileName);
  FInvoice.Memo1 := Memo1;
  FInvoice.Memo2 := Memo1;
  FInvoice.StatusBar1 := StatusBar1;
  FInvoice.DecodeInvoice;
  InvoiceDateDatePicker.Date := FInvoice.InvoiceDate;
  edtInvoiceNo.Text := FInvoice.InvoiceNo;
  InvoiceDateFromDatePicker.Date := FInvoice.InvoiceDateFrom;
  InvoiceDateToPicker.Date := FInvoice.InvoiceDateTo;
  meTotalHours.Text := FInvoice.TotalHours.ToString;
  meTotalAmount.Text := FloatToStr(FInvoice.InvoiceAmount);
  edtClientRef.Text := FInvoice.ClientRef;
  edtProject.Text := FInvoice.Project;

  StringGrid1.Clear;

  l := 1;
  StringGrid1.Cells[0, 0] := 'LineNo';
  StringGrid1.Cells[1, 0] := 'Description';
  StringGrid1.Cells[2, 0] := 'Qty';
  StringGrid1.Cells[3, 0] := 'Rate';
  StringGrid1.Cells[4, 0] := 'Amount';

  StringGrid1.ColWidths[1] := 600;
  for i := 0 to FInvoice.FPages.Count - 1 do
  begin
    for j := 0 to FInvoice.FPages[i].FLineItems.Count - 1 do
    begin
      StringGrid1.Cells[0, l] := FInvoice.FPages[i].FLineItems[j].LineNo.ToString;
      StringGrid1.Cells[1, l] := FInvoice.FPages[i].FLineItems[j].Description;
      StringGrid1.Cells[2, l] := FInvoice.FPages[i].FLineItems[j].Qty.ToString;
      StringGrid1.Cells[3, l] := FloatToStr(FInvoice.FPages[i].FLineItems[j].Rate);
      StringGrid1.Cells[4, l] := CurrToStr(FInvoice.FPages[i].FLineItems[j].Amount);
      Inc(l);
    end;
  end;
end;

end.
