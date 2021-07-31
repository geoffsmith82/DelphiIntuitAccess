unit secrets;

interface

const
  SECRET_INTUIT_CLIENTID = '';
  SECRET_INTUIT_CLIENTSECRET = '';
  SECRET_REDIRECT_URL = 'https://developer.intuit.com/v2/OAuth2Playground/RedirectUrl';
  SECRET_REALMID = '';
  SECRET_REFRESHTOKEN = '';
  SECRET_QUICKPDF_KEY = '';
{$IFDEF WIN64}
  QUICKPDF_DLL_PATH = 'DebenuPDFLibrary64DLL0916.dll';
{$ENDIF}
{$IFDEF WIN32}
  QUICKPDF_DLL_PATH = 'DebenuPDFLibraryDLL0916.dll';
{$ENDIF}
  InitialDirectory = '';
  SECRET_CUSTOMER_ID = '';
  SECRET_CUSTOMER_NAME = '';

implementation

end.
