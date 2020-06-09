# Welcome to Julia!
# Assuming you have Atom + Juno, you should have a pane below called REPL
# (Read, Eval, Print, Loop) which lets you execute julia code.
# Click it and Press Enter to start Julia!
# After a bit of time you should see the Julia logo and the Julia prompt
# julia>
# If not, you will need to troubleshoot your installation

### Evaluation Basics

# Let's evaluate some code.
# There are a few ways to do this:
# 1. You could do this by copying and pasting into the REPL pane
# 2. You can also do this by evaluating the entire file from command-line
# if you added julia to your $PATH then `julia path/to/file.jl` will run
# all the code in the file. However, unlike python workflow, this is not the
# reccomended way to develop Julia code quickly.
# 3. The reccommended way is (in Atom) to type Shift+Enter on the lines
# you want to evaluate
print("Hello Dynamical Systems Reading Group!")

# We can evaluate some math
x = 1+2+3
# which will display inline in the editor, but not the REPL.

# If we want to supress the output in the editor we can use ;
y = x ^ 2.5;

# And if we do want to have the evaluation output
print(x += 2)
# or the @show macro will also include what's evaluated and no parenthesis
@show x*y

δ = "αbasf" # type \delta and then press TAB
😺, 😀, 😞 = 1, 0, -1 # do e.g. \:smile: <TAB>
😺 + 😞 == 😀

🌹= 12
typeof(😺)
typeof(1.5)
typeof("asdf")

### Arrays

# Create a 1D column vector:
x_col = [1, 2, 3] # or [1; 2; 3]
@show size(x_col)

# Create a row vector:
x_row = [1 2 3]
@show size(x_row)

# Transpose with the ' syntax
x_t = x_row'
@show size(x_t)

# Ranges are useful shorthand notations that define
# a "vector" (one dimensional array)
x_lin = 1:0.5:100
range(1, 100, step = 0.5)
range(1, 100, length = 35)

typeof(x_lin)
# this is a lazy array constructor that should act like an array in most cases!
# however, you can always make it an explicit array
collect(x_lin)

# List comprenhensions are also very useful (the if part is optional)
[a^2 for a in 1:10 if iseven(a)]

# Matrices can be constructed explicitly
# Spaces for columns and ; for rows
A = [1 2 3; 4 5 6; 7 8 9]

# or alternatively
A = [1 2 3
     4 5 6
     7 8 9]

# More often we'll want to create matrices (and vectors)
# with special elements. This is convenient:
zeros(200,300)
ones(4,3)

# Random Arrays
# sampled from uniform
rand(2,2)
# sampled from unit Normal
randn(2,2)

# Other structured matrices can be found in the LinearAlgebra.jl package
# which is included in the standard library of Julia.
# So we can use it by
using LinearAlgebra

# It has the Identity Matrix
I
# Notice that it has no dimension, will assume the dimensions of its neighbours
I*A == A

# Diagonal Matrices can be specified by their diagonal vector entries
# These are stored efficiently in memory, and can use faster algorithms
Diagonal([4,1,4])

# Indexing into Arrays
# Arrays are represented in memory as a single vector, which you can acess like
A[:]
# ith row use A[i,:]
A[1, :]
# jth column use A[:,j]
A[:,1]
# So the i,jth element A[i,j]
A[2,1]
# Note! Unlike Python, Julia is 1-based index
# So the first element is [1] and the last element is length of the dimension
v = [1, 2, 3]
v[1]
v[3]
v[end]
v[-1]
v[0]
v[2:-1:1]

# Common operations on Arrays

# We saw transpose (actually this is complex conjugate transpose)
A'

# Concatenate horizontally
hcat(v,v)
# or
[a a]

# Concatenate vertically
vcat(v,v)
# or
[v; v]

B = 1:24 |> collect
# x |> f is a fancy syntax for f(x)

# Reshape the array
B_re = reshape(B,3,4,2)
B_re = reshape(B,3,4,:)

B_vec = vec(B_re)

B_vec[3] = 999
B
B_re

# It is also possible access arrays by slicing
C = B_re[1:2, 2:4, 2]
C[1,1] = 888

# We can also create views instead of making a copy
D = view(B_re, 1:2, 2:4, 2)
fill!(D, 0)
B_re

# An alteranive way, using macros
D = @view B_re[1:2, 2:4, 2]

# Functions on Arrays
# Another important convention in Julia is that elementwise functions
# won't automatically apply elementwise
sin(B)

# this would work in Python, so it's a big gotcha!
# To apply elementwise, you must use broadcast
broadcast(sin,B)
# this has a very nice sytnax, .
sin.(B)
D[:] .= 1

