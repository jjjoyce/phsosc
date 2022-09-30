import numpy as np
import matplotlib.pyplot as plt
import math
import time
import os


# N=2n+1
def one_loop(n: int, b1:float, b2:float, nr2: int):

    coef='sqr_'+'n'+str(n)+'nr2'+str(nr2)+'b1'+str(b1)+'b2'+str(b2)+'_ran_'

    T = 20000
    dt = 0.2

    a1 = 1
    a2 = 0

    def h(x: float):
        hu =  a1*np.sin(x)+a2*np.sin(2*x)+b1*(np.cos(x)-1)+b2*(np.cos(2*x)-1)
        return hu

    u = np.zeros((2*n+1,2*n+1),dtype='float32') 
    om = np.zeros((2*n+1,2*n+1),dtype='float32') 
    
    n2=2*n+1;
    n4=n*n-1; # different from c code
    

    u = np.random.rand(2*n+1,2*n+1)
    # initialize u = theta
    for i in range(n2):
        for j in range(n2):
            rij = ((i-n)*(i-n)+(j-n)*(j-n))
            if (rij < nr2) or (rij > n4):
                u[i,j]=None
            else:
                #u[i,j]=np.arctan2(i-n,j-n)+np.random.rand();
                pass


    count=0
    # ode
    u_old = u.copy() # check for convergence
    for t in range(T+1): 
        for  i in range(n2):
            for j in range(n2):
                u0  =u[i,j]
                if not (math.isnan(u0)):
                    sumh = 0
                    # left 
                    u1 = u[i,j-1]
                    if not (math.isnan(u1)):
                        sumh += h(u1-u0)
                    # right 
                    u2 = u[i,j+1]
                    if not (math.isnan(u2)):
                        sumh += h(u2-u0)
                    # up
                    u3 = u[i-1,j]
                    if not (math.isnan(u3)):
                        sumh += h(u3-u0)
                    # down 
                    u4 = u[i+1,j]
                    if not (math.isnan(u4)):
                        sumh += h(u4-u0)

                    om[i,j]=sumh
                    #u[i,j]=(u[i,j]+dt*(om[i,j]-om[n,n])+onepi)%twopi-onepi
                    u[i,j]=(u[i,j]+dt*om[i,j]+np.pi)%(np.pi*2)-np.pi

        if (t%400==0):
            print(t)

            if np.allclose(u, u_old, atol=1e-05, equal_nan=True):
                break

            om_old = om.copy()

            fig, axs = plt.subplots()
            axs.set_aspect('equal')
            axs.pcolor(u, cmap='hsv')

            savename = 'ani'+str(count)+coef+'.jpg'    
            plt.savefig(savename, dpi = 600, bbox_inches = "tight")
            count+=1
            plt.cla()

    np.savetxt(coef+'u'+'.dat', u ,fmt='%1.4e')

if __name__ == "__main__":
    one_loop(25,0,0,0)