import winreg as reg

action = input("Do you want to turn write protection ON or OFF? (Type '1' or '0'): ").strip().upper()

key_path = r"SYSTEM\CurrentControlSet\Control\StorageDevicePolicies"

with reg.CreateKey(reg.HKEY_LOCAL_MACHINE, key_path) as key:
    if action == "1":
        reg.SetValueEx(key, "WriteProtect", 0, reg.REG_DWORD, 1)
        print("Write protection is now ON.")
    elif action == "0":
        reg.SetValueEx(key, "WriteProtect", 0, reg.REG_DWORD, 0)
        print("Write protection is now OFF.")
    else:
        print("You need to type '1' or '0'.")
