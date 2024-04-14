# sudoku

## Getting Started
You need [Git](https://git-scm.com/) and [Docker](https://www.docker.com/) installed on your computer.
1. Clone this repo:
   ```sh
   git clone https://github.com/g-ohara/sudoku.git && cd sudoku
   ```
1. Run container:
   ```sh
   docker compose up -d
   ```
1. Compile and execute the app:
   ```sh
   docker compose exec haskell ghc sudoku.hs && ./sudoku
   ```
