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
  , IPPeerClient
  , REST.Client
  , REST.Authenticator.OAuth
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
  , OAuth2.Intuit
  , JSON.InvoiceList
  , JSON.VendorList
  , JSON.ChartOfAccountList
  , JSON.CustomerList
  , JSON.AttachableList
  , fmLogin
  , PDFInvoices
  ;

type
  TForm1 = class(TForm)
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    Button1: TButton;
    Button3: TButton;
    btnListCustomer: TButton;
    btnListInvoice: TButton;
    btnAuthWithRefreshToken: TButton;
    btnCreateInvoiceFromObject: TButton;
    RESTResponse1: TRESTResponse;
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
    procedure FormDestroy(Sender: TObject);
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
    FrealmId : String;
    FInvoice : TPDFInvoice;
    FfrmLogin: TfrmLogin;
    function CreateInvoice(invoice: TInvoiceClass): TInvoiceClass;
    procedure SetupInvoice(invoice: TInvoiceClass; TxnDate: TDate; invoiceID: String);
    procedure UploadAttachment(inFilename, inInvoiceID: string);
  public
    { Public declarations }
    OAuth2Authenticator1: TIntuitOAuth2;
  published
    property RealmId : string read FrealmId write FrealmId;
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
  , IdMultipartFormData
  ;

procedure TForm1.btnAttachFileClick(Sender: TObject);
begin
  if FileListBox1.FileName.Length = 0 then
  begin
    ShowMessage('Please Select a file first');
    Exit;
  end;
  UploadAttachment(FileListBox1.FileName, edtInvoiceNo.Text);
end;

procedure TForm1.UploadAttachment(inFilename:string; inInvoiceID:string);
var
  attachable : TAttachableClass;
  attachableRefArr : TArray<TAttachableRefClass>;
  attachableRef : TAttachableRefClass;
  attachJSON : TJSONObject;
  RequestStream : TStringStream;
  param : TRESTRequestParameter;
begin
  if not TFile.Exists(inFilename) then
  begin
    raise Exception.Create('File Does not exist - ' + inFilename);
  end;

  attachable := TAttachableClass.Create;
  attachable.ContentType := 'application/pdf';
  attachable.FileName := ExtractFileName(inFilename);

  attachableRefArr := TArray<TAttachableRefClass>.Create();
  SetLength(attachableRefArr, 1);
  attachableRef := TAttachableRefClass.Create;

  attachableRefArr[0] := attachableRef;

  attachableRef.EntityRef.&type := 'Invoice';
  attachableRef.EntityRef.value := inInvoiceID;
  attachableRef.IncludeOnSend := False;

  attachable.AttachableRef := attachableRefArr;

  RESTRequest1.Method := rmPOST;
  RESTRequest1.Resource := '/v3/company/' + FrealmId + '/upload';

  Memo1.Lines.Add(attachable.ToJsonString);
  Memo1.Lines.Add('--------');

  attachJSON := TJSONObject.ParseJSONValue(attachable.ToJsonString) as TJSONObject;

  attachJSON.RemovePair('MetaData');
  attachJSON.RemovePair('Id');
  attachJSON.RemovePair('Size');
  attachJSON.RemovePair('TempDownloadUri');
  attachJSON.RemovePair('domain');
  attachJSON.RemovePair('sparse');
  attachJSON.RemovePair('SyncToken');

  RESTRequest1.ClearBody;
  // This workaround is required to get around a bug in the Delphi REST Components
  param := RESTRequest1.Params.AddItem('file_metadata_01', '', TRESTRequestParameterKind.pkREQUESTBODY,
      [], TRESTContentType.ctAPPLICATION_JSON);
  RequestStream := TStringStream.Create;
  try
    RequestStream.WriteString(attachjson.ToJSON);
    param.SetStream(RequestStream);
  finally
    FreeAndNil(RequestStream);
  end;
  // End workaround

  RESTRequest1.AddFile('file_content_01', inFilename, TRESTContentType.ctAPPLICATION_PDF);
  RESTRequest1.Execute;

  Memo1.Lines.Add(attachJSON.ToJSON);
  Memo1.Lines.Add('--------');
  Memo1.Lines.Add(RESTResponse1.Content);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  OAuth2Authenticator1 := TIntuitOAuth2.Create(nil);
  OAuth2Authenticator1.AuthorizationEndpoint := 'https://appcenter.intuit.com/connect/oauth2';
  OAuth2Authenticator1.AccessTokenEndpoint := 'https://oauth.platform.intuit.com/oauth2/v1/tokens/bearer';

  OAuth2Authenticator1.RedirectionEndpoint := 'https://developer.intuit.com/v2/OAuth2Playground/RedirectUrl';

  OAuth2Authenticator1.Scope := 'com.intuit.quickbooks.accounting openid profile email phone address';
  OAuth2Authenticator1.ClientID := SECRET_INTUIT_CLIENTID;
  OAuth2Authenticator1.ClientSecret := SECRET_INTUIT_CLIENTSECRET;

  OAuth2Authenticator1.ResponseType := TOAuth2ResponseType.rtCODE;

  RESTClient1.Authenticator := OAuth2Authenticator1;

  FfrmLogin := TfrmLogin.Create(nil);

  DirectoryListBox1.Directory := InitialDirectory;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FfrmLogin);
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  crlf : string;
  invoiceObj : TJSONObject;
  invoiceLine : TJSONObject;
  invoiceLines : TJSONArray;
  SalesItemLineDetail : TJSONObject;
  ItemRef : TJSONObject;
  CustomerRef : TJSONObject;
