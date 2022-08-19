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

##### AkelPad 4.9.12
Official version is 4.9.8, but there are some fixes in codesvn of sourceforget.net. I compared github version to official codesvn version, 
github version is better than codesvn version. Author of the github changed version to 4.9.12. I ported the version 4.9.12.   
AkelPad and plugins were ported to Arm32 except Scripts plugin.  I also ported aspell core file to Arm32, but I don't know how to use. 
So I don't know if ported aspell core works.   
If you want to use context menu, run command prompt as Administrator and run regsvr32.exe shellext.dll. To unregister, run regsvr32.exe /u shellext.dll.  
 