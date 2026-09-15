#!/bin/bash

echo "==================== System Health Report ===================="
echo "Generated on: $(date)"
echo

echo "-------------------- Hostname --------------------"
hostname
echo

echo "-------------------- Uptime --------------------"
uptime -p
echo

echo "-------------------- CPU Usage --------------------"
top -bn1 | grep "Cpu(s)"
echo

echo "-------------------- Memory Usage --------------------"
free -h
echo

echo "-------------------- Disk Usage --------------------"
df -h --total
echo

echo "-------------------- Top Processes (CPU) --------------------"
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -15
echo

echo "-------------------- All Running Processes --------------------"
ps -eo pid,ppid,cmd,%cpu,%mem --sort=pid
echo

echo "-------------------- Services (Running / Stopped / Failed) --------------------"
systemctl list-units --type=service --all
echo

echo "-------------------- Failed Services --------------------"
systemctl --failed
echo

echo "-------------------- Listening Application Ports --------------------"
ss -tulnp
echo

echo "-------------------- All Application Ports (Listening + Established) --------------------"
ss -tunap
echo

echo "==================== End of Report ===================="
