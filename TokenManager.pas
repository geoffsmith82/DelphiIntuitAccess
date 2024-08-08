unit TokenManager;

interface

uses
  System.SysUtils,
  System.NetEncoding,
  System.IniFiles,
  Windows;

type
  TTokenManager = class
  private type
    TNCryptDescriptorHandle = Pointer;

    TNCryptBuffer = record
      cbBuffer: DWORD;
      BufferType: DWORD;
      pvBuffer: PVOID;
    end;
    PNCryptBuffer = ^TNCryptBuffer;

    TNCryptBufferDesc = record
      ulVersion: DWORD;
      cBuffers: DWORD;
      pBuffers: PNCryptBuffer;
    end;
    PNCryptBufferDesc = ^TNCryptBufferDesc;

    PPBYTE = ^PBYTE;

  private
    hNCrypt: HMODULE;
    FIniFile: TIniFile;

    NCryptCreateProtectionDescriptor: function(
      pszDescriptorString: LPCWSTR;
      dwFlags: DWORD;
      phDescriptor: PPointer
    ): HRESULT; stdcall;

    NCryptProtectSecret: function(
      hDescriptor: TNCryptDescriptorHandle;
      dwFlags: DWORD;
      pbData: PBYTE;
      cbData: DWORD;
      pMemPara: PNCryptBufferDesc;
      hWnd: HWND;
      ppbProtectedBlob: PPBYTE;
      pcbProtectedBlob: PDWORD
    ): HRESULT; stdcall;

    NCryptUnprotectSecret: function(
      hDescriptor: TNCryptDescriptorHandle;
      dwFlags: DWORD;
      pbProtectedBlob: PBYTE;
      cbProtectedBlob: DWORD;
      pMemPara: PNCryptBufferDesc;
      hWnd: HWND;
      ppbData: PPBYTE;
      pcbData: PDWORD
    ): HRESULT; stdcall;

    NCryptCloseProtectionDescriptor: function(
      hDescriptor: TNCryptDescriptorHandle
    ): HRESULT; stdcall;


  public
    constructor Create(const IniFileName: string);
    destructor Destroy; override;

    function ProtectSecret(const Secret: string): string;
    function UnprotectSecret(const ProtectedBlob: string): string;
    function RetrieveDecryptedToken: string;
    procedure StoreEncryptedToken(const Token: string);

    procedure StoreExtraData(const Name, Value: string);
    function RetrieveExtraData(const name: string): string;
  end;

implementation

const
  NCRYPT_PROTECT_SECRET_VERSION = 1;

function SecureZeroMemory(_ptr: Pointer; cnt: Longint): Pointer;
begin
  FillChar(_ptr^, cnt, 0);
  Result := _ptr;
end;

constructor TTokenManager.Create(const IniFileName: string);
begin
  inherited Create;

  FIniFile := TIniFile.Create(IniFileName);

  hNCrypt := LoadLibrary('NCrypt.dll');
  if hNCrypt <> 0 then
  begin
    @NCryptCreateProtectionDescriptor := GetProcAddress(hNCrypt, 'NCryptCreateProtectionDescriptor');
    @NCryptProtectSecret := GetProcAddress(hNCrypt, 'NCryptProtectSecret');
    @NCryptUnprotectSecret := GetProcAddress(hNCrypt, 'NCryptUnprotectSecret');
    @NCryptCloseProtectionDescriptor := GetProcAddress(hNCrypt, 'NCryptCloseProtectionDescriptor');

    if not Assigned(NCryptCreateProtectionDescriptor) or
       not Assigned(NCryptProtectSecret) or
       not Assigned(NCryptUnprotectSecret) or
       not Assigned(NCryptCloseProtectionDescriptor) then
      raise Exception.Create('Failed to load one or more NCrypt functions');
  end
  else
    raise Exception.Create('Failed to load NCrypt.dll');
end;

destructor TTokenManager.Destroy;
begin
  FIniFile.Free;

  if hNCrypt <> 0 then
    FreeLibrary(hNCrypt);

  inherited Destroy;
