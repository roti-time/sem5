using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LabTask6
{
    using System;

    class SuperStringCheck
    {
        static void Main(string[] args)
        {
            Console.Write("Enter a string: ");
            string input = Console.ReadLine().ToUpper(); 

            if (IsSuperString(input))
            {
                Console.WriteLine($"{input} is a SUPER STRING.");
            }
            else
            {
                Console.WriteLine($"{input} is NOT a SUPER STRING.");
            }
        }

       
        static bool IsSuperString(string str)
        {
           
            int[] charCounts = new int[26];

            
            foreach (char c in str)
            {
                if (c < 'A' || c > 'Z') 
                {
                    Console.WriteLine("Invalid input. Only uppercase alphabet characters are allowed.");
                    return false;
                }

                int index = c - 'A'; )
                charCounts[index]++;
            }

            for (int i = 0; i < 26; i++)
            {
                if (charCounts[i] > 0) 
                {
                    int superAsciiValue = 26 - i; 
                    if (charCounts[i] != superAsciiValue)
                    {
                        return false; 
                    }
                }
            }

            return true;  
        }
    }

}
