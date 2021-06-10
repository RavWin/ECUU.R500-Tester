unit fuMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  uFVIN, RVer,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, CPortCtl, CPort,
  Vcl.ExtCtrls;

type
  TfECUU = class(TForm)
    Panel1: TPanel;
    ComLed1: TComLed;
    cbPort: TComComboBox;
    cbBaud: TComComboBox;
    ComPort: TComPort;
    GroupBox1: TGroupBox;
    eV1: TEdit;
    eV2: TEdit;
    eV3: TEdit;
    eV4: TEdit;
    eV5: TEdit;
    leAddr: TLabeledEdit;
    leError: TLabeledEdit;
    bTM: TButton;
    gbEngineCommands: TGroupBox;
    bEngStart: TButton;
    bEngStop: TButton;
    bEngPump: TButton;
    bEngVent: TButton;
    bEngReset: TButton;
    bGetTM: TButton;
    log: TMemo;
    tSender: TTimer;
    cbAutoSend: TCheckBox;
    Panel2: TPanel;
    ComTerminal1: TComTerminal;
    Splitter1: TSplitter;
    mReceive: TMemo;
    lSend: TLabel;
    sbThrottle: TScrollBar;
    bThrottle: TButton;
    Panel3: TPanel;
    cbReqTM: TCheckBox;
    tTM: TTimer;
    tThrottle: TTimer;
    cbThrottle: TCheckBox;
    procedure cbPortChange(Sender: TObject);
    procedure ComLed1DblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure bTMClick(Sender: TObject);
    procedure ComTerminal1DblClick(Sender: TObject);
    procedure bVentClick(Sender: TObject);
    procedure cbPortDropDown(Sender: TObject);
    procedure bEngStartClick(Sender: TObject);
    procedure bEngStopClick(Sender: TObject);
    procedure bEngPumpClick(Sender: TObject);
    procedure bEngVentClick(Sender: TObject);
    procedure bEngResetClick(Sender: TObject);
    procedure bGetTMClick(Sender: TObject);
    procedure ComLed1Click(Sender: TObject);
    procedure cbAutoSendClick(Sender: TObject);
    procedure tSenderTimer(Sender: TObject);
    procedure ComPortRxBuf(Sender: TObject; const Buffer; Count: Integer);
    procedure sbThrottleChange(Sender: TObject);
    procedure bThrottleClick(Sender: TObject);
    procedure mReceiveDblClick(Sender: TObject);
    procedure cbReqTMClick(Sender: TObject);
    procedure tTMTimer(Sender: TObject);
    procedure tThrottleTimer(Sender: TObject);
    procedure cbThrottleClick(Sender: TObject);
  private
    { Private declarations }
    fvin: TfvinPacket;
  public
    inByte : UInt8;
    prevByte : UInt8;
    inBuf : string;
    { Public declarations }
    procedure showCommand(buf: PByte; len:UInt32);
    procedure logByte(b: UInt8);
  end;

var
  fECUU: TfECUU;

implementation

{$R *.dfm}

procedure TfECUU.bThrottleClick(Sender: TObject);
var
  cmd: array [0..8] of UInt8;
  Throttle : UInt16;
begin
  Throttle := sbThrottle.Position * 10;
  cmd[0]:=$FE;
  cmd[1]:=$FE;
  cmd[2]:=StrToInt(leAddr.Text);
  cmd[3]:=$84;
  cmd[4]:=Lo(Throttle);
  cmd[5]:=Hi(Throttle);
  cmd[6]:=cmd[2] xor cmd[3] xor cmd[4] xor cmd[5];
  cmd[7]:=$FF;
  cmd[8]:=$FF;
  if not ComPort.Connected then exit;
  ComPort.Write(cmd, SizeOf(cmd));
  showCommand(@cmd, SizeOf(cmd));
end;

procedure TfECUU.bTMClick(Sender: TObject);
var
  data: array [0..5] of UInt16;
  pkt : TfvinTM;
begin
//  SetLength(data, 5);
  if not ComPort.Connected then exit;
  data[0] := StrToIntDef(eV1.Text, 1);
  data[1] := StrToIntDef(eV2.Text, 1);
  data[2] := StrToIntDef(eV3.Text, 1);
  data[3] := StrToIntDef(eV4.Text, 1);
  data[4] := StrToIntDef(eV5.Text, 1);
  pkt.prepare(StrToInt(leAddr.Text), StrToInt(leError.Text), data);
  ComPort.Write(pkt, SizeOf(pkt));
end;

procedure TfECUU.bEngStartClick(Sender: TObject);
begin
  if not ComPort.Connected then exit;
  fvin.prepare(StrToInt(leAddr.Text), $21);
  ComPort.Write(fvin, SizeOf(fvin));
  showCommand(@fvin, SizeOf(fvin));
