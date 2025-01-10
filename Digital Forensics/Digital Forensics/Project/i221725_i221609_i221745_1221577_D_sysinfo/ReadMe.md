# Forensic Information Extractor

A Python application for extracting forensic information from Windows system files, including `SAM`, `SYSTEM`, and `NTUSER.dat`. This tool provides a graphical user interface (GUI) using Tkinter to facilitate easy access to static forensic data.

## Features

- **Static System Forensic Extraction**:
  - Extract user account information from `SAM` and `SYSTEM` files.
  - Parse `NTUSER.dat` files to retrieve installed software names.
  - Display user account data in a user-friendly table format with CSV export functionality.

## Requirements

- Python 3.x
- Tkinter (usually included with Python)
- Registry (install via `pip install Registry`)

## Installation

1. Clone the repository or download the files.
2. Ensure you have Python installed on your system.
3. Install the required libraries:
   ```bash```
   pip install Registry

## Limitations

1. Only allows certain hives SYSTEM, SAM and NTUSER.dat for static aquisition of limited sysinfo
2. The hives should be extracted via FTK Imager or anyother software.
3. Some functionalities may not work without required libraries.