# Intro to Julia for Dynamical Systems and Scientific Machine Learning
Codes used for a 1 hour overview of Julia for Dynamical Systems and Scientific Machine Learning, given at the Dynamical Systems Reading Group of Mila.

Before starting, please install Julia and Atom+Juno, following [this instructions](http://docs.junolab.org/stable/man/installation/).


### Credit
Some of the material of this talk was created by the author (Germán Abrevaya). However significant content comes from the following sources:

* [George Datseris' workshop](https://github.com/Datseris/Zero2Hero-JuliaWorkshop)
* [Jesse Bettencourt's intro-tutorial](https://github.com/ProbMLCourse/intro-tutorial)
* [Aurelio Amerio's From zero to Julia!](https://techytok.com/from-zero-to-julia/)
* [Julius Martensen's DataDrivenDiffEq.jl documentation](https://datadriven.sciml.ai/)
* [Chris Rackauckas' DiffEqFlux.jl documentation](https://diffeqflux.sciml.ai/)
* [Universal Diffrential Equations paper's codes](https://github.com/ChrisRackauckas/universal_differential_equations)






The following is written by George Datseris.

## What is Julia?

[Julia](https://julialang.org/) is a relatively new programming language, developed at MIT, with version 1.0 released in August 2018. Even though it is so recent, it has taken the scientific community by storm and many serious large scale projects have started using Julia.

The following **facts** about Julia justify why so many scientists are willing to learn a new language:

- [Performance as good as C/Fortran](https://julialang.org/benchmarks/)
- Dynamic, interactive language like Python or Matlab
- Intuitive, expressive and high-level syntax
- General purpose as well as scientific computing
- Multiple dispatch
- Interoperability and "free" extension-ability of Julia packages
- Able to call C, Fortran, Python, etc... without boilerplate
- Free and open source
- Thriving ecosystem

## Why should I learn Julia?

*(in the author's personal opinion, which targets an audience of scientists)*

- It solves the two language problem: allows interactive exploration of your system with high performance.
- It offers a syntax that is intuitive and easy to read. Your own code does not differ much from Julia's base code.
- Unicode makes math expressions in code feel natural and allows you to use symbols from your native language as well!
- Integrated package manager (and super good as well), and everything runs everywhere: no `makefile` nonsence, no spending weeks figuring out how to install things, no worries whether your program will be able to run on Windows.
- Multiple dispatch and functional programming are [most suitable paradigm to implement scientific thought in code](https://www.youtube.com/watch?v=7y-ahkUsIrY).
- Its so darn easy to extend other's people code and then for other people to extend your code!
- A lot of code re-use leads to rapid development and more features than would be possible with other languages.
- The astonishing and cutting edge Julia package ecosystem.
- Many programming laguanges (e.g. Python, C) are directly callable from Julia without boilerplate. Which means, if you have a good code base in Python or C, you don't have to re-write it!
- Julia has a [scientific project assistant software](https://github.com/JuliaDynamics/DrWatson.jl).
