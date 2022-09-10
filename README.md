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

##### Notepad2
Official version is 4.2.25, it uses Scintilla 2.24, version of Scintilla is very old. Some issues need to fix, otherwise you can't compile pass. 

##### Notepad2-mod
Official version is 4.2.25.998. it uses Scintilla 3.7.5. In order to build for Arm32, you must change some setting in Visual Studio 2019. 
Notepad2-mod-cn is a localization version to support Chinese Simplified. Compare to Notepad2-mod 4.2.25.998, except reosurce change, I didn't find other changes.
Notepad2-zufuliu is another Notepad2-mod enhance version. In other words, it is a enhanced Notepad2 modification. Many features were added into the project.   
The project provided ARM release files. You can download from https://github.com/zufuliu/notepad2. But you need sign the related files to run.

##### Notepad3
Notepad3 is a enhanced Notepad2. It supports many features. It is easy to port Notepad3, minipath and related languages. But it is difficult to port grepWinNP3.   
In order to build x86 and x64 versions of grepWinNP3, it use NuGet to download boost libary and import to VS2019 project. Unfortunately, NuGet can't get ARM 
version of boost library. I guess that there are no arm versions for all libaries at all, not only boost. You must download boost and compile it manually. Below 
is build steps for boost:
(1) Open Developer command prompt  
(2) Enter boost uncompressed folder, and run bootstrap.bat to generate b2.exe.   
(3) Enter C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build, run vcvarsamd64_arm.bat if your host machine is Windows 64Bit. I don't 
know if it is necessary. I do it and no error occurred.  
(4) Enter boost uncompressed folder, run below command:  
b2 -j8 -a toolset=msvc-14.2 address-model=32 architecture=arm link=static threading=multi runtime-link=static --build-type=minimal stage --stagedir=stage/arm define=_ARM_WINAPI_PARTITION_DESKTOP_SDK_AVAILABLE=1  
I only need static library, so I set link=static. In order to avoid missing runtime library, I set runtime link to static for all of portings, not only boost.  
(5) There are some prompt disalogs, I click OK to skip.  
(6) You need to add boost path to Additional Include Directory and Additional Library Directory in VS2019.  
Size of compiled boost library files is huge. I don't provide them. If you want to rebhuild grepWinNP3 using the sln and vcxproj I provided, you need to compile boost yourself.  

##### 7-Zip
7-Zip doesn't provide Arm32 version in its official website. Even though you can download arm32 version from sourceforge, eg.https://sourceforge.net/projects/sevenzip/files/7-Zip/22.01/,   
but the exe and dll is not signed. It can not work under Windows RT 8.1. I split the arm32 version over two parts: 7zInstaller.exe and 7z archive. And I signed related files. Then re-generate a new installer execute file. 
If you want to use context menu, you need set owner and full control permission to below registry items:   
HKEY_CLASSES_ROOT\\*\shellex\ContextMenuHandlers
HKEY_CLASSES_ROOT\Directory\shellex\ContextMenuHandlers
HKEY_CLASSES_ROOT\Folder\shellex\ContextMenuHandlers
HKEY_CLASSES_ROOT\Directory\shellex\DragDropHandlers
HKEY_CLASSES_ROOT\Drive\shellex\DragDropHandlers   
After changed above registry items:   
For portable version, click Options of 7-Zip File Manager and check Integrate 7-Zip to shell context menu.    
For 7-Zip Installer, run installer execute file to install.   

##### WinMerge
You can not find arm32 version of WinMerge from WinMerge.org, but you can find it from https://github.com/WinMerge/winmerge/. You need resign each of files for working under Windows RT 8.1.   
You needn't compile source code to get execute files.
On Windows RT 8.1 and in Test Mode, the WinMerge app from github can't run, error info is "can not verify digital signature." I installed the Root CA, it can't run yet. 
So, I signed my certification, it works well. I don't know why.  
If you want to build WinMerge from source codes, you can open solution using VS2017, VS2019 and VS2022. There are VS solutions and projects files in WinMerge source codes. You needn't add ARM configuration, because it existed. 
I found, build gtest fail. It is not important to use WinMerge on Surface RT. It is only for test purpose. 

##### FastCopy
Latest open source version is 3.63. Here provided two versions. One is ported original version. Another is FastCopy modification to support Chinese Simplified. But the author changed app icon. 

##### SumatraPDF
Latest version used Edge WebView2, it is not suitable for Windows RT 8.1. So ported latest version is 3.3.3. It is difficult to build whole solution. The reason is that the all projects use same outpath.  
If you specified different outpath, it will be clear. I try to enable SIMD for jpeg-turbo, but failed. It failed to emebedded 14 based fonts to exe file. If missing font, you need copy tofu fonts to windows fonts.  

##### FileZilla
I found newer version from https://github.com/driver1998/filezilla-woa. But you need sign to run under Windows RT 8.1.