# Often you'll want to apply functions along columns, rows, or higher dimensions
# Some functions will have this built-in
sum(A, dims=1)
sum(A, dims=2)
# You can do this with broadcasting and general functions too!
# lazy iterator that gives each row of A
eachrow(A)
sum.(eachrow(A))
sum.(eachcol(A))
# Notice that this resulted in different dimensions than sum with dims
eachslice(A,dims=1) # for arrays of more than 2 dimensions

# Assessing your code performance is easy in Julia
# for instance, should we broadcast sum over eachrow or sum with dims keword?
# We can use the BenchmarkTools.@btime macro to find out!
using BenchmarkTools
# uh oh... we don't have that package installed!


### Package manager

# We can access the package manager by typing ] into the REPL
# From here we can ] add PackageName to get the package.
# However! let's do even better.
# To share code (like very this one!), it is very helpful to know
# exactly what packages and verisons everyone is using
# (including old versions of your own code!)
# Inside the project directory type
#] activate .
# This will create a new environment, you should see
# (Julia-for-DS-and-SciML) pkg>
# This is the package prompt for our new environment
# You can see what packages are installed by
# pkg> status
# Now let's add packages!
# ] add BenchmarkTools
# By the way, pressing ; into the REPL we can access
# the system shell

using BenchmarkTools

A_big = randn(1000,1000)
@btime sum.(eachrow(A_big));
@btime sum(A_big, dims=2);
# For performance sensitive code this can be helpful to make sure things are fast!

# More array operations
x = rand(1,5)
A = rand(5,6)

# Matrix multiplication
x * A
# with useful error messages
A * x

# Elementwise-multiplication
[1 2 3] * ones(3)
[1 2 3] .* ones(3)

# Elementwise-power
[1 2 3].^2
[1 2 3]^2 # gives error!

# Dot product (from LinearAlgebra.jl)
dot(x,x)
# or \cdot + [tab] -> ⋅
x ⋅ x

# Determinants of square matrices
det(rand(5,5))
# Euclidian Norm
norm(rand(5,5))

### Functions

# there are a few ways to define functions
# in a block, this is most common
function f(x)
    return x^2     # return word is not necessary
end                # by default, the last executed expression is returned

# inline, very nice for quick math!
f(x) = x^2   # equivalent to above

# anonymous, very nice for temporary functions
h = x -> x^2

f(5)

# Functions in Julia support optional positional arguments, as  well as
# keyword arguments. The positional arguments are always given by their order,
# while keyword arguments are always given by their keyword. Keyword arguments
# are all the arguments defined in a function after the symbol ;. Example:

g(x, y = 5; z = 2) = x*z*y
g(5)                # give x. default y, z
g(5, 3)             # give x, y. default z
g(5, z = 3)         # give x, z. default y
g(2, 4, z = 1.5)    # give everything
g(2, 4, 2)          # keyword arguments can't be specified by position


### Control Flow

# if...else blocks
function absolute(x)
    if x ≥ 0
        return x
    else
        return -x
    end
end

# You can have multiple elseif
x = 42
if x<1
    print("$x < 1")
elseif x < 3
    print("$x < 3")
elseif x < 100
    print("$x < 100")
else
    print("$x is really big!")
end
# also you saw some string interpolation

# and -> &
if 1 < 3 & 3 < 4
    print("eureka!")
end

# or -> ||
2==2 || 1>3


# Ternary operator: a short version of if...else
NeurIPS_deadline_extension_resulted_in_good_news = true
NeurIPS_deadline_extension_resulted_in_good_news ? print("😃") : print("😕")


# Basic loops syntax
for i in 0:10       # it also works with
    println(i)      #  '=' instead of 'in'
end

# or loop over elements in an array or tuple
# \in + tab = ∈
for i ∈ [1,2,3,4,5]
    if i ≈ 2.99999999
        break
    else
        println(f(i))
    end
end


N = 1:100
for n in N
    isodd(n) && continue
    println(n)
    n > 10 && break
end

x = ["a","b","c"]
for (i,val) ∈ enumerate(x)
    println("i = $i, val = $val")
end

# eachindex create an iterable object for visiting each index
# of an Array in an efficient manner
A = reshape(1:24, 2,3,4)
for i ∈ eachindex(A)
    println(A[i])
end

### Copy of variables

# x == y checks if two expressions have te same value
# x === y or x ≡ y (\equiv) goes beyond that and checks if they are
# identical, in the sense that no program could distinguish them

a = [1, 2, 3]; b = [1, 2, 3];
a == b
a ≡ b
a ≡ a

# Note that if we create a new variable from another one like this
c = a
# (similar to python but opposite to matlab)
# it only creates a copy by reference, so 'a' and 'b' refers to the same object
c ≡ a
c[1] = 999
a

