## Overview

Eclipse is a portable system tray application that lets you send encrypted 
emails and encrypt any text in place. 

## How it Works

- Select any text.
- Press <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>E</kbd> (customizable).
- You will be prompted for a password, enter one.
- Your text will be encrypted and pasted in place.
- To decrypt, repeat the operation.
- You can choose to keep the encrypted/decrypted text in the clipboard or
  not by ticking the Keep checkbox.
- Additional options can be configered in the provided INI file.
- You may hide the tray icon by setting `HideIcon=1` in the INI file.

## Technical Notes

Eclipse uses blowfish encryption provided by the
[MySecret](http://www.di-mgt.com.au/mysecret.html)
command line utility (already included in the download).

## Related Freeware Utilities

For a drag and drop interface to encrypt any file, see
**[File Blender](/software/fileblender)**
which supports file encryption, audio conversion, video conversion and many
other file processing functions.
