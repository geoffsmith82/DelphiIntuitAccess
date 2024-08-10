unit OAuth2.Intuit;

interface

uses
    REST.Client
  , REST.Authenticator.OAuth
  ;

type
  TIntuitOAuth2 = class(TOAuth2Authenticator)
  private
    FRefreshExpiry: TDateTime;
    function IsAccessTokenValid: Boolean;
  protected
    procedure DoAuthenticate(ARequest: TCustomRESTRequest); override;
  public
    procedure ChangeAuthCodeToAccesToken;
    procedure ChangeRefreshTokenToAccesToken;
  published
    property RefreshExpiry: TDateTime read FRefreshExpiry write FRefreshExpiry;
    property AccessToken;
    property AccessTokenEndpoint;
    property AccessTokenExpiry;
    property AuthCode;
    property AuthorizationEndpoint;
    property ClientID;
    property ClientSecret;
    property LocalState;
    property RedirectionEndpoint;
    property RefreshToken;
    property ResponseType;
    property Scope;
    property TokenType;
  end;

implementation

uses
  REST.Consts,
  REST.Types,
  Windows,
  System.NetEncoding,
  System.Net.URLClient,
  System.SysUtils,
  System.DateUtils;

{ TIntuitOAuth2 }

procedure TIntuitOAuth2.ChangeRefreshTokenToAccesToken;
var
  LClient: TRestClient;
  LRequest: TRESTRequest;
  LToken: string;
  LIntValue: int64;
  AuthData : String;
  url : TURI;
begin
  url := TURI.Create('http://localhost');
  url.AddParameter('refresh_token', RefreshToken);
  url.AddParameter('grant_type', 'refresh_token');
  // we do need an authorization-code here, because we want
  // to send it to the servce and exchange the code into an
  // access-token.

