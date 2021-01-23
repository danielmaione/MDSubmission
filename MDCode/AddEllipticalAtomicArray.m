%based on other code given in the 4700 code file
function AddEllipticalAtomicArray(radA,radB,X0,Y0,VX0,VY0,InitDist,Temp,Type)
global C
global x y AtomSpacing
global nAtoms
global AtomType Vx Vy Mass0 Mass1

if Type == 0
    Mass = Mass0;
else
    Mass = Mass1;
end

%Equations in order to get the length and width of the array
L = (2*radA - 1) * AtomSpacing;
W = (2*radB - 1) * AtomSpacing;

%In order to create an array filled with atoms the following is done
xp(1, :) = linspace(-L/2, L/2, 2*radA);
yp(1, :) = linspace(-W/2, W/2, 2*radB);


NumberOfAtoms = 0;
for i = 1:2*radA
    for j = 1:2*radB
        %The Equation for an elipse is (x-h)^2/a^2 +(y-k)^2/b^2 shown below
        if ((xp(i))^2)/((radA*AtomSpacing)^2) + ((yp(j))^2)/((radB*AtomSpacing)^2) <= 1
            NumberOfAtoms = NumberOfAtoms+1;
            x(nAtoms + NumberOfAtoms) = xp(i);
            y(nAtoms  + NumberOfAtoms) = yp(j);
        else
            i
            j
        end
    end
end

%based on previously given code in the 4700 file
x(nAtoms + 1:nAtoms + NumberOfAtoms) = x(nAtoms + 1:nAtoms + NumberOfAtoms) + ...
    (rand(1, NumberOfAtoms) - 0.5) * AtomSpacing * InitDist + X0;
y(nAtoms + 1:nAtoms + NumberOfAtoms) = y(nAtoms + 1:nAtoms + NumberOfAtoms) + ...
    (rand(1, NumberOfAtoms) - 0.5) * AtomSpacing * InitDist + Y0;

AtomType(nAtoms + 1:nAtoms + NumberOfAtoms) = Type;

if Temp == 0
    Vx(nAtoms + 1:nAtoms + NumberOfAtoms) = 0;
    Vy(nAtoms + 1:nAtoms + NumberOfAtoms) = 0;
else
    std0 = sqrt(C.kb * Temp / Mass);

    Vx(nAtoms + 1:nAtoms + NumberOfAtoms) = std0 * randn(1, NumberOfAtoms);
    Vy(nAtoms + 1:nAtoms + NumberOfAtoms) = std0 * randn(1, NumberOfAtoms);
end

Vx(nAtoms + 1:nAtoms + NumberOfAtoms) = Vx(nAtoms + 1:nAtoms + NumberOfAtoms) - ...
    mean(Vx(nAtoms + 1:nAtoms + NumberOfAtoms)) + VX0;
Vy(nAtoms + 1:nAtoms + NumberOfAtoms) = Vy(nAtoms + 1:nAtoms + NumberOfAtoms) - ...
    mean(Vy(nAtoms + 1:nAtoms + NumberOfAtoms)) + VY0;

nAtoms = nAtoms + NumberOfAtoms;

end

