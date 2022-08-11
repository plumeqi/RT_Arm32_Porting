# RT_Arm32_Porting
 Porting several apps to Surface RT

Here, I ported several open source apps to Windows on Arm32.  
I compiled them using Visual Studio 2019 with installing individual ARM components. I only added ARM Release configuration.  

##### Notepad++ 8.4.4
I modified some codes to support Arm32:
- Add Arm32 Arch_Type
- Disable AutoUpdate
NppShell had been ported. You can run command prompt as Administrator and input regsvr32 /i NppShell.dll to install ContextMenu.  
But, you must add Administrators group to HKEY_CLASSES_ROOT and set permission to Full Control. You also must add Administrators 
group to HKEY_CLASSES_ROOT\*\shellex\ContextMenuHandlers and set permission to Full Control. You can run SetContextMenu.cmd as 
Administrator, it will give you some information and help you install context menu.  
NppPluginList had been ported. You can download, install and remove plugins via Plugin Admin. I ported 34 plugins.   

 