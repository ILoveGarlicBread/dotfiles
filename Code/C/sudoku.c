#include <stdio.h>
#include <stdbool.h>

#define N 9

// Function to print the Sudoku grid
void printGrid(int grid[N][N]) {
    for (int row = 0; row < N; row++) {
        for (int col = 0; col < N; col++)
            printf("%2d ", grid[row][col]);
        printf("\n");
    }
}

// Function to check if a given number can be placed at the given position
bool isSafe(int grid[N][N], int row, int col, int num) {
    // Check if the number is not present in the current row and column
    for (int x = 0; x < N; x++)
        if (grid[row][x] == num || grid[x][col] == num)
            return false;

    // Check if the number is not present in the current 3x3 subgrid
    int startRow = row - row % 3, startCol = col - col % 3;
    for (int i = 0; i < 3; i++)
        for (int j = 0; j < 3; j++)
            if (grid[i + startRow][j + startCol] == num)
                return false;

    return true;
}

// Function to solve the Sudoku puzzle using backtracking
bool solveSudoku(int grid[N][N]) {
    int row, col;

    // Find an empty position in the grid
    bool isEmpty = false;
    for (row = 0; row < N; row++) {
        for (col = 0; col < N; col++) {
            if (grid[row][col] == 0) {
                isEmpty = true;
                break;
            }
        }
        if (isEmpty)
            break;
    }

    // If there is no empty position, the puzzle is solved
    if (!isEmpty)
        return true;

    // Try placing numbers from 1 to 9 in the empty position
    for (int num = 1; num <= 9; num++) {
        // Check if the number can be placed at the current position
        if (isSafe(grid, row, col, num)) {
            // Place the number at the current position
            grid[row][col] = num;

            // Recursively solve the rest of the puzzle
            if (solveSudoku(grid))
                return true;

            // If placing the current number leads to an invalid solution, backtrack
            grid[row][col] = 0;
        }
    }

    // If no number can be placed at the current position, backtrack
    return false;
}

int main() {
    int grid[N][N] = {
        {5, 3, 0, 0, 7, 0, 0, 0, 0},
        {6, 0, 0, 1, 9, 5, 0, 0, 0},
        {0, 9, 8, 0, 0, 0, 0, 6, 0},
        {8, 0, 0, 0, 6, 0, 0, 0, 3},
        {4, 0, 0, 8, 0, 3, 0, 0, 1},
        {7, 0, 0, 0, 2, 0, 0, 0, 6},
        {0, 6, 0, 0, 0, 0, 2, 8, 0},
        {0, 0, 0, 4, 1, 9, 0, 0, 5},
        {0, 0, 0, 0, 8, 0, 0, 7, 9}
    };

    printf("Sudoku Puzzle:\n");
    printGrid(grid);

    if (solveSudoku(grid)) {
        printf("\nSolution:\n");
        printGrid(grid);
    } else {
        printf("\nNo solution exists.\n");
    }

    return 0;
}