begin
  crlf := #10 + #13;
  RESTRequest1.Resource := '/v3/company/' + FrealmId + '/invoice';
  invoiceObj := TJSONObject.Create;
  invoiceLines := TJSONArray.Create;

  invoiceLine := TJSONObject.Create;
  invoiceLine.AddPair('Amount', TJSONNumber.Create(100.00));
  invoiceLine.AddPair('DetailType','SalesItemLineDetail');

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

  RESTRequest1.Client.ProxyServer := 'localhost';
  RESTRequest1.Client.ProxyPort := 5555;
  RESTRequest1.Method := rmPOST;
  RESTRequest1.Execute;
  Memo1.Lines.Add(RESTRequest1.Response.Content);
end;

procedure TForm1.btnListCustomerClick(Sender: TObject);
var
  customers : TCustomerListClass;
  i : Integer;
begin
  RESTRequest1.Method := rmGET;
  RESTRequest1.Resource := '/v3/company/' + FrealmId + '/query?query=select * from Customer Where Metadata.LastUpdatedTime > ' + QuotedStr('2015-03-01');
  RESTRequest1.Execute;

  customers := TCustomerListClass.FromJsonString(RESTRequest1.Response.Content);

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
  RESTRequest1.Method := rmGET;
  RESTRequest1.Resource := '/v3/company/' + FrealmId + '/query?query=select * from Invoice Where Id > ' + QuotedStr('166');
  RESTRequest1.Execute;
  try
    invoiceList := TJSONInvoiceListClass.FromJsonString(RESTRequest1.Response.Content);
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
  OAuth2Authenticator1.RefreshToken := FfrmLogin.GetRefreshToken;
  FrealmID := SECRET_REALMID;
  OAuth2Authenticator1.ChangeRefreshTokenToAccesToken;
end;

procedure TForm1.SetupInvoice(invoice: TInvoiceClass; TxnDate:TDate; invoiceID:String);
begin
  invoice.CurrencyRef.name  := 'Australian Dollar';
  invoice.CurrencyRef.value := 'AUD';
  invoice.CustomerRef.name  := SECRET_CUSTOMER_NAME;
  invoice.CustomerRef.value := SECRET_CUSTOMER_ID;
  invoice.EmailStatus := 'NotSet';
  invoice.GlobalTaxCalculation := 'NotApplicable';
  invoice.PrintStatus := 'NotSet';
  invoice.SyncToken := '0';
  invoice.domain := 'QBO';
  invoice.TxnDate := FormatDatetime('yyyy-mm-dd', TxnDate);  //'2019-05-30';
  invoice.CustomerMemo.value := invoiceID;
  invoice.TrackingNum := invoiceID;
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
  SetupInvoice(invoice, TxnDate, invoiceID);

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
  CreateInvoice(invoice);
end;

