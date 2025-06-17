# Node.js Without Admin

Run Node.js, npm, and npx commands on Windows without needing admin rights. This solution provides a lightweight batch file, when paired with the portable Node.js Standalone Binary ZIP, allow's Node.js access without having admin permissions — no changes to your system, no registry edits, and no PATH updates.

---

## Setup

### 1. Download Node.js Standalone ZIP
- Go to [Node.js Downloads](https://nodejs.org/en/download/)
- Find "Standalone Binary (.zip)" and download the latest version
- Extract it to a folder you can write to (Desktop, Documents, etc)

### 2. Get the Batch File
- Download the latest release and save `run-node.bat`, then run the batch file

### 3. Configure Node Path
- Edit `NODE_PATH` in the batch file to the path where you saved your Node.js folder

```batch
SET NODE_PATH=C:\Users\YourUsername\Downloads\node-v22.15.1-win-x64
```


### 4. Launch and Use
- Double-click the batch file or run it in Command Prompt
- Pick a directory, select a tool (node, npm, npx, etc), and enter your command
- **Note:** When entering a command in the tool, do not include the tool name (such as `node`, `npm`, or `npx`) at the beginning. The batch file automatically prefixes the command with the selected tool. For example, entering `npm run dev` will result in `npm npm run dev` being executed, which will cause an error.
- A `temp-node.bat` file will be created in the directory where you run your Node.js commands. This is normal behavior and is necessary for the batch file to function properly.



### Menu Options

```
┌────────────────────────────────────────────┐
│  [1] Run Node.js Command (node)            │
│  [2] Run NPM Command (npm)                 │
│  [3] Run NPX Command (npx)                 │
│  [4] Back to directory selection           │
│  [5] Exit                                  │
└────────────────────────────────────────────┘
```

## System Requirements

- **Windows OS**: Windows 7 or newer (batch file compatibility)
- **Node.js Standalone Binary ZIP**: The Windows Binary (.zip) version from [nodejs.org](https://nodejs.org/en/download), **not the installer**
- **Storage access**: Write permissions for:
  - The folder where you extract Node.js
  - Ability to run batch files and execute commands through the command prompt
- **No administrative rights needed**: Works with standard user permissions

## Troubleshooting

#### Node.js not found
- Check `NODE_PATH` points to your Node.js folder (the standalone binary should contain `node.exe`, `npm.cmd`, etc)

```batch
SET NODE_PATH=C:\Users\YourUsername\Documents\node-v22.15.1-win-x64
```

#### Commands not working
- Confirm operating in the right project directory
- Check your `package.json` if using npm
- Use correct command syntax, don't include the tool name (npm, node)

#### Report Issues
If you encounter any issues, feel free to create an issue on the GitHub repository. You can also submit a pull request if you have a fix or improvement to suggest.

## License

MIT License - see [LICENSE.md](LICENSE.md)

## Last Updated

June 18, 2025
