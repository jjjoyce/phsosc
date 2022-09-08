import numpy as np
import math
import time
import os
import matplotlib.pyplot as plt

ti = time.time()

def one_loop(n: int, a1: float, a2: float, b1:float, b2:float):

    T = 100
    dt = 0.2

    def h(x: float):
        hu =  a1*np.sin(x)+a2*np.sin(2*x)+b1*(np.cos(x)-1)+b2*(np.cos(2*x)-1)
        return hu

    sqr33 = np.sqrt(3)/3

    
    nr2 = n*n-1
    m = np.zeros((2*n+1,2*n+1,3),dtype='float32') # (x,y,z) z=0 up (connect to i+1)
    u = np.zeros((2*n+1,2*n+1),dtype='float32') # phase 
    uu = np.zeros((2*n+1,2*n+1),dtype='float32') # phase 
    om = np.zeros((2*n+1,2*n+1),dtype='float32')

    x0 = np.linspace(0, sqr33*(2*n), (2*n+1),dtype='float32')
    y1 = np.zeros(2*n+1,dtype='float32')
    y2 = np.zeros(2*n+1,dtype='float32')
    y3 = np.zeros(2*n+1,dtype='float32')
    y4 = np.zeros(2*n+1,dtype='float32')

    for i in range(2*n+1):
        if (i%2==0):
            y1[i] = 1/3
            y2[i] = 2/3
            y3[i] = 1
            y4[i] = 0
        else:
            y1[i] = 2/3
            y2[i] = 1/3
            y3[i] = 0
            y4[i] = 1

    for i in range(2*n+1):
        m[i,:,0]+=x0
        if (i%2==0):
            m[i,:,1]=i+y1
            m[i,:,2]=y3
        else:
            m[i,:,1]=i+y2
            m[i,:,2]=y4

    # scaling
    m = m*sqr33*3


    # initialize
    x0,y0=m[n,n,0],m[n,n,1]
    for i in range(2*n+1):
        for j in range(2*n+1):
            rij =  (m[i,j,0]-x0)**2+(m[i,j,1]-y0)**2
            if rij >= nr2:
                u[i,j]=None
            else:
                u[i,j]=np.arctan2(m[i,j,0]-x0,m[i,j,1]-y0)

    count = 0
    onepi=np.pi
    twopi=np.pi*2
    # ode
    u_old = u.copy()

    for t in range(T+1):
        for i in range(2*n+1):
            for j in range(2*n+1):
                u0 = u[i,j]
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
                    # up or down
                    if m[i,j,2]==0:
                        u3 = u[i+1,j]
                    else:
                        u3 = u[i-1,j]

                    if not (math.isnan(u3)):
                        sumh += h(u3-u0)

                    om[i,j]=sumh
                    u[i,j]=(u[i,j]+dt*(om[i,j]-om[n,n])+onepi)%twopi-onepi
                    #u[i,j]=(u[i,j]+dt*(om[i,j]-om[n,n]))

        if (t%100==0):

            if np.allclose(u, u_old, atol=1e-03, equal_nan=True):
                break

            u_old = u.copy()
            
    # calculate f(r), direction 9:00 (tri pictures are horizental flipped compared to sqr)
    fr = u[n,1]-u[n,n];

    coef='full_tri_'+'n_'+str(n)+'b1_'+str(b1)+'b2_'+str(b2)+'_'
    np.savetxt(coef+'u'+'.dat', u ,fmt='%1.4e')

    
    #filename = coef+'om&t'+'.dat' 
    filename = "tri_output_full.dat"
    with open(filename, 'at') as fout:
        fout.write(coef+'\n')
        fout.write(str(om[n][n])+'\n')
        fout.write(str(fr)+'\n')
        fout.write(str(t))
        fout.write('\n')

    # for plot

    for i in range(2*n+1):
        for j in range(2*n+1):
            if math.isnan(u[i,j]):
                uu[i,j]=10
            else:
                uu[i,j]=np.nan 

    fig, axs = plt.subplots()
    fig.set_dpi(300)
    axs.set_aspect('equal')

    im = axs.scatter(m[:,:,0], m[:,:,1], c=u, s = 3, cmap='hsv')
    fig.colorbar(im, ax=axs)
    im = axs.scatter(m[:,:,0], m[:,:,1], c=uu, s = 3, cmap='twilight')
    fig.savefig('hexs50.eps', format='eps')
    
    plt.show()

    
    elapsed = time.time() - ti
    print( "%5.2f" % elapsed)


    # h(u)
if __name__ == "__main__":
    one_loop(25,1,0,0,0)
    #one_loop(25,1,0,0,0.1)
    #one_loop(50,1,0,0.4,0)
    #one_loop(50,1,0,0,0.1)
    #one_loop(50,1,0,0.2,0)
    #one_loop(50,1,0,0,0.05)

