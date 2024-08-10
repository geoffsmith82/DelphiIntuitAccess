unit InvoiceParserUnit;

interface
uses
  System.SysUtils,
  System.Classes,
  System.IOUtils,
  System.JSON,
  System.Generics.Collections
  ;
type
  TLineItem = class
  private
    FDescription: string;
    FQuantity: Double;
    FRate: Double;
    FAmount: Double;
  public
    property Description: string read FDescription write FDescription;
    property Quantity: Double read FQuantity write FQuantity;
    property Rate: Double read FRate write FRate;
    property Amount: Double read FAmount write FAmount;
  end;
  TInvoice = class
  private
    FClientRef: string;
    FInvoiceNumber: string;
    FDate: TDateTime;
    FPeriodFrom: TDateTime;
    FPeriodTo: TDateTime;
    FTotal: string;
    FLineItems: TObjectList<TLineItem>;
    FTotalHours: Double;
    function GetTotalHours: Double;
  public
    constructor Create;
    destructor Destroy; override;
    property ClientRef: string read FClientRef write FClientRef;
    property InvoiceNumber: string read FInvoiceNumber write FInvoiceNumber;
    property Date: TDateTime read FDate write FDate;
    property PeriodFrom: TDateTime read FPeriodFrom write FPeriodFrom;
    property PeriodTo: TDateTime read FPeriodTo write FPeriodTo;
    property Total: string read FTotal write FTotal;
    property LineItems: TObjectList<TLineItem> read FLineItems;
    property TotalHours: Double read GetTotalHours;
  end;
function ParseInvoiceJson(const JsonStr: string): TInvoice;
function ParseInvoiceJsonFile(const JsonFile: string): TInvoice;

implementation
constructor TInvoice.Create;
begin
  inherited Create;
  FLineItems := TObjectList<TLineItem>.Create;
end;
destructor TInvoice.Destroy;
begin
  FLineItems.Free;
  inherited Destroy;
end;
function ParseDateTimeFromJson(const DateStr: string): TDateTime;
var
  CleanDateStr: string;
  FormatSettings: TFormatSettings;
begin
  // Replace \/ with /
  CleanDateStr := StringReplace(DateStr, '\/', '/', [rfReplaceAll]);
  // Define custom format settings to match "dd/mm/yyyy"
  FormatSettings := TFormatSettings.Create;
  FormatSettings.DateSeparator := '/';
  FormatSettings.ShortDateFormat := 'dd/mm/yyyy';
  if not TryStrToDate(CleanDateStr, Result, FormatSettings) then
    raise Exception.CreateFmt('Invalid date format: %s', [CleanDateStr]);
end;
function TInvoice.GetTotalHours: Double;
var
  I: Integer;
begin
  // If FTotalHours is not set (e.g., -1), calculate it dynamically
  if FTotalHours < 0 then
  begin
    Result := 0;
    for I := 0 to FLineItems.Count - 1 do
      Result := Result + FLineItems[I].Quantity;
  end
  else
  begin
    Result := FTotalHours;
  end;
end;
function ParseInvoiceJson(const JsonStr: string): TInvoice;
var
  JsonObj, LineItemObj: TJSONObject;
  JsonLineItems: TJSONArray;
  LineItem: TLineItem;
  I: Integer;
  qty : Double;
begin
  Result := TInvoice.Create;
  try
    JsonObj := TJSONObject.ParseJSONValue(JsonStr) as TJSONObject;
    try
      Result.ClientRef := JsonObj.GetValue<string>('clientref');
      Result.InvoiceNumber := JsonObj.GetValue<string>('invoice_number');
      Result.Date := ParseDateTimeFromJson(JsonObj.GetValue<string>('date'));
      Result.PeriodFrom := ParseDateTimeFromJson(JsonObj.GetValue<string>('period_from'));
      Result.PeriodTo := ParseDateTimeFromJson(JsonObj.GetValue<string>('period_to'));
      Result.Total := JsonObj.GetValue<string>('total');
      // Check if TotalHours exists in JSON
      if JsonObj.TryGetValue<Double>('total_hours', Result.FTotalHours) then
        Result.FTotalHours := JsonObj.GetValue<Double>('total_hours')
      else
        Result.FTotalHours := -1;  // Mark for dynamic calculation
      JsonLineItems := JsonObj.GetValue<TJSONArray>('line_items');
      for I := 0 to JsonLineItems.Count - 1 do
      begin
        LineItemObj := JsonLineItems.Items[I] as TJSONObject;
        LineItem := TLineItem.Create;
        LineItem.Description := LineItemObj.GetValue<string>('description');
        if LineItemObj.TryGetValue('qty', qty) then
          LineItem.Quantity := qty
        else if LineItemObj.TryGetValue('hours', qty) then
          LineItem.Quantity := qty
        else if LineItemObj.TryGetValue('qty_hours', qty) then
          LineItem.Quantity := qty
        else
          LineItem.Quantity := LineItemObj.GetValue<Double>('quantity');
        LineItem.Rate := LineItemObj.GetValue<string>('rate').Replace('$','').ToDouble;
        LineItem.Amount := LineItemObj.GetValue<string>('amount').Replace('$','').ToDouble;
        Result.LineItems.Add(LineItem);
      end;
    finally
      JsonObj.Free;
    end;
  except
    Result.Free;
    raise;
  end;
end;
function ParseInvoiceJsonFile(const JsonFile: string): TInvoice;
var
  json : string;
begin
  json := TFile.ReadAllText(jsonFile);

  Result := ParseInvoiceJson(json);
end;
end.

