object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Intuit Login Demo'
  ClientHeight = 578
  ClientWidth = 1078
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poDesigned
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 17
  object GridPanel1: TGridPanel
    Left = 0
    Top = -69
    Width = 1078
    Height = 647
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Align = alBottom
    Anchors = [akLeft, akTop, akRight, akBottom]
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
    ExplicitTop = -61
    ExplicitHeight = 597
    object GridPanel2: TGridPanel
      Left = 1
      Top = 1
      Width = 538
      Height = 645
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
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
      ExplicitWidth = 480
      ExplicitHeight = 595
      object DirectoryListBox1: TDirectoryListBox
        Left = 1
        Top = 1
        Width = 536
        Height = 322
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Align = alClient
        FileList = FileListBox1
        ItemHeight = 17
        TabOrder = 0
        ExplicitWidth = 478
        ExplicitHeight = 296
      end
      object FileListBox1: TFileListBox
        Left = 1
        Top = 323
        Width = 536
        Height = 321
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Align = alClient
        ItemHeight = 17
        Mask = '*.pdf'
        TabOrder = 1
        OnChange = FileListBoxEx1Change
        ExplicitTop = 297
        ExplicitWidth = 478
        ExplicitHeight = 297
      end
    end
    object PageControl1: TPageControl
      Left = 539
      Top = 155
      Width = 538
      Height = 491
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      ActivePage = TabSheet2
      Align = alBottom
      TabOrder = 1
      ExplicitTop = 250
      object TabSheet1: TTabSheet
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Caption = 'Log'
        object Memo1: TMemo
          Left = 0
          Top = 0
          Width = 530
          Height = 459
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Align = alClient
          Lines.Strings = (
            'Memo1')
          TabOrder = 0
          ExplicitWidth = 472
          ExplicitHeight = 563
        end
      end
      object TabSheet2: TTabSheet
        Margins.Left = 4
        Margins.Top = 4
        Margins.Right = 4
        Margins.Bottom = 4
        Caption = 'Invoice Info'
        ImageIndex = 1
        object Label1: TLabel
          Left = -2
          Top = 24
          Width = 77
          Height = 17
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = 'Invoice Date'
        end
        object Label2: TLabel
          Left = 0
          Top = 58
          Width = 80
          Height = 17
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = 'Invoice From'
        end
        object Label3: TLabel
          Left = 0
          Top = 88
          Width = 64
          Height = 17
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = 'Invoice To'
        end
        object Label4: TLabel
          Left = 0
          Top = 125
          Width = 65
          Height = 17
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = 'Invoice No'
        end
        object Label5: TLabel
          Left = 248
          Top = 24
          Width = 70
          Height = 17
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = 'Total Hours'
        end
        object Label6: TLabel
          Left = 248
          Top = 58
          Width = 83
          Height = 17
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = 'Total Amount'
        end
        object Label7: TLabel
          Left = 250
          Top = 92
          Width = 53
          Height = 17
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = 'ClientRef'
        end
        object Label8: TLabel
          Left = 250
          Top = 125
          Width = 44
          Height = 17
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Caption = 'Project'
        end
        object edtClientRef: TEdit
          Left = 332
          Top = 88
          Width = 151
          Height = 25
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          TabOrder = 0
        end
        object edtProject: TEdit
          Left = 332
          Top = 122
          Width = 151
          Height = 25
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          TabOrder = 1
        end
        object StringGrid1: TStringGrid
          Left = 3
          Top = 230
          Width = 465
          Height = 329
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          DefaultColWidth = 80
          DefaultRowHeight = 30
          TabOrder = 2
        end
        object edtInvoiceNo: TEdit
          Left = 73
          Top = 121
          Width = 151
          Height = 25
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          TabOrder = 3
          Text = 'edtInvoiceNo'
        end
        object meTotalAmount: TEdit
          Left = 339
          Top = 55
          Width = 151
          Height = 25
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          TabOrder = 4
          Text = 'meTotalAmount'
        end
        object meTotalHours: TEdit
          Left = 340
          Top = 22
          Width = 151
          Height = 25
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          TabOrder = 5
          Text = 'meTotalHours'
        end
        object InvoiceDateDatePicker: TDateTimePicker
          Left = 83
          Top = 21
          Width = 138
          Height = 25
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Date = 44922.000000000000000000
          Time = 0.976881793983920900
          TabOrder = 6
        end
        object InvoiceDateFromDatePicker: TDateTimePicker
          Left = 80
          Top = 54
          Width = 141
          Height = 25
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Date = 44922.000000000000000000
          Time = 0.977810972224688200
          TabOrder = 7
        end
        object InvoiceDateToPicker: TDateTimePicker
          Left = 80
          Top = 83
          Width = 141
          Height = 25
          Margins.Left = 4
          Margins.Top = 4
          Margins.Right = 4
          Margins.Bottom = 4
          Date = 44922.000000000000000000
          Time = 0.977810972224688200
          TabOrder = 8
        end
      end
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = -93
    Width = 1078
    Height = 24
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Anchors = []
    Panels = <
      item
        Width = 625
      end
      item
        Width = 63
      end>
    ExplicitTop = 504
    ExplicitWidth = 962
  end
  object GridPanel3: TGridPanel
    Left = 0
    Top = 0
    Width = 1078
    Height = 52
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
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
    ExplicitWidth = 962
    DesignSize = (
      1078
      52)
    object btnAddInvoiceLine: TButton
      Left = 12
      Top = 1
      Width = 131
      Height = 32
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Anchors = []
      Caption = 'Add Invoice Line'
      TabOrder = 0
      OnClick = btnAddInvoiceLineClick
      ExplicitLeft = 3
    end
    object btnAttachFile: TButton
      Left = 169
      Top = 1
      Width = 83
      Height = 31
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Anchors = []
      Caption = 'Attach File'
      TabOrder = 1
      OnClick = btnAttachFileClick
      ExplicitLeft = 146
    end
    object btnAuthWithRefreshToken: TButton
      Left = 267
      Top = 1
      Width = 173
      Height = 32
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Anchors = []
      Caption = 'Auth with Refresh Token'
      TabOrder = 2
      OnClick = btnAuthWithRefreshTokenClick
      ExplicitLeft = 238
    end
    object btnCreateInvoiceFromObject: TButton
      Left = 358
      Top = 1
      Width = 178
      Height = 31
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Anchors = []
      Caption = 'Create Invoice From Object'
      TabOrder = 3
      OnClick = btnCreateInvoiceFromObjectClick
      ExplicitLeft = 320
    end
    object btnListCustomer: TButton
      Left = 464
      Top = 1
      Width = 100
      Height = 32
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Anchors = []
      Caption = 'List Customer'
      TabOrder = 4
      OnClick = btnListCustomerClick
      ExplicitLeft = 410
    end
    object btnListInvoice: TButton
      Left = 584
      Top = 1
      Width = 93
      Height = 31
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Anchors = []
      Caption = 'List Invoice'
      TabOrder = 5
      OnClick = btnListInvoiceClick
      ExplicitLeft = 517
    end
    object btnUploadInvoice: TButton
      Left = 703
      Top = 1
      Width = 112
      Height = 32
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Anchors = []
      Caption = 'Upload Invoice'
      TabOrder = 6
      OnClick = btnUploadInvoiceClick
      ExplicitLeft = 622
    end
    object btnLogin: TButton
      Left = 854
      Top = 1
      Width = 94
      Height = 31
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Anchors = []
      Caption = 'Login'
      TabOrder = 7
      OnClick = LoginClick
      ExplicitLeft = 757
    end
    object Button2: TButton
      Left = 979
      Top = 1
      Width = 94
      Height = 32
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Anchors = []
      Caption = 'JSON Invoice'
      TabOrder = 8
      OnClick = JSONInvoiceClick
      ExplicitLeft = 870
    end
    object Button3: TButton
      Left = 26
      Top = 26
      Width = 103
      Height = 32
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Anchors = []
      Caption = 'Create Invoice'
      TabOrder = 9
      Visible = False
      OnClick = Button3Click
      ExplicitLeft = 17
    end
  end
end
