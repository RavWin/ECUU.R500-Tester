object fECUU: TfECUU
  Left = 0
  Top = 0
  AlphaBlend = True
  Caption = 'fECUU'
  ClientHeight = 482
  ClientWidth = 930
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  ShowHint = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 353
    Height = 482
    Align = alLeft
    TabOrder = 0
    DesignSize = (
      353
      482)
    object ComLed1: TComLed
      Left = 183
      Top = 8
      Width = 25
      Height = 25
      ComPort = ComPort
      LedSignal = lsConn
      Kind = lkRedLight
      OnClick = ComLed1Click
      OnDblClick = ComLed1DblClick
    end
    object lSend: TLabel
      Left = 8
      Top = 337
      Width = 44
      Height = 13
      Anchors = [akLeft, akBottom]
      Caption = 'Send Log'
      ExplicitTop = 417
    end
    object cbPort: TComComboBox
      Left = 8
      Top = 8
      Width = 97
      Height = 21
      ComPort = ComPort
      ComProperty = cpPort
      Text = 'COM1'
      Style = csDropDownList
      ItemIndex = 1
      TabOrder = 0
      OnChange = cbPortChange
      OnDropDown = cbPortDropDown
    end
    object cbBaud: TComComboBox
      Left = 111
      Top = 8
      Width = 66
      Height = 21
      ComPort = ComPort
      ComProperty = cpBaudRate
      Text = '115200'
      Style = csDropDownList
      ItemIndex = 13
      TabOrder = 1
    end
    object GroupBox1: TGroupBox
      Left = 8
      Top = 39
      Width = 145
      Height = 290
      Caption = 'TM Emulation'
      TabOrder = 2
      object eV1: TEdit
        Left = 12
        Top = 101
        Width = 121
        Height = 21
        Hint = 'RPM'
        TabOrder = 0
        Text = '0,5'
      end
      object eV2: TEdit
        Left = 12
        Top = 126
        Width = 121
        Height = 21
        Hint = 'Temp'
        TabOrder = 1
        Text = '1,0'
      end
      object eV3: TEdit
        Left = 12
        Top = 151
        Width = 121
        Height = 21
        Hint = 'fuel feedback'
        TabOrder = 2
        Text = '2,0'
      end
      object eV4: TEdit
        Left = 12
        Top = 177
        Width = 121
        Height = 21
        Hint = 'feedback_oil'
        TabOrder = 3
        Text = '3,0'
      end
      object eV5: TEdit
        Left = 12
        Top = 203
        Width = 121
        Height = 21
        Hint = 'R500 Stte'
        TabOrder = 4
        Text = '4,0'
      end
      object leAddr: TLabeledEdit
        Left = 12
        Top = 31
        Width = 121
        Height = 21
        EditLabel.Width = 23
        EditLabel.Height = 13
        EditLabel.Caption = 'Addr'
        TabOrder = 5
        Text = '$A1'
      end
      object leError: TLabeledEdit
        Left = 12
        Top = 74
        Width = 121
        Height = 21
        EditLabel.Width = 24
        EditLabel.Height = 13
        EditLabel.Caption = 'Error'
        TabOrder = 6
        Text = '00'
      end
      object bTM: TButton
        Left = 38
        Top = 230
        Width = 75
        Height = 26
        Caption = 'Send TM'
        TabOrder = 7
        OnClick = bTMClick
      end
      object cbAutoSend: TCheckBox
        Left = 12
        Top = 262
        Width = 97
        Height = 17
        Caption = 'Auto Send'
        TabOrder = 8
        OnClick = cbAutoSendClick
      end
    end
    object gbEngineCommands: TGroupBox
      Left = 159
      Top = 39
      Width = 97
      Height = 256
      Caption = 'Engine commands'
      TabOrder = 3
      object bEngStart: TButton
        Left = 11
        Top = 16
        Width = 75
        Height = 25
        Caption = 'Start'
        TabOrder = 0
        OnClick = bEngStartClick
      end
      object bEngStop: TButton
        Left = 11
        Top = 47
        Width = 75
        Height = 25
        Caption = 'Stop'
        TabOrder = 1
        OnClick = bEngStopClick
      end
      object bEngPump: TButton
        Left = 11
        Top = 77
        Width = 75
        Height = 25
        Caption = 'Pump'
        TabOrder = 2
        OnClick = bEngPumpClick
      end
      object bEngVent: TButton
        Left = 11
        Top = 108
        Width = 75
        Height = 25
        Caption = 'Vent'
        TabOrder = 3
        OnClick = bEngVentClick
      end
      object bEngReset: TButton
        Left = 11
        Top = 139
        Width = 75
        Height = 25
        Caption = 'Reset'
        TabOrder = 4
        OnClick = bEngResetClick
      end
      object bGetTM: TButton
        Left = 11
        Top = 170
        Width = 75
        Height = 25
        Caption = 'GetTM'
        TabOrder = 5
        OnClick = bGetTMClick
      end
      object cbReqTM: TCheckBox
        Left = 11
        Top = 211
        Width = 97
        Height = 17
        Caption = 'Req TM'
        TabOrder = 6
        OnClick = cbReqTMClick
      end
    end
    object log: TMemo
      Left = 1
      Top = 356
      Width = 351
      Height = 125
      Align = alBottom
      TabOrder = 4
    end
    object sbThrottle: TScrollBar
      Left = 272
      Top = 55
      Width = 17
      Height = 178
      Kind = sbVertical
      PageSize = 0
      TabOrder = 5
      OnChange = sbThrottleChange
    end
    object bThrottle: TButton
      Left = 295
      Top = 93
      Width = 50
      Height = 93
      Caption = 'Thr'
      Default = True
      TabOrder = 6
      OnClick = bThrottleClick
    end
    object cbThrottle: TCheckBox
      Left = 273
      Top = 250
      Width = 97
      Height = 17
      Caption = 'Throttle'
      TabOrder = 7
      OnClick = cbThrottleClick
    end
  end
  object Panel2: TPanel
    Left = 353
    Top = 0
    Width = 577
    Height = 482
    Align = alClient
    Caption = 'Panel2'
    TabOrder = 1
    object Splitter1: TSplitter
      Left = 1
      Top = 225
      Width = 575
      Height = 3
      Cursor = crVSplit
      Align = alBottom
      ExplicitTop = 1
      ExplicitWidth = 208
    end
    object ComTerminal1: TComTerminal
      Left = 1
      Top = 228
      Width = 575
      Height = 253
      Align = alBottom
      Color = clBlack
      Columns = 120
      ComPort = ComPort
      Emulation = teVT100orANSI
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = 'Fixedsys'
      Font.Style = []
      ScrollBars = ssHorizontal
      TabOrder = 0
      OnDblClick = ComTerminal1DblClick
    end
    object mReceive: TMemo
      Left = 1
      Top = 21
      Width = 575
      Height = 204
      Align = alClient
      ScrollBars = ssVertical
      TabOrder = 1
      OnDblClick = mReceiveDblClick
    end
    object Panel3: TPanel
      Left = 1
      Top = 1
      Width = 575
      Height = 20
      Align = alTop
      Caption = 'Receive Log'
      TabOrder = 2
    end
  end
  object ComPort: TComPort
    BaudRate = br115200
    Port = 'COM1'
    Parity.Bits = prNone
    StopBits = sbOneStopBit
    DataBits = dbEight
    Events = [evRxChar, evTxEmpty, evRxFlag, evRing, evBreak, evCTS, evDSR, evError, evRLSD, evRx80Full]
    FlowControl.OutCTSFlow = False
    FlowControl.OutDSRFlow = False
    FlowControl.ControlDTR = dtrDisable
    FlowControl.ControlRTS = rtsDisable
    FlowControl.XonXoffOut = False
    FlowControl.XonXoffIn = False
    StoredProps = [spBasic]
    TriggersOnRxChar = False
    OnRxBuf = ComPortRxBuf
    Left = 24
    Top = 40
  end
  object tSender: TTimer
    Enabled = False
    Interval = 20
    OnTimer = tSenderTimer
    Left = 216
    Top = 48
  end
  object tTM: TTimer
    Enabled = False
    Interval = 500
    OnTimer = tTMTimer
    Left = 256
    Top = 47
  end
  object tThrottle: TTimer
    Enabled = False
    Interval = 50
    OnTimer = tThrottleTimer
    Left = 293
    Top = 48
  end
end
