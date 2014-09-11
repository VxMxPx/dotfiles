#!/usr/bin/env python3

"""
Answer to all life's questions...
Print Yes / No randomaly.
Use: ./yesno.py [Question]
"""

import random, sys

def get_answer(question=""):
    """Get yes / no randomly based on a question."""
    stat = 0
    rounds = sum([ord(char) for char in question])
    while rounds > 1000:
        rounds = round(rounds / 10)
    for _ in range(rounds or 10):
        stat += (1 if random.randint(0, 1) else -1)
    return 'Yes' if stat > 0 else 'No'

def get_question():
    """Get input"""
    arguments = sys.argv
    del arguments[0]
    return ' '.join(arguments)

print(get_answer(get_question()))
