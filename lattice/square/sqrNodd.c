#include<stdio.h>
#include<math.h>

const int T=200000; // not sure if I need this many 
const double dt=0.2;

double a1=1;
double b1=0.4;
double a2=0.;
double b2=0.0;

FILE *fout,*fw;
char bob[256];
double u[1001][1001] = {0.0};
double u0[1001][1001] = {0.0};
double up[1001][1001] = {0.0};
double uh[1001][1001] = {0.0};
double uhd[1001][1001] = {0.0};
double om[1001][1001] = {0.0};

const double tol=0.001;
double ven0=0,vend;


double h(double x){
    double hx =  a1*sin(x)+a2*sin(2*x)+b1*(cos(x)-1)+b2*(cos(2*x)-1);
    return hx;
}

// N=2n+1
void one_loop(int n, double bb1, double bb2, double nr2){

    double h(double x);
    
    const int n2=2*n+1;
    const int n1=n+1;
    const int n4=n*n;
    const int n3=n1+(sqrt(nr2)+1); // grid of r0
    

    int i,j;

    double rij,rn;
    const double pi =  3.14159265359;
    b1=bb1;
    b2=bb2;



    // initialize u = theta
    for ( i = 1; i <= n2; i++)
    {
        for ( j = 1; j <= n2; j++)
        {
            rij=((i-n1)*(i-n1)+(j-n1)*(j-n1));
            if ((rij<=n4) && (rij>=nr2))
            {
                u[i][j]=fmod(atan2(i-n1,j-n1)+4*pi,2*pi);
            }
        }
    }

    for ( i = 1; i <= n2; i++)
    {
        for ( j = 1; j <= n2; j++)
        {
            u0[i][j] = fmod(u[i][j]-u[n1][n1]+2*pi,2*pi);
        }
    }

    for ( i = 1; i <= n2; i++)
    {
        for ( j = 1; j <= n2; j++)
        {
            u[i][j] = u0[i][j];
        }
    }

    // ode
    int t, ip, im, jp, jm;
    double uij, upp, upm, ump, umm;

    for ( t = 1; t <= T; t++)
    {   
        for ( i = 1; i <= n2; i++ )
        {
            for ( j = 1; j <= n2; j++ )
            {
                rij = ((i-n1)*(i-n1)+(j-n1)*(j-n1));
                if ((rij<=n4) && (rij>=nr2))
                {
                    uij = u[i][j];
                    ip = i + 1;
                    im = i - 1;
                    jp = j + 1;
                    jm = j - 1;

                    om[i][j]=0.0;
                    rn=(ip-n1)*(ip-n1)+(j-n1)*(j-n1);
                    if((rn<=n4) && (rn>=nr2) && (ip<=n2))
                      om[i][j]+=h(u[ip][j]-uij);
                    rn=(im-n1)*(im-n1)+(j-n1)*(j-n1);
                    if((rn<=n4) && (rn>=nr2) && (im>0))
                      om[i][j]+=h(u[im][j]-uij);
                    rn=(jp-n1)*(jp-n1)+(i-n1)*(i-n1);
                    if((rn<=n4) && (rn>=nr2) && (jp<=n2))
                      om[i][j]+=h(u[i][jp]-uij);
                    rn=(jm-n1)*(jm-n1)+(i-n1)*(i-n1);
                    if((rn<=n4) && (rn>=nr2) && (jm>0))
                      om[i][j]+=h(u[i][jm]-uij);
                    
                    up[i][j]= uij+dt*om[i][j];
                }
            }
        }

        for ( i = 1; i <= n2; i++)
        {
            for ( j = 1; j <= n2; j++)
            {
                u[i][j] = up[i][j];
            }
        } 

        /* check for convergence */
        if ((t%10000)==0)  
        {
            vend=u[n1][n2]-u[n1][n3];
            printf("N=%d at t=%d  u=%g om=%g \n",n,t,vend,om[n1/2][n1/2]);
            if(fabs(vend-ven0)<tol)
                break;
            ven0=vend;
        }

    }

    // uh cut off the hole, subtituted by NAN
    // uhd = u-u0

    for ( i = 1; i <= n2; i++ )
        {
            for ( j = 1; j <= n2; j++ )
            {
                rij = ((i-n1)*(i-n1)+(j-n1)*(j-n1));
                if ((rij<=n4) && (rij>=nr2))
                {
                    uh[i][j] = u[i][j];
                    uhd[i][j] = uh[i][j]-u0[i][j];
                    /*  printf(" %d %d %g %g \n",i,j,fmod(m[i][j],2*pi), m0[i][j]); */
                }
                else
                {
                    uh[i][j] = NAN;
                    uhd[i][j] = NAN;
                }
            }
        }

    // from f(r0) to f(1), 3:00 direction
    double fr = uhd[n1][n2]-uhd[n1][n3];
    sprintf(bob,"f_r_b1_%gb2_%gn_%dnr2_%g.dat",b1,b2,n,nr2);
    fout=fopen(bob,"w");
    for(j=n3;j<=n2;j++)
      fprintf(fout,"%d %g\n",j-n1,uhd[n1][j]);
    fclose(fout);

    printf("N=%d\n", n);
    printf("b1=%f, b2=%f\n",b1,b2);
    printf("nr2=%f\n",nr2);
    printf("om=%f\n",om[n1/2][n1/2]);
    printf("fr=%f\n",fr);

    sprintf(bob,"output_sqrNodd_n_%d.dat",n);
    fout=fopen(bob,"a");
    fprintf(fout,"N=%d\n", n);
    fprintf(fout,"b1=%f\n",b1);
    fprintf(fout,"b2=%f\n",b2);
    fprintf(fout,"nr2=%f\n",nr2);
    fprintf(fout,"om=%f\n",om[n1/2][n1/2]);
    fprintf(fout,"fr=%f\n",fr);
    fclose(fout);

    sprintf(bob,"uh_b1_%gb2_%gn_%dnr2_%g.dat",b1,b2,n,nr2);
     fout=fopen(bob,"w");
    for(i=1;i<=n2;i++){
      for(j=1;j<=n2;j++)
    fprintf(fout,"%g ",uh[i][j]);
      fprintf(fout,"\n");
    }

    sprintf(bob,"uhd_b1_%gb2_%gn_%dnr2_%g.dat",b1,b2,n,nr2);
     fout=fopen(bob,"w");
    for(i=1;i<=n2;i++){
      for(j=1;j<=n2;j++)
    fprintf(fout,"%g ",uhd[i][j]);
      fprintf(fout,"\n");
    }
    fclose(fout);  

}

int main()
{
    
    /*one_loop(50,0.4,0.0,11);
    one_loop(50,0.4,0.0,13);
    one_loop(50,0.4,0.0,15);
    one_loop(50,0.4,0.0,17);*/

  one_loop(200,0.0,0.0,0);  
  one_loop(200,0.4,0.0,0);  
  one_loop(200,0.4,0.0,1);  
  one_loop(200,0.4,0.0,2); 
  one_loop(200,0.4,0.0,3);  
  one_loop(200,0.4,0.0,4);  
    /*one_loop(100,0.4,0.0,3);
    one_loop(100,0.4,0.0,5);
    one_loop(100,0.4,0.0,9);*/

  /* 
  one_loop(100,0.4,0.0,0);  
  one_loop(100,0.4,0.0,1);  
  one_loop(100,0.4,0.0,2);  
  one_loop(100,0.4,0.0,4);  */


    return 0;

}