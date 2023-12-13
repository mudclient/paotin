Name "PaoTin++ for Windows"
OutFile setup.exe
ShowInstDetails show
AllowRootDirInstall true

!include "FileFunc.nsh"
!include "nsDialogs.nsh"
!include "winmessages.nsh"

Page custom SelectDriver
Page instfiles

var dialog
var hctrl
var drive

Function getDrivesCallback
    ${NSD_CB_AddString} $hctrl "$9"
    Push $0
FunctionEnd

Function changeSelect
    ${NSD_GetText} $hctrl $0
    StrCpy $drive $0
FunctionEnd

Function SelectDriver
    nsDialogs::Create 1018
    Pop $dialog

    ${NSD_CreateLabel} 0 10u 100% 20u "Select which disk you want to install to:"
    Pop $hctrl
    ${NSD_CreateDropList} 0 30u 100% 80u "Select"
    Pop $hctrl

    ${GetDrives} "HDD" "getDrivesCallback"
    StrCpy $drive "C:\"
    ${NSD_CB_SelectString} $hctrl "$drive"

    ${NSD_OnChange} $hctrl "changeSelect"

    nsDialogs::Show
FunctionEnd

var file
var dir

Section
    StrCpy $drive $drive 2
    StrCpy $file "$TEMP\settings.json"
    FileOpen $R3 $file w
    FileWrite $R3 "{$\r$\n"
    FileWrite $R3 "    $\"profiles$\": $\r$\n"
    FileWrite $R3 "    {$\r$\n"
    FileWrite $R3 "        $\"defaults$\": {},$\r$\n"
    FileWrite $R3 "        $\"list$\": $\r$\n"
    FileWrite $R3 "        [$\r$\n"
    FileWrite $R3 "            {$\r$\n"
    FileWrite $R3 "                $\"commandline$\": $\"$drive\\paotin\\bin\\tt++.exe ids/tintin$\",$\r$\n"
    FileWrite $R3 "                $\"guid$\": $\"{0b778637-b3ef-410d-b678-3f825e2cdef1}$\",$\r$\n"
    FileWrite $R3 "                $\"hidden$\": false,$\r$\n"
    FileWrite $R3 "                $\"name$\": $\"WinTin++$\",$\r$\n"
    FileWrite $R3 "                $\"startingDirectory$\": $\"$drive\\paotin$\"$\r$\n"
    FileWrite $R3 "            },$\r$\n"
    FileWrite $R3 "            {$\r$\n"
    FileWrite $R3 "                $\"commandline$\": $\"$drive\\paotin\\bin\\tt++.exe ids/paotin$\",$\r$\n"
    FileWrite $R3 "                $\"guid$\": $\"{0b778637-b3ef-410d-b678-3f825e2cdef2}$\",$\r$\n"
    FileWrite $R3 "                $\"hidden$\": false,$\r$\n"
    FileWrite $R3 "                $\"name$\": $\"PaoTin++ for Windows$\",$\r$\n"
    FileWrite $R3 "                $\"startingDirectory$\": $\"$drive\\paotin$\"$\r$\n"
    FileWrite $R3 "            },$\r$\n"
    FileWrite $R3 "            {$\r$\n"
    FileWrite $R3 "                $\"commandline$\": $\"$drive\\paotin\\bin\\tt++.exe ids/pkuxkx$\",$\r$\n"
    FileWrite $R3 "                $\"guid$\": $\"{0b778637-b3ef-410d-b678-3f825e2cdef3}$\",$\r$\n"
    FileWrite $R3 "                $\"hidden$\": false,$\r$\n"
    FileWrite $R3 "                $\"name$\": $\"\u5317\u5927\u4fa0\u5ba2\u884c$\",$\r$\n"
    FileWrite $R3 "                $\"startingDirectory$\": $\"$drive\\paotin$\"$\r$\n"
    FileWrite $R3 "            },$\r$\n"
    FileWrite $R3 "            {$\r$\n"
    FileWrite $R3 "                $\"commandline$\": $\"$drive\\paotin\\bin\\tt++.exe ids/thuxyj$\",$\r$\n"
    FileWrite $R3 "                $\"guid$\": $\"{0b778637-b3ef-410d-b678-3f825e2cdef4}$\",$\r$\n"
    FileWrite $R3 "                $\"hidden$\": false,$\r$\n"
    FileWrite $R3 "                $\"name$\": $\"\u6e05\u534e\u897f\u6e38\u8bb0$\",$\r$\n"
    FileWrite $R3 "                $\"startingDirectory$\": $\"$drive\\paotin$\"$\r$\n"
    FileWrite $R3 "            }$\r$\n"
    FileWrite $R3 "        ]$\r$\n"
    FileWrite $R3 "    }$\r$\n"
    FileWrite $R3 "}$\r$\n"
    FileClose $R3

    StrCpy $dir "$LocalAppData\Microsoft\Windows Terminal\Fragments\PaoTin++"
    CreateDirectory "$dir"
    CopyFiles /SILENT "$file" "$dir"
    StrCpy $dir "$LocalAppData\Microsoft\Windows Terminal Preview\Fragments\PaoTin++"
    CreateDirectory "$dir"
    CopyFiles /SILENT "$file" "$dir"
SectionEnd

Section
    StrCpy $INSTDIR "$drive\paotin"
    StrCpy $OUTDIR "$drive\paotin"
    SetOutPath "$INSTDIR"
    RMDir "$INSTDIR"
    File /r *
SectionEnd

!define CreateJunction "!insertmacro CreateJunction"

Function CreateJunction
    Exch $4
    Exch
    Exch $5
    Push $1
    Push $2
    Push $3
    Push $6
    CreateDirectory "$5"
    System::Call "kernel32::CreateFileW(w `$5`, i 0x40000000, i 0, i 0, i 3, i 0x02200000, i 0) i .r6"

    ${If} $0 = "-1"
        StrCpy $0 "0"
        RMDir "$5"
        goto create_junction_end
    ${EndIf}

    CreateDirectory "$4"  ; Windows XP requires that the destination exists
    StrCpy $4 "\??\$4"
    StrLen $0 $4
    IntOp $0 $0 * 2
    IntOp $1 $0 + 2
    IntOp $2 $1 + 10
    IntOp $3 $1 + 18
    System::Call "*(i 0xA0000003, &i4 $2, &i2 0, &i2 $0, &i2 $1, &i2 0, &w$1 `$4`, &i2 0)i.r2"
    System::Call "kernel32::DeviceIoControl(i r6, i 0x900A4, i r2, i r3, i 0, i 0, *i r4r4, i 0) i.r0"
    System::Call "kernel32::CloseHandle(i r6) i.r1"

    ${If} $0 == "0"
        RMDir "$5"
    ${EndIf}

    create_junction_end:
    Pop $6
    Pop $3
    Pop $2
    Pop $1
    Pop $5
    Pop $4
FunctionEnd

!macro CreateJunction Junction Target outVar
    Push $0
    Push "${Junction}"
    Push "${Target}"
    Call CreateJunction
    StrCpy ${outVar} $0
    Pop $0
!macroend

Section
    CreateDirectory "$drive\my-paotin"
    CreateDirectory "$drive\my-paotin\ids"
    CreateDirectory "$drive\my-paotin\etc"
    CreateDirectory "$drive\my-paotin\data"
    CreateDirectory "$drive\my-paotin\log"
    CreateDirectory "$drive\my-paotin\plugins"

    ${CreateJunction} "$drive\paotin\var" "$drive\my-paotin" $0
SectionEnd
