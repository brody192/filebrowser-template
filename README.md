[![Logo](https://raw.githubusercontent.com/filebrowser/logo/master/banner.png)](https://github.com/filebrowser/filebrowser)

# 📂 Web File Browser

[![Deploy on Railway](https://railway.app/button.svg)](https://railway.app/template/Nan7Bs?referralCode=ySCnWl)

Filebrowser provides a file managing interface within the attached volume and it can be used to upload, delete, preview, rename, and edit your files.

## FileBrowser Features

- Upload, Delete, Rename, and Create Files and Folders
- Preview, Edit and Share Files

## Template Features

- Run any Filebrowser version by setting the `FILEBROWSER_VERSION` variable

- Automatically uses attached volume as the storage location

- Username and Password are set by service variables

- By default, the storage location is set to the `storage` subdirectory in the root of the volume, but by setting a service variable `USE_VOLUME_ROOT` to `1` you can opt to use the root of the volume as the storage location instead

### Caveats

- Setting a password in Filebrowser's settings will not persist across deployments, this is because the password from the `WEB_PASSWORD` variable is used instead on every deployment, in order to keep the login password in sync with what is set in the variable

**If there are any issues with this template, just let me know in the [Railway Discord](https://discord.gg/railway), and I'll gladly fix them!**