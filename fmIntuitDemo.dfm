object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Intuit Login Demo'
  ClientHeight = 535
  ClientWidth = 1037
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 8
    Top = 9
    Width = 75
    Height = 25
    Caption = 'Login'
    TabOrder = 0
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 399
    Top = 8
    Width = 82
    Height = 25
    Caption = 'Create Invoice'
    TabOrder = 1
    Visible = False
    OnClick = Button3Click
  end
  object btnListCustomer: TButton
    Left = 89
    Top = 8
    Width = 80
    Height = 25
    Caption = 'List Customer'
    TabOrder = 2
    OnClick = btnListCustomerClick
  end
  object btnListInvoice: TButton
    Left = 175
    Top = 9
    Width = 74
    Height = 25
    Caption = 'List Invoice'
    TabOrder = 3
    OnClick = btnListInvoiceClick
  end
  object btnAuthWithRefreshToken: TButton
    Left = 255
    Top = 8
    Width = 138
    Height = 25
    Caption = 'Auth with Refresh Token'
    TabOrder = 4
    OnClick = btnAuthWithRefreshTokenClick
  end
  object btnCreateInvoiceFromObject: TButton
    Left = 559
    Top = 9
    Width = 142
    Height = 25
    Caption = 'Create Invoice From Object'
    TabOrder = 5
    OnClick = btnCreateInvoiceFromObjectClick
  end
  object GridPanel1: TGridPanel
    Left = 0
    Top = 39
    Width = 1037
    Height = 477
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
    TabOrder = 10
    object GridPanel2: TGridPanel
      Left = 1
      Top = 1
      Width = 518
      Height = 475
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
        Width = 516
        Height = 236
        Align = alClient
        FileList = FileListBox1
        TabOrder = 0
      end
      object FileListBox1: TFileListBox
        Left = 1
        Top = 237
        Width = 516
        Height = 237
        Align = alClient
        ItemHeight = 13
        Mask = '*.pdf'
        TabOrder = 1
        OnChange = FileListBoxEx1Change
      end
    end
    object PageControl1: TPageControl
      Left = 519
      Top = 1
      Width = 517
      Height = 475
      ActivePage = TabSheet2
      Align = alClient
      TabOrder = 1
      object TabSheet1: TTabSheet
        Caption = 'Log'
        object Memo1: TMemo
          Left = 0
          Top = 0
          Width = 509
          Height = 447
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
          Left = -1
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
          Top = 73
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
        object InvoiceDateDatePicker: TAdvSmoothDatePicker
          Left = 66
          Top = 16
          Width = 108
          Height = 21
          AllowNumericNullValue = True
          Flat = False
          FlatLineColor = 11250603
          BorderColor = 11250603
          FocusFontColor = 3881787
          DisabledColor = 13948116
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = 4474440
          LabelFont.Height = -11
          LabelFont.Name = 'Tahoma'
          LabelFont.Style = []
          Lookup.Separator = ';'
          Color = clWhite
          Enabled = True
          ReadOnly = False
          TabOrder = 0
          Text = '2/06/2019'
          Visible = True
          Version = '2.6.1.5'
          ButtonStyle = bsDropDown
          ButtonWidth = 16
          Etched = False
          Glyph.Data = {
            DA020000424DDA0200000000000036000000280000000D0000000D0000000100
            200000000000A402000000000000000000000000000000000000F0F0F000F0F0
            F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
            F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
            F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
            F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
            F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
            F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
            F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
            F00000000000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
            F000F0F0F000F0F0F000F0F0F000F0F0F000000000000000000000000000F0F0
            F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
            F0000000000000000000000000000000000000000000F0F0F000F0F0F000F0F0
            F000F0F0F000F0F0F000F0F0F000F0F0F0000000000000000000000000000000
            0000000000000000000000000000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
            F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
            F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
            F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
            F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
            F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
            F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
            F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
            F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000}
          ButtonColor = clWhite
          ButtonColorHot = 15917525
          ButtonColorDown = 14925219
          ButtonTextColor = 4474440
          ButtonTextColorHot = 2303013
          ButtonTextColorDown = 2303013
          ButtonBorderColor = 11250603
          HideCalendarAfterSelection = True
          Calendar.Fill.Color = clWhite
          Calendar.Fill.ColorTo = clNone
          Calendar.Fill.ColorMirror = clNone
          Calendar.Fill.ColorMirrorTo = clNone
          Calendar.Fill.GradientType = gtVertical
          Calendar.Fill.GradientMirrorType = gtSolid
          Calendar.Fill.BorderColor = clNone
          Calendar.Fill.Rounding = 0
          Calendar.Fill.ShadowOffset = 0
          Calendar.Fill.Glow = gmNone
          Calendar.Animation = True
          Calendar.ShowCurrentDate = True
          Calendar.DateAppearance.DateFont.Charset = DEFAULT_CHARSET
          Calendar.DateAppearance.DateFont.Color = clBlack
          Calendar.DateAppearance.DateFont.Height = -11
          Calendar.DateAppearance.DateFont.Name = 'Tahoma'
          Calendar.DateAppearance.DateFont.Style = []
          Calendar.DateAppearance.DateFill.Color = clWhite
          Calendar.DateAppearance.DateFill.ColorTo = clNone
          Calendar.DateAppearance.DateFill.ColorMirror = clNone
          Calendar.DateAppearance.DateFill.ColorMirrorTo = clNone
          Calendar.DateAppearance.DateFill.GradientType = gtVertical
          Calendar.DateAppearance.DateFill.GradientMirrorType = gtVertical
          Calendar.DateAppearance.DateFill.BorderColor = clNone
          Calendar.DateAppearance.DateFill.Rounding = 0
          Calendar.DateAppearance.DateFill.ShadowOffset = 0
          Calendar.DateAppearance.DateFill.Glow = gmNone
          Calendar.DateAppearance.DayOfWeekFont.Charset = DEFAULT_CHARSET
          Calendar.DateAppearance.DayOfWeekFont.Color = clBlack
          Calendar.DateAppearance.DayOfWeekFont.Height = -11
          Calendar.DateAppearance.DayOfWeekFont.Name = 'Tahoma'
          Calendar.DateAppearance.DayOfWeekFont.Style = []
          Calendar.DateAppearance.DayOfWeekFill.Color = clWhite
          Calendar.DateAppearance.DayOfWeekFill.ColorTo = clNone
          Calendar.DateAppearance.DayOfWeekFill.ColorMirror = clNone
          Calendar.DateAppearance.DayOfWeekFill.ColorMirrorTo = clNone
          Calendar.DateAppearance.DayOfWeekFill.GradientType = gtVertical
          Calendar.DateAppearance.DayOfWeekFill.GradientMirrorType = gtSolid
          Calendar.DateAppearance.DayOfWeekFill.BorderColor = clWhite
          Calendar.DateAppearance.DayOfWeekFill.Rounding = 0
          Calendar.DateAppearance.DayOfWeekFill.ShadowOffset = 0
          Calendar.DateAppearance.DayOfWeekFill.Glow = gmNone
          Calendar.DateAppearance.SelectedDateFont.Charset = DEFAULT_CHARSET
          Calendar.DateAppearance.SelectedDateFont.Color = clBlack
          Calendar.DateAppearance.SelectedDateFont.Height = -11
          Calendar.DateAppearance.SelectedDateFont.Name = 'Tahoma'
          Calendar.DateAppearance.SelectedDateFont.Style = []
          Calendar.DateAppearance.SelectedDateFill.Color = 14925219
          Calendar.DateAppearance.SelectedDateFill.ColorTo = clNone
          Calendar.DateAppearance.SelectedDateFill.ColorMirror = clNone
          Calendar.DateAppearance.SelectedDateFill.ColorMirrorTo = clNone
          Calendar.DateAppearance.SelectedDateFill.GradientType = gtVertical
          Calendar.DateAppearance.SelectedDateFill.GradientMirrorType = gtVertical
          Calendar.DateAppearance.SelectedDateFill.BorderColor = 14925219
          Calendar.DateAppearance.SelectedDateFill.Rounding = 0
          Calendar.DateAppearance.SelectedDateFill.ShadowOffset = 0
          Calendar.DateAppearance.SelectedDateFill.Glow = gmNone
          Calendar.DateAppearance.CurrentDateFont.Charset = DEFAULT_CHARSET
          Calendar.DateAppearance.CurrentDateFont.Color = 3881787
          Calendar.DateAppearance.CurrentDateFont.Height = -11
          Calendar.DateAppearance.CurrentDateFont.Name = 'Tahoma'
          Calendar.DateAppearance.CurrentDateFont.Style = []
          Calendar.DateAppearance.CurrentDateFill.Color = clWhite
          Calendar.DateAppearance.CurrentDateFill.ColorTo = clNone
          Calendar.DateAppearance.CurrentDateFill.ColorMirror = clNone
          Calendar.DateAppearance.CurrentDateFill.ColorMirrorTo = clNone
          Calendar.DateAppearance.CurrentDateFill.GradientType = gtVertical
          Calendar.DateAppearance.CurrentDateFill.GradientMirrorType = gtVertical
          Calendar.DateAppearance.CurrentDateFill.BorderColor = 14925219
          Calendar.DateAppearance.CurrentDateFill.Rounding = 0
          Calendar.DateAppearance.CurrentDateFill.ShadowOffset = 0
          Calendar.DateAppearance.CurrentDateFill.Glow = gmNone
          Calendar.DateAppearance.WeekendFill.Color = clWhite
          Calendar.DateAppearance.WeekendFill.ColorTo = clNone
          Calendar.DateAppearance.WeekendFill.ColorMirror = clNone
          Calendar.DateAppearance.WeekendFill.ColorMirrorTo = clNone
          Calendar.DateAppearance.WeekendFill.GradientType = gtVertical
          Calendar.DateAppearance.WeekendFill.GradientMirrorType = gtVertical
          Calendar.DateAppearance.WeekendFill.BorderColor = clNone
          Calendar.DateAppearance.WeekendFill.Rounding = 0
          Calendar.DateAppearance.WeekendFill.ShadowOffset = 0
          Calendar.DateAppearance.WeekendFill.Glow = gmNone
          Calendar.DateAppearance.WeekendFont.Charset = DEFAULT_CHARSET
          Calendar.DateAppearance.WeekendFont.Color = clBlack
          Calendar.DateAppearance.WeekendFont.Height = -11
          Calendar.DateAppearance.WeekendFont.Name = 'Tahoma'
          Calendar.DateAppearance.WeekendFont.Style = []
          Calendar.DateAppearance.HoverDateFont.Charset = DEFAULT_CHARSET
          Calendar.DateAppearance.HoverDateFont.Color = 3881787
          Calendar.DateAppearance.HoverDateFont.Height = -11
          Calendar.DateAppearance.HoverDateFont.Name = 'Tahoma'
          Calendar.DateAppearance.HoverDateFont.Style = []
          Calendar.DateAppearance.HoverDateFill.Color = 15917525
          Calendar.DateAppearance.HoverDateFill.ColorTo = clNone
          Calendar.DateAppearance.HoverDateFill.ColorMirror = clNone
          Calendar.DateAppearance.HoverDateFill.ColorMirrorTo = clNone
          Calendar.DateAppearance.HoverDateFill.GradientType = gtVertical
          Calendar.DateAppearance.HoverDateFill.GradientMirrorType = gtVertical
          Calendar.DateAppearance.HoverDateFill.BorderColor = 15917525
          Calendar.DateAppearance.HoverDateFill.Rounding = 0
          Calendar.DateAppearance.HoverDateFill.ShadowOffset = 0
          Calendar.DateAppearance.HoverDateFill.Glow = gmNone
          Calendar.DateAppearance.MonthDateFont.Charset = DEFAULT_CHARSET
          Calendar.DateAppearance.MonthDateFont.Color = clBlack
          Calendar.DateAppearance.MonthDateFont.Height = -11
          Calendar.DateAppearance.MonthDateFont.Name = 'Tahoma'
          Calendar.DateAppearance.MonthDateFont.Style = []
          Calendar.DateAppearance.YearDateFont.Charset = DEFAULT_CHARSET
          Calendar.DateAppearance.YearDateFont.Color = clBlack
          Calendar.DateAppearance.YearDateFont.Height = -11
          Calendar.DateAppearance.YearDateFont.Name = 'Tahoma'
          Calendar.DateAppearance.YearDateFont.Style = []
          Calendar.DateAppearance.WeekNumbers.Font.Charset = DEFAULT_CHARSET
          Calendar.DateAppearance.WeekNumbers.Font.Color = clWindowText
          Calendar.DateAppearance.WeekNumbers.Font.Height = -11
          Calendar.DateAppearance.WeekNumbers.Font.Name = 'Tahoma'
          Calendar.DateAppearance.WeekNumbers.Font.Style = []
          Calendar.DateAppearance.WeekNumbers.Fill.Color = clWhite
          Calendar.DateAppearance.WeekNumbers.Fill.ColorTo = clNone
          Calendar.DateAppearance.WeekNumbers.Fill.ColorMirror = clNone
          Calendar.DateAppearance.WeekNumbers.Fill.ColorMirrorTo = clNone
          Calendar.DateAppearance.WeekNumbers.Fill.GradientType = gtVertical
          Calendar.DateAppearance.WeekNumbers.Fill.GradientMirrorType = gtSolid
          Calendar.DateAppearance.WeekNumbers.Fill.BorderColor = clWhite
          Calendar.DateAppearance.WeekNumbers.Fill.Rounding = 0
          Calendar.DateAppearance.WeekNumbers.Fill.ShadowOffset = 0
          Calendar.DateAppearance.WeekNumbers.Fill.Glow = gmNone
          Calendar.DateAppearance.DisabledDateFont.Charset = DEFAULT_CHARSET
          Calendar.DateAppearance.DisabledDateFont.Color = 13948116
          Calendar.DateAppearance.DisabledDateFont.Height = -11
          Calendar.DateAppearance.DisabledDateFont.Name = 'Tahoma'
          Calendar.DateAppearance.DisabledDateFont.Style = []
          Calendar.DateAppearance.DisabledDateFill.Color = clWhite
          Calendar.DateAppearance.DisabledDateFill.ColorTo = clNone
          Calendar.DateAppearance.DisabledDateFill.ColorMirror = clNone
          Calendar.DateAppearance.DisabledDateFill.ColorMirrorTo = clNone
          Calendar.DateAppearance.DisabledDateFill.GradientType = gtVertical
          Calendar.DateAppearance.DisabledDateFill.GradientMirrorType = gtVertical
          Calendar.DateAppearance.DisabledDateFill.BorderColor = clNone
          Calendar.DateAppearance.DisabledDateFill.Rounding = 0
          Calendar.DateAppearance.DisabledDateFill.ShadowOffset = 0
          Calendar.DateAppearance.DisabledDateFill.Glow = gmNone
          Calendar.DateAppearance.DateBeforeFill.Color = clNone
          Calendar.DateAppearance.DateBeforeFill.ColorMirror = clNone
          Calendar.DateAppearance.DateBeforeFill.ColorMirrorTo = clNone
          Calendar.DateAppearance.DateBeforeFill.GradientType = gtVertical
          Calendar.DateAppearance.DateBeforeFill.GradientMirrorType = gtSolid
          Calendar.DateAppearance.DateBeforeFill.BorderColor = clNone
          Calendar.DateAppearance.DateBeforeFill.Rounding = 0
          Calendar.DateAppearance.DateBeforeFill.ShadowOffset = 0
          Calendar.DateAppearance.DateBeforeFill.Glow = gmNone
          Calendar.DateAppearance.DateAfterFill.Color = clNone
          Calendar.DateAppearance.DateAfterFill.ColorMirror = clNone
          Calendar.DateAppearance.DateAfterFill.ColorMirrorTo = clNone
          Calendar.DateAppearance.DateAfterFill.GradientType = gtVertical
          Calendar.DateAppearance.DateAfterFill.GradientMirrorType = gtSolid
          Calendar.DateAppearance.DateAfterFill.BorderColor = clNone
          Calendar.DateAppearance.DateAfterFill.Rounding = 0
          Calendar.DateAppearance.DateAfterFill.ShadowOffset = 0
          Calendar.DateAppearance.DateAfterFill.Glow = gmNone
          Calendar.DateAppearance.DateBeforeFont.Charset = DEFAULT_CHARSET
          Calendar.DateAppearance.DateBeforeFont.Color = clSilver
          Calendar.DateAppearance.DateBeforeFont.Height = -11
          Calendar.DateAppearance.DateBeforeFont.Name = 'Tahoma'
          Calendar.DateAppearance.DateBeforeFont.Style = []
          Calendar.DateAppearance.DateAfterFont.Charset = DEFAULT_CHARSET
          Calendar.DateAppearance.DateAfterFont.Color = clSilver
          Calendar.DateAppearance.DateAfterFont.Height = -11
          Calendar.DateAppearance.DateAfterFont.Name = 'Tahoma'
          Calendar.DateAppearance.DateAfterFont.Style = []
          Calendar.StatusAppearance.Fill.Color = clRed
          Calendar.StatusAppearance.Fill.ColorMirror = clNone
          Calendar.StatusAppearance.Fill.ColorMirrorTo = clNone
          Calendar.StatusAppearance.Fill.GradientType = gtSolid
          Calendar.StatusAppearance.Fill.GradientMirrorType = gtSolid
          Calendar.StatusAppearance.Fill.BorderColor = clGray
          Calendar.StatusAppearance.Fill.Rounding = 0
          Calendar.StatusAppearance.Fill.RoundingType = rtNone
          Calendar.StatusAppearance.Fill.ShadowOffset = 0
          Calendar.StatusAppearance.Fill.Glow = gmNone
          Calendar.StatusAppearance.Font.Charset = DEFAULT_CHARSET
          Calendar.StatusAppearance.Font.Color = clWhite
          Calendar.StatusAppearance.Font.Height = -11
          Calendar.StatusAppearance.Font.Name = 'Tahoma'
          Calendar.StatusAppearance.Font.Style = []
          Calendar.StatusAppearance.Glow = False
          Calendar.Footer.Fill.Color = clWhite
          Calendar.Footer.Fill.ColorTo = clNone
          Calendar.Footer.Fill.ColorMirror = clNone
          Calendar.Footer.Fill.ColorMirrorTo = clNone
          Calendar.Footer.Fill.GradientType = gtVertical
          Calendar.Footer.Fill.GradientMirrorType = gtSolid
          Calendar.Footer.Fill.BorderColor = clNone
          Calendar.Footer.Fill.Rounding = 0
          Calendar.Footer.Fill.ShadowOffset = 0
          Calendar.Footer.Fill.Glow = gmNone
          Calendar.Footer.Font.Charset = DEFAULT_CHARSET
          Calendar.Footer.Font.Color = 4474440
          Calendar.Footer.Font.Height = -11
          Calendar.Footer.Font.Name = 'Tahoma'
          Calendar.Footer.Font.Style = []
          Calendar.Header.Fill.Color = clWhite
          Calendar.Header.Fill.ColorTo = clNone
          Calendar.Header.Fill.ColorMirror = clNone
          Calendar.Header.Fill.ColorMirrorTo = clNone
          Calendar.Header.Fill.GradientType = gtVertical
          Calendar.Header.Fill.GradientMirrorType = gtSolid
          Calendar.Header.Fill.BorderColor = clNone
          Calendar.Header.Fill.Rounding = 0
          Calendar.Header.Fill.ShadowOffset = 0
          Calendar.Header.Fill.Glow = gmNone
          Calendar.Header.ArrowColor = 4474440
          Calendar.Header.Font.Charset = DEFAULT_CHARSET
          Calendar.Header.Font.Color = 4474440
          Calendar.Header.Font.Height = -11
          Calendar.Header.Font.Name = 'Tahoma'
          Calendar.Header.Font.Style = []
          Calendar.Width = 257
          Calendar.Height = 249
          Calendar.ShowHint = False
          Date = 43618.000000000000000000
          TMSStyle = 8
        end
        object InvoiceDateFromDatePicker: TAdvSmoothDatePicker
          Left = 66
          Top = 43
          Width = 108
          Height = 21
          AllowNumericNullValue = True
          Flat = False
          FlatLineColor = 11250603
          BorderColor = 11250603
          FocusFontColor = 3881787
          DisabledColor = 13948116
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = 4474440
          LabelFont.Height = -11
          LabelFont.Name = 'Tahoma'
          LabelFont.Style = []
          Lookup.Separator = ';'
          Color = clWhite
          Enabled = True
          ReadOnly = False
          TabOrder = 1
          Text = '2/06/2019'
          Visible = True
          Version = '2.6.1.5'
          ButtonStyle = bsDropDown
          ButtonWidth = 16
          Etched = False
          Glyph.Data = {
            DA020000424DDA0200000000000036000000280000000D0000000D0000000100
            200000000000A402000000000000000000000000000000000000F0F0F000F0F0
            F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
            F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
            F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
            F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
            F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
            F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
            F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
            F00000000000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
            F000F0F0F000F0F0F000F0F0F000F0F0F000000000000000000000000000F0F0
            F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
            F0000000000000000000000000000000000000000000F0F0F000F0F0F000F0F0
            F000F0F0F000F0F0F000F0F0F000F0F0F0000000000000000000000000000000
            0000000000000000000000000000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
            F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
            F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
            F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
            F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
            F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
            F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
            F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
            F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000}
          ButtonColor = clWhite
          ButtonColorHot = 15917525
          ButtonColorDown = 14925219
          ButtonTextColor = 4474440
          ButtonTextColorHot = 2303013
          ButtonTextColorDown = 2303013
          ButtonBorderColor = 11250603
          HideCalendarAfterSelection = True
          Calendar.Fill.Color = clWhite
          Calendar.Fill.ColorTo = clNone
          Calendar.Fill.ColorMirror = clNone
          Calendar.Fill.ColorMirrorTo = clNone
          Calendar.Fill.GradientType = gtVertical
          Calendar.Fill.GradientMirrorType = gtSolid
          Calendar.Fill.BorderColor = clNone
          Calendar.Fill.Rounding = 0
          Calendar.Fill.ShadowOffset = 0
          Calendar.Fill.Glow = gmNone
          Calendar.Animation = True
          Calendar.ShowCurrentDate = True
          Calendar.DateAppearance.DateFont.Charset = DEFAULT_CHARSET
          Calendar.DateAppearance.DateFont.Color = clBlack
          Calendar.DateAppearance.DateFont.Height = -11
          Calendar.DateAppearance.DateFont.Name = 'Tahoma'
          Calendar.DateAppearance.DateFont.Style = []
          Calendar.DateAppearance.DateFill.Color = clWhite
          Calendar.DateAppearance.DateFill.ColorTo = clNone
          Calendar.DateAppearance.DateFill.ColorMirror = clNone
          Calendar.DateAppearance.DateFill.ColorMirrorTo = clNone
          Calendar.DateAppearance.DateFill.GradientType = gtVertical
          Calendar.DateAppearance.DateFill.GradientMirrorType = gtVertical
          Calendar.DateAppearance.DateFill.BorderColor = clNone
          Calendar.DateAppearance.DateFill.Rounding = 0
          Calendar.DateAppearance.DateFill.ShadowOffset = 0
          Calendar.DateAppearance.DateFill.Glow = gmNone
          Calendar.DateAppearance.DayOfWeekFont.Charset = DEFAULT_CHARSET
          Calendar.DateAppearance.DayOfWeekFont.Color = clBlack
          Calendar.DateAppearance.DayOfWeekFont.Height = -11
          Calendar.DateAppearance.DayOfWeekFont.Name = 'Tahoma'
          Calendar.DateAppearance.DayOfWeekFont.Style = []
          Calendar.DateAppearance.DayOfWeekFill.Color = clWhite
          Calendar.DateAppearance.DayOfWeekFill.ColorTo = clNone
          Calendar.DateAppearance.DayOfWeekFill.ColorMirror = clNone
          Calendar.DateAppearance.DayOfWeekFill.ColorMirrorTo = clNone
          Calendar.DateAppearance.DayOfWeekFill.GradientType = gtVertical
          Calendar.DateAppearance.DayOfWeekFill.GradientMirrorType = gtSolid
          Calendar.DateAppearance.DayOfWeekFill.BorderColor = clWhite
          Calendar.DateAppearance.DayOfWeekFill.Rounding = 0
          Calendar.DateAppearance.DayOfWeekFill.ShadowOffset = 0
          Calendar.DateAppearance.DayOfWeekFill.Glow = gmNone
          Calendar.DateAppearance.SelectedDateFont.Charset = DEFAULT_CHARSET
          Calendar.DateAppearance.SelectedDateFont.Color = clBlack
          Calendar.DateAppearance.SelectedDateFont.Height = -11
          Calendar.DateAppearance.SelectedDateFont.Name = 'Tahoma'
          Calendar.DateAppearance.SelectedDateFont.Style = []
          Calendar.DateAppearance.SelectedDateFill.Color = 14925219
          Calendar.DateAppearance.SelectedDateFill.ColorTo = clNone
          Calendar.DateAppearance.SelectedDateFill.ColorMirror = clNone
          Calendar.DateAppearance.SelectedDateFill.ColorMirrorTo = clNone
          Calendar.DateAppearance.SelectedDateFill.GradientType = gtVertical
          Calendar.DateAppearance.SelectedDateFill.GradientMirrorType = gtVertical
          Calendar.DateAppearance.SelectedDateFill.BorderColor = 14925219
          Calendar.DateAppearance.SelectedDateFill.Rounding = 0
          Calendar.DateAppearance.SelectedDateFill.ShadowOffset = 0
          Calendar.DateAppearance.SelectedDateFill.Glow = gmNone
          Calendar.DateAppearance.CurrentDateFont.Charset = DEFAULT_CHARSET
          Calendar.DateAppearance.CurrentDateFont.Color = 3881787
          Calendar.DateAppearance.CurrentDateFont.Height = -11
          Calendar.DateAppearance.CurrentDateFont.Name = 'Tahoma'
          Calendar.DateAppearance.CurrentDateFont.Style = []
          Calendar.DateAppearance.CurrentDateFill.Color = clWhite
          Calendar.DateAppearance.CurrentDateFill.ColorTo = clNone
          Calendar.DateAppearance.CurrentDateFill.ColorMirror = clNone
          Calendar.DateAppearance.CurrentDateFill.ColorMirrorTo = clNone
          Calendar.DateAppearance.CurrentDateFill.GradientType = gtVertical
          Calendar.DateAppearance.CurrentDateFill.GradientMirrorType = gtVertical
          Calendar.DateAppearance.CurrentDateFill.BorderColor = 14925219
          Calendar.DateAppearance.CurrentDateFill.Rounding = 0
          Calendar.DateAppearance.CurrentDateFill.ShadowOffset = 0
          Calendar.DateAppearance.CurrentDateFill.Glow = gmNone
          Calendar.DateAppearance.WeekendFill.Color = clWhite
          Calendar.DateAppearance.WeekendFill.ColorTo = clNone
          Calendar.DateAppearance.WeekendFill.ColorMirror = clNone
          Calendar.DateAppearance.WeekendFill.ColorMirrorTo = clNone
          Calendar.DateAppearance.WeekendFill.GradientType = gtVertical
          Calendar.DateAppearance.WeekendFill.GradientMirrorType = gtVertical
          Calendar.DateAppearance.WeekendFill.BorderColor = clNone
          Calendar.DateAppearance.WeekendFill.Rounding = 0
          Calendar.DateAppearance.WeekendFill.ShadowOffset = 0
          Calendar.DateAppearance.WeekendFill.Glow = gmNone
          Calendar.DateAppearance.WeekendFont.Charset = DEFAULT_CHARSET
          Calendar.DateAppearance.WeekendFont.Color = clBlack
          Calendar.DateAppearance.WeekendFont.Height = -11
          Calendar.DateAppearance.WeekendFont.Name = 'Tahoma'
          Calendar.DateAppearance.WeekendFont.Style = []
          Calendar.DateAppearance.HoverDateFont.Charset = DEFAULT_CHARSET
          Calendar.DateAppearance.HoverDateFont.Color = 3881787
          Calendar.DateAppearance.HoverDateFont.Height = -11
          Calendar.DateAppearance.HoverDateFont.Name = 'Tahoma'
          Calendar.DateAppearance.HoverDateFont.Style = []
          Calendar.DateAppearance.HoverDateFill.Color = 15917525
          Calendar.DateAppearance.HoverDateFill.ColorTo = clNone
          Calendar.DateAppearance.HoverDateFill.ColorMirror = clNone
          Calendar.DateAppearance.HoverDateFill.ColorMirrorTo = clNone
          Calendar.DateAppearance.HoverDateFill.GradientType = gtVertical
          Calendar.DateAppearance.HoverDateFill.GradientMirrorType = gtVertical
          Calendar.DateAppearance.HoverDateFill.BorderColor = 15917525
          Calendar.DateAppearance.HoverDateFill.Rounding = 0
          Calendar.DateAppearance.HoverDateFill.ShadowOffset = 0
          Calendar.DateAppearance.HoverDateFill.Glow = gmNone
          Calendar.DateAppearance.MonthDateFont.Charset = DEFAULT_CHARSET
          Calendar.DateAppearance.MonthDateFont.Color = clBlack
          Calendar.DateAppearance.MonthDateFont.Height = -11
          Calendar.DateAppearance.MonthDateFont.Name = 'Tahoma'
          Calendar.DateAppearance.MonthDateFont.Style = []
          Calendar.DateAppearance.YearDateFont.Charset = DEFAULT_CHARSET
          Calendar.DateAppearance.YearDateFont.Color = clBlack
          Calendar.DateAppearance.YearDateFont.Height = -11
          Calendar.DateAppearance.YearDateFont.Name = 'Tahoma'
          Calendar.DateAppearance.YearDateFont.Style = []
          Calendar.DateAppearance.WeekNumbers.Font.Charset = DEFAULT_CHARSET
          Calendar.DateAppearance.WeekNumbers.Font.Color = clWindowText
          Calendar.DateAppearance.WeekNumbers.Font.Height = -11
          Calendar.DateAppearance.WeekNumbers.Font.Name = 'Tahoma'
          Calendar.DateAppearance.WeekNumbers.Font.Style = []
          Calendar.DateAppearance.WeekNumbers.Fill.Color = clWhite
          Calendar.DateAppearance.WeekNumbers.Fill.ColorTo = clNone
          Calendar.DateAppearance.WeekNumbers.Fill.ColorMirror = clNone
          Calendar.DateAppearance.WeekNumbers.Fill.ColorMirrorTo = clNone
          Calendar.DateAppearance.WeekNumbers.Fill.GradientType = gtVertical
          Calendar.DateAppearance.WeekNumbers.Fill.GradientMirrorType = gtSolid
          Calendar.DateAppearance.WeekNumbers.Fill.BorderColor = clWhite
          Calendar.DateAppearance.WeekNumbers.Fill.Rounding = 0
          Calendar.DateAppearance.WeekNumbers.Fill.ShadowOffset = 0
          Calendar.DateAppearance.WeekNumbers.Fill.Glow = gmNone
          Calendar.DateAppearance.DisabledDateFont.Charset = DEFAULT_CHARSET
          Calendar.DateAppearance.DisabledDateFont.Color = 13948116
          Calendar.DateAppearance.DisabledDateFont.Height = -11
          Calendar.DateAppearance.DisabledDateFont.Name = 'Tahoma'
          Calendar.DateAppearance.DisabledDateFont.Style = []
          Calendar.DateAppearance.DisabledDateFill.Color = clWhite
          Calendar.DateAppearance.DisabledDateFill.ColorTo = clNone
          Calendar.DateAppearance.DisabledDateFill.ColorMirror = clNone
          Calendar.DateAppearance.DisabledDateFill.ColorMirrorTo = clNone
          Calendar.DateAppearance.DisabledDateFill.GradientType = gtVertical
          Calendar.DateAppearance.DisabledDateFill.GradientMirrorType = gtVertical
          Calendar.DateAppearance.DisabledDateFill.BorderColor = clNone
          Calendar.DateAppearance.DisabledDateFill.Rounding = 0
          Calendar.DateAppearance.DisabledDateFill.ShadowOffset = 0
          Calendar.DateAppearance.DisabledDateFill.Glow = gmNone
          Calendar.DateAppearance.DateBeforeFill.Color = clNone
          Calendar.DateAppearance.DateBeforeFill.ColorMirror = clNone
          Calendar.DateAppearance.DateBeforeFill.ColorMirrorTo = clNone
          Calendar.DateAppearance.DateBeforeFill.GradientType = gtVertical
          Calendar.DateAppearance.DateBeforeFill.GradientMirrorType = gtSolid
          Calendar.DateAppearance.DateBeforeFill.BorderColor = clNone
          Calendar.DateAppearance.DateBeforeFill.Rounding = 0
          Calendar.DateAppearance.DateBeforeFill.ShadowOffset = 0
          Calendar.DateAppearance.DateBeforeFill.Glow = gmNone
          Calendar.DateAppearance.DateAfterFill.Color = clNone
          Calendar.DateAppearance.DateAfterFill.ColorMirror = clNone
          Calendar.DateAppearance.DateAfterFill.ColorMirrorTo = clNone
          Calendar.DateAppearance.DateAfterFill.GradientType = gtVertical
          Calendar.DateAppearance.DateAfterFill.GradientMirrorType = gtSolid
          Calendar.DateAppearance.DateAfterFill.BorderColor = clNone
          Calendar.DateAppearance.DateAfterFill.Rounding = 0
          Calendar.DateAppearance.DateAfterFill.ShadowOffset = 0
          Calendar.DateAppearance.DateAfterFill.Glow = gmNone
          Calendar.DateAppearance.DateBeforeFont.Charset = DEFAULT_CHARSET
          Calendar.DateAppearance.DateBeforeFont.Color = clSilver
          Calendar.DateAppearance.DateBeforeFont.Height = -11
          Calendar.DateAppearance.DateBeforeFont.Name = 'Tahoma'
          Calendar.DateAppearance.DateBeforeFont.Style = []
          Calendar.DateAppearance.DateAfterFont.Charset = DEFAULT_CHARSET
          Calendar.DateAppearance.DateAfterFont.Color = clSilver
          Calendar.DateAppearance.DateAfterFont.Height = -11
          Calendar.DateAppearance.DateAfterFont.Name = 'Tahoma'
          Calendar.DateAppearance.DateAfterFont.Style = []
          Calendar.StatusAppearance.Fill.Color = clRed
          Calendar.StatusAppearance.Fill.ColorMirror = clNone
          Calendar.StatusAppearance.Fill.ColorMirrorTo = clNone
          Calendar.StatusAppearance.Fill.GradientType = gtSolid
          Calendar.StatusAppearance.Fill.GradientMirrorType = gtSolid
          Calendar.StatusAppearance.Fill.BorderColor = clGray
          Calendar.StatusAppearance.Fill.Rounding = 0
          Calendar.StatusAppearance.Fill.RoundingType = rtNone
          Calendar.StatusAppearance.Fill.ShadowOffset = 0
          Calendar.StatusAppearance.Fill.Glow = gmNone
          Calendar.StatusAppearance.Font.Charset = DEFAULT_CHARSET
          Calendar.StatusAppearance.Font.Color = clWhite
          Calendar.StatusAppearance.Font.Height = -11
          Calendar.StatusAppearance.Font.Name = 'Tahoma'
          Calendar.StatusAppearance.Font.Style = []
          Calendar.StatusAppearance.Glow = False
          Calendar.Footer.Fill.Color = clWhite
          Calendar.Footer.Fill.ColorTo = clNone
          Calendar.Footer.Fill.ColorMirror = clNone
          Calendar.Footer.Fill.ColorMirrorTo = clNone
          Calendar.Footer.Fill.GradientType = gtVertical
          Calendar.Footer.Fill.GradientMirrorType = gtSolid
          Calendar.Footer.Fill.BorderColor = clNone
          Calendar.Footer.Fill.Rounding = 0
          Calendar.Footer.Fill.ShadowOffset = 0
          Calendar.Footer.Fill.Glow = gmNone
          Calendar.Footer.Font.Charset = DEFAULT_CHARSET
          Calendar.Footer.Font.Color = 4474440
          Calendar.Footer.Font.Height = -11
          Calendar.Footer.Font.Name = 'Tahoma'
          Calendar.Footer.Font.Style = []
          Calendar.Header.Fill.Color = clWhite
          Calendar.Header.Fill.ColorTo = clNone
          Calendar.Header.Fill.ColorMirror = clNone
          Calendar.Header.Fill.ColorMirrorTo = clNone
          Calendar.Header.Fill.GradientType = gtVertical
          Calendar.Header.Fill.GradientMirrorType = gtSolid
          Calendar.Header.Fill.BorderColor = clNone
          Calendar.Header.Fill.Rounding = 0
          Calendar.Header.Fill.ShadowOffset = 0
          Calendar.Header.Fill.Glow = gmNone
          Calendar.Header.ArrowColor = 4474440
          Calendar.Header.Font.Charset = DEFAULT_CHARSET
          Calendar.Header.Font.Color = 4474440
          Calendar.Header.Font.Height = -11
          Calendar.Header.Font.Name = 'Tahoma'
          Calendar.Header.Font.Style = []
          Calendar.Width = 257
          Calendar.Height = 249
          Calendar.ShowHint = False
          Date = 43618.000000000000000000
          TMSStyle = 8
        end
        object InvoiceDateToPicker: TAdvSmoothDatePicker
          Left = 66
          Top = 70
          Width = 108
          Height = 21
          AllowNumericNullValue = True
          Flat = False
          FlatLineColor = 11250603
          BorderColor = 11250603
          FocusFontColor = 3881787
          DisabledColor = 13948116
          LabelFont.Charset = DEFAULT_CHARSET
          LabelFont.Color = 4474440
          LabelFont.Height = -11
          LabelFont.Name = 'Tahoma'
          LabelFont.Style = []
          Lookup.Separator = ';'
          Color = clWhite
          Enabled = True
          ReadOnly = False
          TabOrder = 2
          Text = '2/06/2019'
          Visible = True
          Version = '2.6.1.5'
          ButtonStyle = bsDropDown
          ButtonWidth = 16
          Etched = False
          Glyph.Data = {
            DA020000424DDA0200000000000036000000280000000D0000000D0000000100
            200000000000A402000000000000000000000000000000000000F0F0F000F0F0
            F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
            F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
            F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
            F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
            F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
            F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
            F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
            F00000000000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
            F000F0F0F000F0F0F000F0F0F000F0F0F000000000000000000000000000F0F0
            F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
            F0000000000000000000000000000000000000000000F0F0F000F0F0F000F0F0
            F000F0F0F000F0F0F000F0F0F000F0F0F0000000000000000000000000000000
            0000000000000000000000000000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
            F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
            F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
            F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
            F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
            F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
            F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
            F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0
            F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000F0F0F000}
          ButtonColor = clWhite
          ButtonColorHot = 15917525
          ButtonColorDown = 14925219
          ButtonTextColor = 4474440
          ButtonTextColorHot = 2303013
          ButtonTextColorDown = 2303013
          ButtonBorderColor = 11250603
          HideCalendarAfterSelection = True
          Calendar.Fill.Color = clWhite
          Calendar.Fill.ColorTo = clNone
          Calendar.Fill.ColorMirror = clNone
          Calendar.Fill.ColorMirrorTo = clNone
          Calendar.Fill.GradientType = gtVertical
          Calendar.Fill.GradientMirrorType = gtSolid
          Calendar.Fill.BorderColor = clNone
          Calendar.Fill.Rounding = 0
          Calendar.Fill.ShadowOffset = 0
          Calendar.Fill.Glow = gmNone
          Calendar.Animation = True
          Calendar.ShowCurrentDate = True
          Calendar.DateAppearance.DateFont.Charset = DEFAULT_CHARSET
          Calendar.DateAppearance.DateFont.Color = clBlack
          Calendar.DateAppearance.DateFont.Height = -11
          Calendar.DateAppearance.DateFont.Name = 'Tahoma'
          Calendar.DateAppearance.DateFont.Style = []
          Calendar.DateAppearance.DateFill.Color = clWhite
          Calendar.DateAppearance.DateFill.ColorTo = clNone
          Calendar.DateAppearance.DateFill.ColorMirror = clNone
          Calendar.DateAppearance.DateFill.ColorMirrorTo = clNone
          Calendar.DateAppearance.DateFill.GradientType = gtVertical
          Calendar.DateAppearance.DateFill.GradientMirrorType = gtVertical
          Calendar.DateAppearance.DateFill.BorderColor = clNone
          Calendar.DateAppearance.DateFill.Rounding = 0
          Calendar.DateAppearance.DateFill.ShadowOffset = 0
          Calendar.DateAppearance.DateFill.Glow = gmNone
          Calendar.DateAppearance.DayOfWeekFont.Charset = DEFAULT_CHARSET
          Calendar.DateAppearance.DayOfWeekFont.Color = clBlack
          Calendar.DateAppearance.DayOfWeekFont.Height = -11
          Calendar.DateAppearance.DayOfWeekFont.Name = 'Tahoma'
          Calendar.DateAppearance.DayOfWeekFont.Style = []
          Calendar.DateAppearance.DayOfWeekFill.Color = clWhite
          Calendar.DateAppearance.DayOfWeekFill.ColorTo = clNone
          Calendar.DateAppearance.DayOfWeekFill.ColorMirror = clNone
          Calendar.DateAppearance.DayOfWeekFill.ColorMirrorTo = clNone
          Calendar.DateAppearance.DayOfWeekFill.GradientType = gtVertical
          Calendar.DateAppearance.DayOfWeekFill.GradientMirrorType = gtSolid
          Calendar.DateAppearance.DayOfWeekFill.BorderColor = clWhite
          Calendar.DateAppearance.DayOfWeekFill.Rounding = 0
          Calendar.DateAppearance.DayOfWeekFill.ShadowOffset = 0
          Calendar.DateAppearance.DayOfWeekFill.Glow = gmNone
          Calendar.DateAppearance.SelectedDateFont.Charset = DEFAULT_CHARSET
          Calendar.DateAppearance.SelectedDateFont.Color = clBlack
          Calendar.DateAppearance.SelectedDateFont.Height = -11
          Calendar.DateAppearance.SelectedDateFont.Name = 'Tahoma'
          Calendar.DateAppearance.SelectedDateFont.Style = []
          Calendar.DateAppearance.SelectedDateFill.Color = 14925219
          Calendar.DateAppearance.SelectedDateFill.ColorTo = clNone
          Calendar.DateAppearance.SelectedDateFill.ColorMirror = clNone
          Calendar.DateAppearance.SelectedDateFill.ColorMirrorTo = clNone
          Calendar.DateAppearance.SelectedDateFill.GradientType = gtVertical
          Calendar.DateAppearance.SelectedDateFill.GradientMirrorType = gtVertical
          Calendar.DateAppearance.SelectedDateFill.BorderColor = 14925219
          Calendar.DateAppearance.SelectedDateFill.Rounding = 0
          Calendar.DateAppearance.SelectedDateFill.ShadowOffset = 0
          Calendar.DateAppearance.SelectedDateFill.Glow = gmNone
          Calendar.DateAppearance.CurrentDateFont.Charset = DEFAULT_CHARSET
          Calendar.DateAppearance.CurrentDateFont.Color = 3881787
          Calendar.DateAppearance.CurrentDateFont.Height = -11
          Calendar.DateAppearance.CurrentDateFont.Name = 'Tahoma'
          Calendar.DateAppearance.CurrentDateFont.Style = []
          Calendar.DateAppearance.CurrentDateFill.Color = clWhite
          Calendar.DateAppearance.CurrentDateFill.ColorTo = clNone
          Calendar.DateAppearance.CurrentDateFill.ColorMirror = clNone
          Calendar.DateAppearance.CurrentDateFill.ColorMirrorTo = clNone
          Calendar.DateAppearance.CurrentDateFill.GradientType = gtVertical
          Calendar.DateAppearance.CurrentDateFill.GradientMirrorType = gtVertical
          Calendar.DateAppearance.CurrentDateFill.BorderColor = 14925219
          Calendar.DateAppearance.CurrentDateFill.Rounding = 0
          Calendar.DateAppearance.CurrentDateFill.ShadowOffset = 0
          Calendar.DateAppearance.CurrentDateFill.Glow = gmNone
          Calendar.DateAppearance.WeekendFill.Color = clWhite
          Calendar.DateAppearance.WeekendFill.ColorTo = clNone
          Calendar.DateAppearance.WeekendFill.ColorMirror = clNone
          Calendar.DateAppearance.WeekendFill.ColorMirrorTo = clNone
          Calendar.DateAppearance.WeekendFill.GradientType = gtVertical
          Calendar.DateAppearance.WeekendFill.GradientMirrorType = gtVertical
          Calendar.DateAppearance.WeekendFill.BorderColor = clNone
          Calendar.DateAppearance.WeekendFill.Rounding = 0
          Calendar.DateAppearance.WeekendFill.ShadowOffset = 0
          Calendar.DateAppearance.WeekendFill.Glow = gmNone
          Calendar.DateAppearance.WeekendFont.Charset = DEFAULT_CHARSET
          Calendar.DateAppearance.WeekendFont.Color = clBlack
          Calendar.DateAppearance.WeekendFont.Height = -11
          Calendar.DateAppearance.WeekendFont.Name = 'Tahoma'
          Calendar.DateAppearance.WeekendFont.Style = []
          Calendar.DateAppearance.HoverDateFont.Charset = DEFAULT_CHARSET
          Calendar.DateAppearance.HoverDateFont.Color = 3881787
          Calendar.DateAppearance.HoverDateFont.Height = -11
          Calendar.DateAppearance.HoverDateFont.Name = 'Tahoma'
          Calendar.DateAppearance.HoverDateFont.Style = []
          Calendar.DateAppearance.HoverDateFill.Color = 15917525
          Calendar.DateAppearance.HoverDateFill.ColorTo = clNone
          Calendar.DateAppearance.HoverDateFill.ColorMirror = clNone
          Calendar.DateAppearance.HoverDateFill.ColorMirrorTo = clNone
          Calendar.DateAppearance.HoverDateFill.GradientType = gtVertical
          Calendar.DateAppearance.HoverDateFill.GradientMirrorType = gtVertical
          Calendar.DateAppearance.HoverDateFill.BorderColor = 15917525
          Calendar.DateAppearance.HoverDateFill.Rounding = 0
          Calendar.DateAppearance.HoverDateFill.ShadowOffset = 0
          Calendar.DateAppearance.HoverDateFill.Glow = gmNone
          Calendar.DateAppearance.MonthDateFont.Charset = DEFAULT_CHARSET
          Calendar.DateAppearance.MonthDateFont.Color = clBlack
          Calendar.DateAppearance.MonthDateFont.Height = -11
          Calendar.DateAppearance.MonthDateFont.Name = 'Tahoma'
          Calendar.DateAppearance.MonthDateFont.Style = []
          Calendar.DateAppearance.YearDateFont.Charset = DEFAULT_CHARSET
          Calendar.DateAppearance.YearDateFont.Color = clBlack
          Calendar.DateAppearance.YearDateFont.Height = -11
          Calendar.DateAppearance.YearDateFont.Name = 'Tahoma'
          Calendar.DateAppearance.YearDateFont.Style = []
          Calendar.DateAppearance.WeekNumbers.Font.Charset = DEFAULT_CHARSET
          Calendar.DateAppearance.WeekNumbers.Font.Color = clWindowText
          Calendar.DateAppearance.WeekNumbers.Font.Height = -11
          Calendar.DateAppearance.WeekNumbers.Font.Name = 'Tahoma'
          Calendar.DateAppearance.WeekNumbers.Font.Style = []
          Calendar.DateAppearance.WeekNumbers.Fill.Color = clWhite
          Calendar.DateAppearance.WeekNumbers.Fill.ColorTo = clNone
          Calendar.DateAppearance.WeekNumbers.Fill.ColorMirror = clNone
          Calendar.DateAppearance.WeekNumbers.Fill.ColorMirrorTo = clNone
          Calendar.DateAppearance.WeekNumbers.Fill.GradientType = gtVertical
          Calendar.DateAppearance.WeekNumbers.Fill.GradientMirrorType = gtSolid
          Calendar.DateAppearance.WeekNumbers.Fill.BorderColor = clWhite
          Calendar.DateAppearance.WeekNumbers.Fill.Rounding = 0
          Calendar.DateAppearance.WeekNumbers.Fill.ShadowOffset = 0
          Calendar.DateAppearance.WeekNumbers.Fill.Glow = gmNone
          Calendar.DateAppearance.DisabledDateFont.Charset = DEFAULT_CHARSET
          Calendar.DateAppearance.DisabledDateFont.Color = 13948116
          Calendar.DateAppearance.DisabledDateFont.Height = -11
          Calendar.DateAppearance.DisabledDateFont.Name = 'Tahoma'
          Calendar.DateAppearance.DisabledDateFont.Style = []
          Calendar.DateAppearance.DisabledDateFill.Color = clWhite
          Calendar.DateAppearance.DisabledDateFill.ColorTo = clNone
          Calendar.DateAppearance.DisabledDateFill.ColorMirror = clNone
          Calendar.DateAppearance.DisabledDateFill.ColorMirrorTo = clNone
          Calendar.DateAppearance.DisabledDateFill.GradientType = gtVertical
          Calendar.DateAppearance.DisabledDateFill.GradientMirrorType = gtVertical
          Calendar.DateAppearance.DisabledDateFill.BorderColor = clNone
          Calendar.DateAppearance.DisabledDateFill.Rounding = 0
          Calendar.DateAppearance.DisabledDateFill.ShadowOffset = 0
          Calendar.DateAppearance.DisabledDateFill.Glow = gmNone
          Calendar.DateAppearance.DateBeforeFill.Color = clNone
          Calendar.DateAppearance.DateBeforeFill.ColorMirror = clNone
          Calendar.DateAppearance.DateBeforeFill.ColorMirrorTo = clNone
          Calendar.DateAppearance.DateBeforeFill.GradientType = gtVertical
          Calendar.DateAppearance.DateBeforeFill.GradientMirrorType = gtSolid
          Calendar.DateAppearance.DateBeforeFill.BorderColor = clNone
          Calendar.DateAppearance.DateBeforeFill.Rounding = 0
          Calendar.DateAppearance.DateBeforeFill.ShadowOffset = 0
          Calendar.DateAppearance.DateBeforeFill.Glow = gmNone
          Calendar.DateAppearance.DateAfterFill.Color = clNone
          Calendar.DateAppearance.DateAfterFill.ColorMirror = clNone
          Calendar.DateAppearance.DateAfterFill.ColorMirrorTo = clNone
          Calendar.DateAppearance.DateAfterFill.GradientType = gtVertical
          Calendar.DateAppearance.DateAfterFill.GradientMirrorType = gtSolid
          Calendar.DateAppearance.DateAfterFill.BorderColor = clNone
          Calendar.DateAppearance.DateAfterFill.Rounding = 0
          Calendar.DateAppearance.DateAfterFill.ShadowOffset = 0
          Calendar.DateAppearance.DateAfterFill.Glow = gmNone
          Calendar.DateAppearance.DateBeforeFont.Charset = DEFAULT_CHARSET
          Calendar.DateAppearance.DateBeforeFont.Color = clSilver
          Calendar.DateAppearance.DateBeforeFont.Height = -11
          Calendar.DateAppearance.DateBeforeFont.Name = 'Tahoma'
          Calendar.DateAppearance.DateBeforeFont.Style = []
          Calendar.DateAppearance.DateAfterFont.Charset = DEFAULT_CHARSET
          Calendar.DateAppearance.DateAfterFont.Color = clSilver
          Calendar.DateAppearance.DateAfterFont.Height = -11
          Calendar.DateAppearance.DateAfterFont.Name = 'Tahoma'
          Calendar.DateAppearance.DateAfterFont.Style = []
          Calendar.StatusAppearance.Fill.Color = clRed
          Calendar.StatusAppearance.Fill.ColorMirror = clNone
          Calendar.StatusAppearance.Fill.ColorMirrorTo = clNone
          Calendar.StatusAppearance.Fill.GradientType = gtSolid
          Calendar.StatusAppearance.Fill.GradientMirrorType = gtSolid
          Calendar.StatusAppearance.Fill.BorderColor = clGray
          Calendar.StatusAppearance.Fill.Rounding = 0
          Calendar.StatusAppearance.Fill.RoundingType = rtNone
          Calendar.StatusAppearance.Fill.ShadowOffset = 0
          Calendar.StatusAppearance.Fill.Glow = gmNone
          Calendar.StatusAppearance.Font.Charset = DEFAULT_CHARSET
          Calendar.StatusAppearance.Font.Color = clWhite
          Calendar.StatusAppearance.Font.Height = -11
          Calendar.StatusAppearance.Font.Name = 'Tahoma'
          Calendar.StatusAppearance.Font.Style = []
          Calendar.StatusAppearance.Glow = False
          Calendar.Footer.Fill.Color = clWhite
          Calendar.Footer.Fill.ColorTo = clNone
          Calendar.Footer.Fill.ColorMirror = clNone
          Calendar.Footer.Fill.ColorMirrorTo = clNone
          Calendar.Footer.Fill.GradientType = gtVertical
          Calendar.Footer.Fill.GradientMirrorType = gtSolid
          Calendar.Footer.Fill.BorderColor = clNone
          Calendar.Footer.Fill.Rounding = 0
          Calendar.Footer.Fill.ShadowOffset = 0
          Calendar.Footer.Fill.Glow = gmNone
          Calendar.Footer.Font.Charset = DEFAULT_CHARSET
          Calendar.Footer.Font.Color = 4474440
          Calendar.Footer.Font.Height = -11
          Calendar.Footer.Font.Name = 'Tahoma'
          Calendar.Footer.Font.Style = []
          Calendar.Header.Fill.Color = clWhite
          Calendar.Header.Fill.ColorTo = clNone
          Calendar.Header.Fill.ColorMirror = clNone
          Calendar.Header.Fill.ColorMirrorTo = clNone
          Calendar.Header.Fill.GradientType = gtVertical
          Calendar.Header.Fill.GradientMirrorType = gtSolid
          Calendar.Header.Fill.BorderColor = clNone
          Calendar.Header.Fill.Rounding = 0
          Calendar.Header.Fill.ShadowOffset = 0
          Calendar.Header.Fill.Glow = gmNone
          Calendar.Header.ArrowColor = 4474440
          Calendar.Header.Font.Charset = DEFAULT_CHARSET
          Calendar.Header.Font.Color = 4474440
          Calendar.Header.Font.Height = -11
          Calendar.Header.Font.Name = 'Tahoma'
          Calendar.Header.Font.Style = []
          Calendar.Width = 257
          Calendar.Height = 249
          Calendar.ShowHint = False
          Date = 43618.000000000000000000
          TMSStyle = 8
        end
        object edtInvoiceNo: TEdit
          Left = 66
          Top = 97
          Width = 108
          Height = 21
          TabOrder = 3
        end
        object meTotalAmount: TMoneyEdit
          Left = 265
          Top = 43
          Width = 121
          Height = 21
          CalculatorLook.ButtonWidth = 24
          CalculatorLook.ButtonHeight = 24
          CalculatorLook.ButtonColor = clSilver
          CalculatorLook.Color = clWhite
          CalculatorLook.Flat = False
          CalculatorLook.Font.Charset = DEFAULT_CHARSET
          CalculatorLook.Font.Color = clWindowText
          CalculatorLook.Font.Height = -11
          CalculatorLook.Font.Name = 'Tahoma'
          CalculatorLook.Font.Style = []
          TabOrder = 4
          Version = '1.1.2.0'
        end
        object StringGrid1: TAdvStringGrid
          Left = 0
          Top = 136
          Width = 509
          Height = 311
          Cursor = crDefault
          Align = alBottom
          Anchors = [akLeft, akTop, akRight, akBottom]
          Color = clWhite
          ColCount = 6
          Ctl3D = True
          DoubleBuffered = True
          DrawingStyle = gdsClassic
          FixedColor = clWhite
          FixedCols = 0
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Options = [goVertLine, goHorzLine, goRangeSelect, goColSizing, goColMoving, goEditing, goFixedColClick]
          ParentCtl3D = False
          ParentDoubleBuffered = False
          ParentFont = False
          ScrollBars = ssBoth
          TabOrder = 5
          GridLineColor = 15987699
          GridFixedLineColor = 15987699
          HoverRowCells = [hcNormal, hcSelected]
          ActiveCellFont.Charset = DEFAULT_CHARSET
          ActiveCellFont.Color = 4474440
          ActiveCellFont.Height = -11
          ActiveCellFont.Name = 'Tahoma'
          ActiveCellFont.Style = [fsBold]
          ActiveCellColor = 11565130
          ActiveCellColorTo = 11565130
          BorderColor = 11250603
          ControlLook.FixedGradientFrom = clWhite
          ControlLook.FixedGradientTo = clWhite
          ControlLook.FixedGradientMirrorFrom = clWhite
          ControlLook.FixedGradientMirrorTo = clWhite
          ControlLook.FixedGradientHoverFrom = clGray
          ControlLook.FixedGradientHoverTo = clWhite
          ControlLook.FixedGradientHoverMirrorFrom = clWhite
          ControlLook.FixedGradientHoverMirrorTo = clWhite
          ControlLook.FixedGradientHoverBorder = 11645361
          ControlLook.FixedGradientDownFrom = clWhite
          ControlLook.FixedGradientDownTo = clWhite
          ControlLook.FixedGradientDownMirrorFrom = clWhite
          ControlLook.FixedGradientDownMirrorTo = clWhite
          ControlLook.FixedGradientDownBorder = 11250603
          ControlLook.DropDownHeader.Font.Charset = DEFAULT_CHARSET
          ControlLook.DropDownHeader.Font.Color = clWindowText
          ControlLook.DropDownHeader.Font.Height = -11
          ControlLook.DropDownHeader.Font.Name = 'Tahoma'
          ControlLook.DropDownHeader.Font.Style = []
          ControlLook.DropDownHeader.Visible = True
          ControlLook.DropDownHeader.Buttons = <>
          ControlLook.DropDownFooter.Font.Charset = DEFAULT_CHARSET
          ControlLook.DropDownFooter.Font.Color = clWindowText
          ControlLook.DropDownFooter.Font.Height = -11
          ControlLook.DropDownFooter.Font.Name = 'Tahoma'
          ControlLook.DropDownFooter.Font.Style = []
          ControlLook.DropDownFooter.Visible = True
          ControlLook.DropDownFooter.Buttons = <>
          Filter = <>
          FilterDropDown.Font.Charset = DEFAULT_CHARSET
          FilterDropDown.Font.Color = clWindowText
          FilterDropDown.Font.Height = -11
          FilterDropDown.Font.Name = 'Tahoma'
          FilterDropDown.Font.Style = []
          FilterDropDown.TextChecked = 'Checked'
          FilterDropDown.TextUnChecked = 'Unchecked'
          FilterDropDownClear = '(All)'
          FilterEdit.TypeNames.Strings = (
            'Starts with'
            'Ends with'
            'Contains'
            'Not contains'
            'Equal'
            'Not equal'
            'Larger than'
            'Smaller than'
            'Clear')
          FixedRowHeight = 22
          FixedFont.Charset = DEFAULT_CHARSET
          FixedFont.Color = clBlack
          FixedFont.Height = -11
          FixedFont.Name = 'Tahoma'
          FixedFont.Style = [fsBold]
          FloatFormat = '%.2f'
          HoverButtons.Buttons = <>
          HoverButtons.Position = hbLeftFromColumnLeft
          HTMLSettings.ImageFolder = 'images'
          HTMLSettings.ImageBaseName = 'img'
          Look = glCustom
          Navigation.AlwaysEdit = True
          PrintSettings.DateFormat = 'dd/mm/yyyy'
          PrintSettings.Font.Charset = DEFAULT_CHARSET
          PrintSettings.Font.Color = clWindowText
          PrintSettings.Font.Height = -11
          PrintSettings.Font.Name = 'Tahoma'
          PrintSettings.Font.Style = []
          PrintSettings.FixedFont.Charset = DEFAULT_CHARSET
          PrintSettings.FixedFont.Color = clWindowText
          PrintSettings.FixedFont.Height = -11
          PrintSettings.FixedFont.Name = 'Tahoma'
          PrintSettings.FixedFont.Style = []
          PrintSettings.HeaderFont.Charset = DEFAULT_CHARSET
          PrintSettings.HeaderFont.Color = clWindowText
          PrintSettings.HeaderFont.Height = -11
          PrintSettings.HeaderFont.Name = 'Tahoma'
          PrintSettings.HeaderFont.Style = []
          PrintSettings.FooterFont.Charset = DEFAULT_CHARSET
          PrintSettings.FooterFont.Color = clWindowText
          PrintSettings.FooterFont.Height = -11
          PrintSettings.FooterFont.Name = 'Tahoma'
          PrintSettings.FooterFont.Style = []
          PrintSettings.PageNumSep = '/'
          SearchFooter.ColorTo = clWhite
          SearchFooter.FindNextCaption = 'Find &next'
          SearchFooter.FindPrevCaption = 'Find &previous'
          SearchFooter.Font.Charset = DEFAULT_CHARSET
          SearchFooter.Font.Color = clWindowText
          SearchFooter.Font.Height = -11
          SearchFooter.Font.Name = 'Tahoma'
          SearchFooter.Font.Style = []
          SearchFooter.HighLightCaption = 'Highlight'
          SearchFooter.HintClose = 'Close'
          SearchFooter.HintFindNext = 'Find next occurrence'
          SearchFooter.HintFindPrev = 'Find previous occurrence'
          SearchFooter.HintHighlight = 'Highlight occurrences'
          SearchFooter.MatchCaseCaption = 'Match case'
          SearchFooter.ResultFormat = '(%d of %d)'
          SelectionColor = 13744549
          SelectionResizer = True
          SortSettings.DefaultFormat = ssAutomatic
          SortSettings.HeaderColor = clWhite
          SortSettings.HeaderColorTo = clWhite
          SortSettings.HeaderMirrorColor = clWhite
          SortSettings.HeaderMirrorColorTo = clWhite
          Version = '8.6.0.0'
          ColWidths = (
            64
            64
            64
            64
            64
            64)
          RowHeights = (
            22
            22
            22
            22
            22
            22
            22
            22
            22
            22)
        end
        object edtClientRef: TEdit
          Left = 265
          Top = 70
          Width = 121
          Height = 21
          TabOrder = 6
        end
        object edtProject: TEdit
          Left = 265
          Top = 97
          Width = 121
          Height = 21
          TabOrder = 7
        end
        object meTotalHours: TMoneyEdit
          Left = 265
          Top = 16
          Width = 121
          Height = 21
          CalculatorLook.ButtonWidth = 24
          CalculatorLook.ButtonHeight = 24
          CalculatorLook.ButtonColor = clSilver
          CalculatorLook.Color = clWhite
          CalculatorLook.Flat = False
          CalculatorLook.Font.Charset = DEFAULT_CHARSET
          CalculatorLook.Font.Color = clWindowText
          CalculatorLook.Font.Height = -11
          CalculatorLook.Font.Name = 'Tahoma'
          CalculatorLook.Font.Style = []
          TabOrder = 8
          Version = '1.1.2.0'
        end
      end
    end
  end
  object btnAttachFile: TButton
    Left = 487
    Top = 9
    Width = 66
    Height = 25
    Caption = 'Attach File'
    TabOrder = 6
    OnClick = btnAttachFileClick
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 516
    Width = 1037
    Height = 19
    Anchors = []
    Panels = <
      item
        Width = 500
      end
      item
        Width = 50
      end>
  end
  object btnUploadInvoice: TButton
    Left = 712
    Top = 8
    Width = 89
    Height = 25
    Caption = 'Upload Invoice'
    TabOrder = 7
    OnClick = btnUploadInvoiceClick
  end
  object btnAddInvoiceLine: TButton
    Left = 807
    Top = 8
    Width = 105
    Height = 25
    Caption = 'Add Invoice Line'
    TabOrder = 8
    OnClick = btnAddInvoiceLineClick
  end
end
