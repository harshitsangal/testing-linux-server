# Dev-Server System Monitoring Setup

## Overview

This repository contains a simple but effective system-monitoring setup for a Linux-based development server.  
It helps track **CPU, memory, process usage, and disk/storage usage** over time — making it easier for developers and operations teams to:  
- Observe real-time resource usage (for performance troubleshooting)  
- Collect periodic snapshots of system state for capacity planning and trend analysis  
- Identify resource-hungry processes or storage bottlenecks  

This setup is ideal for small-to-medium dev environments and gives a foundation for more advanced monitoring if needed later.

---

## What’s Inside

| File / Directory | Purpose / Description |
|------------------|------------------------|
| `sys_monitor.sh` | Bash script to collect system metrics (disk usage, top processes, memory usage, etc.) and save logs with timestamps. |
| `README.md` | This documentation — explains what the project does, how to set it up and use it. |
| (optional) `cron-setup.sh` | Helper script / instructions to install a cron job for periodic monitoring. |
| `logs/` *(or configurable log directory)* | Where the output snapshots (logs) will accumulate over time. |

---

## Prerequisites

- A Linux-based server (Ubuntu / Debian / RHEL / CentOS / similar)  
- A user account with sudo privileges (for installation), and appropriate permissions to read system info and write logs  
- Basic shell environment (bash, sh) — no special dependencies  

Optionally (but recommended):  
- Install `nmon` (for more advanced logging / CSV output)  
- `cron` or another job scheduler for periodic execution  

---

## Setup & Installation

1. Clone this repository:

    ```bash
    git clone https://github.com/YOUR_USERNAME/your-repo-name.git
    cd your-repo-name
    ```

2. Make the monitoring script executable:

    ```bash
    chmod +x sys_monitor.sh
    ```

3. Install `nmon`:

    ```bash
    # On Debian/Ubuntu
    sudo apt update
    sudo apt install -y nmon

    # On RHEL/CentOS (if using yum/dnf)
    # sudo yum install nmon   (or install from EPEL if required)
    ```

4. Run the monitoring script manually to verify:

    ```bash
    ./sys_monitor.sh
    ```

<img width="618" height="523" alt="image" src="https://github.com/user-attachments/assets/100cae3a-8f3a-4f9c-83cb-c5e10d6f4c41" />


   This should create a new log file under `logs/` (or configured log directory), containing:

   - Disk usage (via `df`)  
   - Directory size summary (via `du`, if configured)  
   - Top CPU-consuming processes  
   - Top memory-consuming processes  
   - Memory usage snapshot (`free -h`)  

---

<img width="827" height="116" alt="image" src="https://github.com/user-attachments/assets/5da3e0dd-9d05-4ec5-b32e-99ed45644492" />


## Automating Monitoring (cron)

To collect logs automatically (e.g. daily), set up a cron job. Example (runs every day at 23:59):


59 23 * * * /testing-linux-server/sys_monitor.sh

<img width="400" height="53" alt="image" src="https://github.com/user-attachments/assets/4225ad04-01f7-431d-b624-0cd8b944349b" />

## Task 2 — User Management & Access Control  

## Objective  
Set up secure user accounts for new developers (Sarah and Mike), create isolated working directories for each, enforce strict access permissions, and implement a password policy with expiration and complexity.

---

## 👤 User Accounts Creation  

As root (or using `sudo`), run the following commands:

```bash
# 1. Create users Sarah and mike (login names are case-sensitive)
sudo useradd -m -s /bin/bash Sarah
sudo useradd -m -s /bin/bash mike

<img width="340" height="49" alt="image" src="https://github.com/user-attachments/assets/8cae886d-84c6-465f-874a-f6acee5e7d2d" />


# 2. Set passwords (interactive)
sudo passwd Sarah
sudo passwd mike

# 3. Create workspace directories
sudo mkdir -p /home/Sarah/workspace
sudo mkdir -p /home/mike/workspace

# 4. Set ownership & permissions
sudo chown -R Sarah:Sarah /home/Sarah/workspace
sudo chown -R mike:mike /home/mike/workspace
sudo chmod 700 /home/Sarah/workspace
sudo chmod 700 /home/mike/workspace

# 5. Install password policy module (Debian/Ubuntu)
sudo apt update
sudo apt install libpam-pwquality

# 6. Edit PAM config to enforce password complexity
# (modify /etc/pam.d/common-password as shown above)

# 7. Set password expiration policy
sudo chage -M 30 Sarah
sudo chage -M 30 mike
sudo chage -m 7 -W 5 Sarah
sudo chage -m 7 -W 5 mike

# 8. Verify aging settings
sudo chage -l Sarah
sudo chage -l mike
