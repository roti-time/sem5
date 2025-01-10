using System;

class PalindromeCheck
{
    static void Main(string[] args)
    {
        Console.Write("Enter a number: ");
        int num = Convert.ToInt32(Console.ReadLine());

        // Call the function to check if the number is a palindrome
        if (IsPalindrome(num))
        {
            Console.WriteLine(num + " is a palindrome.");
        }
        else
        {
            Console.WriteLine(num + " is not a palindrome.");
        }
    }

    // Method to check if a number is a palindrome
    static bool IsPalindrome(int number)
    {
        int originalNumber = number;  // Store the original number
        int reverse = 0;  // To hold the reversed number

        // Reverse the digits of the number
        while (number > 0)
        {
            int remainder = number % 10;  // Get the last digit
            reverse = reverse * 10 + remainder;  // Build the reversed number
            number /= 10;  // Remove the last digit from the number
        }

        // Check if the original number and the reversed number are the same
        return originalNumber == reverse;
    }
}
