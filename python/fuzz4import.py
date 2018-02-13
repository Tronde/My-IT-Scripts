#!/usr/bin/env python3
# -*- encoding: utf-8 -*-

# Beschreibung:
# Fuzzing-Test für ein spezifisches import.php-Skript
#
# Autor: Tronde
# Lizenz: GPLv3

import string
import random

sysname_val = ''.join(random.choice(string.printable) for _ in range(random.choice(range(0,50,1))))

taskname_val = ''.join(random.choice(string.printable) for _ in range(random.choice(range(0,50,1))))

id_val = ''.join(random.choice(string.printable) for _ in range(random.choice(range(0,50,1))))

val1 = ''.join(random.choice(string.printable) for _ in range(random.choice(range(0,50,1))))

val2 = ''.join(random.choice(string.printable) for _ in range(random.choice(range(0,50,1))))

print(sysname_val)
print(taskname_val)
print(id_val)
print(val1)
print(val2)
