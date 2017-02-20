#!/usr/bin/python
# coding: utf-8

import os
import codecs

# 2
for root, dirs, files in os.walk('./features/2书面语语料/'):
    r = root.replace('./features/2书面语语料/', '')

    if len(r) > 0:
        print(r)
        category = '2'+r[0]
        filename = './features/'+category+'.txt'
        outF = codecs.open(filename, 'a', 'utf-8')
        for f in files:
            if f == 'fea.txt':
                inF = codecs.open(os.path.join(root, f), 'r', 'utf-8')
                outF.write(inF.read())
                inF.close()

        outF.close()


# 1
for root, dirs, files in os.walk('./features/1口语语料/'):
    r = root.replace('./features/1口语语料/', '')

    if len(r) > 0:
        print(r)
        if r[0] == '7':
            category = '13'
        elif r[0] == '5':
            category = '14'
        else:
            category = '1'+r[0]
        filename = './features/'+category+'.txt'
        outF = codecs.open(filename, 'a', 'utf-8')
        for f in files:
            if f == 'fea.txt':
                inF = codecs.open(os.path.join(root, f), 'r', 'utf-8')
                outF.write(inF.read())
                inF.close()

        outF.close()