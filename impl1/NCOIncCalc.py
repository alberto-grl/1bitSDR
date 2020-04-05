Python 3.7.3 (v3.7.3:ef4ec6ed12, Mar 25 2019, 22:22:05) [MSC v.1916 64 bit (AMD64)] on win32
Type "help", "copyright", "credits" or "license()" for more information.
>>> print(hex(0x1000000000000000 * 900000 / 136000000))
Traceback (most recent call last):
  File "<pyshell#0>", line 1, in <module>
    print(hex(0x1000000000000000 * 900000 / 136000000))
TypeError: 'float' object cannot be interpreted as an integer
>>> print(hex(0x1000000000000000 * 900000 // 136000000))
0x1b1b1b1b1b1b1b
>>> 
