# Mini compilator Pseudo-Pascal to DOT
A mini compilator from language Pseudo-Pascal to DOT written in C language.

It detects all the function call in the Pseudo-Pascal program, then translate it into dot syntax to describe which function calls which other, ex:  
```
digraph call_graph {
	program;
	program -> writeln;
	program -> f;
	program -> g;
}
```
As DOT is a graph description language, so we can also represent it with a graphe.

## To use
    make
    ./prog pseudo-pascal/bignum.p
The Pseudo-Pascal code examples are provided in folder "pseudo-pascal", use Makefile to compile and generate the executable file "prog". Then we can use it to "compile" our Pseudo-Pascal program.
