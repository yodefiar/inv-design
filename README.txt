Hi

I am currently trying to develop an inverse design optimization method by utilizing MATLAB's build-in tool Genetic Algorithm. 
The objective is to achieve an optimized airfoil geometry with desired pressure distribution profile using PARSEC airfoil parameterization.
The desired profile is a laminar flow over the upper-front part of the airfoil, with as small (favorable) pressure gradient as possible, 
similar to the baseline NLF(1)-0414F in a particular flight condition. The GA is used to minimize the error of a pressure distribution calculated 
by XFOIL compared to a given target. 

My inverse optimization algorithm (EnhancedInv.m) seems to be working as after 5000 iterations the function returned a PARSEC coordinates that 
generated a presssure distribution profile with error under 3%. The problem is even when the values of Cp and XCp from the XFOIL came out just fine, 
somehow for the same coordinates XFOIL failed to generate other outputs such as Cl, Cd, Cm, etc (they either came out empty cell or a NaN), 
as you will see with my last coordinates I obtained from GA included in the main file (last line).  

Disclaimer: I am writing these codes for my final project in uni and I have no intention to commercialize any parts of it. The XFOIL interface for MATLAB 
and the PARSEC solver are not originally mine but both are distributed under open license in MathWorks' File Exchange forum. I modified both functions 
mildly to fit my needs. I also tried to upload the XFOIL solver needed to run its MATLAB interface in this folder but GitHub wouldn't allow me due to size 
issues, so I attached the ZIP file instead.

Thank you so much for taking a look at my case, your help is truly appreciated. Should you have any questions or other inquiries feel free to 
contact me directly here or through my email yodefiar@hotmail.com 