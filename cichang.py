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
    for i in f:
        txt=open(i, encoding='utf8').readlines()
        tk=[]
        for t in txt:
            for x in t.split():
                tk.append(x)
        cha=0
        for n in tk:
            cha=cha+len(n)
        r=float(cha/len(tk))
        print(r)
        '''print (i)
        for n in tk[:20]:
            print (len(n))'''
        

if __name__=='__main__':
    #print ('the result of pattern %s' % pattern)
    main(drctn)
    print ('the end')




    

    
