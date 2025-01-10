using System;

class PalindromeCheck
{
    static void Main(string[] args)
    {
        Console.Write("Enter a number: ");
        int num = Convert.ToInt32(Console.ReadLine());


        if (IsPalindrome(num))
        {
            Console.WriteLine(num + " is a palindrome.");
        }
        else
        {
            Console.WriteLine(num + " is not a palindrome.");
        }
    }


    static bool IsPalindrome(int number)
    {
        int originalNumber = number;
        int reverse = 0;


        while (number > 0)
        {
            int remainder = number % 10;
            reverse = reverse * 10 + remainder;
            number /= 10;
        }


        return originalNumber == reverse;
    }
}