# use copy for creating a shallow copy (outer structure is copied)
d = copy(a)
d ≡ a

# however if the type of a field of the copied object is mutable,
# then it will be copied by reference
e = [a,3,4]
e_copy = copy(e)
e_copy[1] ≡ e[1]

# use deepcopy to copy everything recursively,
# resulting in a fully independent object
e_deepcopy = deepcopy(e)
e_deepcopy[1] ≡ e[1]

### Plotting

using Plots
# it will take some time to compile the package the first time
# There are also other many other plotting packages
# like Makie, Gadify, PyPlot

# There's a few ways to plot a function y = f(x)
# 1. make the ys by calling f on the xs
xs = 0:0.01:20
f(x) = sin.(x)
ys = f(xs)
# then plot
plot(xs, ys)
# look in the Plots pane of Atom
# plots are only useful if they're readable!
plot(xs, ys,
    label = "sin",
    xlabel="x",
    ylabel="y",
    title="Awesome Trig Function")

# If we want to add new stuff to the existing plot we can use `plot!
# ! is a convention that means "mutates"
plot!(xs, cos.(xs), label="cos")

# 2. You can use the function directly
plot(xs, f)
plot([sin,cos], 0, 2π)

# There are many other kinds of plots
# (and also many different backends)
histogram(randn(10000),normalize=true, label="unit normal")
histogram!(rand(10000),normalize=true, label="uniform")

# you can save the figure for use in latex!
savefig("my_distributions.pdf")


p = plot(1)
@gif for x=0:0.1:5
  push!(p, 1, sin(x))
end

# plotlyjs()
l = @layout([[a; b] c])
p = plot(plot([sin, cos], 1, leg = false),
        scatter([atan, cos], 1, leg = false),
        plot(log, 1, xlims = (1, 10π), ylims = (0, 5), leg = false), layout = l)

anim = Animation()

for x in range(1, stop = 10π, length = 100)
    plot(push!(p, x, Float64[sin(x), cos(x), atan(x), cos(x), log(x)]))
    frame(anim)
end

gif(anim, "anim_fps15.gif", fps = 15)
# gif(anim)




# Sources to learn Julia
# https://julialang.org/learning/
# https://docs.julialang.org/
# https://juliadocs.github.io/Julia-Cheat-Sheet//
# https://www.youtube.com/user/JuliaLanguage



## Finding Help
# If you have questions about how to use Julia in general
# First search the very active community forum:
# https://discourse.julialang.org/
# If your question has not been answered yet, try asking there!
# This way future users can benefit from your questions



## Extra

# Type-stable code

# When possible, it helps to ensure that a function always
# returns a value of a type that depends only on the arguments
# types so that the compiler can infer it.
pos1(x) = x < 0 ? 0 : x
pos2(x) = x < 0 ? zero(x) : x
x = randn(100_000)
@btime pos1.(x)
@btime pos2.(x)

# There is also a oneunit function, and a more general
# oftype(x, y) function, which returns y converted to the type of x.


function foo()
    x = 1
    for i = 1:100_000
        x /= rand()
    end
    return x
end

function foo2()
    x = 1.0
    for i = 1:100_000
        x /= rand()
    end
    return x
end

@btime foo()
@btime foo2()


@code_warntype foo()
@code_warntype foo2()


# Unicode
α₀ = 2.0
2π*√3 + 4α₀

# Custom infix operators
⋅(x,y) = x .* y
x = [1 2 3]
y = [4 5 6]
x ⋅ y
# Example QuantumOptics.jl

#varargs functions
bar(a,b,x...) = (a,b,x)
bar(1,2,3,4,5,6)
a = [1,2,3,4]
#splatting
bar(a...)

#optional args
f(x, y = 3.6) = x*y
f(2)
f(2,3)

f(x, z=2; kwargs...) = (x,z,kwargs)
f(1,2,3,3,4)
f(1)
f(1,pepe=5,Irina=6)

# Broadcasting (dot-fusion)


#composition
# (f ∘ g)(args...) is the same as f(g(args...)).


function fib(n)
    if n ≤ 1
        1
    else
        fib(n-1)+fib(n-2)
    end
end

@btime fib(40)



using DifferentialEquations, Plots

function lorenz(u,p,t)
    x, y, z = u
    σ, ρ, β = p

    ẋ = σ*(y - x)
    ẏ = x*(ρ - z) - y
    ż = x*y - β*z

    return [ẋ, ẏ, ż]
end

u₀ = [1., 5., 10.]
tspan = (0., 10.)
p = [10.0, 28.0, 8/3]
prob = ODEProblem(lorenz, u₀, tspan,p)
sol = solve(prob)
@time animate(sol, vars = (1,2,3), every=4, fps = 10)

plot(sol)
