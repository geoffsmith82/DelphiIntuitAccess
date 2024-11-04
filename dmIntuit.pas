unit dmIntuit;

interface

uses
    System.SysUtils
  , System.Classes
  , System.JSON
  , System.IOUtils
  , Winapi.Windows
  , REST.Types
  , REST.Client
  , REST.Authenticator.OAuth
  , System.Net.URLClient
  , Data.Bind.Components
  , Data.Bind.ObjectScope
  , FireDAC.Stan.Intf
  , FireDAC.Stan.Option
  , FireDAC.Stan.Param
  , FireDAC.Stan.Error
  , FireDAC.DatS
  , FireDAC.Phys.Intf
  , FireDAC.DApt.Intf
  , Data.DB
  , FireDAC.Comp.DataSet
  , FireDAC.Comp.Client
  , JSON.CustomerList
  , JSON.InvoiceList
  , JSON.AttachableList
  , JSON.VendorList
  , OAuth2.Intuit
  , TokenManager
  , fmLogin
  ;

type
  TOnLogStatus = procedure(inText: string) of object;

  EIntuitException = class(Exception)
  private
    FTid : string;
  public
    constructor Create(tid:string; msg: string);
    property Tid: string read FTid;
  end;

  TdmIntuitAPI = class(TDataModule)
    RESTResponse1: TRESTResponse;
    RESTRequest1: TRESTRequest;
    RESTClient1: TRESTClient;
    tblCustomers: TFDMemTable;
    tblCustomersActive: TBooleanField;
    tblInvoices: TFDMemTable;
    tblInvoicesTotalAmount: TFloatField;
    tblCustomersId: TWideStringField;
    tblCustomersDisplayName: TWideStringField;
    tblCustomersSyncToken: TWideStringField;
    tblCustomersPrimaryEmailAddr: TWideStringField;
    tblInvoicesId: TWideStringField;
    tblInvoicesSyncToken: TWideStringField;
    tblInvoicesTxnDate: TWideStringField;
    tblInvoicesCustomerRefName: TWideStringField;
    tblInvoicesCustomerRefValue: TWideStringField;
    tblVendors: TFDMemTable;
    tblVendorsId: TWideStringField;
    tblVendorsDisplayName: TWideStringField;
    tblVendorsActive: TBooleanField;
    tblVendorsSyncToken: TWideStringField;
    tblVendorsBalance: TFloatField;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  strict private
    FrealmId : String;
    FOnLog : TOnLogStatus;
    FfrmLogin: TfrmLogin;
    FTokenManager: TTokenManager;
    OAuth2Authenticator1: TIntuitOAuth2;
    procedure DoLog(inText: string);
  private
    { Private declarations }
    FClientID : string;
    FClientSecret : string;
    function GetEnvironment: string;
  public
    { Public declarations }
    function CreateInvoice(invoice: TInvoiceClass): TInvoiceClass;
    function GetCustomers: TCustomerListClass;
    procedure ListInvoices;
    procedure ListVendors;
    procedure SetupInvoice(invoice: TInvoiceClass; TxnDate: TDate; invoiceID: String);
    procedure UploadAttachment(inFilename, inInvoiceID: string);
    procedure ChangeRefreshTokenToAccessToken;
    procedure ShowLoginForm;
    procedure HandleOAuthCodeRedirect(uri: TURI);
    procedure SetEnvironment(inEnvironment: string);
    function GetBaseURL: string;
    function GetEnvironmentData(inName: string): string;
  published
    property RealmId : string read FrealmId write FrealmId;
    property TokenManager: TTokenManager read FTokenManager;
    property Environment: string read GetEnvironment;
  end;

var
  dmIntuitAPI: TdmIntuitAPI;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

uses
    secrets
  ;

procedure TdmIntuitAPI.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(OAuth2Authenticator1);
  FreeAndNil(FfrmLogin);
  FreeAndNil(FTokenManager);
end;

