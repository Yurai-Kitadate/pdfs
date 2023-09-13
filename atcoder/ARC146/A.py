n = int(input())
a = list(map(int,input().split()))
from collections import Counter
for i in range(1,n + 1):
    p = []
    for j in range(n):
        p.append(a[j]%i)
    c = Counter(p)
    print(c)