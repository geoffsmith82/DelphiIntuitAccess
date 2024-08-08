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
  //  FIniFile : TIniFile;
  public
    { Public declarations }
    procedure Login(url:string);
  end;

implementation

{$R *.dfm}

uses
    System.Net.URLClient
  , fmIntuitDemo
  , dmIntuit
  ;


procedure TfrmLogin.EdgeBrowser1NavigationCompleted(Sender: TCustomEdgeBrowser;
    IsSuccess: Boolean; WebErrorStatus: TOleEnum);
var
  uri : TURI;
  state : String;
  code : String;
  i : Integer;
  codeExists : Boolean;
  url : string;
begin
  codeExists := False;
  try
    url := Sender.LocationURL;
    if URL.StartsWith('about:') then Exit;
    uri := TURI.Create(URL);
    OutputDebugString(PChar('Browser: ' + uri.ToString));
     for i := 0 to Length(uri.Params)-1 do
     begin
       if uri.Params[i].Name='code' then
       begin
         codeExists := True;
         Break;
       end;
     end;
  except

  end;

  if not codeExists then
    Exit;

  code := uri.ParameterByName['code'];
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
  dmIntuitAPI.TokenManager.StoreExtraData('RealmId', dmIntuitAPI.RealmId);
  Close;
end;

procedure TfrmLogin.EdgeBrowser1NavigationStarting(Sender: TCustomEdgeBrowser; Args: TNavigationStartingEventArgs);
var
  uri : TURI;
  state : String;
  code : String;
  i : Integer;
  codeExists : Boolean;
  url : string;
begin
  codeExists := False;
  try
    url := Sender.LocationURL;
    if URL.StartsWith('about:') then Exit;
    uri := TURI.Create(URL);
    OutputDebugString(PChar('Browser: ' + uri.ToString));
     for i := 0 to Length(uri.Params)-1 do
     begin
       if uri.Params[i].Name='code' then
       begin
         codeExists := True;
         Break;
       end;
     end;
  except

  end;

  if not codeExists then
    Exit;

  code := uri.ParameterByName['code'];
  state := uri.ParameterByName['state'];
  dmIntuitAPI.RealmId := uri.ParameterByName['realmId'];

  dmIntuitAPI.OAuth2Authenticator1.AuthCode := code;
  Form1.Memo1.Lines.Add('url:'+URL);

  dmIntuitAPI.OAuth2Authenticator1.ChangeAuthCodeToAccesToken;
  Form1.Memo1.Lines.Add('Access Granted');
  Form1.Memo1.Lines.Add(dmIntuitAPI.OAuth2Authenticator1.AccessToken);
  dmIntuitAPI.TokenManager.StoreEncryptedToken(dmIntuitAPI.OAuth2Authenticator1.RefreshToken);
  Close;
end;

procedure TfrmLogin.Login(url: string);
begin
  EdgeBrowser1.Navigate(url);
  ShowModal;
end;

end.