procedure TForm1.btnUploadInvoiceClick(Sender: TObject);
var
  invoice : TInvoiceClass;
  lineItems : TArray<TLineClass>;
  lineItem : TLineClass;
  invoiceID : string;
  TxnDate : TDateTime;
  cnt : Integer;
  i: Integer;
  returnedInvoice : TInvoiceClass;
begin
  invoice := TInvoiceClass.Create;

  TxnDate := InvoiceDateDatePicker.Date;
  invoiceID := edtInvoiceNo.Text;
  SetupInvoice(invoice, TxnDate, invoiceID);

  lineItems := TArray<TLineClass>.Create();
  cnt := 1; // skip heading
  while True do
  begin
    StringGrid1.Cells[0,cnt];
    if StringGrid1.Cells[0,cnt] = '' then
      Break;

    Inc(cnt);
  end;

  SetLength(lineItems, cnt-1);
  for i := 1 to cnt-2 do
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
  lineItems[i-1] := lineItem;

  invoice.Line := lineItems;
  Memo1.Lines.Add(invoice.ToJsonString);
  returnedInvoice := CreateInvoice(invoice);

  if returnedInvoice.Id.Length > 0 then
    UploadAttachment(FileListBox1.FileName, returnedInvoice.Id);
end;

procedure TForm1.btnAddInvoiceLineClick(Sender: TObject);
begin
   StringGrid1.RowCount := StringGrid1.RowCount + 1;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  uri : TURI;
begin
  uri := TURI.Create('https://appcenter.intuit.com/connect/oauth2');
  uri.AddParameter('client_id', SECRET_INTUIT_CLIENTID);
  uri.AddParameter('client_secret', SECRET_INTUIT_CLIENTSECRET);
  uri.AddParameter('scope', 'com.intuit.quickbooks.accounting');
  uri.AddParameter('redirect_uri', SECRET_REDIRECT_URL);
  uri.AddParameter('state', '2342342323');
  uri.AddParameter('response_type', 'code');

  FfrmLogin.Login(uri.ToString);
end;

function TForm1.CreateInvoice(invoice: TInvoiceClass): TInvoiceClass;
var
  invoiceJSON: TJSONObject;
  invoiceText: string;
  retJSON : TJSONObject;
begin
  RESTRequest1.ResetToDefaults;
  RESTResponse1.ResetToDefaults;

  invoiceJSON := TJSONObject.ParseJSONValue(invoice.ToJsonString) as TJSONObject;
  invoiceJSON.RemovePair('allowIPNPayment');
  invoiceJSON.RemovePair('allowOnlineACHPayment');
  invoiceJSON.RemovePair('allowOnlinePayment');
  invoiceJSON.RemovePair('allowOnlineCreditCardPayment');
  invoiceJSON.RemovePair('CreditCardPayment');
  invoiceJSON.RemovePair('EmailStatus');
  invoiceJSON.RemovePair('Balance');
  invoiceJSON.RemovePair('Deposit');
  invoiceJSON.RemovePair('DocNumber');
  invoiceJSON.RemovePair('Id');
  invoiceJSON.RemovePair('DueDate');
  invoiceJSON.RemovePair('TxnSource');
  invoiceJSON.RemovePair('GlobalTaxCalculation');
  invoiceJSON.RemovePair('MetaData');
  invoiceJSON.RemovePair('TotalAmt');
  invoiceJSON.RemovePair('domain');
  invoiceJSON.RemovePair('sparse');
  invoiceText := invoiceJSON.ToJSON;
  Memo1.Lines.Add(invoiceText);
  RESTRequest1.Method := rmPost;
  FrealmID := SECRET_REALMID;
  RESTRequest1.Resource := '/v3/company/' + FrealmId + '/invoice?minorversion=38';
  RESTRequest1.AddBody(invoiceText, ctAPPLICATION_JSON);
  RESTRequest1.Execute;

  Memo1.Lines.Add(RESTResponse1.Content);
  retJSON := TJSONObject.ParseJSONValue(RESTResponse1.Content) as TJSONObject;
  try
  Result := TInvoiceClass.FromJsonString(retJSON.Values['Invoice'].ToJSON);
  finally
    FreeAndNil(retJSON);
  end;
end;

procedure TForm1.FileListBoxEx1Change(Sender: TObject);
var
  i : Integer;
  l : Integer;
  j: Integer;
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
  StringGrid1.Cells[4, 0] := 'Amount'
  ;

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
