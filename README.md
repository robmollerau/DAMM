# DAMM Check Digit Verification in C#/Delphi/MSSQL

## Installation

C# and Delphi : Compile and run
MSSQL : Set database name and execute to createe function

## Information

DAMM encoding addresses the two most common trascription errors which are single digit mistype and transposed characters. Ie. 1121 (should be 1221) and 6933 (should be 9633).<br />
<br />
It is supperior to other checksum calculations such as:<br />
<br />
Sum Only - n1+n2+n3...nx - use lowest denominator as checksum<br />
Sum and Multiply - (((((n1+n2)*n3)+n4)+n5)...nX) - use lowest denominator as checksum<br />

## Usage

*C# and Delphi*

When prompted enter digits including DAMM checksum.
Program will tell if value has a vaid DAMM checksum.
To finish enter a blank value.

*MSSQL*

Call it directly in SSMS or use it inside stored procedures.
Example:
use <database>
print dbo.fn_CheckDAMM( 1234 )
Result should be 5

## License

Open license
