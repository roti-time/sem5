using System;

class ReverseString
{
    static void Main(string[] args)
    {
        Console.Write("Enter a string: ");
        string input = Console.ReadLine();

        string reversedString = Reverse(input);

        Console.WriteLine("Reversed string: " + reversedString);
    }

    static string Reverse(string str)
    {
        string reversed = ""; 

        for (int i = str.Length - 1; i >= 0; i--)
        {
            reversed += str[i];
        }

        return reversed;  
    }
}
