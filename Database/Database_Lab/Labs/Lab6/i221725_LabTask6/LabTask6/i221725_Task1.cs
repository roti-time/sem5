using System;
class SimpleCalculator
{
    static void Main(string[] args)
    {
        while (true)
        {
            Console.WriteLine("1. Add two numbers");
            Console.WriteLine("2. Subtract two numbers");
            Console.WriteLine("3. Divide two numbers");
            Console.WriteLine("4. Find remainder (Modular Division)");
            Console.WriteLine("5. Multiply two numbers");
            Console.WriteLine("6. Check if a number is prime");
            Console.WriteLine("7. Find factorial of a number");
            Console.WriteLine("8. Find square root of a number");
            Console.WriteLine("9. Exit");

            Console.Write("Enter your choice (1-9): ");
            int choice = Convert.ToInt32(Console.ReadLine());

            if (choice == 9)
            {
                Console.WriteLine("Goodbye!");
                break;
            }

            switch (choice)
            {
                case 1:
                    Console.Write("Enter first number: ");
                    int num1 = Convert.ToInt32(Console.ReadLine());
                    Console.Write("Enter second number: ");
                    int num2 = Convert.ToInt32(Console.ReadLine());
                    Console.WriteLine("Result: " + (num1 + num2));
                    break;

                case 2:
                    Console.Write("Enter first number: ");
                    num1 = Convert.ToInt32(Console.ReadLine());
                    Console.Write("Enter second number: ");
                    num2 = Convert.ToInt32(Console.ReadLine());
                    Console.WriteLine("Result: " + (num1 - num2));
                    break;

                case 3:
                    Console.Write("Enter the dividend: ");
                    num1 = Convert.ToInt32(Console.ReadLine());
                    Console.Write("Enter the divisor: ");
                    num2 = Convert.ToInt32(Console.ReadLine());
                    if (num2 == 0)
                    {
                        Console.WriteLine("Cannot divide by zero!");
                    }
                    else
                    {
                        Console.WriteLine("Result: " + (num1 / num2));
                    }
                    break;

                case 4:
                    Console.Write("Enter the first number: ");
                    num1 = Convert.ToInt32(Console.ReadLine());
                    Console.Write("Enter the second number: ");
                    num2 = Convert.ToInt32(Console.ReadLine());
                    Console.WriteLine("Remainder (mod): " + (num1 % num2));
                    break;

                case 5:
                    Console.Write("Enter first number: ");
                    num1 = Convert.ToInt32(Console.ReadLine());
                    Console.Write("Enter second number: ");
                    num2 = Convert.ToInt32(Console.ReadLine());
                    Console.WriteLine("Result: " + (num1 * num2));
                    break;

                case 6:
                    Console.Write("Enter a number: ");
                    int primeCheck = Convert.ToInt32(Console.ReadLine());
                    if (IsPrime(primeCheck))
                    {
                        Console.WriteLine(primeCheck + " is a prime number.");
                    }
                    else
                    {
                        Console.WriteLine(primeCheck + " is not a prime number.");
                    }
                    break;

                case 7:
                    Console.Write("Enter a number: ");
                    int factNum = Convert.ToInt32(Console.ReadLine());
                    Console.WriteLine("Factorial: " + Factorial(factNum));
                    break;

                case 8:
                    Console.Write("Enter a number: ");
                    double sqrtNum = Convert.ToDouble(Console.ReadLine());
                    Console.WriteLine("Square root: " + Math.Sqrt(sqrtNum));
                    break;

                default:
                    Console.WriteLine("Invalid choice. Please try again.");
                    break;
            }

            Console.WriteLine("Press any key to continue...");
            Console.ReadKey();
            Console.Clear();
        }
    }

    static bool IsPrime(int number)
    {
        if (number <= 1) return false;

        for (int i = 2; i < number; i++)
        {
            if (number % i == 0)
            {
                return false;
            }
        }

        return true;
    }

    static int Factorial(int n)
    {
        if (n == 0 || n == 1) return 1;
        return n * Factorial(n - 1);
    }
}

