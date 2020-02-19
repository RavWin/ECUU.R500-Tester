unit uFVIN;

interface

type
  TfvinPacket = packed record
    head  : UInt16;
    addr   : UInt8;
    cmd   : UInt8;
    crc   : UInt8;
    tail  : UInt16;
    procedure prepare(aAddr: UInt8; aCmd: UInt8);
  end;

  TfvinTM = packed record
    head  : UInt16;
    addr   : UInt8;
    err   : UInt8;
    data  : array [0..4] of Single;
    crc   : UInt8;
    tail  : UInt16;
    procedure prepare(aAddr: UInt8; aErr: UInt8; aData: array of UInt16);
  end;

implementation

{ TfvinPacket }


{ TfvinPacket }

procedure TfvinPacket.prepare(aAddr, aCmd: UInt8);
begin
  head := $FEFE;
  cmd := aCmd;
  addr := aAddr;
  crc := aCmd xor aAddr;
  tail := $FFFF;
end;

{ TfvinTM }


{ TfvinTM }

procedure TfvinTM.prepare(aAddr, aErr: UInt8; aData: array of UInt16);
var
  I: Integer;
begin
  head := $FEFE;
  addr  := aAddr;
  err   := aErr;
  crc := addr xor err;
  for I := 0 to 4 do begin
    data[i] := aData[i];
  end;
  for I := 0 to 19 do
    crc := crc xor PByte( UInt32(@data[0])+i)^;
  tail := $FFFF;

end;

end.
