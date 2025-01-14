using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LabTask6
{

    class StringReversal
    {
        static void Main(string[] args)
        {
            
            Console.Write("Enter a string: ");
            string input = Console.ReadLine();

            
            if (string.IsNullOrEmpty(input))
            {
                Console.WriteLine("You did not enter a valid string.");
                return;
            }

            
            string reversedString = ReverseString(input);

            
            Console.WriteLine("Reversed string: " + reversedString);
        }

        static string ReverseString(string str)
        {
            char[] charArray = str.ToCharArray(); 

            Array.Reverse(charArray);              
            return new string(charArray);       
        }
    }



}
