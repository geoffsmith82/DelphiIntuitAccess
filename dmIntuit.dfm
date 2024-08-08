object dmIntuitAPI: TdmIntuitAPI
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 379
  Width = 569
  object RESTResponse1: TRESTResponse
    Left = 384
    Top = 168
  end
  object RESTRequest1: TRESTRequest
    Client = RESTClient1
    Params = <>
    Response = RESTResponse1
    SynchronizedEvents = False
    Left = 288
    Top = 168
  end
  object RESTClient1: TRESTClient
    BaseURL = 'https://quickbooks.api.intuit.com'
    Params = <>
    SynchronizedEvents = False
    Left = 320
    Top = 112
  end
end
