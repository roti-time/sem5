using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LabTask6
{

    class Calculator
    {
        
        public double Add(double a, double b)
        {
            return a + b;
        }

        
        public double Subtract(double a, double b)
        {
            return a - b;
        }

        
        public double Multiply(double a, double b)
        {
            return a * b;
        }

        
        public double Divide(double a, double b)
        {
            if (b == 0)
            {
                throw new DivideByZeroException("Cannot divide by zero!");
            }
            return a / b;
        }

        
        public double Modulo(double a, double b)
        {
            if (b == 0)
            {
                throw new DivideByZeroException("Cannot perform modulo by zero!");
            }
            return a % b;
        }

        
        public bool IsPrime(int n)
        {
            if (n <= 1) return false;
            if (n == 2) return true;
            for (int i = 2; i <= Math.Sqrt(n); i++)
            {
                if (n % i == 0)
                {
                    return false;
                }
            }
            return true;
        }

        
        public long Factorial(int n)
        {
            if (n < 0)
                throw new ArgumentException("Factorial is not defined for negative numbers.");
            if (n == 0 || n == 1)
                return 1;
            return n * Factorial(n - 1);
        }

       
        public double SquareRoot(double n)
        {
            if (n < 0)
                throw new ArgumentException("Square root is not defined for negative numbers.");
            return Math.Sqrt(n);
        }

        static void Main(string[] args)
        {
            Calculator calculator = new Calculator();

            while (true)
            {
                Console.WriteLine("\nSelect operation:");
                Console.WriteLine("1. Addition");
                Console.WriteLine("2. Subtraction");
                Console.WriteLine("3. Multiplication");
                Console.WriteLine("4. Division");
                Console.WriteLine("5. Modulo");
                Console.WriteLine("6. Check Prime");
                Console.WriteLine("7. Factorial");
                Console.WriteLine("8. Square Root");
                Console.WriteLine("9. Exit");
                Console.Write("Enter your choice (1-9): ");
                int choice = int.Parse(Console.ReadLine());

                switch (choice)
                {
                    case 1:
                        Console.Write("Enter first number: ");
                        double add1 = double.Parse(Console.ReadLine());
                        Console.Write("Enter second number: ");
                        double add2 = double.Parse(Console.ReadLine());
                        Console.WriteLine("Result: " + calculator.Add(add1, add2));
                        break;

                    case 2:
                        Console.Write("Enter first number: ");
                        double sub1 = double.Parse(Console.ReadLine());
                        Console.Write("Enter second number: ");
                        double sub2 = double.Parse(Console.ReadLine());
                        Console.WriteLine("Result: " + calculator.Subtract(sub1, sub2));
                        break;

                    case 3:
                        Console.Write("Enter first number: ");
                        double mul1 = double.Parse(Console.ReadLine());
                        Console.Write("Enter second number: ");
                        double mul2 = double.Parse(Console.ReadLine());
                        Console.WriteLine("Result: " + calculator.Multiply(mul1, mul2));
                        break;

                    case 4:
                        Console.Write("Enter first number: ");
                        double div1 = double.Parse(Console.ReadLine());
                        Console.Write("Enter second number: ");
                        double div2 = double.Parse(Console.ReadLine());
                        Console.WriteLine("Result: " + calculator.Divide(div1, div2));
                        break;

                    case 5:
                        Console.Write("Enter first number: ");
                        double mod1 = double.Parse(Console.ReadLine());
                        Console.Write("Enter second number: ");
                        double mod2 = double.Parse(Console.ReadLine());
                        Console.WriteLine("Result: " + calculator.Modulo(mod1, mod2));
                        break;

                    case 6:
                        Console.Write("Enter number to check for prime: ");
                        int prime = int.Parse(Console.ReadLine());
                        Console.WriteLine("Is Prime: " + calculator.IsPrime(prime));
                        break;

                    case 7:
                        Console.Write("Enter number to find factorial: ");
                        int fact = int.Parse(Console.ReadLine());
                        Console.WriteLine("Factorial: " + calculator.Factorial(fact));
                        break;

                    case 8:
                        Console.Write("Enter number to find square root: ");
                        double sqrt = double.Parse(Console.ReadLine());
                        Console.WriteLine("Square root: " + calculator.SquareRoot(sqrt));
                        break;

                    case 9:
                        Console.WriteLine("Exiting...");
                        return;

                    default:
                        Console.WriteLine("Invalid choice. Please select a valid operation.");
                        break;
                }
            }
        }
    }

}
