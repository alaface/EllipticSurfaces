# Lift Homomorphisms

This repository contains a Magma implementation of the `LiftHomomorphism` function, designed to lift a homomorphism $f: \mathbb{Z}^8 \to A$ to a homomorphism $\mathbb{Z}^{10} \to G \oplus \mathbb{Z}$, where $G$ and $A$ are finite abelian groups.

## Description

The `LiftHomomorphism` function performs the following tasks:
1. Lifts a homomorphism $f: \mathbb{Z}^8 \to A$ to a homomorphism $\mathbb{Z}^9 \to G$.
2. Constructs a homomorphism $\mathbb{Z}^{10} \to G \oplus \mathbb{Z}$, where $G$ is the domain of a given homomorphism $G \to A$, and $\mathbb{Z}$ is added to the codomain.

The lifting process is guided by a canonical divisor and coefficients that are combined to define the image of generators.

## Requirements

To run this program, you need the [Magma computational algebra system](https://magma.maths.usyd.edu.au/magma/).

## Usage

Here is an example of how to use the `LiftHomomorphism` function:

### Code Example

```magma
// Define the groups G and A
G := RSpace(Integers(), [2, 4]); // G = Z/2 x Z/4
A := RSpace(Integers(), [2, 2]); // A = Z/2 x Z/2

// Define the homomorphism GA_Homomorphism: G -> A
GA_Homomorphism := hom<G -> A | [A.1, A.2]>;

// Define the space Z^8 and the homomorphism f: Z^8 -> A
Z8 := RSpace(Integers(), 8);
f := hom<Z8 -> A | [A.1, A.2, A.1, A.2, A.1, A.2, A.1, A.2]>;

// Call the function
LiftedHom, Subgroup := LiftHomomorphism(GA_Homomorphism, f);

// Output the result
Pic := Domain(LiftedHom);
K := Pic![-3, 1, 1, 1, 1, 1, 1, 1, 1, 1];
[LiftedHom(b) : b in Basis(Pic)];
