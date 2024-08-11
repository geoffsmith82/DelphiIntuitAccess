unit fmIntuitDemo;

interface

uses
    Winapi.Windows
  , Winapi.Messages
  , System.SysUtils
  , System.Variants
  , System.Classes
  , System.RegularExpressions
  , System.Generics.Collections
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
  , Data.Bind.EngExt
  , Vcl.Bind.DBEngExt
  , System.Rtti
  , System.Bindings.Outputs
  , Vcl.Bind.Editors
  , Data.Bind.DBScope
  , Vcl.Menus
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
    Button3: TButton;
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
    GridPanel3: TGridPanel;
    tsCustomers: TTabSheet;
    lvCustomers: TListView;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    MainMenu: TMainMenu;
    File1: TMenuItem;
    New1: TMenuItem;
    Open1: TMenuItem;
    Save1: TMenuItem;
    SaveAs1: TMenuItem;
    Print1: TMenuItem;
    PrintSetup1: TMenuItem;
    Exit1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    Login1: TMenuItem;
    tsInvoices: TTabSheet;
    lvInvoices: TListView;
    BindSourceDB2: TBindSourceDB;
    LinkListControlToField2: TLinkListControlToField;
    Environment1: TMenuItem;
    Sandbox1: TMenuItem;
    Production1: TMenuItem;
    tsSuppliers: TTabSheet;
    lvSuppliers: TListView;
    BindSourceDB3: TBindSourceDB;
    LinkListControlToField3: TLinkListControlToField;
    procedure btnAttachFileClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure btnCreateInvoiceFromObjectClick(Sender: TObject);
    procedure btnUploadInvoiceClick(Sender: TObject);
    procedure btnAddInvoiceLineClick(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure LoginClick(Sender: TObject);
    procedure FileListBoxEx1Change(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure Production1Click(Sender: TObject);
    procedure Sandbox1Click(Sender: TObject);
  private
    FInvoice: TInvoice;
    procedure ResetGrid(Grid: TStringGrid);
  public
    { Public declarations }
    procedure SetEnvironment(inEnvironment: string);
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
var
  environment: string;
begin
  DirectoryListBox1.Directory := InitialDirectory;
  environment := dmIntuitAPI.TokenManager.RetrieveExtraSectionData('Global', 'Enviromentment');
  if environment.ToLower = 'production' then
  begin
    Production1.Checked := True;
    SetEnvironment(environment);
  end
  else
  begin
    SandBox1.Checked := True;
    SetEnvironment('sandbox');
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  invoiceObj: TJSONObject;
  invoiceLine: TJSONObject;
  invoiceLines: TJSONArray;
  SalesItemLineDetail: TJSONObject;
  ItemRef: TJSONObject;
  CustomerRef: TJSONObject;
begin
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

  dmIntuitAPI.RESTRequest1.Resource := '/v3/company/{RealmId}/invoice';
  dmIntuitAPI.RESTRequest1.AddParameter('RealmId', dmIntuitAPI.RealmId, pkURLSEGMENT);
  dmIntuitAPI.RESTRequest1.Method := rmPOST;
  dmIntuitAPI.RESTRequest1.Execute;

  Memo1.Lines.Add(dmIntuitAPI.RESTRequest1.Response.Content);
end;

procedure TForm1.btnCreateInvoiceFromObjectClick(Sender: TObject);
var
  invoice: TInvoiceClass;
  lineItems: TArray<TLineClass>;
  lineItem: TLineClass;
  invoiceID: string;
  TxnDate: TDateTime;
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
  invoice: TInvoiceClass;
  lineItems: TArray<TLineClass>;
  lineItem: TLineClass;
  invoiceID: string;
  TxnDate: TDateTime;
  cnt: Integer;
  i: Integer;
  returnedInvoice: TInvoiceClass;
  LineItemsList : TObjectList<TLineClass>;
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
    Inc(cnt);
    if StringGrid1.Cells[0, cnt] = '' then
      Break;
  end;

//  SetLength(lineItems, cnt - 1);
  LineItemsList := TObjectList<TLineClass>.Create(False);
  for i := 1 to cnt - 1 do
  begin
    try
      lineItem := TLineClass.Create;
      lineItem.Amount := StrToFloat(StringGrid1.Cells[4, i]);
      lineItem.Description := StringGrid1.Cells[1, i];
      lineItem.DetailType := 'SalesItemLineDetail';
      lineItem.Id := StringGrid1.Cells[0, i];
      lineItem.LineNum := StrToFloat(StringGrid1.Cells[0, i]);

      lineItem.SalesItemLineDetail.ItemRef.name := 'Services';
      lineItem.SalesItemLineDetail.ItemRef.value := '1';
//      lineItem.SalesItemLineDetail.TaxCodeRef.value := 'GST free';
      lineItem.SalesItemLineDetail.qty := StrToFloat(StringGrid1.Cells[2, i]);
      lineItem.SalesItemLineDetail.unitPrice := StrToFloat(StringGrid1.Cells[3, i]);
      LineItemsList.Add(lineItem);
     // lineItems[i - 1] := lineItem;
    except
      on e: Exception do
      begin
        ShowMessage(e.Message);
      end;
    end;
  end;

{  i := cnt;
  lineItem := TLineClass.Create;
  lineItem.Amount := StrToFloat(StringGrid1.Cells[4, i]);
  lineItem.Description := '';
  lineItem.DetailType := 'SubTotalLineDetail';
  lineItem.Id := '0';
  lineItem.LineNum := 0;

  lineItem.SalesItemLineDetail.ItemRef.name := '';
  lineItem.SalesItemLineDetail.ItemRef.value := '';
  lineItem.SalesItemLineDetail.qty := 0;
  lineItem.SalesItemLineDetail.unitPrice := 0;}
//  lineItem.SalesItemLineDetail.TaxCodeRef.value := 'GST free';
  //lineItems[i - 1] := lineItem;
 // LineItemsList.Add(lineItem);

  SetLength(lineItems, LineItemsList.Count);
  for I := 0 to LineItemsList.Count - 1 do
  begin
    lineItems[i] := LineItemsList[i];
  end;

  invoice.Line := lineItems;

  FreeAndNil(LineItemsList);
  Memo1.Lines.Add(invoice.ToJsonString);

 // invoice.TxnTaxDetail.TotalTax := 0;

  returnedInvoice := dmIntuitAPI.CreateInvoice(invoice);

  if returnedInvoice.Id.Length > 0 then
    dmIntuitAPI.UploadAttachment(FileListBox1.FileName, returnedInvoice.Id);
end;

procedure TForm1.btnAddInvoiceLineClick(Sender: TObject);
begin
  StringGrid1.RowCount := StringGrid1.RowCount + 1;
end;

procedure TForm1.Exit1Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TForm1.LoginClick(Sender: TObject);
begin
  dmIntuitAPI.ShowLoginForm;
end;

procedure TForm1.ResetGrid(Grid: TStringGrid);
var
  I: Integer;
begin
  Grid.ColCount := 5; //

  for I := 0 to Grid.RowCount - 1 do
  begin
    Grid.Rows[i].Clear;  // Clear the first row
  end;
  Grid.RowCount := 1;  // Set the RowCount to 1

  Grid.Cells[0, 0] := 'LineNo';
  Grid.Cells[1, 0] := 'Description';
  Grid.Cells[2, 0] := 'Qty';
  Grid.Cells[3, 0] := 'Rate';
  Grid.Cells[4, 0] := 'Amount';
  Grid.ColWidths[1] := 600;
end;

procedure TForm1.SetEnvironment(inEnvironment: string);
begin
  dmIntuitAPI.SetEnvironment(inEnvironment);
  if inEnvironment.ToLower = 'sandbox' then
  begin
    Caption := 'Intuit Login Demo - Sandbox Environment';

  end
  else if inEnvironment.ToLower = 'production' then
  begin
    Caption := 'Intuit Login Demo - Production Environment';
  end
  else
  begin
    raise Exception.Create('Unknown Environment Selected');
  end;
end;

procedure TForm1.FileListBoxEx1Change(Sender: TObject);
var
  i: Integer;
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
  edtProject.Text := FInvoice.ClientRef.Substring(0, 3);

  StringGrid1.RowCount := FInvoice.LineItems.Count + 1;
  for i := 0 to FInvoice.LineItems.Count - 1 do
  begin
    StringGrid1.Cells[0, i + 1] := (i + 1).ToString; //FInvoice.LineItems.LineNo.ToString;
    StringGrid1.Cells[1, i + 1] := FInvoice.LineItems[i].Description;
    StringGrid1.Cells[2, i + 1] := FInvoice.LineItems[i].Quantity.ToString;
    StringGrid1.Cells[3, i + 1] := FloatToStr(FInvoice.LineItems[i].Rate);
    StringGrid1.Cells[4, i + 1] := CurrToStr(FInvoice.LineItems[i].Amount);
  end;
end;

procedure TForm1.PageControl1Change(Sender: TObject);
begin
  if PageControl1.ActivePage.Caption = 'Customers' then
  begin
    //ShowMessage('Customers');
    dmIntuitAPI.GetCustomers;
  end
  else if PageControl1.ActivePage.Caption = 'Invoices' then
  begin
    //ShowMessage('Invoices');
    dmIntuitAPI.ListInvoices;
  end
  else if PageControl1.ActivePage.Caption = 'Suppliers' then
  begin
    //ShowMessage('Suppliers');
    dmIntuitAPI.ListVendors;
  end
end;

procedure TForm1.Production1Click(Sender: TObject);
begin
  dmIntuitAPI.TokenManager.StoreExtraSectionData('Global', 'Environment', 'production');
  SetEnvironment('production');
end;

procedure TForm1.Sandbox1Click(Sender: TObject);
begin
  dmIntuitAPI.TokenManager.StoreExtraSectionData('Global', 'Environment', 'sandbox');
  SetEnvironment('sandbox');
end;

end.

