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
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  strict private
    FrealmId : String;
    FOnLog : TOnLogStatus;
    FfrmLogin: TfrmLogin;
    FTokenManager: TTokenManager;
    OAuth2Authenticator1: TIntuitOAuth2;
    procedure doLog(inText: string);
  private
    { Private declarations }
  public
    { Public declarations }
    function CreateInvoice(invoice: TInvoiceClass): TInvoiceClass;
    function GetCustomers: TCustomerListClass;
    procedure ListInvoices;
    procedure SetupInvoice(invoice: TInvoiceClass; TxnDate: TDate; invoiceID: String);
    procedure UploadAttachment(inFilename, inInvoiceID: string);
    procedure ChangeRefreshTokenToAccessToken;
    procedure ShowLoginForm;
    procedure HandleOAuthCodeRedirect(uri: TURI);

  published
    property RealmId : string read FrealmId write FrealmId;
    property TokenManager: TTokenManager read FTokenManager;
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
  OAuth2Authenticator1 := TIntuitOAuth2.Create(nil);
  OAuth2Authenticator1.AuthorizationEndpoint := 'https://appcenter.intuit.com/connect/oauth2';
  OAuth2Authenticator1.AccessTokenEndpoint := 'https://oauth.platform.intuit.com/oauth2/v1/tokens/bearer';

  OAuth2Authenticator1.RedirectionEndpoint := SECRET_REDIRECT_URL; //'https://developer.intuit.com/v2/OAuth2Playground/RedirectUrl';

  OAuth2Authenticator1.Scope := 'com.intuit.quickbooks.accounting openid';
  OAuth2Authenticator1.ClientID := SECRET_INTUIT_CLIENTID;
  OAuth2Authenticator1.ClientSecret := SECRET_INTUIT_CLIENTSECRET;

  OAuth2Authenticator1.ResponseType := TOAuth2ResponseType.rtCODE;
  FTokenManager := TTokenManager.Create(ChangeFileExt(ParamStr(0), '.ini'));
  OAuth2Authenticator1.RefreshToken := FTokenManager.RetrieveDecryptedToken;
  RealmId := TokenManager.RetrieveExtraData('RealmId');
  RESTClient1.Authenticator := OAuth2Authenticator1;
  FfrmLogin := TfrmLogin.Create(nil);
  RESTClient1.BaseURL := 'https://sandbox-quickbooks.api.intuit.com';
end;

procedure TdmIntuitAPI.ChangeRefreshTokenToAccessToken;
begin
  OAuth2Authenticator1.RefreshToken := TokenManager.RetrieveDecryptedToken;
  RealmId := TokenManager.RetrieveExtraData('RealmId');
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
  FrealmID := FTokenManager.RetrieveExtraData('RealmId');
  RESTRequest1.Resource := '/v3/company/' + FrealmId + '/invoice?minorversion=38';
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

procedure TdmIntuitAPI.SetupInvoice(invoice: TInvoiceClass; TxnDate:TDate; invoiceID:String);
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

procedure TdmIntuitAPI.doLog(inText: string);
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

function TdmIntuitAPI.GetCustomers: TCustomerListClass;
var
  customers : TCustomerListClass;
begin
  dmIntuitAPI.RESTRequest1.ResetToDefaults;
  dmIntuitAPI.RESTRequest1.Method := rmGET;
  dmIntuitAPI.RESTRequest1.Resource := '/v3/company/{RealmId}/query?query=select * from Customer Where Metadata.LastUpdatedTime > ' + QuotedStr('2015-03-01');
  dmIntuitAPI.RESTRequest1.AddParameter('RealmId', dmIntuitAPI.RealmId, pkURLSEGMENT);
  dmIntuitAPI.RESTRequest1.AddParameter('minorversion', '73', TRESTRequestParameterKind.pkQUERY);
  dmIntuitAPI.RESTRequest1.ExecuteAsync(procedure ()
  var
    i : Integer;
  begin
    customers := TCustomerListClass.FromJsonString(dmIntuitAPI.RESTRequest1.Response.Content);
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
  TokenManager.StoreEncryptedToken(OAuth2Authenticator1.RefreshToken);
  TokenManager.StoreExtraData('RealmId', RealmId);
end;

procedure TdmIntuitAPI.ShowLoginForm;
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
  RESTRequest1.Resource := '/v3/company/' + RealmId + '/upload';

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
