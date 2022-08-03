# Simulation of phase oscillators on annulus domain

## Phase Coupled oscillators
This code solve the following equation with a wave solution $u=\Omega t + \theta +f(r)$ on the annulus domain.
$$\frac{d u}{d t} = \Omega t + \int W(|x-x'|)H(u(x)-u(x')) dx' $$

$W$ is a Gaussian kernel, 
$$W(r) = exp(-r^2)$$

The coupling function $H$ is written as,
$$H(u)=\sin(u+d)-\sin d $$

Output is the relative phase (w.r.t. a fixed point on the annulus) at time $T$

## Smooth Pulse Coupled oscillators
This code solve the following equation with a wave solution $u=\theta +f(r)$ on the annulus domain.

$$\frac{d u}{d t} = 1 + \Detla(u)\int W(|x-x'|)P(u(x')) dx' $$

$W$ is a Gaussian kernel, 
$$W(r) = exp(-r^2)$$

$P(u)$ is a periodic pulse-like coupling function,
$$P(u) = \frac{1}{N(\beta)}\exp(-\beta(1-\cos u))$$
it is normalized with $N(\beta)$ such that $\int_0^{2\pi} P(u)\ d {u} = 1$. 
$$N(\beta) = 2\pi \exp(-\beta )I_0(\beta)$$

$\Delta(u)$ is the interaction,
$$\Delta(u) =\alpha(\sin d - \sin (u+d))$$


make animation of pulse-like coupling on annulus

final phase state saved in v_pul2da0.2b5d0amp1.mat 

f(r) saved in f_pul2da0.2b5d0amp1.mat 