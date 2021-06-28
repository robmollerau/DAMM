using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApp1
{
    class Program
    {
        public static readonly int[,] DAMM_LOOKUP_ARRAY =
        {
           { 0, 3, 1, 7, 5, 9, 8, 6, 4, 2 },
           { 7, 0, 9, 2, 1, 5, 4, 8, 6, 3 },
           { 4, 2, 0, 6, 8, 7, 1, 3, 5, 9 },
           { 1, 7, 5, 0, 9, 8, 3, 4, 2, 6 },
           { 6, 1, 2, 3, 0, 4, 5, 9, 7, 8 },
           { 3, 6, 7, 4, 2, 0, 9, 5, 8, 1 },
           { 5, 8, 6, 9, 7, 2, 0, 1, 3, 4 },
           { 8, 9, 4, 5, 3, 6, 2, 0, 1, 7 },
           { 9, 4, 3, 8, 6, 1, 7, 2, 0, 5 },
           { 2, 5, 8, 1, 4, 3, 6, 7, 9, 0 }
        };

        static int DAMMEncode( string AValue )
        {
            int interim = 0;
            int digit = 0;
            int ctr = 0;

            for (ctr = 0; ctr < AValue.Length; ctr++)
            {
                if (new string[] { "0", "1", "2", "3", "4", "5", "6", "7", "8", "9" }.Any( s => AValue.Contains( s ) ) )
                {
                    digit = Int32.Parse(AValue.Substring(ctr, 1));
                    interim = DAMM_LOOKUP_ARRAY[interim,digit];
                }
                else
                {
                    return -1;

                }
            }

            return interim;

        }

        static bool DAMMCheck( string AValue)
        {
            int ctr = 0;
            int checkSum = 0;
            int calcCheckSum = 0;
            int lenNum = AValue.Length;
            string numCheck = "";

            if ( lenNum <= 0 )
            {
                return true;
            }

            for (ctr = 0; ctr < lenNum; ctr++)
            {
                if ( ! new string[] { "0", "1", "2", "3", "4", "5", "6", "7", "8", "9" }.Any(s => AValue.Contains(s)))
                {
                    return false;
                }
            }

            checkSum = Int32.Parse(AValue.Substring(lenNum - 1, 1));
            numCheck = AValue.Substring(0, lenNum - 1);

            calcCheckSum = DAMMEncode(numCheck);

            if ( calcCheckSum < 0 )
            {
                return false;
            }

            return (calcCheckSum == checkSum);
        }


        static void Main(string[] args)
        {
            string inputValue = "";
            bool DAMMCheckFlag = false;

            while ( true )
            {
                Console.Write( "Please enter DAMM value to check, blank to exit: " );
                inputValue = Console.ReadLine();
                if ( inputValue == "")
                {
                    break;
                }

                DAMMCheckFlag = DAMMCheck(inputValue);
                if ( DAMMCheckFlag )
                {
                    Console.WriteLine("Entered value has correct DAMM check digit");
                }
                else
                {
                    Console.WriteLine("Entered value does not have correct DAMM check digit");
                }

            }
            
        }
    }
}