end;

function TTokenManager.ProtectSecret(const Secret: string): string;
var
  hDescriptor: TNCryptDescriptorHandle;
  ProtectedBlob: PBYTE;
  ProtectedBlobSize: DWORD;
  ResultCode: HRESULT;
  EncryptedBytes: TBytes;
begin
  if not Assigned(NCryptCreateProtectionDescriptor) or not Assigned(NCryptProtectSecret) then
    raise Exception.Create('NCrypt functions not assigned');

  // Create the protection descriptor
  ResultCode := NCryptCreateProtectionDescriptor('LOCAL=user', 0, @hDescriptor);
  if ResultCode <> S_OK then
    RaiseLastOSError(ResultCode);

  try
    ResultCode := NCryptProtectSecret(
      hDescriptor,
      0,
      PBYTE(Secret),
      Length(Secret) * SizeOf(Char), // Length in bytes
      nil,
      0,
      @ProtectedBlob,
      @ProtectedBlobSize
    );

    if ResultCode = S_OK then
    begin
      SetLength(EncryptedBytes, ProtectedBlobSize);
      Move(ProtectedBlob^, EncryptedBytes[0], ProtectedBlobSize);
      Result := TNetEncoding.Base64String.EncodeBytesToString(EncryptedBytes);
      LocalFree(HLOCAL(ProtectedBlob));
    end
    else
      RaiseLastOSError(ResultCode);
  finally
    // Close the protection descriptor
    NCryptCloseProtectionDescriptor(hDescriptor);
  end;
end;

function TTokenManager.UnprotectSecret(const ProtectedBlob: string): string;
var
  hDescriptor: TNCryptDescriptorHandle;
  Data: PBYTE;
  DataSize: DWORD;
  ResultCode: HRESULT;
  EncryptedBytes: TBytes;
begin
  if not Assigned(NCryptCreateProtectionDescriptor) or not Assigned(NCryptUnprotectSecret) then
    raise Exception.Create('NCrypt functions not assigned');

  // Create the protection descriptor
  ResultCode := NCryptCreateProtectionDescriptor('LOCAL=user', 0, @hDescriptor);
  if ResultCode <> S_OK then
    RaiseLastOSError(ResultCode);

  try
    EncryptedBytes := TNetEncoding.Base64String.DecodeStringToBytes(ProtectedBlob);

    ResultCode := NCryptUnprotectSecret(
      hDescriptor,
      0,
      @EncryptedBytes[0],
      Length(EncryptedBytes),
      nil,
      0,
      @Data,
      @DataSize
    );

    if ResultCode = S_OK then
    begin
      SetLength(Result, DataSize div SizeOf(Char)); // Adjust length for character size
      Move(Data^, PChar(Result)^, DataSize);
      SecureZeroMemory(Data, DataSize);
      LocalFree(HLOCAL(Data));
    end
    else
      RaiseLastOSError(ResultCode);
  finally
    // Close the protection descriptor
    NCryptCloseProtectionDescriptor(hDescriptor);
  end;
end;

function TTokenManager.RetrieveDecryptedToken: string;
var
  EncryptedToken: string;
begin
  EncryptedToken := FIniFile.ReadString('Token', 'Encrypted', '');
  if EncryptedToken = '' then
  begin
    Result := '';
    Exit;
  end;

  Result := UnprotectSecret(EncryptedToken);
end;

function TTokenManager.RetrieveExtraData(const name: string): string;
begin
  Result := FIniFile.ReadString('Token', name, '');
end;

procedure TTokenManager.StoreEncryptedToken(const Token: string);
var
  EncryptedToken: string;
begin
  EncryptedToken := ProtectSecret(Token);
  FIniFile.WriteString('Token', 'Encrypted', EncryptedToken);
end;

procedure TTokenManager.StoreExtraData(const Name: string; const Value: string);
begin
  FIniFile.WriteString('Token', Name, Value);
end;

end.

