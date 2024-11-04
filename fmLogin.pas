unit fmLogin;

interface

uses
    Winapi.Windows
  , Winapi.Messages
  , Winapi.ActiveX
  , System.SysUtils
  , System.Variants
  , System.Classes
  , System.IniFiles
  , System.Net.URLClient
  , Vcl.Controls
  , Vcl.Forms
  , Vcl.Dialogs
  , Vcl.OleCtrls
  , Vcl.Edge
  , WebView2
  ;

type
  TfrmLogin = class(TForm)
    EdgeBrowser: TEdgeBrowser;
    procedure EdgeBrowserNavigationCompleted(Sender: TCustomEdgeBrowser; IsSuccess: Boolean; WebErrorStatus: TOleEnum);
    procedure EdgeBrowserNavigationStarting(Sender: TCustomEdgeBrowser; Args: TNavigationStartingEventArgs);
    procedure EdgeBrowserWebResourceRequested(Sender: TCustomEdgeBrowser; Args: TWebResourceRequestedEventArgs);
    procedure FormCreate(Sender: TObject);
    procedure EdgeBrowserCreateWebViewCompleted(Sender: TCustomEdgeBrowser; AResult: HRESULT);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Login(url:string);
  end;

  TURIParamHelper = record Helper for TURI
    function ParamExists(paramName: string): Boolean;
  end;

implementation

{$R *.dfm}

uses
    fmIntuitDemo
  , dmIntuit
  ;


procedure TfrmLogin.EdgeBrowserCreateWebViewCompleted(Sender: TCustomEdgeBrowser; AResult: HRESULT);
begin
  if Succeeded(AResult) then
  begin
    // Set the OnWebResourceRequested event handler
    EdgeBrowser.AddWebResourceRequestedFilter('*', COREWEBVIEW2_WEB_RESOURCE_CONTEXT_ALL);
    EdgeBrowser.OnWebResourceRequested := EdgeBrowserWebResourceRequested;
  end
  else
    ShowMessage('Failed to initialize WebView2');
end;

procedure TfrmLogin.EdgeBrowserNavigationCompleted(Sender: TCustomEdgeBrowser;
    IsSuccess: Boolean; WebErrorStatus: TOleEnum);
var
  uri : TURI;
  url : string;
begin
  url := Sender.LocationURL;
  if URL.StartsWith('about:') then Exit;
  uri := TURI.Create(URL);
  OutputDebugString(PChar('Browser: ' + uri.ToString));

  if not uri.ParamExists('code') then
    Exit;

  dmIntuitAPI.HandleOAuthCodeRedirect(uri);

{  code := uri.ParameterByName['code'];
  state := uri.ParameterByName['state'];
  dmIntuitAPI.RealmId := uri.ParameterByName['realmId'];

  dmIntuitAPI.OAuth2Authenticator1.AuthCode := code;
  Form1.Memo1.Lines.Add('url:'+URL);

  dmIntuitAPI.OAuth2Authenticator1.ChangeAuthCodeToAccesToken;
  Form1.Memo1.Lines.Add('Access Granted');
  Form1.Memo1.Lines.Add('RefreshToken=' + dmIntuitAPI.OAuth2Authenticator1.RefreshToken);
  Form1.Memo1.Lines.Add('Access Token');

  Form1.Memo1.Lines.Add(dmIntuitAPI.OAuth2Authenticator1.AccessToken);
  dmIntuitAPI.TokenManager.StoreEncryptedToken(dmIntuitAPI.OAuth2Authenticator1.RefreshToken);
  dmIntuitAPI.TokenManager.StoreExtraData('RealmId', dmIntuitAPI.RealmId);}
  Close;
end;

procedure TfrmLogin.EdgeBrowserNavigationStarting(Sender: TCustomEdgeBrowser; Args: TNavigationStartingEventArgs);
var
  uri : TURI;
  url : string;
begin
  url := Sender.LocationURL;
  if URL.StartsWith('about:') then Exit;
  if url.IsEmpty then Exit;
  
  uri := TURI.Create(URL);
  OutputDebugString(PChar('Browser: ' + uri.ToString));

  if not uri.ParamExists('code') then
    Exit;

  dmIntuitAPI.HandleOAuthCodeRedirect(uri);
  Close;
end;

procedure TfrmLogin.EdgeBrowserWebResourceRequested(Sender: TCustomEdgeBrowser;
  Args: TWebResourceRequestedEventArgs);
var
  Request: ICoreWebView2WebResourceRequest;
  Response: ICoreWebView2WebResourceResponse;
  URL: PChar;
  urlString : string;
  EmptyStream: IStream;
begin
    Args.ArgsInterface.Get_Request(Request);
    Request.Get_uri(URL);
    urlString := URL;
    // Check if the request URL matches the domain we want to block
    // need to update this to your domain so that the request doesn't actually get sent to server
    if urlString.StartsWith('https://www.tysontechnology.com.au') then
    begin
      // Create a custom response to block the request
      EmptyStream := TStreamAdapter.Create(TMemoryStream.Create, soOwned);
      EdgeBrowser.EnvironmentInterface.CreateWebResourceResponse(
        EmptyStream, 200, 'OK', 'Content-Type: text/html', Response);

      Args.ArgsInterface.Set_Response(Response);
    end;
end;

procedure TfrmLogin.FormCreate(Sender: TObject);
begin
  // Start creating the WebView2 environment
  EdgeBrowser.OnCreateWebViewCompleted := EdgeBrowserCreateWebViewCompleted;
  EdgeBrowser.CreateWebView;
end;

procedure TfrmLogin.Login(url: string);
begin
  EdgeBrowser.Navigate(url);
  ShowModal;
end;

{ TURIParamHelper }

function TURIParamHelper.ParamExists(paramName: string): Boolean;
var
  i : Integer;
begin
  Result := False;
  for i := 0 to Length(Params)-1 do
  begin
    if Params[i].Name='code' then
    begin
      Result := True;
      Exit;
    end;
  end;
end;

end.
