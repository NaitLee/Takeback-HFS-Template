VERSION 5.00
Begin VB.Form FormMain 
   Appearance      =   0  'Flat
   BackColor       =   &H80000005&
   Caption         =   "Takeback your template        0.14c"
   ClientHeight    =   6135
   ClientLeft      =   60
   ClientTop       =   405
   ClientWidth     =   9855
   BeginProperty Font 
      Name            =   "Calibri"
      Size            =   9.75
      Charset         =   0
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   Icon            =   "FormMain.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   6135
   ScaleWidth      =   9855
   StartUpPosition =   2  'ÆÁÄ»ÖÐÐÄ
   Begin VB.TextBox TextCmd 
      Appearance      =   0  'Flat
      BackColor       =   &H00000000&
      BeginProperty Font 
         Name            =   "Fixedsys"
         Size            =   12
         Charset         =   134
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00E0E0E0&
      Height          =   330
      Left            =   360
      TabIndex        =   23
      Text            =   "\>::(CDFB Shell)"
      Top             =   5760
      Visible         =   0   'False
      Width           =   9135
   End
   Begin VB.DirListBox DirCurrent 
      Appearance      =   0  'Flat
      Height          =   345
      Left            =   0
      TabIndex        =   22
      Top             =   0
      Visible         =   0   'False
      Width           =   165
   End
   Begin VB.TextBox TextHelp 
      Appearance      =   0  'Flat
      BorderStyle     =   0  'None
      Height          =   2415
      Left            =   6600
      Locked          =   -1  'True
      MultiLine       =   -1  'True
      TabIndex        =   21
      Text            =   "FormMain.frx":000C
      Top             =   2640
      Width           =   3255
   End
   Begin VB.CommandButton CommandReset 
      Appearance      =   0  'Flat
      Caption         =   "Reset Selections"
      Height          =   615
      Left            =   6480
      TabIndex        =   20
      ToolTipText     =   "Useful when you selected unwanted language/font."
      Top             =   5160
      Width           =   1455
   End
   Begin VB.CommandButton CommandGo 
      Appearance      =   0  'Flat
      Caption         =   "Go!"
      Height          =   615
      Left            =   8040
      TabIndex        =   19
      Top             =   5160
      Width           =   1455
   End
   Begin VB.FileListBox FilelistDiff 
      Appearance      =   0  'Flat
      Height          =   1605
      Left            =   6600
      MultiSelect     =   1  'Simple
      Pattern         =   "*.diff.*.tpl"
      TabIndex        =   17
      ToolTipText     =   "You can also select other addons."
      Top             =   480
      Width           =   2895
   End
   Begin VB.Frame FrameCfg 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "Configurations"
      ForeColor       =   &H80000008&
      Height          =   3255
      Left            =   360
      TabIndex        =   4
      Top             =   2520
      Width           =   6015
      Begin VB.CheckBox CheckCfg 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "Override HFS settings"
         ForeColor       =   &H80000008&
         Height          =   225
         Index           =   5
         Left            =   240
         TabIndex        =   16
         ToolTipText     =   "This template requires some settings of HFS to be changed to run perfectly. You may uncheck this if you don't want."
         Top             =   2760
         Value           =   1  'Checked
         Width           =   2655
      End
      Begin VB.TextBox TextTitleText 
         Appearance      =   0  'Flat
         Height          =   330
         Left            =   480
         TabIndex        =   15
         Text            =   "HFS::%folder%"
         ToolTipText     =   "The text that will show on browser's page tab."
         Top             =   1200
         Width           =   2415
      End
      Begin VB.CheckBox CheckCfg 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "Enable jQuery"
         ForeColor       =   &H80000008&
         Height          =   225
         Index           =   4
         Left            =   3000
         TabIndex        =   13
         ToolTipText     =   "By default this template do not need jQuery. Not recommended."
         Top             =   2760
         Width           =   2655
      End
      Begin VB.CheckBox CheckCfg 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "Enable status text"
         ForeColor       =   &H80000008&
         Height          =   225
         Index           =   3
         Left            =   240
         TabIndex        =   12
         Top             =   1560
         Value           =   1  'Checked
         Width           =   2655
      End
      Begin VB.TextBox TextStatusText 
         Appearance      =   0  'Flat
         Height          =   330
         Left            =   480
         TabIndex        =   11
         Text            =   "Files here are available for view & download."
         Top             =   1800
         Width           =   5175
      End
      Begin VB.TextBox TextHeaderText 
         Appearance      =   0  'Flat
         Height          =   330
         Left            =   3240
         TabIndex        =   10
         Text            =   "HTTP File Server"
         Top             =   1200
         Width           =   2415
      End
      Begin VB.CheckBox CheckCfg 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "Enable header text"
         ForeColor       =   &H80000008&
         Height          =   225
         Index           =   2
         Left            =   3000
         TabIndex        =   9
         ToolTipText     =   "Text that will show on the middle-top of your page"
         Top             =   960
         Width           =   2655
      End
      Begin VB.CheckBox CheckCfg 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "Enable picture background"
         ForeColor       =   &H80000008&
         Height          =   225
         Index           =   1
         Left            =   240
         TabIndex        =   8
         ToolTipText     =   "If you have a fast network, you may enable this."
         Top             =   2160
         Width           =   2655
      End
      Begin VB.TextBox TextBgPath 
         Appearance      =   0  'Flat
         Height          =   330
         Left            =   480
         TabIndex        =   7
         Text            =   "/pic/img/bg/"
         ToolTipText     =   "Path of your pictures. Don't forget the last slash /"
         Top             =   2400
         Width           =   5175
      End
      Begin VB.TextBox TextDtFormat 
         Appearance      =   0  'Flat
         Height          =   330
         Left            =   480
         TabIndex        =   6
         Text            =   "mm/dd/yyyy hh:MM:ss ampm"
         ToolTipText     =   "An example format"
         Top             =   600
         Width           =   5175
      End
      Begin VB.CheckBox CheckCfg 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "Use special datetime format"
         ForeColor       =   &H80000008&
         Height          =   255
         Index           =   0
         Left            =   240
         TabIndex        =   5
         ToolTipText     =   "Datetime format for your files"
         Top             =   360
         Width           =   5415
      End
      Begin VB.Label LabelCfg 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         Caption         =   "Browser tab text"
         ForeColor       =   &H80000008&
         Height          =   255
         Left            =   480
         TabIndex        =   14
         Top             =   960
         Width           =   2415
      End
   End
   Begin VB.FileListBox FilelistLang 
      Appearance      =   0  'Flat
      Height          =   1605
      Left            =   3480
      Pattern         =   "*.font.*.tpl"
      TabIndex        =   3
      ToolTipText     =   "You may not select if you don't want this load."
      Top             =   480
      Width           =   2895
   End
   Begin VB.FileListBox FilelistFont 
      Appearance      =   0  'Flat
      Height          =   1605
      Left            =   360
      Pattern         =   "*.lng.*.tpl"
      TabIndex        =   1
      ToolTipText     =   "You may not select if you prefer English."
      Top             =   480
      Width           =   2895
   End
   Begin VB.Label LabelSlctDiff 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "Select prefered diffs:"
      ForeColor       =   &H80000008&
      Height          =   255
      Left            =   6600
      TabIndex        =   18
      Top             =   240
      Width           =   2895
   End
   Begin VB.Label LabelSlctLang 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "Select your language:"
      ForeColor       =   &H80000008&
      Height          =   255
      Left            =   360
      TabIndex        =   2
      Top             =   240
      Width           =   2895
   End
   Begin VB.Label LabelSlctFont 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Caption         =   "Select prefered font:"
      ForeColor       =   &H80000008&
      Height          =   255
      Left            =   3480
      TabIndex        =   0
      Top             =   240
      Width           =   2895
   End
