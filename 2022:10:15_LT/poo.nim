proc fib(n: int): int =
    var m = 1000000007
    if n <= 1:
        return 1
    return (fib(n - 1) + fib(n - 2)) mod m

echo fib(40)
#2.79s
