# ASUS ROG Zephyrus G14 - Software Debloating
Originally posted as the ASUS G14 bloatware cleanup guide [here](https://www.reddit.com/r/ZephyrusG14/comments/k4ch5x/asus_zephyrus_g14_bloatwear_cleanup_guide/).

## What does this do?
This guide removes all possible ASUS software while still leaving critical functions working.

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

## Background
I've seen many posts on how to remove ASUS / ROG / Armoury and other software from the ASUS G14 notebooks, however none of them went into the detail I wanted. So I started experimenting. Below is an extensive list for how to _properly_ and _cleanly_ remove almost all ASUS software, without affecting critical functions.

## Power usage
I'm using the WQHD G14 (2560x1440) which will probably draw more power than the FHD (1920x1080) version. However during general use my laptop sits between 6,200mW and 8,900mW of battery draw, with screen brightness on 30% and keyboard lighting on "low". This guide has reduced power usage by around 1,000mW. This is with [Bitdefender Free](https://www.bitdefender.com/solutions/free.html), [MacType](https://github.com/snowie2000/mactype) (of which I am also an author), [Rainmeter](https://www.rainmeter.net/), [Free Shooter](https://www.henrypp.org/product/freeshooter), [Mullvad VPN](https://mullvad.net/en/), [TinyWall](https://tinywall.pados.hu/), two instances of Google Backup & Sync x2 (idle), and [Phrase Express Client](https://www.phraseexpress.com/) running.

## Performance
This doesn't affect performance in a noticable way. It certainly won't reduce performance. If there is any difference, it will be a few percent improvement.

## More information
Some of the ASUS services are actually installed as drivers. So if you simply remove these drivers and services, Windows will reinstall them. This procedure will show you how to cleanly remove the services and cleanup files without triggering Windows to reinstall them.

As we know, there is also the issue of Windows Updates reinstalling things on the ASUS G14. E.g. if you update the AMD or NVIDIA drivers manually, Windows Update may reinstall the official ASUS drivers, even if it's an older version. If this is the case, see the section **ASUS drivers** to block those updates from Windows Updates.

## Why not just disable drivers?
A lot of people aren't aware that disabling drivers in Device Manager also may disable the power management for those drivers (e.g. the NVIDIA USBC driver). Some devices may revert to 100% power usage when their corresponding driver is disabled, so this is not best practice.

## Links useful links
- How to enable HIPM/DIPM power management for the SSD (see [here](https://www.sevenforums.com/tutorials/177819-ahci-link-power-management-enable-hipm-dipm.html))
- Disabled Turbo Boost for better power/heat management control (see [here](https://www.reddit.com/r/ZephyrusG14/comments/gho535/important_update_to_properly_disable_boosting/))
- Update the Western Digital SSD firmware using [Western Digital Dashboard](https://support.wdc.com/downloads.aspx)
- To prevent ASUS drivers from reinstalling via Windows Update use the [Microsoft "Show or hide updates" troubleshooter](https://support.microsoft.com/en-us/help/3183922/how-to-temporarily-prevent-a-windows-update-from-reinstalling-in-windo)

## Before starting
1. Ensure all Windows Updates are installed and the laptop is in a known-good state.
1. I recommend you use a tool like [Uninstall Tool](https://crystalidea.com/?source=uninstalltool) to cleans up files missed by several of the uninstallers below.
2. To install new NVIDIA and AMD drivers, I recommend installing both in "clean-up" or "clean install" mode, which deletes all the previous drivers and settings, then installing the most minimal set of drivers you need.

## Procedure



[Edit 1] **Armoury Crate Control interface** still exists in Device Manager > System devices. I'm going to leave this for now because a) it will just be reinstalled if we remove it, b) it's likely just an endpoint for the AniMe matrix display, and doesn't actually do anything without the Armoury Crate software installed, and c) I don't want to cause any power management issues or use a really hacky solution. (Everything else in this procedure is pretty clean.)

### Software cleanup
Using your uninstaller of choice:
1. Uninstall Armoury Crate
3. Uninstall ASUS Framework Service
4. Uninstall ASUS Gamefirst IV (supposedly a network optimizer)
5. Uninstall ROG Live Service
6. Uninstall ROG Font Installer (AniMe Matrix font)
7. Uninstall MyASUS (used for ASUS driver and firmware updates. Remove if you prefer to control these manually)
8. Uninstall AURA
9. Uninstall AURA Service

### Disable Services (basic)
The ASUS Optimization service is responsible for keyboard shortcuts, so leave that running.

Note that simply disabling some services may actually cause performance issues, if things are trying to query those services and they're not available.

1. Disable Armoury Crate Control Interface (if it wasn't uninstalled from the above)
2. Disable ASUS Link Near
3. Disable ASUS Link Near Extension
4. Disable ASUS Link Remote
5. Disable ASUS Link Near
7. Disable ASUS Software Manager
8. Disable Asus System Analysis
9. Disable ASUS System Diagnosis
10. Disable ASUS Update Service (asus)
11. Disable ASUS Update Service (asusm)

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

### Delete ASUS Scheduled Tasks
1. Delete ASUS Update Checker 2.0
2. Delete AsusSystemAnalysis_\[UUID]
3. Delete MyASUSTask
4. Disable StartCN (I don't delete this, simply because it's AMD, not ASUS)
5. Delete ASUS\ArmourySocketServer
6. Delete ASUS\UpdateTaskMachineCore
7. Delete ASUS\UpdateTaskMachineUA
8. Delete ASUS\P508PowerAgent_sdk
9. Delete the ASUS folder (right-click, Delete folder)
10. Delete leftover ASUS files

### End all processes in Task Manager:
- ASUS*.exe
- Armoury*.exe
- ROG*.exe
- P50*.exe

### Delete files/folders
1. Delete the folder C:\Program Files (x86)\ArmouryDevice
2. Delete the folder C:\Program Files (x86)\ROG Live Service
3. Delete the folder C:\Program Files (x86)\Update
4. Delete the folder C:\Program Files (x86)\ASUS
5. Delete the folder %LocalAppData%\ASUS
6. Delete C:\Windows\System32\DriverStore\FileRepository\asussci2.inf_amd64_34ba03d292044348\ (**Note:** *I haven't done this next step, it's not necessary as the services are deleted, and it will corrupt the driver signature {CAT} which could cause Windows to reinstall it and undo everything you've done.*)
 - ASUSLinkNear
 - ASUSLinkRemote
 - ASUSLinkRemoteLicense
 - ASUSSoftwareManager
 - ASUSSystemAnalysis
 - ASUSSystemDiagnosis

### Limit maximum battery charge percent
Thanks to [u/EbolaBoi](https://reddit.com/u/EbolaBoi) who achieved this by creating a Scheduled Task. THe reason for doing this is to conserve battery life.

1. Create a new Scheduled Task called "Limit Charge at 60%" (or 80%, etc.)
![Limit Battery Task 1](/images/limit_battery_task_1.png)
2. Select "Run with highest privileges"
![Limit Battery Task 2](/images/limit_battery_task_2.png)
3. Configure the Trigger to "Run at login of any user"
![Limit Battery Task 3](/images/scheduled_task_3.png)
4. Configure the Trigger to "Run on a custom filter event" per this screenshot:
![Limit Battery Task 4](/images/scheduled_task_4.png)
5. Add an action > Start a program > `Powershell.exe (Get-WmiObject -Namespace root/WMI -Class AsusAtkWmi_WMNB).DEVS(0x00120057, 60)` (Use 60 for 60%, 80 for 80%, etc.)
![Limit Battery Task 5](/images/scheduled_task_5.png)
6. Conditions > Stop if the computer ceases to be idle, Stop if the computer switches to battery power

### Disabling Windows 10 20H2 services
See my guide here for Windows 10 20H2 Services are safe to disable: https://www.deviantart.com/sammilucia/art/Windows-10-20H2-Services-that-are-safe-to-disable-861880643
