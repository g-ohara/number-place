# number-place
[Number Place](https://en.wikipedia.org/wiki/Sudoku) solver using brute-force search.
(Number Place is also called "Sudoku (数独)", which is registered trademark in Japan.)
## Getting Started
### Setup
You need [Git](https://git-scm.com/) and [Docker](https://www.docker.com/) installed on your computer.
1. Clone this repo:
   ```sh
   git clone https://github.com/g-ohara/number-place.git && cd number-place
   ```
1. Run container:
   ```sh
   docker compose up -d
   ```
1. Compile the app:
   ```sh
   docker compose exec haskell ghc solver.hs
   ```
1. Then you will get the executable ```solver``` file.
### Solve Problem
1. Run the app:
   ```sh
   ./solver
   ```
1. Input your problem with "." for empty cells, for example:
   ```sh
   ..7436592
   .92.5..4.
   ..5...1.6
   ...2.....
   9.83....1
   .641.58.9
   87962.41.
   .1....26.
   .2651.973
   ```
   
1. Then you will get all possible solutions if your input is a valid problem:
   ```sh
   Solution(s):
   187436592
   692851347
   345792186
   731289654
   958364721
   264175839
   879623415
   513947268
   426518973
   ```
