# CSS
~~Cascading Style Sheets~~ Colorful Sudoku Solver

CSS is a simple solver that treats sudoku as a graph coloring problem (with one color corresponding to each digit).
More precisely, the solver first computes the set of available colors for each cell, then builds a min-heap containing cells ordered by their number of possible colors, and looks for a solution by coloring the cells with fewer possibilities first.
This order of coloring combined with early pruning of impossible cases allow us to drastically reduce the number of branches to explore.

## Usage

To build the solver, make sure that you have `ocaml` and `dune` installed on your machine and then run `make`.

The solver reads a sudoku grid from the standard input and prints the solution to standard output.

The input grid is expected to have 9 lines of 9 numbers separated by space, with empty cells represented as `0`.
For instance:
```
0 6 0 0 5 0 0 0 0
0 0 0 0 0 0 8 4 0
0 5 3 0 0 0 0 0 0
1 0 0 9 0 0 0 0 6
0 0 6 3 0 8 0 0 7
8 0 0 6 0 0 0 0 4
0 7 1 0 0 0 0 0 0
0 0 0 0 0 0 3 9 0
0 8 0 0 4 0 0 0 0
```

The repository contains some example grids in the `examples` folder.
You can test them with `./solver < examples/whatever_grid_you_want.txt`
