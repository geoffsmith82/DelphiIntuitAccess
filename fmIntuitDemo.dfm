object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Intuit Login Demo'
  ClientHeight = 462
  ClientWidth = 866
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu
  Position = poDesigned
  OnCreate = FormCreate
  TextHeight = 13
  object GridPanel1: TGridPanel
    Left = 0
    Top = 42
    Width = 866
    Height = 401
    Align = alClient
    Caption = 'GridPanel1'
    ColumnCollection = <
      item
        Value = 50.000000000000000000
      end
      item
        Value = 50.000000000000000000
      end>
    ControlCollection = <
      item
        Column = 0
        Control = GridPanel2
        Row = 0
      end
      item
        Column = 1
        Control = PageControl1
        Row = 0
      end>
    RowCollection = <
      item
        Value = 100.000000000000000000
      end
      item
        SizeStyle = ssAuto
      end>
    TabOrder = 1
    ExplicitWidth = 862
    ExplicitHeight = 400
    object GridPanel2: TGridPanel
      Left = 1
      Top = 1
      Width = 432
      Height = 399
      Align = alClient
      Caption = 'GridPanel2'
      ColumnCollection = <
        item
          Value = 100.000000000000000000
        end>
      ControlCollection = <
        item
          Column = 0
          Control = DirectoryListBox1
          Row = 0
        end
        item
          Column = 0
          Control = FileListBox1
          Row = 1
        end>
      RowCollection = <
        item
          Value = 50.000000000000000000
        end
        item
          Value = 50.000000000000000000
        end
        item
          SizeStyle = ssAuto
        end>
      TabOrder = 0
      ExplicitWidth = 430
      ExplicitHeight = 398
      object DirectoryListBox1: TDirectoryListBox
        Left = 1
        Top = 1
        Width = 430
        Height = 198
        Align = alClient
        FileList = FileListBox1
        TabOrder = 0
        ExplicitWidth = 428
      end
      object FileListBox1: TFileListBox
        Left = 1
        Top = 199
        Width = 430
        Height = 199
        Align = alClient
        ItemHeight = 13
        Mask = '*.pdf'
        TabOrder = 1
        OnChange = FileListBoxEx1Change
        ExplicitWidth = 428
        ExplicitHeight = 198
      end
    end
    object PageControl1: TPageControl
      Left = 433
      Top = 1
      Width = 432
      Height = 399
      ActivePage = TabSheet4
      Align = alClient
      TabOrder = 1
      OnChange = PageControl1Change
      object TabSheet1: TTabSheet
        Caption = 'Log'
        object Memo1: TMemo
          Left = 0
          Top = 0
          Width = 424
          Height = 371
          Align = alClient
          Lines.Strings = (
            'Memo1')
          TabOrder = 0
        end
      end
      object TabSheet2: TTabSheet
        Caption = 'Invoice Info'
        ImageIndex = 1
        object Label1: TLabel
          Left = -2
          Top = 19
          Width = 61
          Height = 13
          Caption = 'Invoice Date'
        end
        object Label2: TLabel
          Left = 0
          Top = 46
          Width = 62
          Height = 13
          Caption = 'Invoice From'
        end
        object Label3: TLabel
          Left = 0
          Top = 70
          Width = 50
          Height = 13
          Caption = 'Invoice To'
        end
        object Label4: TLabel
          Left = 0
          Top = 100
          Width = 51
          Height = 13
          Caption = 'Invoice No'
        end
        object Label5: TLabel
          Left = 198
          Top = 19
          Width = 55
          Height = 13
          Caption = 'Total Hours'
        end
        object Label6: TLabel
          Left = 198
          Top = 46
          Width = 64
          Height = 13
          Caption = 'Total Amount'
        end
        object Label7: TLabel
          Left = 200
          Top = 74
          Width = 44
          Height = 13
          Caption = 'ClientRef'
        end
        object Label8: TLabel
          Left = 200
          Top = 100
          Width = 34
          Height = 13
          Caption = 'Project'
        end
        object edtClientRef: TEdit
          Left = 274
          Top = 71
          Width = 120
          Height = 21
          TabOrder = 0
        end
        object edtProject: TEdit
          Left = 266
          Top = 98
          Width = 120
          Height = 21
          TabOrder = 1
        end
        object StringGrid1: TStringGrid
          Left = 0
          Top = 166
          Width = 424
          Height = 205
          Align = alBottom
          Anchors = [akLeft, akTop, akRight, akBottom]
          FixedCols = 0
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goEditing, goRowSelect, goFixedRowDefAlign]
          TabOrder = 2
          ExplicitWidth = 422
          ExplicitHeight = 204
        end
        object edtInvoiceNo: TEdit
          Left = 58
          Top = 97
          Width = 121
          Height = 21
          TabOrder = 3
          Text = 'edtInvoiceNo'
        end
        object meTotalAmount: TEdit
          Left = 268
          Top = 44
          Width = 121
          Height = 21
          TabOrder = 4
          Text = 'meTotalAmount'
        end
        object meTotalHours: TEdit
          Left = 272
          Top = 17
          Width = 121
          Height = 21
          TabOrder = 5
          Text = 'meTotalHours'
        end
        object InvoiceDateDatePicker: TDateTimePicker
          Left = 66
          Top = 17
          Width = 111
          Height = 21
          Date = 44922.000000000000000000
          Time = 0.976881793983920900
          TabOrder = 6
        end
        object InvoiceDateFromDatePicker: TDateTimePicker
          Left = 64
          Top = 43
          Width = 113
          Height = 21
          Date = 44922.000000000000000000
          Time = 0.977810972224688200
          TabOrder = 7
        end
        object InvoiceDateToPicker: TDateTimePicker
          Left = 64
          Top = 66
          Width = 113
          Height = 21
          Date = 44922.000000000000000000
          Time = 0.977810972224688200
          TabOrder = 8
        end
      end
      object TabSheet3: TTabSheet
        Caption = 'Customers'
        ImageIndex = 2
        object ListView1: TListView
          Left = 0
          Top = 0
          Width = 424
          Height = 371
          Align = alClient
          Columns = <
            item
              Caption = 'Id'
            end
            item
              Caption = 'DisplayName'
              Width = 200
            end>
          RowSelect = True
          TabOrder = 0
          ViewStyle = vsReport
          ExplicitLeft = 1
          ExplicitTop = -1
        end
      end
      object TabSheet4: TTabSheet
        Caption = 'Invoices'
        ImageIndex = 3
        object lvInvoices: TListView
          Left = 0
          Top = 0
          Width = 424
          Height = 371
          Align = alClient
          Columns = <
            item
              Caption = 'Id'
            end
            item
              Caption = 'CustomerRefName'
              Width = 100
            end
            item
              Caption = 'CustomerRefValue'
              Width = 100
            end
            item
              Caption = 'Total'
            end
            item
              Caption = 'Date'
            end>
          RowSelect = True
          TabOrder = 0
          ViewStyle = vsReport
          ExplicitLeft = 1
          ExplicitTop = -1
        end
      end
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 443
    Width = 866
    Height = 19
    Anchors = []
    Panels = <
      item
        Width = 500
      end
      item
        Width = 50
      end>
    ExplicitTop = 442
    ExplicitWidth = 862
  end
  object GridPanel3: TGridPanel
    Left = 0
    Top = 0
    Width = 866
    Height = 42
    Align = alTop
    Caption = 'GridPanel3'
    ColumnCollection = <
      item
        Value = 14.215147155716520000
      end
      item
        Value = 10.464527289654270000
      end
      item
        Value = 8.529088293429915000
      end
      item
        Value = 9.381997122772907000
      end
      item
        Value = 10.320196835050200000
      end
      item
        Value = 11.352216518555220000
      end
      item
        Value = 12.487438170410740000
      end
      item
        Value = 13.736181987451810000
      end
      item
        Value = 9.513206626958402000
      end>
    ControlCollection = <
      item
        Column = 0
        Control = btnAddInvoiceLine
        Row = 0
      end
      item
        Column = 1
        Control = btnAttachFile
        Row = 0
      end
      item
        Column = 2
        Control = btnAuthWithRefreshToken
        Row = 0
      end
      item
        Column = 3
        Control = btnCreateInvoiceFromObject
        Row = 0
      end
      item
        Column = 5
        Control = btnListInvoice
        Row = 0
      end
      item
        Column = 6
        Control = btnUploadInvoice
        Row = 0
      end
      item
        Column = 0
        Control = Button3
        Row = 1
      end>
    RowCollection = <
      item
        Value = 50.000000000000000000
      end
      item
        Value = 50.000000000000000000
      end
      item
        SizeStyle = ssAuto
      end
      item
        SizeStyle = ssAuto
      end
      item
        SizeStyle = ssAuto
      end>
    TabOrder = 2
    ExplicitLeft = 1
    ExplicitTop = -4
    DesignSize = (
      866
      42)
    object btnAddInvoiceLine: TButton
      Left = 10
      Top = 1
      Width = 104
      Height = 25
      Anchors = []
      Caption = 'Add Invoice Line'
      TabOrder = 0
      OnClick = btnAddInvoiceLineClick
    end
    object btnAttachFile: TButton
      Left = 135
      Top = 1
      Width = 67
      Height = 25
      Anchors = []
      Caption = 'Attach File'
      TabOrder = 1
      OnClick = btnAttachFileClick
      ExplicitLeft = 134
    end
    object btnAuthWithRefreshToken: TButton
      Left = 214
      Top = 1
      Width = 138
      Height = 25
      Anchors = []
      Caption = 'Auth with Refresh Token'
      TabOrder = 2
      OnClick = btnAuthWithRefreshTokenClick
      ExplicitLeft = 213
    end
    object btnCreateInvoiceFromObject: TButton
      Left = 288
      Top = 1
      Width = 143
      Height = 25
      Anchors = []
      Caption = 'Create Invoice From Object'
      TabOrder = 3
      OnClick = btnCreateInvoiceFromObjectClick
      ExplicitLeft = 287
    end
    object btnListInvoice: TButton
      Left = 469
      Top = 1
      Width = 75
      Height = 25
      Anchors = []
      Caption = 'List Invoice'
      TabOrder = 4
      OnClick = btnListInvoiceClick
      ExplicitLeft = 467
    end
    object btnUploadInvoice: TButton
      Left = 565
      Top = 1
      Width = 90
      Height = 25
      Anchors = []
      Caption = 'Upload Invoice'
      TabOrder = 5
      OnClick = btnUploadInvoiceClick
      ExplicitLeft = 562
    end
    object Button3: TButton
      Left = 21
      Top = 21
      Width = 82
      Height = 25
      Anchors = []
      Caption = 'Create Invoice'
      TabOrder = 6
      Visible = False
      OnClick = Button3Click
    end
  end
  object BindSourceDB1: TBindSourceDB
    DataSet = dmIntuitAPI.tblCustomers
    ScopeMappings = <>
    Left = 424
    Top = 240
  end
  object BindingsList1: TBindingsList
    Methods = <>
    OutputConverters = <>
    Left = 68
    Top = 85
    object LinkListControlToField1: TLinkListControlToField
      Category = 'Quick Bindings'
      DataSource = BindSourceDB1
      FieldName = 'Id'
      Control = ListView1
      FillExpressions = <
        item
          SourceMemberName = 'DisplayName'
          ControlMemberName = 'SubItems[0]'
        end>
      FillHeaderExpressions = <>
      FillBreakGroups = <>
    end
    object LinkListControlToField2: TLinkListControlToField
      Category = 'Quick Bindings'
      DataSource = BindSourceDB2
      FieldName = 'Id'
      Control = lvInvoices
      FillExpressions = <
        item
          SourceMemberName = 'CustomerRefName'
          ControlMemberName = 'SubItems[0]'
        end
        item
          SourceMemberName = 'CustomerRefValue'
          ControlMemberName = 'SubItems[1]'
        end
        item
          SourceMemberName = 'TotalAmount'
          ControlMemberName = 'SubItems[2]'
        end
        item
          SourceMemberName = 'TxnDate'
          ControlMemberName = 'SubItems[3]'
        end>
      FillHeaderExpressions = <>
      FillBreakGroups = <>
    end
  end
  object MainMenu: TMainMenu
    Left = 597
    Top = 235
    object File1: TMenuItem
      Caption = '&File'
      object Login1: TMenuItem
        Caption = 'Login...'
        OnClick = LoginClick
      end
      object New1: TMenuItem
        Caption = '&New'
      end
      object Open1: TMenuItem
        Caption = '&Open...'
      end
      object Save1: TMenuItem
        Caption = '&Save'
      end
      object SaveAs1: TMenuItem
        Caption = 'Save &As...'
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object Print1: TMenuItem
        Caption = '&Print...'
      end
      object PrintSetup1: TMenuItem
        Caption = 'P&rint Setup...'
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Exit1: TMenuItem
        Caption = 'E&xit'
        OnClick = Exit1Click
      end
    end
  end
  object BindSourceDB2: TBindSourceDB
    DataSet = dmIntuitAPI.tblInvoices
    ScopeMappings = <>
    Left = 424
    Top = 248
  end
end
