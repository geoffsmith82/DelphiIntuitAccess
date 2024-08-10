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
  object tblCustomers: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 448
    Top = 80
    object tblCustomersId: TWideStringField
      FieldName = 'Id'
      Size = 0
    end
    object tblCustomersDisplayName: TWideStringField
      FieldName = 'DisplayName'
      Size = 0
    end
    object tblCustomersActive: TBooleanField
      FieldName = 'Active'
    end
    object tblCustomersSyncToken: TWideStringField
      FieldName = 'SyncToken'
      Size = 0
    end
    object tblCustomersPrimaryEmailAddr: TWideStringField
      FieldName = 'PrimaryEmailAddr'
      Size = 0
    end
  end
  object tblInvoices: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 440
    Top = 240
    object tblInvoicesId: TWideStringField
      FieldName = 'Id'
      Size = 0
    end
    object tblInvoicesSyncToken: TWideStringField
      FieldName = 'SyncToken'
      Size = 0
    end
    object tblInvoicesTxnDate: TWideStringField
      FieldName = 'TxnDate'
      Size = 0
    end
    object tblInvoicesCustomerRefName: TWideStringField
      FieldName = 'CustomerRefName'
      Size = 0
    end
    object tblInvoicesCustomerRefValue: TWideStringField
      FieldName = 'CustomerRefValue'
      Size = 0
    end
    object tblInvoicesTotalAmount: TFloatField
      FieldName = 'TotalAmount'
    end
  end
end
