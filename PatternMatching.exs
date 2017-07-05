## 1

a = [1, 2, 3] # match
a = 4 # match
4 = a # no match (match after `a = 4`)
[a, b] = [1, 2, 3] # no match
a = [[1, 2, 3]] # match
[a] = [[1, 2, 3]] # match
[[a]] = [[1, 2, 3]] # no match

## 2

[a, b, a] = [1, 2, 3] # no match
[a, b, a] = [1, 1, 2] # no match
[a, b, a] = [1, 2, 1] # match

## 3 (a = 2)

[a, b, a] = [1, 2, 3] # no match
[a, b, a] = [1, 1, 2] # no match
a = 1 # match
^a = 2 # match
^a = 1 # no match
^a = 2 - a # no match