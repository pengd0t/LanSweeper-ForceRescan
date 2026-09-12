# LanSweeper-ForceRescan

A simple Windows batch script that forces the local Lansweeper Agent to perform an immediate rescan and update the central Lansweeper database.

## Background

Lansweeper collects inventory data (hardware, software versions, etc.) from client PCs via a locally installed agent and stores it in a central database. Administrators use this data to run reports on software versions, vulnerabilities, and other details across the environment.

On occasion it is desirable to update Lansweeper data manually. For example, a report may show all computers running a particular version of software with a critical vulnerability, and a clean report is the metric used to confirm the issue has been resolved. In these cases there is not always a convenient built-in way to trigger an immediate scan.

This script solves that problem by stopping the Lansweeper Agent service, removing its configuration file, and restarting the service. When the agent starts again it performs a fresh scan right away. The script can also be called at the end of other scripts (for example after a software upgrade) so that Lansweeper reflects the change almost immediately and progress can be tracked in near-real time.

## How It Works

1. Stops the **Lansweeper Agent Service**
2. Waits a few seconds
3. Deletes the agent configuration file:  
   `C:\Program Files (x86)\LansweeperAgent\lsagent.ini`
4. Starts the **Lansweeper Agent Service** again
5. Waits a few more seconds

Removing the `.ini` file forces the agent to re-initialize and scan immediately when the service restarts.

## Requirements

- Must be run **as Administrator**
- Lansweeper Agent must be installed on the machine
- The script is intended to run **locally** on the target PC (it does not support remote execution)

## Usage

1. Download `LansweeperRescan.bat`
2. Right-click the file → **Run as administrator**
3. The script will stop the service, delete the configuration file, restart the service, and then pause so you can see the results

You can also call the script from other batch files or deployment tools at the end of an installation/upgrade process to force an immediate Lansweeper update.

## Notes

- The script targets the service named `Lansweeper Agent Service`.
- The configuration file path is hardcoded to the default 32-bit Program Files location. Adjust the path if your environment uses a different installation directory.
- A short delay is included between stop/start commands to allow the service to fully stop and start cleanly.
- After the script finishes, allow a short time for the agent to complete its scan and send data to the Lansweeper server before expecting the change to appear in reports.
