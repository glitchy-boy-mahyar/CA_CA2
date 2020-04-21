# This file can be used for generating test files
# in binary format

import random

# test file with 32-bit representation
# of numbers 0 to 99

with open('./data/test_1_data_mem.bin', 'w') as test_1:
    number = ''
    for i in range(250):
        number = '{:032b}'.format(0)
        test_1.write(number[0:8] + ' ' + number[8:16] + ' ' + number[16:24] + ' ' + number[24:32] + '\n')
    for i in range(10):
        number = '{:032b}'.format(i)
        test_1.write(number[0:8] + ' ' + number[8:16] + ' ' + number[16:24] + ' ' + number[24:32] + '\n')
