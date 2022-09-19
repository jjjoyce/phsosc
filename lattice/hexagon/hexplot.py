import numpy as np
import math
import os
import matplotlib.pyplot as plt



def for_plot(n: int, a1: float, a2: float, b1:float, b2:float):


    def h(x: float):
        hu =  a1*np.sin(x)+a2*np.sin(2*x)+b1*(np.cos(x)-1)+b2*(np.cos(2*x)-1)
        return hu

    sqr33 = np.sqrt(3)/3

    nr2 = n*n-1
    m = np.zeros((2*n+1,2*n+1,3),dtype='float32') # (x,y,z) z=0 up (connect to i+1)
    u = np.zeros((2*n+1,2*n+1),dtype='float32') # phase 
    uu = np.zeros((2*n+1,2*n+1),dtype='float32') # phase 

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

    onepi=np.pi
    twopi=np.pi*2
    # read data
    filename='_tri_'+'n_'+str(n)+'b1_'+str(b1)+'b2_'+str(b2)+'_'+'u'+'.dat'
    u = np.loadtxt(filename, unpack = True)
    u = u.transpose()
    u = np.fliplr(u)
    u = u%twopi

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

    im = axs.scatter(m[:,:,0], m[:,:,1], c=u, s = 2, cmap='hsv')
    fig.colorbar(im, ax=axs)
    im = axs.scatter(m[:,:,0], m[:,:,1], c=uu, s = 2, cmap='twilight')
    fig.savefig('hexs50s.eps', format='eps')
    
    plt.show()



    # h(u)
if __name__ == "__main__":
    for_plot(50,1,0,0.4,0)
    #one_loop(25,1,0,0,0.1)
    #one_loop(50,1,0,0.4,0)
    #one_loop(50,1,0,0,0.1)
    #one_loop(50,1,0,0.2,0)
    #one_loop(50,1,0,0,0.05)

