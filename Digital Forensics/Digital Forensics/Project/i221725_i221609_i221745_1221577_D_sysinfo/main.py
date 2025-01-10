import tkinter as tk
from tkinter import scrolledtext, messagebox
import subprocess
import os
import sqlite3
import winreg
from datetime import datetime, timedelta
import wmi


class ForensicExtractorGUI:
    def __init__(self, root):
        self.root = root
        self.root.title("Forensic Information Extractor")
        self.root.geometry("900x800")
        self.root.config(bg="#F4F6F9")

        # Title Label
        title_label = tk.Label(root, text="Forensic Information Extractor", font=("Helvetica", 16, "bold"), bg="#3498db", fg="white", pady=10)
        title_label.pack(fill="x")

        # Show main menu
        self.show_initial_menu()

    def show_initial_menu(self):
        """Display the initial menu asking the user to choose the mode."""
        initial_menu_frame = tk.Frame(self.root, bg="#F4F6F9")
        initial_menu_frame.pack(fill="both", expand=True)

        # Menu label
        menu_label = tk.Label(initial_menu_frame, text="Choose the System Mode", font=("Helvetica", 18, "bold"), fg="#2c3e50", bg="#F4F6F9")
        menu_label.pack(pady=20)

        # Buttons for selecting Live or Static system mode
        live_button = tk.Button(initial_menu_frame, text="Live System Info", command=self.show_live_system_mode, font=("Helvetica", 14), bg="#3498db", fg="white", relief="raised", width=20)
        live_button.pack(pady=10)

        static_button = tk.Button(initial_menu_frame, text="Static System Info", command=self.run_static_system_script, font=("Helvetica", 14), bg="#3498db", fg="white", relief="raised", width=20)
        static_button.pack(pady=10)

    def show_live_system_mode(self):
        """Show options for Live System forensic extraction."""
        for widget in self.root.winfo_children():
            widget.destroy()

        title_label = tk.Label(self.root, text="Live System Forensic Information Extractor", font=("Helvetica", 16, "bold"), bg="#3498db", fg="white", pady=10)
        title_label.pack(fill="x")

        # Buttons for live system extraction
        btn_system_info = tk.Button(self.root, text="System Info", command=self.extract_system_info, font=("Helvetica", 14), bg="#3498db", fg="white", relief="raised", width=20)
        btn_system_info.pack(pady=10)

        btn_user_info = tk.Button(self.root, text="User Info", command=self.extract_user_info, font=("Helvetica", 14), bg="#3498db", fg="white", relief="raised", width=20)
        btn_user_info.pack(pady=10)

        btn_hardware_info = tk.Button(self.root, text="Hardware Info", command=self.extract_hardware_info, font=("Helvetica", 14), bg="#3498db", fg="white", relief="raised", width=20)
        btn_hardware_info.pack(pady=10)

        btn_usb_info = tk.Button(self.root, text="USB Devices", command=self.extract_usb_info, font=("Helvetica", 14), bg="#3498db", fg="white", relief="raised", width=20)
        btn_usb_info.pack(pady=10)

        btn_browser_history = tk.Button(self.root, text="Browser History", command=self.extract_browser_history, font=("Helvetica", 14), bg="#3498db", fg="white", relief="raised", width=20)
        btn_browser_history.pack(pady=10)

        btn_recent_files = tk.Button(self.root, text="Recent Files", command=self.extract_recent_files, font=("Helvetica", 14), bg="#3498db", fg="white", relief="raised", width=20)
        btn_recent_files.pack(pady=10)

       

        self.output_text = scrolledtext.ScrolledText(self.root, wrap="word", width=100, height=25, font=("Consolas", 10))
        self.output_text.pack(padx=20, pady=20)

    def run_static_system_script(self):
        """Run the Static System forensic extraction script."""
        try:
            script_path = "static.py"  # Update with the correct path to your static.py script
            if not os.path.exists(script_path):
                messagebox.showerror("Error", f"Cannot find the static script at: {script_path}")
                return

            # Run the static forensic script
            subprocess.run(["python", script_path], check=True)
        except subprocess.CalledProcessError as e:
            messagebox.showerror("Error", f"Error while running static script: {e}")
        except Exception as e:
            messagebox.showerror("Error", f"Unexpected error: {e}")

    def get_registry_value(self, hive, path, name):
        try:
            with winreg.OpenKey(hive, path) as key:
                value, _ = winreg.QueryValueEx(key, name)
                return value
        except FileNotFoundError:
            return "Not Found"
        except PermissionError:
            return "Access Denied"

    def append_to_output(self, text):
        self.output_text.insert(tk.END, text + "\n")
        self.output_text.see(tk.END)

    def extract_system_info(self):
        self.output_text.delete("1.0", tk.END)
        self.append_to_output("=== System Configuration ===\n")
        os_name = self.get_registry_value(winreg.HKEY_LOCAL_MACHINE, r"SOFTWARE\Microsoft\Windows NT\CurrentVersion", "ProductName")
        install_date = self.get_registry_value(winreg.HKEY_LOCAL_MACHINE, r"SOFTWARE\Microsoft\Windows NT\CurrentVersion", "InstallDate")
        self.append_to_output(f"Operating System: {os_name}")
        self.append_to_output(f"Installation Date: {datetime.fromtimestamp(int(install_date)) if isinstance(install_date, int) else 'N/A'}")

        bios_vendor = self.get_registry_value(winreg.HKEY_LOCAL_MACHINE, r"HARDWARE\DESCRIPTION\System\BIOS", "BIOSVendor")
        bios_version = self.get_registry_value(winreg.HKEY_LOCAL_MACHINE, r"HARDWARE\DESCRIPTION\System\BIOS", "BIOSVersion")
        self.append_to_output(f"BIOS Vendor: {bios_vendor}")
        self.append_to_output(f"BIOS Version: {bios_version}\n")

    def extract_user_info(self):
        self.output_text.delete("1.0", tk.END)
        self.append_to_output("=== User Information ===\n")
        try:
            c = wmi.WMI()
            users = c.Win32_UserAccount()
            active_users = [user for user in users if user.LocalAccount and not user.Disabled]

            for user in active_users:
                username = user.Name
                profile_path = os.path.join("C:\\Users", username)

                creation_time = last_accessed_time = None
                if os.path.exists(profile_path):
                    creation_time = datetime.fromtimestamp(os.path.getctime(profile_path))
                    last_accessed_time = datetime.fromtimestamp(os.path.getatime(profile_path))

                self.append_to_output(f"User Account: {username}")
                self.append_to_output(f"  Creation Time: {creation_time}")
                self.append_to_output(f"  Last Accessed Time: {last_accessed_time}")

            if not active_users:
                self.append_to_output("No active user accounts found.")
        except Exception as e:
            self.append_to_output(f"An error occurred while fetching user accounts: {e}")

    def extract_hardware_info(self):
        self.output_text.delete("1.0", tk.END)
        self.append_to_output("=== Hardware Information ===\n")
        wmi_obj = wmi.WMI()

        for cpu in wmi_obj.Win32_Processor():
            self.append_to_output(f"CPU: {cpu.Name}, Cores: {cpu.NumberOfCores}")
        total_ram = sum(int(mem.Capacity) for mem in wmi_obj.Win32_PhysicalMemory()) / (1024 ** 3)
        self.append_to_output(f"Total RAM: {total_ram:.2f} GB")

        self.append_to_output("\n=== Disk Drives and Partitions ===")
        for disk in wmi_obj.Win32_DiskDrive():
            self.append_to_output(f"Disk: {disk.Caption}, Size: {int(disk.Size) / (1024 ** 3):.2f} GB")
            for partition in disk.associators("Win32_DiskDriveToDiskPartition"):
                self.append_to_output(f"  Partition: {partition.Caption}, Size: {int(partition.Size) / (1024 ** 3):.2f} GB")
                for logical_disk in partition.associators("Win32_LogicalDiskToPartition"):
                    self.append_to_output(f"    Logical Disk: {logical_disk.DeviceID}, File System: {logical_disk.FileSystem}, Size: {int(logical_disk.Size) / (1024 ** 3):.2f} GB")

    def extract_usb_info(self):
        self.output_text.delete("1.0", tk.END)
        self.append_to_output("\n=== USB Devices ===\n")
        usb_devices_path = r"SYSTEM\CurrentControlSet\Enum\USBSTOR"
        try:
            with winreg.OpenKey(winreg.HKEY_LOCAL_MACHINE, usb_devices_path) as key:
                for i in range(winreg.QueryInfoKey(key)[0]):
                    device_name = winreg.EnumKey(key, i)
                    self.append_to_output(f"USB Device: {device_name}")
        except PermissionError:
            self.append_to_output("Access Denied to USB Devices\n")

    def fetch_browser_history(self, browser_name, history_path):
        if not os.path.exists(history_path):
            self.append_to_output(f"{browser_name} history file not found.")
            return
        try:
            conn = sqlite3.connect(history_path)
            cursor = conn.cursor()
            cursor.execute("SELECT url, title, last_visit_time FROM urls ORDER BY last_visit_time DESC LIMIT 10")
            self.append_to_output(f"\n=== {browser_name} Browser History ===")
            for row in cursor.fetchall():
                url, title, last_visit_time = row
                visit_time = datetime(1601, 1, 1) + timedelta(microseconds=last_visit_time)
                self.append_to_output(f"Title: {title}\nURL: {url}\nLast Visited: {visit_time}")
            conn.close()
        except sqlite3.OperationalError:
            self.append_to_output(f"{browser_name} history database is locked. Please close {browser_name} and try again.\n")

    def extract_browser_history(self):
        self.output_text.delete("1.0", tk.END)
        # Paths for major browsers
        chrome_path = os.path.expanduser(r"~\AppData\Local\Google\Chrome\User Data\Default\History")
        self.fetch_browser_history("Chrome", chrome_path)

        firefox_path = os.path.expanduser(r"~\AppData\Roaming\Mozilla\Firefox\Profiles\{profile}\places.sqlite")
        self.fetch_browser_history("Firefox", firefox_path)

        edge_path = os.path.expanduser(r"~\AppData\Local\Microsoft\Edge\User Data\Default\History")
        self.fetch_browser_history("Edge", edge_path)

        brave_path = os.path.expanduser(r"~\AppData\Local\BraveSoftware\Brave-Browser\User Data\Default\History")
        self.fetch_browser_history("Brave", brave_path)

        opera_gx_path = os.path.expanduser(r"~\AppData\Roaming\Opera Software\Opera GX Stable\History")
        self.fetch_browser_history("Opera GX", opera_gx_path)

    def extract_recent_files(self):
        self.output_text.delete("1.0", tk.END)
        self.append_to_output("\n=== Recently Accessed Files ===")
        recent_docs_path = r"SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\RecentDocs"

        try:
            with winreg.OpenKey(winreg.HKEY_CURRENT_USER, recent_docs_path) as key:
                for i in range(winreg.QueryInfoKey(key)[1]):  # Iterate through values
                    file_name, file_data, _ = winreg.EnumValue(key, i)
                    if file_name and isinstance(file_data, bytes):
                        file_path = file_data.decode("utf-16", errors="ignore").strip("\x00")
                        if file_path and os.path.splitext(file_path)[1]:
                            name, extension = os.path.splitext(file_path)
                            truncated_file_path = f"{name[:6]}{extension}"
                            self.append_to_output(f"File Name: {file_name}\nFile Path: {truncated_file_path}\n")
                        else:
                            self.append_to_output(f"File Name: {file_name}\nFile Path: Invalid or Unknown Path\n")
        except PermissionError:
            self.append_to_output("Access Denied to Recently Accessed Files\n")
        except Exception as e:
            self.append_to_output(f"An error occurred: {e}\n")


# Run the GUI application
root = tk.Tk()
app = ForensicExtractorGUI(root)
root.mainloop()
