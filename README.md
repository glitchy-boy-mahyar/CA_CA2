# CA_CA2
Comp_Arch project no.2 by Mahyar Karimi & Alireza Salamat

This is Single Cycle implementation of MIPS processor with a reduced instruction set. All modules codings are completely behavioral.

## Modular Analysis

  All modules in this project can be classified into 3 categories with respect to their functionalities:
  1. __Memory__: two different modules are included, which can allow us to store instructions and data in different modules.
      <br>__NOTE__: please consider that memory modules have internal read routines and should be loaded manually before a simulation would take place. 
      you can detect these code lines by looking for `$readmemb` function instances, which are set for reading default benchmark values. 
