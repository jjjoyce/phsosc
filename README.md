# Simulation of phase oscillators on annulus domain

## Phase Coupled oscillators
This code solve the following equation with a wave solution $u=\Omega t + \theta +f(r)$, where $(\theta,r)$ is the location on the annulus domain.
$$\frac{d u}{d t} = \Omega t + \int W(|x-x'|)H(u(x)-u(x')) dx' $$

$W$ is a Gaussian kernel, 

The coupling function $H$ is written as,
$$H(u)=\sin(u+d)-\sin d $$

$$W(r) = exp(-r^2)$$

## Smooth Pulse Coupled oscillators
This code solve the following equation with a wave solution $u=\theta +f(r)$, where $(\theta,r)$ is the location on the annulus domain.

$$\frac{d u}{d t} = 1 + P(u)\int W(|x-x'|)H(u(x)-u(x')) dx' $$