end;

procedure TfECUU.bEngStopClick(Sender: TObject);
begin
  if not ComPort.Connected then exit;
  fvin.prepare(StrToInt(leAddr.Text), $22);
  ComPort.Write(fvin, SizeOf(fvin));
  showCommand(@fvin, SizeOf(fvin));
end;

procedure TfECUU.bEngPumpClick(Sender: TObject);
begin
  if not ComPort.Connected then exit;
  fvin.prepare(StrToInt(leAddr.Text), $20);
  ComPort.Write(fvin, SizeOf(fvin));
  showCommand(@fvin, SizeOf(fvin));
end;

procedure TfECUU.bEngVentClick(Sender: TObject);
begin
  if not ComPort.Connected then exit;
  fvin.prepare(StrToInt(leAddr.Text), $23);
  ComPort.Write(fvin, SizeOf(fvin));
  showCommand(@fvin, SizeOf(fvin));
end;

procedure TfECUU.bGetTMClick(Sender: TObject);
begin
  if not ComPort.Connected then exit;
  fvin.prepare(StrToInt(leAddr.Text), $95);
  ComPort.Write(fvin, SizeOf(fvin));
  showCommand(@fvin, SizeOf(fvin));
end;

procedure TfECUU.bEngResetClick(Sender: TObject);
begin
  if not ComPort.Connected then exit;
  fvin.prepare(StrToInt(leAddr.Text), $24);
  ComPort.Write(fvin, SizeOf(fvin));
  showCommand(@fvin, SizeOf(fvin));
end;

procedure TfECUU.bVentClick(Sender: TObject);
var
  b: AnsiChar;
begin
  b:='V';
  ComPort.Write(b,1);
  showCommand(@fvin, SizeOf(fvin));
end;

procedure TfECUU.cbAutoSendClick(Sender: TObject);
begin
  tSender.Enabled := cbAutoSend.Checked;
end;

procedure TfECUU.cbPortChange(Sender: TObject);
begin
  if ComPort.Connected then ComPort.Close;
  ComPort.Port := cbPort.Text;
  ComPort.BaudRate := TBaudRate(cbBaud.ItemIndex);
  ComPort.Open;
end;

procedure TfECUU.cbPortDropDown(Sender: TObject);
begin
  EnumComPorts(cbPort.Items);
end;

procedure TfECUU.cbReqTMClick(Sender: TObject);
begin
  tTM.Enabled := cbReqTM.Checked;
end;

procedure TfECUU.cbThrottleClick(Sender: TObject);
begin
  tThrottle.Enabled := cbThrottle.Checked;
end;

procedure TfECUU.ComLed1Click(Sender: TObject);
begin
  cbPortChange(Self);
end;

procedure TfECUU.ComLed1DblClick(Sender: TObject);
begin
  ComPort.Close;
end;

procedure TfECUU.ComPortRxBuf(Sender: TObject; const Buffer; Count: Integer);
var
  I: Integer;
  inByte : UInt8;
  pb : Pbyte;

begin
  pb := @Buffer;
  for I := 0 to count -1 do begin
    logByte(pb[i]);
  end;

end;

procedure TfECUU.ComTerminal1DblClick(Sender: TObject);
begin
  ComTerminal1.ClearScreen;
end;

procedure TfECUU.FormCreate(Sender: TObject);
begin
  Caption := 'ECUU tester ' + GetVersion;
end;

procedure TfECUU.logByte(b: UInt8);
begin
  inBuf := inBuf + IntToHex(b)+' ';

  if (prevByte = $FF) and (b = $FF) then begin
    mReceive.Lines.Add(inBuf);
    inBuf:='';
  end;
  prevByte := b;
end;

procedure TfECUU.mReceiveDblClick(Sender: TObject);
begin
 mReceive.Clear;
end;

procedure TfECUU.sbThrottleChange(Sender: TObject);
begin
  sbThrottle.Hint := InttoStr(sbThrottle.Position)+'%';
end;

procedure TfECUU.showCommand;
var
  s: string;
  i: Integer;
begin
  for I := 0 to len-1 do
  s:= s+ '$'+IntToHex( Pbyte(Integer(buf)+i)^)+' ';
  log.Lines.Add(s);
end;

procedure TfECUU.tSenderTimer(Sender: TObject);
begin  bTMClick(self);
end;


procedure TfECUU.tThrottleTimer(Sender: TObject);
begin
  bThrottleClick(self);
  Sleep(1);
  bGetTMClick(self);
end;

procedure TfECUU.tTMTimer(Sender: TObject);
begin
  bGetTMClick(self);
end;

end.