//  if AuthCode = '' then
//    raise EOAuth2Exception.Create(SAuthorizationCodeNeeded);

  LClient := TRestClient.Create(AccessTokenEndpoint);
  try
    LRequest := TRESTRequest.Create(LClient); // The LClient now "owns" the Request and will free it.
    LRequest.Method := TRESTRequestMethod.rmPOST;
    LRequest.AddParameter('', url.Query, TRESTRequestParameterKind.pkREQUESTBODY, [poDoNotEncode]);


    AuthData := 'Basic ' +TNetEncoding.Base64.Encode(ClientID+':'+ClientSecret);
    AuthData := AuthData.Replace(#10,'').Replace(#13,''); // remove crlf
    LRequest.AddAuthParameter('Authorization', AuthData, TRESTRequestParameterKind.pkHTTPHEADER, [TRESTRequestParameterOption.poDoNotEncode]);

    LRequest.Execute;

    if LRequest.Response.GetSimpleValue('access_token', LToken) then
      AccessToken := LToken;
    if LRequest.Response.GetSimpleValue('refresh_token', LToken) then
      RefreshToken := LToken;

    // detect token-type. this is important for how using it later
    if LRequest.Response.GetSimpleValue('token_type', LToken) then
      TokenType := OAuth2TokenTypeFromString(LToken);

    // if provided by the service, the field "expires_in" contains
    // the number of seconds an access-token will be valid
    if LRequest.Response.GetSimpleValue('expires_in', LToken) then
    begin
      LIntValue := StrToIntdef(LToken, -1);
      if (LIntValue > -1) then
        AccessTokenExpiry := IncSecond(Now, LIntValue)
      else
        AccessTokenExpiry := 0.0;
    end;

    if LRequest.Response.GetSimpleValue('x_refresh_token_expires_in', LToken) then
    begin
      LIntValue := StrToIntdef(LToken, -1);
      if (LIntValue > -1) then
        FRefreshExpiry := IncSecond(Now, LIntValue)
      else
        FRefreshExpiry := 0.0;
    end;

    // an authentication-code may only be used once.
    // if we succeeded here and got an access-token, then
    // we do clear the auth-code as is is not valid anymore
    // and also not needed anymore.
    if (AccessToken <> '') then
      AuthCode := '';
  finally
    LClient.DisposeOf;
  end;
end;

function TIntuitOAuth2.IsAccessTokenValid: Boolean;
begin
  Result := (AccessToken <> '') and
    ((AccessTokenExpiry <= 0.1) or (AccessTokenExpiry > Now));
end;

procedure TIntuitOAuth2.DoAuthenticate(ARequest: TCustomRESTRequest);
var
  AuthData: string;
begin
  if not IsAccessTokenValid then
  begin
    if RefreshToken <> '' then
      ChangeRefreshTokenToAccesToken;
  end;
  AuthData := 'Bearer ' + AccessToken;
  ARequest.AddAuthParameter('Authorization', AuthData, TRESTRequestParameterKind.pkHTTPHEADER, [TRESTRequestParameterOption.poDoNotEncode]);
end;

procedure TIntuitOAuth2.ChangeAuthCodeToAccesToken;
var
  LClient: TRestClient;
  LRequest: TRESTRequest;
  LToken: string;
  LIntValue: int64;
  AuthData : String;
  url : TURI;
begin
  url := TURI.Create('http://localhost');
  url.AddParameter('grant_type', 'authorization_code');
  url.AddParameter('code', AuthCode);
  url.AddParameter('redirect_uri', RedirectionEndpoint);

  OutputDebugString(PChar(url.Query));
  // we do need an authorization-code here, because we want
  // to send it to the servce and exchange the code into an
  // access-token.

  if AuthCode = '' then
    raise EOAuth2Exception.Create(SAuthorizationCodeNeeded);

  LClient := TRestClient.Create(AccessTokenEndpoint);
  try
    LRequest := TRESTRequest.Create(LClient); // The LClient now "owns" the Request and will free it.
    LRequest.Method := TRESTRequestMethod.rmPOST;

    LRequest.AddParameter('', url.Query, TRESTRequestParameterKind.pkREQUESTBODY, [poDoNotEncode]);

    AuthData := 'Basic ' +TNetEncoding.Base64.Encode(ClientID + ':' + ClientSecret);
    AuthData := AuthData.Replace(#10,'').Replace(#13,''); // remove crlf
    LRequest.AddAuthParameter('Authorization', AuthData, TRESTRequestParameterKind.pkHTTPHEADER, [TRESTRequestParameterOption.poDoNotEncode]);

    LRequest.Execute;

    if LRequest.Response.GetSimpleValue('access_token', LToken) then
      AccessToken := LToken;
    if LRequest.Response.GetSimpleValue('refresh_token', LToken) then
      RefreshToken := LToken;

    // detect token-type. this is important for how using it later
    if LRequest.Response.GetSimpleValue('token_type', LToken) then
      TokenType := OAuth2TokenTypeFromString(LToken);

    // if provided by the service, the field "expires_in" contains
    // the number of seconds an access-token will be valid
    if LRequest.Response.GetSimpleValue('expires_in', LToken) then
    begin
      LIntValue := StrToIntdef(LToken, -1);
      if (LIntValue > -1) then
        AccessTokenExpiry := IncSecond(Now, LIntValue)
      else
        AccessTokenExpiry := 0.0;
    end;

    if LRequest.Response.GetSimpleValue('x_refresh_token_expires_in', LToken) then
    begin
      LIntValue := StrToIntdef(LToken, -1);
      if (LIntValue > -1) then
        FRefreshExpiry := IncSecond(Now, LIntValue)
      else
        FRefreshExpiry := 0.0;
    end;

    // an authentication-code may only be used once.
    // if we succeeded here and got an access-token, then
    // we do clear the auth-code as is is not valid anymore
    // and also not needed anymore.
    if (AccessToken <> '') then
      AuthCode := '';
  finally
    LClient.DisposeOf;
  end;
end;

end.
