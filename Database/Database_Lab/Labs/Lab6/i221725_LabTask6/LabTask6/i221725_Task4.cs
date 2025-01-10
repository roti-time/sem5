using System;

class SuperStringChecker
{
    static void Main(string[] args)
    {
        
        Console.Write("Enter a string (UPPERCASE only): ");
        string input = Console.ReadLine();

        
        if (IsSuperString(input))
        {
            Console.WriteLine("The string is a SUPER STRING.");
        }
        else
        {
            Console.WriteLine("The string is NOT a SUPER STRING.");
        }
    }

    
    static bool IsSuperString(string str)
    {
       
        str = str.ToUpper();

        
        int[] letterCount = new int[26];

       
        foreach (char c in str)
        {
            if (c >= 'A' && c <= 'Z')
            {
                int index = c - 'A';  
                letterCount[index]++;
            }
        }

       
        for (char c = 'A'; c <= 'Z'; c++)
        {
            int expectedValue = 26 - (c - 'A');  
            int actualCount = letterCount[c - 'A'];

            if (actualCount > 0 && actualCount != expectedValue)
            {
                return false;  
            }
        }

        return true;  
    }
}