End
Attribute VB_Name = "FormMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim FbCmd

Private Sub CommandReset_Click()
    FilelistFont.Refresh
    FilelistLang.Refresh
    FilelistDiff.Refresh
End Sub

Private Sub Form_Load()
    FilelistFont.Path = "takeback.stuffs"
    FilelistLang.Path = "takeback.stuffs"
    FilelistDiff.Path = "takeback.stuffs"
End Sub

Private Sub CommandGo_Click()
    Compile
End Sub

' A function for adding quotes before and after a string, and a space at end
Function Attr(str)
    Attr = Chr(34) & str & Chr(34) & " "
End Function

Function GetFbCmdCfg(ChkCfgVal, CfgBool, CfgBoolVal, CfgStr, CfgStrText)
    Temp = ""
    If CfgStr = "" Then
        If CheckCfg(ChkCfgVal).Value = 0 Then
            Temp = "=stuff|" & CfgBool & "\3d" & 0 & "\n|1"
        Else
            Temp = "=stuff|" & CfgBool & "\3d" & CfgBoolVal & "\n|1"
        End If
    Else
        If CheckCfg(ChkCfgVal).Value = 0 Then
            Temp = "=stuff|" & CfgBool & "\3d" & 0 & "\n|1=stuff|" & CfgStr & "\3d" & "" & "\n|1"
        Else
            Temp = "=stuff|" & CfgBool & "\3d" & CfgBoolVal & "\n|1=stuff|" & CfgStr & "\3d" & Replace(CfgStrText.Text, "=", "\3d") & "\n|1"
        End If
    End If
    GetFbCmdCfg = Temp