procedure TdmIntuitAPI.DataModuleCreate(Sender: TObject);
begin
  FfrmLogin := TfrmLogin.Create(nil);
  FTokenManager := TTokenManager.Create(ChangeFileExt(ParamStr(0), '.ini'));
  OAuth2Authenticator1 := TIntuitOAuth2.Create(nil);

  OAuth2Authenticator1.AuthorizationEndpoint := 'https://appcenter.intuit.com/connect/oauth2';
  OAuth2Authenticator1.AccessTokenEndpoint := 'https://oauth.platform.intuit.com/oauth2/v1/tokens/bearer';

  OAuth2Authenticator1.RedirectionEndpoint := SECRET_REDIRECT_URL; //'https://developer.intuit.com/v2/OAuth2Playground/RedirectUrl';

  OAuth2Authenticator1.Scope := 'com.intuit.quickbooks.accounting openid';
  SetEnvironment(environment);

  OAuth2Authenticator1.ResponseType := TOAuth2ResponseType.rtCODE;
  OAuth2Authenticator1.RefreshToken := FTokenManager.RetrieveDecryptedToken(Environment, 'refresh_token');

  RealmId := GetEnvironmentData('RealmId');

  RESTClient1.Authenticator := OAuth2Authenticator1;
  RESTClient1.BaseURL := GetBaseURL;
end;

procedure TdmIntuitAPI.ChangeRefreshTokenToAccessToken;
begin
  OAuth2Authenticator1.RefreshToken := TokenManager.UnprotectSecret(GetEnvironmentData('refresh_token'));
  RealmId := GetEnvironmentData('RealmId');
  OAuth2Authenticator1.ChangeRefreshTokenToAccesToken;
end;

function TdmIntuitAPI.CreateInvoice(invoice: TInvoiceClass): TInvoiceClass;
var
  invoiceJSON: TJSONObject;
  invoiceText: string;
  retJSON : TJSONObject;
  tid : string;
begin
  RESTRequest1.ResetToDefaults;
  RESTResponse1.ResetToDefaults;
  try

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
  doLog(invoiceText);
  RESTRequest1.Method := rmPost;
  FrealmID := GetEnvironmentData('RealmId');
  RESTRequest1.Resource := '/v3/company/' + FrealmId + '/invoice';

  RESTRequest1.AddBody(invoiceText, ctAPPLICATION_JSON);
  RESTRequest1.Execute;

  doLog(RESTResponse1.Content);
  retJSON := TJSONObject.ParseJSONValue(RESTResponse1.Content) as TJSONObject;
  try
    Result := TInvoiceClass.FromJsonString(retJSON.Values['Invoice'].ToJSON);
  finally
    FreeAndNil(retJSON);
  end;
  except
    on e : Exception do
    begin
      tid := RESTResponse1.Headers.Values['intuit_tid'];
      raise EIntuitException.Create(tid, e.Message);
    end;
  end;
end;

procedure TdmIntuitAPI.SetEnvironment(inEnvironment: string);
begin
  TokenManager.StoreExtraSectionData('Global', 'Environment', inEnvironment);

  if inEnvironment.ToLower = 'sandbox' then
  begin
    FClientID := SECRET_SANDBOX_INTUIT_CLIENTID;
    FClientSecret := SECRET_SANDBOX_INTUIT_CLIENTSECRET;
  end
  else if inEnvironment.ToLower = 'production' then
  begin
    FClientID := SECRET_PRODUCTION_INTUIT_CLIENTID;
    FClientSecret := SECRET_PRODUCTION_INTUIT_CLIENTSECRET;
  end
  else
  begin
    raise Exception.Create('Unknown Environment Selected');
  end;
  OAuth2Authenticator1.ClientID := FClientID;
  OAuth2Authenticator1.ClientSecret := FClientSecret;
  OAuth2Authenticator1.RefreshToken := TokenManager.RetrieveDecryptedToken(Environment, 'refresh_token');
  FrealmId := self.GetEnvironmentData('RealmId');
  RESTClient1.BaseURL := GetBaseURL;
end;

procedure TdmIntuitAPI.SetupInvoice(invoice: TInvoiceClass; TxnDate:TDate; invoiceID:String);
begin
  invoice.CurrencyRef.name  := 'Australian Dollar';
  invoice.CurrencyRef.value := 'AUD';
  invoice.CustomerRef.name  := SECRET_CUSTOMER_NAME;
  invoice.CustomerRef.value := SECRET_CUSTOMER_ID;
  invoice.DocNumber := invoiceID;
  invoice.EmailStatus := 'NotSet';
  invoice.GlobalTaxCalculation := 'NotApplicable';
  invoice.PrintStatus := 'NotSet';
  invoice.SyncToken := '0';
  invoice.domain := 'QBO';
  invoice.TxnDate := FormatDatetime('yyyy-mm-dd', TxnDate);  //'2019-05-30';
  invoice.CustomerMemo.value := invoiceID;
  invoice.TrackingNum := invoiceID;
end;

