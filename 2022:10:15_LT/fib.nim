proc fib(n: int): int =
    var m = 1000000007
    if n == 0 or n == 1:
        return 1
    else:
        return (fib(n - 1) + fib(n - 2)) mod m
echo fib(35)
#0.61s
