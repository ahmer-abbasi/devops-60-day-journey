#!/bin/bash

# ============================================================
#  Application Diagnostics Script
#  Collects system, service, process, network, disk, memory,
#  and performance diagnostics using standard Linux tools.
# ============================================================

TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
OUTPUT="diagnostics_$TIMESTAMP.log"

echo "============================================================" | tee -a $OUTPUT
echo "        SYSTEM DIAGNOSTICS REPORT - $TIMESTAMP" | tee -a $OUTPUT
echo "============================================================" | tee -a $OUTPUT

# -------------------------------
# System Information
# -------------------------------
echo -e "\n### SYSTEM INFORMATION ###" | tee -a $OUTPUT
hostname | tee -a $OUTPUT
uptime | tee -a $OUTPUT

# -------------------------------
# Systemd Services
# -------------------------------
echo -e "\n### SYSTEMCTL SERVICES (FAILED) ###" | tee -a $OUTPUT
systemctl --failed | tee -a $OUTPUT

echo -e "\n### SYSTEMCTL SERVICES (ALL) ###" | tee -a $OUTPUT
systemctl list-units --type=service | tee -a $OUTPUT

# -------------------------------
# Journal Logs
# -------------------------------
echo -e "\n### RECENT SYSTEM LOGS (journalctl) ###" | tee -a $OUTPUT
journalctl -p 3 -n 50 | tee -a $OUTPUT   # Priority 3 = errors

# -------------------------------
# Process Information
# -------------------------------
echo -e "\n### TOP PROCESSES (CPU) ###" | tee -a $OUTPUT
ps -eo pid,ppid,cmd,%cpu,%mem --sort=-%cpu | head -20 | tee -a $OUTPUT

echo -e "\n### TOP PROCESSES (MEMORY) ###" | tee -a $OUTPUT
ps -eo pid,ppid,cmd,%cpu,%mem --sort=-%mem | head -20 | tee -a $OUTPUT

echo -e "\n### FULL PROCESS LIST ###" | tee -a $OUTPUT
ps aux | tee -a $OUTPUT

# -------------------------------
# Live System Snapshot (top)
# -------------------------------
echo -e "\n### TOP SNAPSHOT ###" | tee -a $OUTPUT
top -b -n 1 | tee -a $OUTPUT

# -------------------------------
# Network Diagnostics
# -------------------------------
echo -e "\n### LISTENING PORTS (ss) ###" | tee -a $OUTPUT
ss -tulnp | tee -a $OUTPUT

echo -e "\n### OPEN FILES (lsof) ###" | tee -a $OUTPUT
lsof | head -200 | tee -a $OUTPUT

# -------------------------------
# Disk Usage
# -------------------------------
echo -e "\n### DISK USAGE (df) ###" | tee -a $OUTPUT
df -h | tee -a $OUTPUT

echo -e "\n### TOP DIRECTORIES BY SIZE (du) ###" | tee -a $OUTPUT
du -ah / | sort -rh | head -20 | tee -a $OUTPUT

# -------------------------------
# Memory Usage
# -------------------------------
echo -e "\n### MEMORY USAGE (free) ###" | tee -a $OUTPUT
free -h | tee -a $OUTPUT

# -------------------------------
# Performance Metrics
# -------------------------------
echo -e "\n### VMSTAT ###" | tee -a $OUTPUT
vmstat 1 5 | tee -a $OUTPUT

echo -e "\n### IOSTAT ###" | tee -a $OUTPUT
iostat -xz 1 3 | tee -a $OUTPUT

# -------------------------------
# Completion
# -------------------------------
echo -e "\nDiagnostics complete. Output saved to: $OUTPUT"
echo "============================================================" | tee -a $OUTPUT
