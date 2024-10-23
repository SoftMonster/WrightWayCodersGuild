import subprocess
import time
import pyautogui
import pygetwindow as gw
import sqlite3


# Connect to SQLite database (or create it if it doesn't exist)
conn = sqlite3.connect('sudoku_puzzles.db')
cursor = conn.cursor()

# Function to load a Sudoku puzzle from a string into a 2D list (9x9 grid)
def load_puzzle_from_string(puzzle_string):
    board = []
    for i in range(0, 81, 9):
        board.append([int(x) for x in puzzle_string[i:i+9]])
    return board
    
# Function to fetch a puzzle from the database
def fetch_puzzle_from_db(test_number):
    cursor.execute(f'SELECT puzzle FROM puzzles Where ID = {test_number}')
    row = cursor.fetchone()
    if row:
        return row[0]  # Return the puzzle as a string
    return None

# Function to move a window to the top-right corner of the screen
def move_window_to_top_right(window_title):
    try:
        # Get the window by title
        window = gw.getWindowsWithTitle(window_title)[0]
        
        # Get screen width and height
        screen_width, screen_height = pyautogui.size()
        
        # Get the window's width and height
        window_width, window_height = window.width, window.height
        
        # Calculate the top-right position
        top_right_x = screen_width - window_width
        top_right_y = 0
        
        # Move the window
        window.moveTo(top_right_x, top_right_y)
        print(f"Window '{window_title}' moved to top-right corner.")
        
    except IndexError:
        print(f"Window with title '{window_title}' not found.")

# Main loop to fetch and validate puzzles from the database
test_number = 1

while True:
    print(f"Fetching test: {test_number}")

    # Fetch a puzzle from the database
    puzzle_string = fetch_puzzle_from_db(test_number)
    if not puzzle_string:
        print("No puzzles found in the database.")
        break

    # Load the puzzle into a 2D board
    sudoku_puzzle = load_puzzle_from_string(puzzle_string)
    print("Found.")
    print(puzzle_string)

    # Run the Sudoku solver script
    subprocess.Popen(["python", "sudoku_solver_2d.py"])  # Assuming solver script exists separately
    print("Waiting for 'Sudoku Solver' window to appear...")

    # Wait for the "Sudoku Solver" window to appear
    window_title = "Sudoku Solver"
    window_found = False

    # Wait for the window to appear, checking every 2 seconds
    while not window_found:
        try:
            window = gw.getWindowsWithTitle(window_title)[0]
            window_found = True
        except IndexError:
            time.sleep(2)

    # Give the application time to load
    print("Preparing to enter puzzle into GUI...")
    move_window_to_top_right(window_title)
    time.sleep(1)

    # Simulate Shift + Tab twice
    pyautogui.hotkey('shift', 'tab')
    pyautogui.hotkey('shift', 'tab')

    # Function to simulate entering the puzzle numbers into the GUI
    def enter_sudoku_numbers(puzzle_string):
        for num in puzzle_string:
            pyautogui.typewrite(num)

    # Enter the puzzle numbers into the GUI
    enter_sudoku_numbers(puzzle_string)

    # Simulate pressing Tab to move to the next field
    pyautogui.press('tab')
    time.sleep(0.5)

    # Simulate pressing Space to trigger an action in the solver
    pyautogui.press('space')

    print("Waiting for tester to close window....")

    # Wait for the window to close, checking every 2 seconds
    while window_found:
        try:
            window = gw.getWindowsWithTitle(window_title)[0]
            time.sleep(2)
        except IndexError:
            window_found = False

    test_number += 1
