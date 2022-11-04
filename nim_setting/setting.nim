import strformat
import strutils
import macros
import sequtils
import math
import sets
import ropes
import random
import hashes
import sugar
import future

template `+`(x: string | char, y: string | char): untyped =
    x & y

template `+`(x: Rope, y: string | char): untyped =
    x & y

template `+`(x: string | char, y: Rope): untyped =
    x & y

template `+=`(x: string | char, y: string | char): untyped =
    x &= y

#正の値を返します。
template `%`(x, y: int): untyped =
    (x + y) mod y

template `//`(x, y: auto): untyped =
    int((x / y))

template `/`(x, y: auto): untyped =
    x.parseFloat / y.parseFloat


template `%=`(x, y: int): untyped =
    x = x mod y

template append[T](a: seq[T], b: T): untyped =
    a.add(b)

template print(t: varargs[auto]): untyped =
    var p = ""
    for i in 0..t.len - 1:
        p &= $t[i]
        if i != t.len - 1:
            p &= " "
    echo p

macro range(a: int, b: int, c: int): untyped =
    var a_rep = repr(a)
    var b_rep = repr(b)
    var c_rep = repr(c).parseInt
    #stepが変数だとbag
    if c_rep >= 1:
        parseStmt(fmt"""countup({a_rep},{b_rep} - 1,{c_rep})""")
    else:
        parseStmt(fmt"""countdown({a_rep},{b_rep} + 1,abs({c_rep}))""")

macro range(a: int, b: int): untyped =
    var a_rep = repr(a)
    var b_rep = repr(b)
    parseStmt(fmt"""countup({a_rep},{b_rep} - 1)""")

macro range(a: int): untyped =
    var a_rep = repr(a)
    parseStmt(fmt"""countup(0,{a_rep} - 1)""")

template `+`[T](a: seq[T], b: seq[T]): untyped =
    concat(a, b)

template `|`(a: int, b: int): untyped =
    countup(a, b - 1)

template `|`[T](a: HashSet[T], b: HashSet[T]): untyped =
    a.union(b)

template `**`(a: int, b: int): untyped =
    a^b

template input(): untyped =
    stdin.readLine

template `<<`(a: int, b: int): untyped =
    a * (2**b)

template `>>`(a: int, b: int): untyped =
    a // (2**b)

template str(a: auto): untyped =
    $a


template set(a: auto): untyped =
    toHashSet(a)

proc nodeToSeq(a: NimNode): seq[string] =
    var res: seq[string] = @[]
    for i in a:
        res.add(i.repr)
    return res

proc seqToIndentFmt(a: seq[string]): string =
    var res = ""
    for i in a:
        if i == "":
            continue
        res += fmt"  {repr(i)[1..^2]}" + "\n"
    return res

macro cfor(head, body: untyped): untyped =
    var heads = head.nodeToSeq
    var declare = head[0]
    var condition = head[1]
    var update = head[2]
    echo heads
    quote do:
        block:
            `declare`
            while `condition`:
                `body`
                `update`

macro rep(a, b, body: untyped): untyped =
    var Variable = newIdentNode(a.repr)
    var To = b.repr.parseInt
    quote do:
        for `Variable` in range(`To`):
            `body`


macro rep(a, b, c, body: untyped): untyped =
    var Variable = newIdentNode(a.repr)
    var From = b.repr.parseInt
    var To = c.repr.parseInt
    quote do:
        for `Variable` in range(`From`, `To`):
            `body`

macro rep(a, b, c, d, body: untyped): untyped =
    var Variable = newIdentNode(a.repr)
    var From = b.repr.parseInt
    var To = c.repr.parseInt
    var Step = d.repr.parseInt
    quote do:
        for `Variable` in range(`From`, `To`, `Step`):
            `body`

macro da(head: untyped): untyped =
    var heads: seq[string] = @[]
    for i in head:
        heads.add(i.repr)
    var res = newNimNode(nnkVarSection)
    var symName = "sym" + $hash(head.repr)
    res.add(newIdentDefs(ident(symName), newEmptyNode(),
            parseExpr(heads[^1])))
    for i in range(len(heads) - 1):
        var t = newNimNode(nnkBracketExpr)
        t.add(ident(fmt"{symName}"), newIntLitNode(i))
        res.add(newIdentDefs(ident(heads[i]), newEmptyNode(),
          t))
    echo res.repr
    quote do:
        `res`
#返り値がない、引数を取らない関数なんていらない、よって実装しない。
macro fn(head, body: untyped): untyped =
    var heads: seq[string] = @[]
    for i in head:
        heads.add(i.repr)
    var bodys: string = body.repr
    bodys = bodys.replace("\x0A", "\x0A  ")
    var procNode = parseExpr(fmt "proc {heads[1]} : {heads[2]} = {bodys}")
    procNode


