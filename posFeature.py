#coding: utf-8
import re,os
from collections import Counter

def fddir(fdir):
    flist=[]
    for root,dirt,files in os.walk(fdir):
        for name in files:
            if name.endswith('out'):
                flist.append(os.path.join(root,name))
    return flist

pos=['n','nr','nr1','nr2','nrj','nrf','ns','nsf','nt','nz','nl','ng','t','tg','s','f','v','vd','vn','vshi','vyou','vf','vx','vi','vl','vg','a','ad','an','ag','al','b','bl','z','r','rr','rz','rzt','rzs','rzv','ry','ryt','rys','ryv','rg','m','mq','q','qv','qt','d','p','pba','pbei','c','cc','u','uzhe','ule','uguo','ude1','ude2','ude3','usuo','udeng','uyy','udh','uls','uzhi','ulian','e','y','o','w','wkz','wky' ,'wyz' ,'wyy' ,'wj' ,'ww' ,'wt' ,'wd' ,'wf' ,'wn' ,'wm','ws' ,'wp' ,'wb','wh']
drctn='C:/Users/ZHU Xiaonan/Desktop/20140402语料库/口语语料/自然会话'
p='C:/Users/ZHU Xiaonan/Desktop/rs.txt'
def main(drctn,pos,p):
    f=fddir(drctn)
    outf=open(p,'w+')
    for i in f:
        txt=open(i, encoding='utf8').read().split()
        t=[w.split('/')[1] for w in txt]
        #print (t[:20])
        c=Counter(t)
        for p in pos:
            if p in t:
                print(c[p], end=',',file=outf)
            else:
                print(0,end=',',file=outf)
        print(end='\n',file=outf)    
    outf.close()
                    

if __name__=='__main__':
    print ('start')
    main(drctn,pos,p)
    print ('the end')
