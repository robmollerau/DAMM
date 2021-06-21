program DAMM;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils, System.StrUtils;

const  
  DAMM_LOOKUP_ARRAY : Array[ 0..9, 0..9 ] of Integer = (
    ( 0, 3, 1, 7, 5, 9, 8, 6, 4, 2 ),
    ( 7, 0, 9, 2, 1, 5, 4, 8, 6, 3 ),
    ( 4, 2, 0, 6, 8, 7, 1, 3, 5, 9 ),
    ( 1, 7, 5, 0, 9, 8, 3, 4, 2, 6 ),
    ( 6, 1, 2, 3, 0, 4, 5, 9, 7, 8 ),
    ( 3, 6, 7, 4, 2, 0, 9, 5, 8, 1 ),
    ( 5, 8, 6, 9, 7, 2, 0, 1, 3, 4 ),
    ( 8, 9, 4, 5, 3, 6, 2, 0, 1, 7 ),
    ( 9, 4, 3, 8, 6, 1, 7, 2, 0, 5 ),
    ( 2, 5, 8, 1, 4, 3, 6, 7, 9, 0 ) );

function DAMMEncode( const AValue : String ) : Integer;
var
  Ctr,
    Interim,
    Digit    : Integer;
  Str        : String;
begin

  Interim := 0;

  Str := Uppercase( Trim( AValue ) );

  for Ctr := 1 to Pred( Length( Str ) ) do begin

    if CharInSet( Str[ Ctr ], [ '0'..'9' ] ) then begin

      Digit := StrToInt( '$' + Str[ Ctr ] );

      Interim := DAMM_LOOKUP_ARRAY[ Interim ][ Digit ];

    end
    else begin 
      Result := -1;
      Exit;
    end;

  end;

  Result := Interim;

end;

function DAMMCheck( const AValue : String ) : Boolean;
var
  Checksum,
    CalcChecksum,
    LenNum,
    Ctr           : Integer;
  Str,
    NumCheck      : String;
begin

  Str    := Uppercase( Trim( AValue ) );
  LenNum := Length( Str );

  if LenNum = 0 then begin
    Result := True;
    Exit;
  end;

  for Ctr := 1 to LenNum do begin
    if not ( CharInSet( Str[ Ctr ], [ '0'..'9' ] ) ) then begin
      Result := False;
      Exit;
    end;
  end;

  Checksum := StrToInt( RightStr( Str, 1 ) );
  NumCheck := LeftStr( Str, LenNum - 1 );

  CalcChecksum := DAMMEncode( NumCheck );
  if CalcChecksum < 0 then begin
    Result := False;
  end
  else begin
    Result := Checksum = CalcChecksum;
  end;

end;

procedure ExecuteProgram;
var
  DAMMCheckFlag : Boolean;
  InputValue    : String;
begin

  while True do begin

    Write( 'Please enter DAMM value to check, blank to exit: ' );
    ReadLn( InputValue );
    InputValue := Trim( InputValue );
    
    if InputValue = '' then begin
      Break;
    end;  
    
    DAMMCheckFlag := DAMMCheck( InputValue );
    if DAMMCheckFlag then begin
      WriteLn( 'Entered has correct DAMM check digit' );
    end
    else begin
      WriteLn( 'Entered value does not have correct DAMM check digit' );
    end;    

    WriteLn( '' );
    
  end;
    
  // Exception check
  // raise Exception.Create( 'Unknown exception' );
  
end;  

begin
  try
    ExecuteProgram;
  except
    on E: Exception do begin
      WriteLn( E.ClassName, ': ', E.Message );
      ExitCode := 1;
    end;  
  end;
end.
