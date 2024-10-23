import random
import sqlite3
import time

# Connect to SQLite database (or create it if it doesn't exist)
conn = sqlite3.connect('sudoku_puzzles.db')
cursor = conn.cursor()

# Create a table for Sudoku puzzles if it doesn't exist
cursor.execute('''
    CREATE TABLE IF NOT EXISTS puzzles (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        puzzle TEXT NOT NULL
    )
''')
conn.commit()

# Function to print the Sudoku board as a continuous string
def print_board_as_string(board):
    result = ""
    for row in board:
        for num in row:
            result += str(num) if num != 0 else "0"
    return result

# Check if placing a number in a specific cell is valid
def is_valid(board, row, col, num):
    for i in range(9):
        if board[row][i] == num or board[i][col] == num:
            return False
    
    # Check the 3x3 grid
    start_row, start_col = 3 * (row // 3), 3 * (col // 3)
    for i in range(start_row, start_row + 3):
        for j in range(start_col, start_col + 3):
            if board[i][j] == num:
                return False
    return True

# Check if placing a number in a specific cell is valid
def is_valid_box(box, row, col, num):
    
    # Check the 3x3 grid
    for i in range(3):
        for j in range(3):
            if box[i][j] == num:
                return False
    return True


# Backtracking function to solve the Sudoku
def solve(board):
    # Find the next empty spot
    for row in range(9):
        for col in range(9):
            if board[row][col] == 0:
                numSample=random.sample(range(1,10),9)
                for num in numSample:
                    if is_valid(board, row, col, num):
                        board[row][col] = num
                        if solve(board):
                            return True
                        board[row][col] = 0  # Backtrack
                return False
    return True

# Generate a fully solved Sudoku puzzle using backtracking
def generate_sudoku():
    board = [[0]*9 for _ in range(9)]    
    solve(board)
    return board

def boardFilled(board):
    for row in range(9):
        for col in range(9):
            if board[row][col] == 0:
                return False
    return True

def countZeros(board):
    count = 0
    for row in range(9):
        for col in range(9):
            if board[row][col] == 0:
                count += 1
    return count

    
# Check if a board is solvable
def solutions(board):
    childSolutions = 0

    # Find the next empty spot
    for row in range(9):
        for col in range(9):
            if board[row][col] == 0:
                # Loop over valid numbers 1 to 9
                for num in range(1, 10):
                    if is_valid(board, row, col, num):
                        board[row][col] = num
                        # Recursively find all solutions
                        childSolutions += solutions(board)
                        # Stop if more than one solution is found
                        if childSolutions > 1:
                            return childSolutions
                        # Backtrack to explore other possibilities
                        board[row][col] = 0
                return childSolutions  # Return solutions from this branch

    # Base case: if the board is fully filled, count it as a solution
    if boardFilled(board):
        return 1
    
    return 0

    
# Insert Sudoku puzzle into SQLite database
def insert_puzzle(puzzle_string):
    cursor.execute('INSERT INTO puzzles (puzzle) VALUES (?)', (puzzle_string,))
    conn.commit()

# Function to find the first empty spot (top-left to bottom-right)
def find_empty(board):
    for r in range(9):
        for c in range(9):
            if board[r][c] == 0:
                return r, c
    return None

def remove_numbers(board):
        
    # Generate a list of all (row, col) coordinates in a 9x9 grid
    coordinates = [(row, col) for row in range(9) for col in range(9)]

    # Shuffle the coordinates to iterate in a random order
    random_order = random.sample(coordinates, len(coordinates))

    # Iterate through the grid in random order
    for row, col in random_order:
        if board[row][col] != 0:
            # Backup the current number, remove it, and check solvability
            backup = [fullrow.copy() for fullrow in board]
            board[row][col] = 0
            if solutions(board)>1:
                board = backup  # Restore the board if not solvable

    return board

def fetch_puzzle_from_db():
    cursor.execute(f'SELECT max(ID) FROM puzzles')
    row = cursor.fetchone()
    if row:
        return row[0]  # Return the puzzle as a string
    return None


# Main loop to generate and store puzzles
test_number = fetch_puzzle_from_db() + 1




while True:
#while test_number == 1:
    
    random.seed(test_number)

    print("Generating test: " + str(test_number))

    # Generate a full board and remove numbers
    sudoku_board = generate_sudoku()
    sudoku_puzzle = remove_numbers([row.copy() for row in sudoku_board])

    # Convert the puzzle to a string and store it in the database
    board_string = puzzle_string = print_board_as_string(sudoku_board)
    puzzle_string = print_board_as_string(sudoku_puzzle)
    insert_puzzle(puzzle_string)  # Insert puzzle into the database

    print(f"Puzzle stored: Test Number {test_number}")
    print(f"{puzzle_string}")
    print(f"{board_string}")
    test_number += 1