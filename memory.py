# This file can be used for generating test files
# in binary format

import random

# test file with 32-bit representation
# of numbers 0 to 99

with open('./data/test_1_data_mem.bin', 'w') as test_1:
    for i in range(1000):
        test_1.write('{:032b}\n'.format(0))
    for i in range(10):
        test_1.write('{:032b}\n'.format(i))
