import winreg as reg
import os
import subprocess

def set_write_protect():
    try:
        # Open the registry key path
        key_path = r'SYSTEM\CurrentControlSet\Control\StorageDevicePolicies'
        try:
            # Try to open the key if it exists
            key = reg.OpenKey(reg.HKEY_LOCAL_MACHINE, key_path, 0, reg.KEY_SET_VALUE)
        except FileNotFoundError:
            # If the key doesn't exist, create it
            key = reg.CreateKey(reg.HKEY_LOCAL_MACHINE, key_path)
        
        # Set the "WriteProtect" value to 1 (DWORD)
        reg.SetValueEx(key, 'WriteProtect', 0, reg.REG_DWORD, 1)
        reg.CloseKey(key)
        print("WriteProtect key set to 1 successfully.")
    except PermissionError:
        print("Permission Denied: Please run this script as an administrator.")
    except Exception as e:
        print(f"An error occurred: {e}")


def enable_deny_write_access_group_policy():
    try:
        # Define the registry key path
        key_path = r'Software\Policies\Microsoft\Windows\RemovableStorageDevices'
        
        try:
            # Try to open the key if it exists, or create it if it doesn't
            key = reg.OpenKey(reg.HKEY_LOCAL_MACHINE, key_path, 0, reg.KEY_SET_VALUE)
        except FileNotFoundError:
            # If the key doesn't exist, create it
            key = reg.CreateKey(reg.HKEY_LOCAL_MACHINE, key_path)
        
        # Set the "Deny_Write" value to 1 (DWORD) in the registry
        reg.SetValueEx(key, 'Deny_Write', 0, reg.REG_DWORD, 1)
        reg.CloseKey(key)
        
        print("Registry key 'Deny_Write' set to 1 successfully.")
    except PermissionError:
        print("Permission Denied: Please run this script as an administrator.")
    except Exception as e:
        print(f"An error occurred while modifying the registry: {e}")


if __name__ == '__main__':
    # Set WriteProtect in the registry
    set_write_protect()
    
    # Enable Deny Write Access in Group Policy
    enable_deny_write_access_group_policy()
