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
  , Vcl.Graphics
  , Vcl.Controls
  , Vcl.Forms
  , Vcl.Dialogs
  , Vcl.OleCtrls
  , Vcl.Edge
  , SHDocVw
  , WebView2
  ;

type
  TfrmLogin = class(TForm)
    EdgeBrowser1: TEdgeBrowser;
    procedure EdgeBrowser1NavigationCompleted(Sender: TCustomEdgeBrowser; IsSuccess: Boolean; WebErrorStatus: TOleEnum);
    procedure EdgeBrowser1NavigationStarting(Sender: TCustomEdgeBrowser; Args: TNavigationStartingEventArgs);
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


procedure TfrmLogin.EdgeBrowser1NavigationCompleted(Sender: TCustomEdgeBrowser;
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

procedure TfrmLogin.EdgeBrowser1NavigationStarting(Sender: TCustomEdgeBrowser; Args: TNavigationStartingEventArgs);
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
  Close;
end;

procedure TfrmLogin.Login(url: string);
begin
  EdgeBrowser1.Navigate(url);
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
