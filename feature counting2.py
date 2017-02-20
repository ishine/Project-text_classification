#coding: utf-8
import re,os

def fddir(fdir):
    flist=[]
    for root,dirt,files in os.walk(fdir):
        for name in files:
            if name.endswith('out'):
                flist.append(os.path.join(root,name))
    return flist

pattern=u'为/p[^，。？！.；：“”《》（）、]+?起见'


drctn='F:/课题组/MDnew/MD/20140402语料库'

ptn=re.compile(pattern)

def main(drctn,ptn):
    f=fddir(drctn)
    for i in f:
        txt=open(i, encoding='utf8').readlines()
        c=0
        for sen in txt:
            rslt=len(re.
                     findall(ptn,sen))
            c=c+rslt
        print (c)

if __name__ == '__main__':
    print ('the result of pattern %s' % pattern)
    main(drctn,ptn)
    print ('the end')




    


