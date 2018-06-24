| Employee | Execution cost (gas) |
|----------+----------------------|
|        1 |                 1702 |
|        2 |                 2483 |
|        3 |                 3264 |
|        4 |                 4045 |
|        5 |                 4826 |
|        6 |                 5607 |
|        7 |                 6388 |
|        8 |                 7169 |
|        9 |                 7950 |
|       10 |                 8731 |

Because the for loop in caculateRunWay is O(n), and each time sum salary of current employees are recalculated. To optimize, use a variable to hold current sum, so it's O(1). Also update this sum in createEmployee, updateEmployee, deleteEmployee. After this:
| Employee | Execution cost (gas) |
|----------+----------------------|
| 1        | 860                  |
| 2        | 860                  |
| 3        | 860                  |
| 4        | 860                  |
| 5        | 860                  |
| 6        | 860                  |
| 7        | 860                  |
| 8        | 860                  |
| 9        | 860                  |
| 10       | 860                  |
