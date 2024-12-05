// Defines the function that lifts the homomorphism f: Z^8 -> A to a homomorphism Z^10 -> G + Z
function LiftHomomorphism(GA_Homomorphism, f)
    // Extract the target group A and the domain G from the first homomorphism
    G := Domain(GA_Homomorphism);
    A := Codomain(GA_Homomorphism);
    
    // Define the vector spaces Z^8 and Z^9 as free groups
    Z8 := Domain(f); 
    Z9 := RSpace(BaseRing(Z8), 9);
    K := Z9![1, 2, 3, 0, 9, 6, 3, 4, 2]; // Canonical divisor in Z9
    
    // Define the homomorphism Z^9 -> Z^8 that projects onto the first 8 components
    phi := hom<Z9 -> Z8 | [Z8.i : i in [1..8]] cat [Z8!0]>;
    
    // Define f_phi as a lambda function that accepts elements of Z^9
    f_phi := func<x | f(phi(x))>;
    
    // Build the lifting: for each generator of Z^9, choose an arbitrary preimage in G
    images := [];
    KernelGen := Kernel(GA_Homomorphism).1; // Generator of the kernel of GA_Homomorphism
    
    // Arbitrary preimages for i from 2 to 9
    for i in [2..9] do
        elem := f_phi(Z9.i);
        preimage := IsCoercible(G, elem @@ GA_Homomorphism) select elem @@ GA_Homomorphism else G!0;
        Append(~images, preimage);
    end for;
    
    // Compute the image of the first generator using K and the remaining generators
    coeffs := [-2, -3, 0, -9, -6, -3, -4, -2];
    images := [KernelGen + &+[coeffs[i] * images[i] : i in [1..#coeffs]]] cat images;

    // Define the lifted homomorphism using the constructed list
    LiftedHom := hom<Z9 -> G | images>;

    Z10 := RSpace(Integers(), 10);
    H := Z10.1;
    E := [Z10.i : i in [2..10]];
    GG := DirectSum(G, RSpace(Integers(), 1));
    gg := hom<Z10 -> GG | [GG.3] cat [GG!(Eltseq(LiftedHom(b)) cat [0]) : b in Basis(Z9)]>;
    lis := [E[i] - E[i+1] : i in [8,7,6,5,4,3]] cat [H - E[1] - E[2] - E[3], E[2] - E[3], E[1] - E[2]];
    M := Matrix([E[1]] cat lis);
    h := hom<Z10 -> Z10 | M^(-1)>;
    LiftedHom := hom<Z10 -> GG | [(h * gg)(b) : b in Basis(Z10)]>;

    K := Z10![-3, 1, 1, 1, 1, 1, 1, 1, 1, 1]; // Canonical divisor in Z10
    
    return LiftedHom, sub<GG | LiftedHom(K)>;
end function;

// Define the groups G and A
G := RSpace(Integers(), [2, 4]); // G = Z/2 x Z/4
A := RSpace(Integers(), [2, 2]); // A = Z/2 x Z/2

// Define the homomorphism GA_Homomorphism: G -> A
// Projection of the second component of G modulo 2
GA_Homomorphism := hom<G -> A | [A.1, A.2]>;

// Define the space Z^8 and the homomorphism f: Z^8 -> A
Z8 := RSpace(Integers(), 8);
f := hom<Z8 -> A | [A.1, A.2, A.1, A.2, A.1, A.2, A.1, A.2]>; // Alternates the generators of A

// Call the LiftHomomorphism function to obtain the lifted homomorphism Z^10 -> G + Z
LiftedHom := LiftHomomorphism(GA_Homomorphism, f);

// Print the lifted homomorphism
Pic := Domain(LiftedHom);
K := Pic![-3, 1, 1, 1, 1, 1, 1, 1, 1, 1];
[LiftedHom(b) : b in Basis(Pic)];

// Compute the Weyl group of E_8
S10 := Sym(10);
gens := [PermutationMatrix(Integers(), S10!(i, i+1)) : i in [2..8]] 
         cat [DiagonalJoin(Matrix([[2, -1, -1, -1], 
                                    [1,  0, -1, -1], 
                                    [1, -1,  0, -1], 
                                    [1, -1, -1,  0]]),
              IdentityMatrix(Integers(), 6))];
W := MatrixGroup<10, Integers() | gens>;

// Define an initial vector of norm -2
v := Vector([0, 1, -1, 0, 0, 0, 0, 0, 0, 0]);

// Generate all (-2)-classes of E_8 via the Weyl group
S := v^W;
