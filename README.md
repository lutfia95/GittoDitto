# GittoDitto - GitHub Repository Downloader

<p align="center">
  <img src="img/747px-132Ditto_Ranger3.png.webp" alt="GittoDitto in Action" width="300">
</p>   


GittoDitto.sh is a **Bash script** that allows you to **search and clone** open-source repositories from GitHub based on:
- **Keywords** (e.g., "machine learning", "data science")
- **Release year** (e.g., fetch all repos created in 2024)
- **Programming language** (e.g., Python, JavaScript, Go)
- **License type** (e.g., MIT, Apache-2.0, GPL-3.0)

## Features
✔️ **Fetches & clones repositories** automatically  
✔️ **Filters by keywords, year, language, and license**  
✔️ **Sorts by stars** (most popular repositories first)  
✔️ **Handles API rate limits & authentication**  
✔️ **Supports pagination** to download all matching repos  

---

##  Installation

### Install dependencies
Ensure you have `git` and `jq` installed:

```bash
sudo apt-get install git jq   # Debian/Ubuntu
brew install git jq           # macOS
```

### Clone this repository
```bash
git clone https://github.com/lutfia95/GittoDitto.git
cd GittoDitto
```

### Make the script executable
```bash
chmod +x GittoDitto.sh
```

---

## Usage
Run the script:
```bash
./GittoDitto.sh
```

You will be prompted to enter search criteria:
```bash
Enter keywords (space-separated, press Enter to fetch ALL repos): machine learning
Enter release year (YYYY): 2024
Enter programming language (optional, press Enter to skip): python
Enter license type (optional, e.g., MIT, Apache-2.0, GPL-3.0, press Enter to skip): MIT
```
