#coding: utf-8
import re,os

def fddir(fdir):
    flist=[]
    for root,dirt,files in os.walk(fdir):
        for name in files:
            if name.endswith('out'):
                flist.append(os.path.join(root,name))
    return flist



drctn='C:/Users/ZHU Xiaonan/Desktop/20140402语料库(无标点)'


def main(drctn):
    f=fddir(drctn)
    #print(len(f),f[0])
    for i in f:
        txt=open(i, encoding='utf8').readlines()
        tk=[]
        for t in txt:
            for x in t.split():
                tk.append(x)
        #print(tk[:50])
        tkn=len(tk)
        #print(tkn)
        tpn=len(set(tk))
        #print(tpn)
        r=float(tpn/tkn)
        print(r)
        #print ('file %s ratio: %d' % (i,r))

if __name__=='__main__':
    #print ('the result of pattern %s' % pattern)
    main(drctn)
    print ('the end')




    

    
