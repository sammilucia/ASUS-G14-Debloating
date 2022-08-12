# ASUS ROG Zephyrus G14 - Software Debloating
Originally posted as the ASUS G14 bloatware cleanup guide [here](https://www.reddit.com/r/ZephyrusG14/comments/k4ch5x/asus_zephyrus_g14_bloatwear_cleanup_guide/).

## Notes:
1. _If you'd like to use a third party tool to control your G14 instead, you could use [G14ControlV2](G14ControlV2 https://github.com/aredden/electron-g14control). I haven't tried it.
2. _If you only want to control fan speeds/curves, I use [atrofac](https://github.com/cronosun/atrofac)_
3. _If you want to limit battery charging, I use [atrofac](https://github.com/cronosun/atrofac)_
3. _If you encounter problems, see the **Debugging** section at the bottom_

## What does this do?
This guide removes all possible ASUS software (MyASUS, Armoury Crates, and other unnecessary files) while still leaving critical functions intact.

## Who is this for?
Advanced users, IT professionals, enthusiasts, people who want to learn how stuff works.

## Contributors
I welcome other people to work on this project. Please [say hello](https://github.com/sammilucia) if you'd like to contribute.

## What still works after this?
- Keyboard Fn keys
- Fan control (with [atrofac](https://github.com/cronosun/atrofac))
- Battery charge limits (using atkacpi—thanks [https://reddit/u/zllovesuki](u/zllovesuki)

## What doesn't work after this
- ROG RGB lighting
- AniMe Matrix Display

## Known problems
- None at this time! :)

## Background
I've seen many posts on how to remove ASUS / ROG / Armoury and other software from the ASUS G14 notebooks, however none of them went into the detail I wanted. So I started experimenting. Below is an extensive list for how to _properly_ and _cleanly_ remove almost all ASUS software, without affecting critical functions.

Frankly my laptop is 100% function-first and I prefer as little software on there as possible. I've never missed the ASUS software. For example why do I want my PC to be able to "Link" with nearby devices? For me—I don't!

## Power usage
I'm using the WQHD G14 (2560x1440) which will probably draw more power than the FHD (1920x1080) version. However during general use my laptop sits between 5,400mW and 7,200mW of battery draw, with screen brightness on 30% and keyboard lighting on "low". This guide has reduced power usage by around 1,000mW.

## Performance
This doesn't affect performance in a noticable way. It certainly won't reduce performance. If there is any difference, it will be a few percent improvement.

## More information
Some of the ASUS services are actually installed as drivers. So if you simply remove these drivers and services, Windows will reinstall them. This procedure will show you how to cleanly remove the services and cleanup files without triggering Windows to reinstall them.

As we know, there is also the issue of Windows Updates reinstalling things on the ASUS G14. E.g. if you update the AMD or NVIDIA drivers manually, Windows Update may reinstall the official ASUS drivers, even if it's an older version. If this is the case, see the section **ASUS drivers** to block those updates from Windows Updates.

## Why not just disable drivers?
A lot of people aren't aware that disabling drivers in Device Manager also may disable the power management for those drivers (e.g. the NVIDIA USBC driver). Some devices may revert to 100% power usage when their corresponding driver is disabled, so this is not best practice.

## Useful links
- How to enable HIPM/DIPM power management for the SSD (see [here](https://www.sevenforums.com/tutorials/177819-ahci-link-power-management-enable-hipm-dipm.html))
- Disabled Turbo Boost for better power/heat management control (see [here](https://www.reddit.com/r/ZephyrusG14/comments/gho535/important_update_to_properly_disable_boosting/))
- Update the Western Digital SSD firmware using [Western Digital Dashboard](https://support.wdc.com/downloads.aspx)
- To prevent ASUS drivers from reinstalling via Windows Update use the [Microsoft "Show or hide updates" troubleshooter](http://download.microsoft.com/download/F/2/2/F22D5FDB-59CD-4275-8C95-1BE17BF70B21/wushowhide.diagcab)
- Windows 10 20H2 Services that are safe to disable [Disable Windows 10 20H2 services](https://www.deviantart.com/sammilucia/art/Windows-10-20H2-Services-that-are-safe-to-disable-861880643)

## Before starting
1. Ensure all Windows Updates are installed and the laptop is in a known-good state.
2. I recommend you use a tool like [Uninstall Tool](https://crystalidea.com/?source=uninstalltool) to cleans up files missed by several of the uninstallers below.
3. To install new NVIDIA and AMD drivers, I recommend installing both in "clean-up" or "clean install" mode, which deletes all the previous drivers and settings, then installing the most minimal set of drivers you need.

## Procedure

### Software cleanup
Uninstall
1. Uninstall Armoury Crate
2. Uninstall Armoury Service
3. Uninstall ASUS Calibration
4. Uninstall ROG CustomHotKey
5. Uninstall ASUS Framework Service
6. Uninstall ASUS Gamefirst IV (supposedly a network optimizer)
7. Uninstall ROG Live Service
8. Uninstall ROG Font Installer (AniMe Matrix font)
9. Uninstall MyASUS (used for ASUS driver and firmware updates. Remove if you prefer to manually install updates)
10. Uninstall AURA
11. Uninstall AURA Service
12. Uninstall ASUS Aac_NBOT HAL (in _Uninstall Tool_ this is under the **System** tab)

### Disable Services (basic)
The ASUS Optimization service is responsible for keyboard shortcuts, so leave that running.

Note that simply disabling some services may actually cause performance issues, if things are trying to query those services and they're not available.

1. Disable ASUSSwitch _(look at the folder location for this service first)_
2. Disable Armoury Crate Control Interface (if it wasn't uninstalled from the above)
3. Disable ASUS Link Near
4. Disable ASUS Link Near Extension
5. Disable AsusROGLSLService Download ROGLSLoader
6. Disable ASUS Link Remote
7. Disable ASUS Link Near
8. Disable ASUS Software Manager
9. Disable Asus System Analysis
10. Disable ASUS System Diagnosis
11. Disable ASUS Update Service (asus)
12. Disable ASUS Update Service (asusm)

### Remove ASUS Services (more advanced)
You can remove all the ASUS services except ASUS Optimization which is required for the hotkeys to work.

From an elevated command prompt run:
1. `sc delete ArmouryCrateControlInterface` (This will delete the Amroury Crate service if it wasn't removed by the uninstaller)
2. `sc delete ASUSLinkNear`
3. `sc delete ASUSLinkNearExt`
4. `sc delete ASUSLinkRemote`
5. `sc delete ASUSSoftwareManager`
6. `sc delete ASUSSystemAnalysis`
7. `sc delete ASUSSystemDiagnosis`
8. `sc delete asus`
9. `sc delete asusm`
10. `sc delete AsusROGLSLService`
11. `sc delete AsusAppService`
12. `sc delete ASUSSoftwareManager`

### Delete ASUS Scheduled Tasks
1. Delete ASUS Optimization {UID}
2. Delete ASUS Update Checker 2.0
3. Delete AsusSystemAnalysis_\{UID}
4. Delete MyASUSTask
5. Disable StartCN (I don't delete this, simply because it's AMD, not ASUS)
6. Delete ASUS\ArmourySocketServer
7. Delete ASUS\UpdateTaskMachineCore
8. Delete ASUS\UpdateTaskMachineUA
9. Delete ASUS\P508PowerAgent_sdk
10. Delete the ASUS folder (right-click, Delete folder)
11. Delete leftover ASUS files

### End all processes in Task Manager:
- ASUS*.exe
- Armoury*.exe
- ROG*.exe
- P50*.exe

### Delete files/folders
1. Delete the folder `C:\Program Files (x86)\ArmouryDevice`
2. Delete the folder `C:\Program Files (x86)\ROG Live Service`
3. Delete the folder `C:\Program Files (x86)\Update` _(just be careful it belongs to ASUS)_
4. Delete the folder `C:\Program Files (x86)\ASUS`
5. Delete the folder `%LocalAppData%\ASUS`
6. Delete the folder `%ProgramData%\ASUS`
7. Delete `C:\Windows\System32\DriverStore\FileRepository\asussci2.inf_amd64_{UID}\` _(you will need to take ownership of these folders)_
   - ASUSLinkNear
   - ASUSLinkRemote
   - ASUSLinkRemoteLicense
   - ASUSSoftwareManager
   - ASUSSystemAnalysis
   - ASUSSystemDiagnosis
   - _...Anything else except ASUSOptimization..._
8. Delete the folder `C:\Program Files (x86)\LightingService`
9. It's safe to delete the entire folder `C:\eSupport\` and contents
10. It's safe to delete the entire folder `C:\Drivers\` and contents
11. There were folders in `C:\Windows\System32\DriverStore\FileRepository` starting with `armourycrate*` which I deleted
12. Delete `C:\Program Files (x86)\ASUS` (whole folder)
13. Delete `C:\Program Files\ASUS` (whole folder)

### Enable On-screen display (OSD)
Thank you to [u/EbolaBoi](https://reddit.com/u/EbolaBoi) for this tip!

To enable the OSD for the Fn buttons, set the following file:
`C:\Windows\System32\DriverStore\FileRepository\asussci2.inf_amd64_{UID}\ASUSOptimization\AsusOSD.exe`
...to startup with Windows (either add it to the Startup folder or create a Scheduled Task).

_Note: If you're happy with the default Windows OSD, you don't need to run the AsusOSD.exe._

There may also be a few `asussci2.inf_amd64_{UID}` folders. They will likely have the same version number (2.1.9.0), but a binary compare reveals they are non-identical. Use the AsusOSD.exe with the newest date.

For further confirmation of using the correct file, this should also be the same file location the Asus Optimization Service runs from. You can copy this location from services.msc, i.e:
![Asus_Optimization](/images/asus_optimization.jpg)

### Limit maximum battery charge percent
Thanks again to [u/EbolaBoi](https://reddit.com/u/EbolaBoi) who achieved this by creating a Scheduled Task. THe reason for doing this is to conserve battery life.

1. Create a new Scheduled Task called "Limit Charge at 60%" (or 80%, etc.)
![Limit Battery Task 1](/images/limit_battery_task_1.png)
2. Select "Run with highest privileges"
![Limit Battery Task 2](/images/limit_battery_task_2.png)
3. Configure the Trigger to "Run at login of any user"
![Limit Battery Task 3](/images/limit_battery_task_3.png)
4. Configure the Trigger to "Run on a custom filter event" per this screenshot:
![Limit Battery Task 4](/images/limit_battery_task_4.png)
5. Add an action > Start a program > `Powershell.exe (Get-WmiObject -Namespace root/WMI -Class AsusAtkWmi_WMNB).DEVS(0x00120057, 60)` (Use 60 for 60%, 80 for 80%, etc.)
![Limit Battery Task 5](/images/limit_battery_task_5.png)
6. Conditions > Stop if the computer ceases to be idle, Stop if the computer switches to battery power

**Note: Armoury Crate Control interface** still exists in Device Manager > System devices. I'm going to leave this for now because a) it will just be reinstalled if we remove it, b) it's likely just an endpoint for the AniMe matrix display, and doesn't actually do anything without the Armoury Crate software installed, and c) I don't want to cause any power management issues or use a really hacky solution. (Everything else in this procedure is pretty clean.)

## Debugging

### 1. Microphone on/off Fn key not working
In some instances, the Keyboard Firmware update (entitled "Hotfix"—ROG Keyboard Firmware Update tool V2.3.0) does not correctly install due to an error in the `installall.bat` script. To work around this, instead of running `installall.bat`, do:

1. Run `installer.exe` as Administrator
2. Run `install.exe` as Administrator
3. Reboot

The microphone Fn key should now be working.

_Note: If you have manually disabled the inbuilt microphone in the Sound Control Panel, the microphone Fn key also won't work._
