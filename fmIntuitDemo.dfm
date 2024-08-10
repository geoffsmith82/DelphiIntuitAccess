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
      object DirectoryListBox1: TDirectoryListBox
        Left = 1
        Top = 1
        Width = 430
        Height = 198
        Align = alClient
        FileList = FileListBox1
        TabOrder = 0
        ExplicitLeft = 0
        ExplicitTop = 5
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
      end
    end
    object PageControl1: TPageControl
      Left = 433
      Top = 1
      Width = 432
      Height = 399
      ActivePage = TabSheet2
      Align = alClient
      TabOrder = 1
      ExplicitTop = 7
      ExplicitHeight = 393
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
          ExplicitTop = 160
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
        Column = 4
        Control = btnListCustomer
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
        Column = 7
        Control = btnLogin
        Row = 0
      end
      item
        Column = 8
        Control = Button2
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
    ExplicitWidth = 862
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
    end
    object btnListCustomer: TButton
      Left = 373
      Top = 1
      Width = 80
      Height = 25
      Anchors = []
      Caption = 'List Customer'
      TabOrder = 4
      OnClick = btnListCustomerClick
    end
    object btnListInvoice: TButton
      Left = 469
      Top = 1
      Width = 75
      Height = 25
      Anchors = []
      Caption = 'List Invoice'
      TabOrder = 5
      OnClick = btnListInvoiceClick
    end
    object btnUploadInvoice: TButton
      Left = 565
      Top = 1
      Width = 90
      Height = 25
      Anchors = []
      Caption = 'Upload Invoice'
      TabOrder = 6
      OnClick = btnUploadInvoiceClick
    end
    object btnLogin: TButton
      Left = 686
      Top = 1
      Width = 75
      Height = 25
      Anchors = []
      Caption = 'Login'
      TabOrder = 7
      OnClick = LoginClick
    end
    object Button2: TButton
      Left = 786
      Top = 1
      Width = 75
      Height = 25
      Anchors = []
      Caption = 'JSON Invoice'
      TabOrder = 8
    end
    object Button3: TButton
      Left = 21
      Top = 21
      Width = 82
      Height = 25
      Anchors = []
      Caption = 'Create Invoice'
      TabOrder = 9
      Visible = False
      OnClick = Button3Click
    end
  end
end
