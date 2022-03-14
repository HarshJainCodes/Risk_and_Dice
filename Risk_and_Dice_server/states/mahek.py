# d = {100 : {"name" : "harsh", "marks" : 80},
#     101 : {"name" : "mahek", "marks" : 70},
#     102 : {"name" : "kshirin", "marks" : 65},
#     103 : {"name" : "badi", "marks" : 76}
# }

# for x in d:
#     if d[x]["marks"] >= 75:
#         print(d[x]["name"])

# d = {10001 : 5000, 10002 : 4500, 10003 : 4300, 10004 : 4900}
# maximum = 0
# for x in d:
#     if d[x] > maximum:
#         maximum = d[x]
# print(maximum)\

# d = {"dr. umesh" : [["harsh", 2945843033], ["mahek", 249453483]], 
#      "dr. mahesh" : [["gaurav", 584837473], ["mahek", 3490349349]], 
#      "dr. sanika" : [["harsh", 4839433894], ["komal", 349349394]]}

# dr_name = input("enter the doctor's name : ")

# for x in d:
#     if dr_name == x:
#         for y in d[x]:
#             print(y[0], end= " ")

from sys import path_hooks


d = {}

while True:
    name = input()
    if name == "exit":
        break
    ph_no = int(input())
    
    d[name] = ph_no

print(d)














