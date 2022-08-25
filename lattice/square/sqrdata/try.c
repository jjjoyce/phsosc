//layerann calculate u(r1)-u(r0)
// N odd

#include<stdio.h> 
#include <math.h>
#include <time.h>



FILE *fout,*fw;
const double tol=0.001;
double ven0=0,vend;
char bob[256];
double m[1001][1001] = {0.0};
double mp[1001][1001] = {0.0};
double om[1001][1001] = {0.0}; // omega
double mh[1001][1001] = {0.0};
double mhd[1001][1001] = {0.0};
double m0[1001][1001] = {0.0};

const int T=200000; // not sure if I need this many 
const double dt=0.2;
double a1=1;
double b1=0.;
double a2=0.;
double b2=0.00;
double nr2=0;  //inner radius squared
//  h(u)=b1(1-cos(u))+b2(1-cos(2u))+a1sin(u)+a2sin(2u) 

void one_loop(int n,double bb1,double bb2,double rad){   
double h(double x);

const double n2=(n+1.0)/2;
const int n1=n+1;
const double n4=n2*n2;  //outer radius squared 

int i,j;

double rij,rn;
const double pi =  3.14159265359;
b1=bb1;
b2=bb2;
//change
nr2=rad-0.5; 

// initialize 
for ( i = 1; i < n+1; i++)
{
    for ( j = 1; j < n+1; j++)
    {
        rij=((i-n2)*(i-n2)+(j-n2)*(j-n2));
        if ((rij<n4) && (rij>nr2))
        {
            m[i][j]=fmod(atan2(i-n2,j-n2)+4*pi,2*pi);

        }
    }
}
    
    for ( i = 1; i < n+1; i++)
    {
        for ( j = 1; j < n+1; j++)
        {
            m0[i][j] = fmod(m[i][j]-m[1][1]+2*pi,2*pi);
        }
    }

    for ( i = 1; i < n+1; i++)
    {
        for ( j = 1; j < n+1; j++)
        {
            m[i][j] = m0[i][j];
        }
    }


    int t, ip, im, jp, jm;
    double u, upp, upm, ump, umm;


    for ( t = 1; t <= T; t++)
    {   
        for ( i = 1; i < n+1; i++ )
        {
            for ( j = 1; j < n+1; j++ )
            {
                rij = ((i-n2)*(i-n2)+(j-n2)*(j-n2));
                if ((rij<n4) & (rij>nr2))
                {
                    ip = i+1;
                    im = i-1;

                    u = m[i][j];
                    jp = j + 1;
                    jm = j - 1;
                    om[i][j]=0.0;
                    rn=(ip-n2)*(ip-n2)+(j-n2)*(j-n2);
                    if((rn<n4) && (rn>nr2) && (ip<(n+1)))
                      om[i][j]+=h(m[ip][j]-u);
                    rn=(im-n2)*(im-n2)+(j-n2)*(j-n2);
                    if((rn<n4) && (rn>nr2) && (im>0))
                      om[i][j]+=h(m[im][j]-u);
                    rn=(jp-n2)*(jp-n2)+(i-n2)*(i-n2);
                    if((rn<n4) && (rn>nr2) && (jp<(n+1)))
                      om[i][j]+=h(m[i][jp]-u);
                    rn=(jm-n2)*(jm-n2)+(i-n2)*(i-n2);
                    if((rn<n4) && (rn>nr2) && (jm>0))
                      om[i][j]+=h(m[i][jm]-u);
                    

                          mp[i][j]= m[i][j]+dt*om[i][j];
                }
            }
        
        }

        for ( i = 1; i < n+1; i++)
        {
            for ( j = 1; j < n+1; j++)
            {
                m[i][j] = mp[i][j];
            }
        }

         if ((t%10000)==0)
                     /* check for convergence */
                {
                
                  vend=m[n/2][n]-m[n/2][n/2];
                  printf("N=%d at t=%d  u=%g om=%g \n",n,t,vend,om[n/2][n/2]);

                  if(fabs(vend-ven0)<tol)
                break;
                  ven0=vend;
                  }
    
    }

    
    
    
    
    for ( i = 1; i < n+1; i++ )
        {
            for ( j = 1; j < n+1; j++ )
            {
                rij = ((i-n2)*(i-n2)+(j-n2)*(j-n2));
                if ((rij<n4) & (rij>nr2))
                {
                    mh[i][j] = m[i][j];
                    mhd[i][j] = mh[i][j]-m0[i][j];
                    /*  printf(" %d %d %g %g \n",i,j,fmod(m[i][j],2*pi), m0[i][j]); */
                }
                else
                {
                    mh[i][j] = NAN;
                    mhd[i][j] = NAN;
                }
            }
        }

//change
    double fmhd;
    if (rad==1 )
        {
            fmhd = mhd[(n+1)/2][n] - mhd[(n+1)/2][(n+1)/2+1];
        }
    
    if (rad==0)
    {
        fmhd = mhd[(n+1)/2][n] - mhd[(n+1)/2][(n+1)/2];
    }

    printf("N=%d\n", n);
    printf("b1=%f\n",b1);
    printf("b2=%f\n",b2);
    printf("rad=%f\n",rad);
    printf("%f\n",fmhd);
    printf("%f\n",om[n/2][n/2]);

    sprintf(bob,"output_sqrodd.dat");
    fout=fopen(bob,"a");
    fprintf(fout,"N=%d\n", n);
    fprintf(fout,"b1=%f\n",b1);
    fprintf(fout,"b2=%f\n",b2);
    fprintf(fout,"rad=%f\n",rad);
    //fprintf(fout,"nr2=%f\n",nr2);
    fprintf(fout,"fN=%f\n",fmhd);
    fprintf(fout,"om=%f\n",om[n/2][n/2]);
    fclose(fout);

    sprintf(bob,"f_r_%gb1_%gb2_%gN%d.dat",rad,b1,b2,n);
    fout=fopen(bob,"w");
    for(j=i;j<=n;j++)
      fprintf(fout,"%d %g\n",j-n/2+1,mhd[n/2][j]);
    fclose(fout);

    sprintf(bob,"r_%gb1_%gb2_%gN_%d.dat",rad,b1,b2,n);
     fout=fopen(bob,"w");
    for(i=1;i<=n;i++){
      for(j=1;j<=n;j++)
    fprintf(fout,"%g ",mhd[i][j]);
      fprintf(fout,"\n");
    }
    fclose(fout);  

    /*sprintf(bob,"core_r%gb1_%gb2_%gN_%d.dat",rad,b1,b2,n);
    fout=fopen(bob,"w");
    u=m[n/2][n/2];
   for(i=(n/2-2);i<=(n/2+3);i++){
      for(j=(n/2-2);j<=(n/2+3);j++)
    fprintf(fout,"%g ",fmod(mhd[i][j]-u,2*pi));
      fprintf(fout,"\n");
      }
    fclose(fout);*/
}

