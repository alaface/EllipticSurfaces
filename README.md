# Library for Elliptic surfaces

## Commands in the Library

### 1. **LiftHomomorphism(GA_Homomorphism, f)**
- **Purpose**: Lifts a homomorphism $f: \mathbb{Z}^8 \to A$ to a homomorphism $\mathbb{Z}^{10} \to G + \mathbb{Z}$.
- **Inputs**:
  - `GA_Homomorphism`: A homomorphism from $G$ to $A$.
  - `f`: A homomorphism from $\mathbb{Z}^8$ to $A$.
- **Outputs**:
  - `LiftedHom`: A homomorphism from $\mathbb{Z}^{10}$ to $G + \mathbb{Z}$.
  - `Subgroup`: A subgroup of the codomain of `LiftedHom`.

### 2. **qua(a, b)**
- **Purpose**: Computes a quadratic form value for two lattice elements.
- **Inputs**:
  - `a, b`: Elements of a lattice represented as vectors.
- **Output**:
  - The value of the quadratic form.

### 3. **FindComp(f)**
- **Purpose**: Finds all the (-2)-curves of a surface.
- **Inputs**:
  - `f`: A homomorphism from a Picard lattice to a group.
- **Outputs**:
  - `Q`: All the (-2)-curves of the surface.
  - `CartanName`: The Cartan type of the lattice.

### 4. **FindSections(cur, m)**
- **Purpose**: Finds all the (-1)-curves of a surface.
- **Inputs**:
  - `cur`: A set of roots.
  - `m`: A scalar value.
- **Output**:
  - A set of (-1)-curves of the surface.

## Example of Liftings with Fibration D~8

### Comments for the Example
This example demonstrates how to use the library:
1. Define the groups $G$ and $A$. Here, $G$ is a rank-4 lattice, and $A$ is a rank-2 lattice.
2. Define the homomorphism `GA_Homomorphism: G -> A`, which projects the second component of $G$ modulo 2.
3. Define the space $\mathbb{Z}^8$ and the homomorphism `f: \mathbb{Z}^8 -> A`. The homomorphism `f` maps the fourth generator of $\mathbb{Z}^8$ to $A.1$.
4. Call the `LiftHomomorphism` function to obtain the lifted homomorphism $\mathbb{Z}^{10} \to G + \mathbb{Z}$.
5. Use the lifted homomorphism to find the (-2)-curves of the surface.
6. Finally, find the (-1)-curves of the surface.

### Magma Session Example
```magma
// Define the groups G and A
G := RSpace(Integers(), [4]);
A := RSpace(Integers(), [2]);

// Define the homomorphism GA_Homomorphism: G -> A
GA_Homomorphism := hom<G -> A | [A.1]>;

// Define the space Z^8 and the homomorphism f: Z^8 -> A
Z8 := RSpace(Integers(), 8);
f := hom<Z8 -> A | [u*A.1 : u in [0, 0, 0, 1, 0, 0, 0, 0]]>;

// Call the LiftHomomorphism function to obtain the lifted homomorphism Z^10 -> G + Z
LiftedHom := LiftHomomorphism(GA_Homomorphism, f);

// Find the (-2)-curves of the surface using the lifted homomorphism
cur := FindComp(LiftedHom);

// Find the (-1)-curves of the surface
FindSections(cur, 2);
```

