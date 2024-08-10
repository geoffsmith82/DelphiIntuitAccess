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
    object tblCustomersId: TStringField
      FieldName = 'Id'
    end
    object tblCustomersActive: TBooleanField
      FieldName = 'Active'
    end
    object tblCustomersDisplayName: TStringField
      FieldName = 'DisplayName'
      Size = 40
    end
    object tblCustomersSyncToken: TStringField
      FieldName = 'SyncToken'
    end
    object tblCustomersPrimaryEmailAddr: TStringField
      FieldName = 'PrimaryEmailAddr'
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
    object tblInvoicesId: TStringField
      FieldName = 'Id'
    end
    object tblInvoicesSyncToken: TStringField
      FieldName = 'SyncToken'
    end
    object tblInvoicesTxnDate: TStringField
      FieldName = 'TxnDate'
    end
    object tblInvoicesCustomerRefName: TStringField
      FieldName = 'CustomerRefName'
    end
    object tblInvoicesCustomerRefValue: TStringField
      FieldName = 'CustomerRefValue'
    end
    object tblInvoicesTotalAmount: TFloatField
      FieldName = 'TotalAmount'
    end
  end
end
