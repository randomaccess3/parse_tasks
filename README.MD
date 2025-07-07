# 📄 XML to JSON Task Parser

This PowerShell script recursively scans a folder for XML files, converts each file into a structured JSON format, and saves the results to a specified output file. It also captures useful metadata such as file path, creation time, and last modification time.

## 🚀 Features

- 🔍 Recursively parses XML files in a given directory  
- 🔄 Converts XML content into nested JSON structures  
- 🕒 Captures file metadata (path, creation time, modification time)  
- 💾 Outputs a single compressed JSON file  
- 🛠️ Gracefully handles malformed XML files  

## 🧰 Usage

```powershell
.\parse_tasks.ps1 -inputFolder "C:\path\to\xml\files" -outputFile "C:\path\to\output.json"
```

### Parameters

| Parameter     | Description                                      |
|---------------|--------------------------------------------------|
| `-inputFolder`| Path to the folder containing XML files          |
| `-outputFile` | Path to the resulting JSON output file           |

## 🧠 How It Works

1. **Recursively scans** the input folder for `.xml` files.
2. **Parses** each XML file into a dictionary-like structure.
3. **Extracts metadata**: file path, creation time (UTC), and last modified time (UTC).
4. **Serializes** the results into a compressed JSON format.
5. **Saves** the final output to the specified file.

## 📦 Output Format

Each entry in the output JSON file includes:

```json
{
  "Path": "C:\\path\\to\\file.xml",
  "Created": "2025-07-07T06:12:34.0000000Z",
  "Modified": "2025-07-07T06:15:00.0000000Z",
  "Task": {
    "RootElement": {
      "ChildElement": "Value",
      "Attributes": "..."
    }
  }
}
```

## ⚠️ Error Handling

- Files that fail XML parsing are skipped with a warning.
- The script continues processing remaining files without interruption.

## 📄 License

This project is licensed under the [MIT License](LICENSE).