procedure TdmIntuitAPI.DoLog(inText: string);
begin
  if Assigned(FOnLog) then
    FOnLog(inText);
end;

procedure TdmIntuitAPI.ListInvoices;
var
  invoiceList : TJSONInvoiceListClass;
  invoice : TInvoiceClass;
begin
  RESTRequest1.Method := rmGET;
  RESTRequest1.Resource := '/v3/company/{RealmId}/query?query=select * from Invoice';// Where Id > ' + QuotedStr('166');
  RESTRequest1.AddParameter('RealmId', RealmId, pkURLSEGMENT);
  RESTRequest1.ExecuteAsync(procedure ()
      var
        i: Integer;
      begin
      try
        invoiceList := TJSONInvoiceListClass.FromJsonString(dmIntuitAPI.RESTRequest1.Response.Content);
        tblInvoices.Active := True;
        for i := 0 to Length(invoiceList.QueryResponse.Invoice) - 1 do
        begin
          invoice := invoiceList.QueryResponse.Invoice[i];
          tblInvoices.Append;
          tblInvoicesId.Value := invoice.Id;
          tblInvoicesSyncToken.Value := invoice.SyncToken;
          tblInvoicesTxnDate.Value := invoice.TxnDate;
          tblInvoicesCustomerRefName.Value := invoice.CustomerRef.name;
          tblInvoicesCustomerRefValue.Value := invoice.CustomerRef.value;
          tblInvoicesTotalAmount.Value := invoice.TotalAmt;
          tblInvoices.Post;
        end;
      finally
        FreeAndNil(invoiceList);
      end;
  end);
end;

function TdmIntuitAPI.GetBaseURL: string;
begin
  if Environment = 'production' then
    Result := 'https://quickbooks.api.intuit.com'
  else
    Result := 'https://sandbox-quickbooks.api.intuit.com';
end;

function TdmIntuitAPI.GetCustomers: TCustomerListClass;
var
  customers : TCustomerListClass;
begin
  RESTRequest1.ResetToDefaults;
  RESTRequest1.Method := rmGET;
  RESTRequest1.Resource := '/v3/company/{RealmId}/query?query=select * from Customer Where Metadata.LastUpdatedTime > ' + QuotedStr('2015-03-01');
  RESTRequest1.AddParameter('RealmId', RealmId, pkURLSEGMENT);
  RESTRequest1.AddParameter('minorversion', '73', TRESTRequestParameterKind.pkQUERY);
  RESTRequest1.ExecuteAsync(procedure ()
  var
    i : Integer;
  begin
    customers := TCustomerListClass.FromJsonString(RESTRequest1.Response.Content);
    tblCustomers.Active := True;
    for i := 0 to Length(customers.QueryResponse.Customer) - 1 do
    begin
      tblCustomers.Append;
      tblCustomersId.Value := customers.QueryResponse.Customer[i].Id;
      tblCustomersSyncToken.Value := customers.QueryResponse.Customer[i].SyncToken;
      tblCustomersDisplayName.Value := customers.QueryResponse.Customer[i].DisplayName;
      tblCustomersPrimaryEmailAddr.Value := customers.QueryResponse.Customer[i].PrimaryEmailAddr.Address;
      tblCustomers.Post;
    //    Memo1.Lines.Add('Id: ' + customers.QueryResponse.Customer[i].Id);
    //    Memo1.Lines.Add('DisplayName: ' + customers.QueryResponse.Customer[i].DisplayName);
    //    Memo1.Lines.Add('Balance: ' + customers.QueryResponse.Customer[i].Balance.ToString)
    end;
  end);


end;

procedure TdmIntuitAPI.ListVendors;
var
  vendors : TJSONVendorListClass;
begin
  RESTRequest1.ResetToDefaults;
  RESTRequest1.Method := rmGET;
  RESTRequest1.Resource := '/v3/company/{RealmId}/query?query=select * from Vendor Where Metadata.LastUpdatedTime > ' + QuotedStr('2015-03-01');
  RESTRequest1.AddParameter('RealmId', RealmId, pkURLSEGMENT);
  RESTRequest1.AddParameter('minorversion', '73', TRESTRequestParameterKind.pkQUERY);
  RESTRequest1.ExecuteAsync(procedure ()
  var
    i : Integer;
  begin
    vendors := TJSONVendorListClass.FromJsonString(RESTRequest1.Response.Content);
    tblVendors.Active := True;
    for i := 0 to Length(vendors.QueryResponse.Vendor) - 1 do
    begin
      tblVendors.Append;
      tblVendorsId.Value := vendors.QueryResponse.Vendor[i].Id;
      tblVendorsSyncToken.Value := vendors.QueryResponse.Vendor[i].SyncToken;
      tblVendorsDisplayName.Value := vendors.QueryResponse.Vendor[i].DisplayName;
      tblVendorsBalance.Value := vendors.QueryResponse.Vendor[i].Balance;
      tblVendors.Post;
    end;
  end);
