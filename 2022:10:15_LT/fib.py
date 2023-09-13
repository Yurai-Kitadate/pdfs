def fib(n):
    m = 1000000007
    if n == 0 or n == 1:
        return 1
    else:
        return (fib(n - 1) + fib(n - 2)) % m


print(fib(40))
# 22.18s