double h(double x){
    double hx =  a1*sin(x)+a2*sin(2*x)+b1*(cos(x)-1)+b2*(cos(2*x)-1);
    return hx;

}

int main()
{
    
    clock_t start_t, end_t;
   double total_t;

   start_t = clock();
   printf("Starting of the program, start_t = %ld\n", start_t);

  one_loop(51,0,0.0,0);  
//one_loop(5,.4,0.0,0);
  
  //one_loop(201,.4,0.0,0);
  //one_loop(201,0.0,0.1,0);
  //one_loop(201,.4,0.0,1);
  //one_loop(201,0.0,0.1,1);
//one_loop(201,.3,0.0,0);
  //one_loop(201,0.4,0,1);

  /*one_loop(201,.2,0,0);
  one_loop(201,0.2,0,1);

  one_loop(201,0,0.05,0);
  one_loop(201,0,0.05,1);
  
   one_loop(401,.4,0,0);
   one_loop(401,.4,0,1);
   one_loop(401,0,0.1,0);
    one_loop(401,0,0.1,1);*/


 /* one_loop(800,.2,0.0);
  one_loop(800,.4,0.0);
  one_loop(800,0.0,0.05);
  one_loop(800,0.0,0.1);
  */
  
  /*  one_loop(100,.2,0.0);
      one_loop(200,.2,0.0); */


         end_t = clock();
   printf("End of the program end_t = %ld\n", end_t);
   
   total_t = (double)(end_t - start_t) / CLOCKS_PER_SEC;
   printf("Total time taken by CPU: %f\n", total_t  );
   printf("Exiting of the program...\n");
  
    return 0;



}
