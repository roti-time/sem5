import tkinter as tk
from tkinter import filedialog, messagebox, scrolledtext, ttk
import subprocess
import sys
from Registry import Registry
import datetime
import os
import csv

class ForensicExtractorGUI:
    def __init__(self, root):
        self.root = root
        self.root.title("Forensic Information Extractor")
        self.root.geometry("900x800")
        self.root.config(bg="#F4F6F9")

        # Title Label
        title_label = tk.Label(root, text="Forensic Information Extractor", font=("Helvetica", 16, "bold"), bg="#3498db", fg="white", pady=10)
        title_label.pack(fill="x")

        # Directly show the Static System forensic extraction page
        self.show_static_mode()

    def show_static_mode(self):
        """Show options for Static System forensic extraction (NTUSER.dat, SAM file, System Info, Software Info)."""
        for widget in self.root.winfo_children():
            widget.destroy()

        title_label = tk.Label(self.root, text="Static System Forensic Information Extractor", font=("Helvetica", 16, "bold"), bg="#3498db", fg="white", pady=10)
        title_label.pack(fill="x")

        btn_ntuser = tk.Button(self.root, text="Open NTUSER.dat File", command=self.open_and_extract_ntuser_software, font=("Helvetica", 14), bg="#3498db", fg="white", relief="raised", width=20)
        btn_ntuser.pack(pady=10)

        btn_sam = tk.Button(self.root, text="Open SAM and SYSTEM Files", command=self.open_and_parse_sam_files, font=("Helvetica", 14), bg="#3498db", fg="white", relief="raised", width=30)
        btn_sam.pack(pady=10)

        btn_user_account = tk.Button(self.root, text="User Account Info", command=self.open_and_display_user_accounts, font=("Helvetica", 14), bg="#3498db", fg="white", relief="raised", width=30)
        btn_user_account.pack(pady=10)

        self.output_text = scrolledtext.ScrolledText(self.root, wrap="word", width=100, height=25, font=("Consolas", 10))
        self.output_text.pack(padx=20, pady=20)

    # ------------------------ SAM and SYSTEM Files Parsing ------------------------

    def open_and_parse_sam_files(self):
        """Select SAM and SYSTEM files and process them with an external script."""
        sam_file = filedialog.askopenfilename(title="Select SAM File", filetypes=[("SAM File", "*.*"), ("All Files", "*.*")])
        if not sam_file:
            messagebox.showwarning("Warning", "No SAM file selected.")
            return

        system_file = filedialog.askopenfilename(title="Select SYSTEM File", filetypes=[("SYSTEM File", "*.*"), ("All Files", "*.*")])
        if not system_file:
            messagebox.showwarning("Warning", "No SYSTEM file selected.")
            return

        self.output_text.delete(1.0, tk.END)
        self.output_text.insert(tk.END, "Processing SAM and SYSTEM files...\n")

        # Path to the external script
        external_script = "samdum.py"

        # Ensure the script exists
        if not os.path.exists(external_script):
            messagebox.showerror("Error", f"Cannot find the external script: {external_script}")
            return

        # Call the external script with the selected files
        try:
            result = subprocess.run(
                ["python", external_script, sam_file, system_file],
                capture_output=True,
                text=True,
                check=True,
            )
            self.format_sam_output(result.stdout)
        except subprocess.CalledProcessError as e:
            self.output_text.insert(tk.END, f"Error while processing files:\n{e.stderr}")
        except Exception as e:
            self.output_text.insert(tk.END, f"Unexpected error: {e}\n")

    def format_sam_output(self, output):
        """Format the output from the SAM processing script for better readability."""
        self.output_text.delete(1.0, tk.END)
        self.output_text.insert(tk.END, "Formatted SAM Analysis Results:\n")
        self.output_text.insert(tk.END, "=" * 50 + "\n")

        lines = output.splitlines()
        for line in lines:
            self.output_text.insert(tk.END, f"{line}\n")
            if line.startswith("  NTLM hash history:"):
                self.output_text.insert(tk.END, "\n")  # Add an empty line after NTLM hash history

        self.output_text.insert(tk.END, "=" * 50 + "\n")

    # ------------------------ User Account Info ------------------------

    def open_and_display_user_accounts(self):
        """Select SAM file, pass it to the merged function and display user account information in a table."""
        sam_file = filedialog.askopenfilename(title="Select SAM File", filetypes=[("SAM File", "*.*"), ("All Files", "*.*")])
        if not sam_file:
            messagebox.showwarning("Warning", "No SAM file selected.")
            return

        # Call the function that processes the SAM file and returns a 2D array
        user_info_array = self.parse_sam_hive_to_array(sam_file)
        
        # Display the returned 2D array in a table format and allow CSV export
        self.display_user_account_table(user_info_array)

    def parse_sam_hive_to_array(self, sam_path):
        """Parse the SAM hive and return data in a 2D array format."""
        table_data = []
        try:
            # Open SAM hive at the specified path
            reg = Registry.Registry(sam_path)
            
            # Access the "SAM\\Domains\\Account\\Users" subkey
            users_key = reg.open("SAM\\Domains\\Account\\Users")
            
            # Iterate over each user (subkey) in "Users"
            for subkey in users_key.subkeys():
                user_rid = subkey.name()
                
                # Iterate over values in the subkey (user)
                for value in subkey.values():
                    value_name = value.name()
                    value_type = value.value_type_str()
                    value_data = value.value()
                    
                    # Convert binary or timestamp values to readable formats where applicable
                    if value_type == "REG_BINARY":
                        value_data = value_data.hex()  # Convert binary data to hex string
                    elif value_type == "REG_QWORD" or value_type == "REG_DWORD":
                        value_data = int(value_data)  # Convert numeric data to integers
                    elif isinstance(value_data, bytes):
                        value_data = value_data.decode('utf-8', errors='ignore')  # Decode bytes to string

                    # Append each value as a row in the 2D table: [value_name, value_type, value_data]
                    table_data.append([value_name, value_type, value_data])

        except Exception as e:
            print(f"Error accessing SAM hive: {e}")
        
        return table_data

    def display_user_account_table(self, user_info_array):
        """Display the user account information in a table with a Save to CSV option."""
        for widget in self.root.winfo_children():
            widget.destroy()

        table_frame = tk.Frame(self.root)
        table_frame.pack(fill="both", expand=True)

        # Define columns for the table
        tree = ttk.Treeview(table_frame, columns=("Value Name", "Value Type", "Value Data"), show="headings")
        tree.heading("Value Name", text="Value Name")
        tree.heading("Value Type", text="Value Type")
        tree.heading("Value Data", text="Value Data")

        tree.pack(fill="both", expand=True)

        # Style the table
        tree.tag_configure('oddrow', background='#f9f9f9')  # Alternate row color
        tree.tag_configure('evenrow', background='#e6f7ff')  # Alternate row color

        # Populate the table with the user account data
        for index, row in enumerate(user_info_array):
            tag = 'oddrow' if index % 2 == 0 else 'evenrow'
            tree.insert("", "end", values=row, tags=(tag,))

        # Add Save to CSV button
        save_button = tk.Button(self.root, text="Save to CSV", command=lambda: self.save_to_csv(user_info_array), font=("Helvetica", 14), bg="#3498db", fg="white", relief="raised")
        save_button.pack(pady=10)

        back_button = tk.Button(self.root, text="Back", command=self.show_static_mode, font=("Helvetica", 14), bg="#3498db", fg="white", relief="raised")
        back_button.pack(pady=10)

    def save_to_csv(self, data):
        """Save the parsed data to a CSV file."""
        file_path = filedialog.asksaveasfilename(defaultextension=".csv", filetypes=[("CSV files", "*.csv"), ("All Files", "*.*")])
        if not file_path:
            return  # User cancelled the save

        try:
            # Write data to CSV
            with open(file_path, mode='w', newline='', encoding='utf-8') as file:
                writer = csv.writer(file)
                writer.writerow(["Value Name", "Value Type", "Value Data"])  # Write header row
                for row in data:
                    writer.writerow(row)  # Write data rows

            messagebox.showinfo("Success", f"Data has been successfully saved to {file_path}")
        except Exception as e:
            messagebox.showerror("Error", f"An error occurred while saving to CSV: {e}")

    # ------------------------ NTUSER.dat Parsing ------------------------

    def open_and_extract_ntuser_software(self):
        """Select the NTUSER.dat file, parse it, and export installed software names."""
        ntuser_file = filedialog.askopenfilename(title="Select NTUSER.dat File", filetypes=[("NTUSER.dat File", "NTUSER.dat"), ("All Files", "*.*")])
        if not ntuser_file:
            messagebox.showwarning("Warning", "No NTUSER.dat file selected.")
            return

        # Process the NTUSER.dat file and get the software info
        software_info_array = self.parse_ntuser_software_to_array(ntuser_file)

        # Export the data to a .txt file
        self.save_to_txt(software_info_array)

    def parse_ntuser_software_to_array(self, ntuser_path):
        """Parse the NTUSER.DAT hive and extract installed software subkey names."""
        software_names = []
        try:
            # Open NTUSER.DAT hive at the specified path
            reg = Registry.Registry(ntuser_path)

            # List of registry keys where installed software might be listed
            reg_keys = [
                r"Software\Microsoft\Windows\CurrentVersion\Uninstall",  # Common Uninstall location
                r"Software\Microsoft\Windows\CurrentVersion\App Paths",  # Application paths
                r"Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall",  # 32-bit apps on 64-bit systems
                r"Software\Wow6432Node\Microsoft\Windows\CurrentVersion\App Paths",  # 32-bit App Paths
                r"Software\Microsoft\Windows\CurrentVersion\Installer\Folders",  # Additional possible location
                r"Software\Microsoft\Windows\CurrentVersion\Installer\UserData",  # Additional possible location
            ]

            # Iterate over each registry key and extract software names
            for reg_key in reg_keys:
                try:
                    # Try opening each key
                    key = reg.open(reg_key)

                    # Iterate over each subkey in the registry key
                    for subkey in key.subkeys():
                        software_name = subkey.name()  # Software name is typically the name of the subkey
                        software_names.append(software_name)

                except Exception as e:
                    print(f"Error accessing registry key {reg_key}: {e}")
        
        except Exception as e:
            print(f"Error accessing NTUSER.DAT hive: {e}")
        
        return software_names

    def save_to_txt(self, data):
        """Save the parsed software data to a TXT file."""  
        file_path = filedialog.asksaveasfilename(defaultextension=".txt", filetypes=[("Text files", "*.txt"), ("All Files", "*.*")])
        if not file_path:
            return  # User cancelled the save

        try:
            # Write data to TXT file
            with open(file_path, mode='w', encoding='utf-8') as file:
                file.write("Installed Software Subkey Names\n")
                file.write("=" * 50 + "\n")
                for row in data:
                    file.write(row + "\n")  # Write each software name on a new line

            messagebox.showinfo("Success", f"Data has been successfully saved to {file_path}")
        except Exception as e:
            messagebox.showerror("Error", f"An error occurred while saving to TXT: {e}")

# Run the application
root = tk.Tk()
app = ForensicExtractorGUI(root)
root.mainloop()
