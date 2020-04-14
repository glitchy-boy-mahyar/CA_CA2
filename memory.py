# This file can be used for generating test files
# in binary format

import random

# test file with 32-bit representation
# of numbers 0 to 99

with open('test_1.txt', 'w') as test_1:
    for i in range(100):
        test_1.write('{:032b}\n'.format(i))