end;

function TdmIntuitAPI.GetEnvironment: string;
begin
  Result := TokenManager.RetrieveExtraSectionData('Global', 'Environment');
  if Result.IsEmpty then
    Result := 'sandbox';
end;

function TdmIntuitAPI.GetEnvironmentData(inName: string): string;
begin
  Result := TokenManager.RetrieveExtraSectionData(Environment, inName);
end;

procedure TdmIntuitAPI.HandleOAuthCodeRedirect(uri: TURI);
var
  code : string;
  state : string;
begin
  code := uri.ParameterByName['code'];
  state := uri.ParameterByName['state'];
  RealmId := uri.ParameterByName['realmId'];

  OAuth2Authenticator1.AuthCode := code;
//  Form1.Memo1.Lines.Add('url:'+URL);

  OAuth2Authenticator1.ChangeAuthCodeToAccesToken;
//  Form1.Memo1.Lines.Add('Access Granted');
//  Form1.Memo1.Lines.Add('RefreshToken=' + OAuth2Authenticator1.RefreshToken);
//  Form1.Memo1.Lines.Add('Access Token');

//  Form1.Memo1.Lines.Add(OAuth2Authenticator1.AccessToken);
  TokenManager.StoreEncryptedToken(environment, 'refresh_token', OAuth2Authenticator1.RefreshToken);
  TokenManager.StoreExtraSectionData(environment, 'RealmId', RealmId);
end;

procedure TdmIntuitAPI.ShowLoginForm;
var
  uri : TURI;
begin
  uri := TURI.Create('https://appcenter.intuit.com/connect/oauth2');
  uri.AddParameter('client_id', FClientID);
  uri.AddParameter('client_secret', FClientSecret);
  uri.AddParameter('scope', 'com.intuit.quickbooks.accounting');
  uri.AddParameter('redirect_uri', SECRET_REDIRECT_URL);
  uri.AddParameter('state', '2342342323');
  uri.AddParameter('response_type', 'code');

  FfrmLogin.Login(uri.ToString, SECRET_REDIRECT_URL);
end;

procedure TdmIntuitAPI.UploadAttachment(inFilename:string; inInvoiceID:string);
var
  attachable : TAttachableClass;
  attachableRefArr : TArray<TAttachableRefClass>;
  attachableRef : TAttachableRefClass;
  attachJSON : TJSONObject;
  param : TRESTRequestParameter;
  tid : string;
begin
  try
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
  RESTRequest1.Resource := '/v3/company/{RealmId}/upload';
  RESTRequest1.AddParameter('RealmId', RealmId, pkURLSEGMENT);
  RESTRequest1.AddParameter('minorversion', '73', TRESTRequestParameterKind.pkQUERY);

  DoLog(attachable.ToJsonString);
  DoLog('--------');

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
  param := RESTRequest1.Params.AddItem('file_metadata_01', attachjson.ToJSON, TRESTRequestParameterKind.pkREQUESTBODY,
      [], TRESTContentType.ctAPPLICATION_JSON);
{  RequestStream := TStringStream.Create;
  try
    RequestStream.WriteString(attachjson.ToJSON);
    param.SetStream(RequestStream);
  finally
    FreeAndNil(RequestStream);
  end;}
  // End workaround

  RESTRequest1.AddFile('file_content_01', inFilename, TRESTContentType.ctAPPLICATION_PDF);
  RESTRequest1.Execute;

  DoLog(attachJSON.ToJSON);
  DoLog('--------');
  DoLog(RESTResponse1.Content);
  except
    on e : Exception do
    begin
      tid := RESTResponse1.Headers.Values['intuit_tid'];
      raise EIntuitException.Create(tid, e.Message);
    end;
  end;
end;


{ EIntuitException }

constructor EIntuitException.Create(tid, msg: string);
begin
  inherited Create(msg);
  FTid := tid;
  OutputDebugString(PChar('Intuit_Tid:' + tid + ' EXCEPTION: ' + msg));
end;

end.
