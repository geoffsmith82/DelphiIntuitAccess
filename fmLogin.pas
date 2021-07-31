unit fmLogin;

interface

uses
    Winapi.Windows
  , Winapi.Messages
  , Winapi.ActiveX
  , System.SysUtils
  , System.Variants
  , System.Classes
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
    WebBrowser1: TWebBrowser;
    procedure EdgeBrowser1NavigationStarting(Sender: TCustomEdgeBrowser; Args: TNavigationStartingEventArgs);
    procedure WebBrowser1BeforeNavigate2(ASender: TObject; const pDisp: IDispatch; const URL, Flags, TargetFrameName, PostData, Headers: OLEVariant; var Cancel: WordBool);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Login(url:string);
  end;

implementation

{$R *.dfm}

uses
    System.Net.URLClient
  , fmIntuitDemo;

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
  Form1.RealmId := uri.ParameterByName['realmId'];

  Form1.OAuth2Authenticator1.AuthCode := code;
  Form1.Memo1.Lines.Add('url:'+URL);

  Form1.OAuth2Authenticator1.ChangeAuthCodeToAccesToken;
  Form1.Memo1.Lines.Add('Access Granted');
  Form1.Memo1.Lines.Add(Form1.OAuth2Authenticator1.AccessToken);
  Close;
end;

procedure TfrmLogin.Login(url: string);
begin
  WebBrowser1.Navigate(url);
  ShowModal;
end;

procedure TfrmLogin.WebBrowser1BeforeNavigate2(ASender: TObject; const pDisp: IDispatch; const URL, Flags, TargetFrameName, PostData, Headers: OLEVariant; var Cancel: WordBool);
var
  uri : TURI;
  state : String;
  code : String;
  i : Integer;
  codeExists : Boolean;
begin
  codeExists := False;
  try
    if string(URL).StartsWith('about:') then Exit;
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

  Cancel := False;

  if not codeExists then
    Exit;

  code := uri.ParameterByName['code'];
  state := uri.ParameterByName['state'];
  Form1.RealmId := uri.ParameterByName['realmId'];

  Form1.OAuth2Authenticator1.AuthCode := code;
  Form1.Memo1.Lines.Add('url:'+URL);

  Form1.OAuth2Authenticator1.ChangeAuthCodeToAccesToken;
  Form1.Memo1.Lines.Add('Access Granted');
  Form1.Memo1.Lines.Add(Form1.OAuth2Authenticator1.AccessToken);
  Close;
end;

end.
