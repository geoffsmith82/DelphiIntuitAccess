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
    FieldDefs = <>
    CachedUpdates = True
    IndexDefs = <
      item
        Name = 'tblCustomersIndex1'
        Fields = 'Id'
      end>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 448
    Top = 80
    object tblCustomersId: TWideStringField
      FieldName = 'Id'
      Size = 10
    end
    object tblCustomersDisplayName: TWideStringField
      FieldName = 'DisplayName'
      Size = 40
    end
    object tblCustomersActive: TBooleanField
      FieldName = 'Active'
    end
    object tblCustomersSyncToken: TWideStringField
      FieldName = 'SyncToken'
      Size = 40
    end
    object tblCustomersPrimaryEmailAddr: TWideStringField
      FieldName = 'PrimaryEmailAddr'
      Size = 60
    end
  end
  object tblInvoices: TFDMemTable
    CachedUpdates = True
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
      Size = 10
    end
    object tblInvoicesSyncToken: TWideStringField
      FieldName = 'SyncToken'
    end
    object tblInvoicesTxnDate: TWideStringField
      FieldName = 'TxnDate'
      Size = 15
    end
    object tblInvoicesCustomerRefName: TWideStringField
      FieldName = 'CustomerRefName'
      Size = 40
    end
    object tblInvoicesCustomerRefValue: TWideStringField
      FieldName = 'CustomerRefValue'
      Size = 10
    end
    object tblInvoicesTotalAmount: TFloatField
      FieldName = 'TotalAmount'
    end
  end
  object tblVendors: TFDMemTable
    CachedUpdates = True
    IndexFieldNames = 'Id'
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 488
    Top = 152
    object tblVendorsId: TWideStringField
      FieldName = 'Id'
      Size = 10
    end
    object tblVendorsDisplayName: TWideStringField
      FieldName = 'DisplayName'
      Size = 40
    end
    object tblVendorsActive: TBooleanField
      FieldName = 'Active'
    end
    object tblVendorsSyncToken: TWideStringField
      FieldName = 'SyncToken'
      Size = 40
    end
    object tblVendorsBalance: TFloatField
      FieldName = 'Balance'
    end
  end
end