End Function

Sub Compile()
    FbCmd = DirCurrent.Path & "\" & "cdfb.bat " & Attr(DirCurrent.Path) & "fb.exe "   ' FB won't work without changing directory
    FbCmd = FbCmd & Chr(34) ' Quote sign "
    
    FbCmd = FbCmd & "=stuff|[+special:strings]\n|1=copy|takeback.stuffs\\tkb.head.tpl|0-"
    
    ' Cfg
    FbCmd = FbCmd & GetFbCmdCfg(0, "UseSpecialDateTimeFormat", 1, "DateTimeFormat", TextDtFormat)
    FbCmd = FbCmd & GetFbCmdCfg(1, "EnableImageBg", 1, "BgFolder", TextBgPath)
    FbCmd = FbCmd & GetFbCmdCfg(2, "EnableHeader", 1, "HeaderText", TextHeaderText)
    FbCmd = FbCmd & GetFbCmdCfg(3, "EnableStatus", 1, "StatusText", TextStatusText)
    FbCmd = FbCmd & GetFbCmdCfg(4, "UseJquery", 1, "", Null)
    
    ' Title
    FbCmd = FbCmd & "=stuff|TitleText\3d" & Replace(TextTitleText.Text, "%", "\25") & "|1"
    
    ' Lang & Font
    If FilelistLang.FileName <> "" Then
        FbCmd = FbCmd & "=copy|takeback.stuffs\\" & FilelistLang.FileName & "|0-"
    End If
    If FilelistFont.FileName <> "" Then
        FbCmd = FbCmd & "=copy|takeback.stuffs\\" & FilelistFont.FileName & "|0-"
    End If
    
    ' Diffs
    For i = 0 To FilelistDiff.ListCount - 1
        If FilelistDiff.Selected(i) = True Then
            FbCmd = FbCmd & "=copy|takeback.stuffs\\" & FilelistDiff.List(i) & "|0-"
        End If
    Next
    
    ' Override, must at end
    If CheckCfg(5).Value = 1 Then
        FbCmd = FbCmd & "=copy|takeback.stuffs\\tkb.cfg_override.tpl|0-"
    End If
    
    ' Others
    FbCmd = FbCmd & "=copy|takeback.stuffs\\tkb.faikquery.tpl|0-=copy|takeback.stuffs\\tkb.body.tpl|0-=copy|takeback.stuffs\\tkb.addon.djfais.tpl|0-=copy|takeback.stuffs\\tkb.addon.pre.tpl|0-=copy|takeback.stuffs\\tkb.addon.preview.tpl|0-=copy|takeback.stuffs\\tkb.addon.slideshow.tpl|0-=copy|takeback.stuffs\\tkb.addon.thumb.tpl|0-=copy|takeback.stuffs\\tkb.fileactions.tpl|0-=copy|takeback.stuffs\\tkb.ajaxctrl.tpl|0-=copy|takeback.stuffs\\tkb.errorpages.tpl|0-=copy|takeback.stuffs\\tkb.rndbg.tpl|0-=copy|takeback.stuffs\\tkb.upload.tpl|0-=copy|takeback.stuffs\\tkb.style.tpl|0-"
    
    FbCmd = FbCmd & Chr(34) ' Quote sign "
    FbCmd = FbCmd & " takeback.customized.tpl"
    TextCmd.Text = FbCmd
    Shell FbCmd, vbHide
    MsgBox "Template saved as file takeback.customized.tpl.", vbInformation, "Complete!"
End Sub
