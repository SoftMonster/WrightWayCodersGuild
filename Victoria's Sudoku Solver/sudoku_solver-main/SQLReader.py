import sqlite3
import tkinter as tk
from tkinter import filedialog, messagebox, scrolledtext

class SQLiteAccessTool:
    def __init__(self, root):
        self.root = root
        self.root.title("SQLite Access Tool")
        self.root.geometry("600x400")

        self.connection = None

        # GUI Elements
        self.label = tk.Label(root, text="Enter your SQL Query:")
        self.label.pack(pady=10)

        self.query_text = scrolledtext.ScrolledText(root, width=70, height=10)
        self.query_text.pack(pady=10)

        self.run_button = tk.Button(root, text="Run Query", command=self.run_query)
        self.run_button.pack(pady=10)

        self.results_text = scrolledtext.ScrolledText(root, width=70, height=10)
        self.results_text.pack(pady=10)

        self.menu = tk.Menu(root)
        self.root.config(menu=self.menu)

        self.file_menu = tk.Menu(self.menu, tearoff=0)
        self.menu.add_cascade(label="File", menu=self.file_menu)
        self.file_menu.add_command(label="Open Database", command=self.open_database)
        self.file_menu.add_command(label="Close Database", command=self.close_database)
        self.file_menu.add_separator()
        self.file_menu.add_command(label="Exit", command=root.quit)

    def open_database(self):
        db_file = filedialog.askopenfilename(title="Select SQLite Database", filetypes=[("SQLite Database", "*.db *.sqlite3")])
        if db_file:
            try:
                self.connection = sqlite3.connect(db_file)
                messagebox.showinfo("Success", f"Connected to {db_file}")
            except Exception as e:
                messagebox.showerror("Error", f"Failed to connect to database: {e}")
        else:
            messagebox.showwarning("No File", "No database file selected.")

    def close_database(self):
        if self.connection:
            self.connection.close()
            self.connection = None
            messagebox.showinfo("Closed", "Database connection closed.")
        else:
            messagebox.showwarning("No Connection", "No database is currently connected.")

    def run_query(self):
        if not self.connection:
            messagebox.showwarning("No Database", "No database is currently connected.")
            return

        query = self.query_text.get("1.0", tk.END).strip()
        if not query:
            messagebox.showwarning("Empty Query", "Please enter an SQL query.")
            return

        try:
            cursor = self.connection.cursor()
            cursor.execute(query)
            results = cursor.fetchall()

            # Display the results in the results_text box
            self.results_text.delete("1.0", tk.END)
            if results:
                for row in results:
                    self.results_text.insert(tk.END, str(row) + "\n")
            else:
                self.results_text.insert(tk.END, "Query executed successfully, but no results to display.\n")

            self.connection.commit()
        except Exception as e:
            self.results_text.delete("1.0", tk.END)
            self.results_text.insert(tk.END, f"Error: {e}\n")

# Main Application
if __name__ == "__main__":
    root = tk.Tk()
    app = SQLiteAccessTool(root)
    root.mainloop()
