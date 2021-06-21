# DAMM Check Digit Verifications in C#/Delphi/MSSQL

## Installation

C# and Delphi : Compile and run
MSSQL : Set database name and execute to createe function

## Usage

*C# and Delphi*
When prompted enter digits including DAMM checksum.
Program will tell if value has a vaid DAMM checksum.
To finish enter a blank value.

*MSSQL*
Call it directly in SSMS.
Example:
use <database>
print dbo.fn_CheckDAMM( 1234 )
Result should be 5

## License

Open license
