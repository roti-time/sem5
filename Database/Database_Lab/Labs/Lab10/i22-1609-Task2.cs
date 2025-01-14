using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LabTask6
{

    class PalindromeCheck
    {
        static void Main(string[] args)
        {
            Console.Write("Enter a number: ");
            int number = int.Parse(Console.ReadLine());

            if (IsPalindrome(number))
            {
                Console.WriteLine($"{number} is a palindrome.");
            }
            else
            {
                Console.WriteLine($"{number} is not a palindrome.");
            }
        }

        
        static bool IsPalindrome(int num)
        {
            int originalNumber = num;
            int reversedNumber = 0;
            int remainder;

            while (num > 0)
            {
                remainder = num % 10;
                reversedNumber = (reversedNumber * 10) + remainder;
                num /= 10;
            }

            
            return originalNumber == reversedNumber;
        }
    }

}
