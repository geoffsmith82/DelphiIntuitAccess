unit dmIntuit;

interface

uses
    System.SysUtils
  , System.Classes
  , System.JSON
  , System.IOUtils
  , REST.Types
  , REST.Client
  , REST.Authenticator.OAuth
  , System.Net.URLClient
  , Data.Bind.Components
  , Data.Bind.ObjectScope
  , JSON.InvoiceList
  , JSON.AttachableList
  , OAuth2.Intuit
  , fmLogin
  ;

type
  TOnLogStatus = procedure(inText: string) of object;

  TdmIntuitAPI = class(TDataModule)
    RESTResponse1: TRESTResponse;
    RESTRequest1: TRESTRequest;
    RESTClient1: TRESTClient;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  strict private
    FrealmId : String;
    FOnLog : TOnLogStatus;
    FfrmLogin: TfrmLogin;
    procedure doLog(inText: string);
  private
    { Private declarations }
  public
    { Public declarations }
    OAuth2Authenticator1: TIntuitOAuth2;
    function CreateInvoice(invoice: TInvoiceClass): TInvoiceClass;
    procedure SetupInvoice(invoice: TInvoiceClass; TxnDate: TDate; invoiceID: String);
    procedure UploadAttachment(inFilename, inInvoiceID: string);
    procedure ChangeRefreshTokenToAccessToken;
    procedure ShowLoginForm;
  published
    property RealmId : string read FrealmId write FrealmId;
  end;

var
  dmIntuitAPI: TdmIntuitAPI;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses
    secrets
  ;

procedure TdmIntuitAPI.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(OAuth2Authenticator1);
  FreeAndNil(FfrmLogin);
end;

procedure TdmIntuitAPI.DataModuleCreate(Sender: TObject);
begin
  OAuth2Authenticator1 := TIntuitOAuth2.Create(nil);
  OAuth2Authenticator1.AuthorizationEndpoint := 'https://appcenter.intuit.com/connect/oauth2';
  OAuth2Authenticator1.AccessTokenEndpoint := 'https://oauth.platform.intuit.com/oauth2/v1/tokens/bearer';

  OAuth2Authenticator1.RedirectionEndpoint := SECRET_REDIRECT_URL; //'https://developer.intuit.com/v2/OAuth2Playground/RedirectUrl';

  OAuth2Authenticator1.Scope := 'com.intuit.quickbooks.accounting openid profile email phone address';
  OAuth2Authenticator1.ClientID := SECRET_INTUIT_CLIENTID;
  OAuth2Authenticator1.ClientSecret := SECRET_INTUIT_CLIENTSECRET;

  OAuth2Authenticator1.ResponseType := TOAuth2ResponseType.rtCODE;

  RESTClient1.Authenticator := OAuth2Authenticator1;
  FfrmLogin := TfrmLogin.Create(nil);
end;

procedure TdmIntuitAPI.ChangeRefreshTokenToAccessToken;
begin
  OAuth2Authenticator1.RefreshToken := FfrmLogin.GetRefreshToken;
  RealmId := SECRET_REALMID;
  OAuth2Authenticator1.ChangeRefreshTokenToAccesToken;
end;

function TdmIntuitAPI.CreateInvoice(invoice: TInvoiceClass): TInvoiceClass;
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
  doLog(invoiceText);
  RESTRequest1.Method := rmPost;
  FrealmID := SECRET_REALMID;
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
end;


end.
