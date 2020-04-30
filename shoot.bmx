' Needed for joystick support
Import Pub.FreeJoy

Incbin "./pictures/michael_cochonou-104_72.png"
Incbin "./pictures/life.png"
' Incbin "./pictures/game_over.png"
Incbin "./pictures/black.png"
Incbin "./pictures/evilchaussure-1-small.png"
Incbin "./pictures/evilchaussure-2-small.png"
Incbin "./pictures/evilchaussure-3-small.png"
Incbin "./pictures/evilchaussure-dead-1-small.png"
Incbin "./pictures/evilchaussure-dead-2-small.png"
Incbin "./pictures/evilpiou-1-small.png"
Incbin "./pictures/evilpiou-2-small.png"
Incbin "./pictures/evilpiou-3-small.png"
Incbin "./pictures/evilpiou-dead-1-small.png"
Incbin "./pictures/evilpiou-dead-2-small.png"
Incbin "./pictures/background_final.png"
Incbin "./pictures/mc-gp-invocation1-500_480.png"
Incbin "./pictures/mc-gp-invocation2-500_480.png"
Incbin "./pictures/mc-gp-invocation3-500_480.png"
Incbin "./pictures/mc-gp-invocation4-500_480.png"
Incbin "./pictures/michael_bullet.png"
Incbin "./pictures/bonus-mark.png"
Incbin "./pictures/title_screen3.png"
Incbin "./pictures/logo_studio_line-640_240.png"
Incbin "./pictures/bleu.png"
Incbin "./pictures/bombe-300.png"
' Incbin "./pictures/baignoire-300.png"
' Incbin "./pictures/baignoire-200.png"
' Incbin "./pictures/canard-300.png"
Incbin "./pictures/bombe-64.png"
' Incbin "./pictures/baignoire-64.png"
' Incbin "./pictures/canard-64.png"
' Incbin "./pictures/canard-action.png"
Incbin "./pictures/bomb-action.png"
' Incbin "./pictures/baignoire-action.png"
Incbin "./fonts/snap_itc.TTF"
Incbin "./fonts/habbo.ttf"

' Fullscreen mode
Graphics 640,480,32
' Windowed mode
' Graphics 640,480,0
SetBlend ALPHABLEND
HideMouse()
If Not JoyCount() Then
	WriteStdout("No joystick found ! -- JoyCount()="+JoyCount()+Chr(13)+Chr(10))
EndIf

' Constant declaration and initialization
Const iIBFEVILCHAUSSURES:Int=20
Const iIBFEVILPIOUS:Int=10
Const iEVILCHAUSSURESSHOOTBONUS:Int=200
Const iEVILPIOUSSHOOTBONUS:Int=100

' Variables declaration and intialization
' Images
Local bmMichael:TImage=LoadImage("incbin::./pictures/michael_cochonou-104_72.png",FILTERED=-1)
Local bmLife:TImage=LoadImage("incbin::./pictures/life.png",FILTERED=-1)
' Local bmGameOver:TImage=LoadImage("incbin::./pictures/game_over.png",FILTERED=-1)
Local bmBlack:TImage=LoadImage("incbin::./pictures/black.png",FILTERED=-1)
Local bmBkg1:TImage=LoadImage("incbin::./pictures/background_final.png",FILTERED=-1)
Local bmBkg2:TImage=LoadImage("incbin::./pictures/background_final.png",FILTERED=-1)
Local bmInvocation1:TImage=LoadImage("incbin::./pictures/mc-gp-invocation1-500_480.png",FILTERED=-1)
Local bmInvocation2:TImage=LoadImage("incbin::./pictures/mc-gp-invocation2-500_480.png",FILTERED=-1)
Local bmInvocation3:TImage=LoadImage("incbin::./pictures/mc-gp-invocation3-500_480.png",FILTERED=-1)
Local bmInvocation4:TImage=LoadImage("incbin::./pictures/mc-gp-invocation4-500_480.png",FILTERED=-1)
' Local bmBonusMark:TImage=LoadImage("incbin::./pictures/bonus-mark.png",FILTERED=-1)
Local bmTitleScreen:TImage=LoadImage("incbin::./pictures/title_screen3.png",FILTERED=-1)
Local bmStudioLineLogo:TImage=LoadImage("incbin::./pictures/logo_studio_line-640_240.png",FILTERED=-1)
' Local bmBonusScreenBkg1:TImage=LoadImage("incbin::./pictures/bleu.png",FILTERED=-1)
' Local bmBonusScreenBkg2:TImage=LoadImage("incbin::./pictures/bleu.png",FILTERED=-1)
' Local bmBombe:TImage=LoadImage("incbin::./pictures/bombe-300.png",FILTERED=-1)
' Local bmBaignoire:TImage=LoadImage("incbin::./pictures/baignoire-300.png",FILTERED=-1)
' Local bmBaignoire200:TImage=LoadImage("incbin::./pictures/baignoire-200.png",FILTERED=-1)
' Local bmCanard:TImage=LoadImage("incbin::./pictures/canard-300.png",FILTERED=-1)
Local bmBombeIcon:TImage=LoadImage("incbin::./pictures/bombe-64.png",FILTERED=-1)
' Local bmBaignoireIcon:TImage=LoadImage("incbin::./pictures/baignoire-64.png",FILTERED=-1)
' Local bmCanardIcon:TImage=LoadImage("incbin::./pictures/canard-64.png",FILTERED=-1)
' Local bmBombAction:TImage=LoadImage("incbin::./pictures/bomb-action.png",FILTERED=-1)
' Local bmCanardAction:TImage=LoadImage("incbin::./pictures/canard-action.png",FILTERED=-1)
' Local bmBaignoireAction:TImage=LoadImage("incbin::./pictures/baignoire-action.png",FILTERED=-1)
Local bmMichaelBullet:TImage=LoadImage("incbin::./pictures/michael_bullet.png",FILTERED=-1)
' Fonts
Global fntSnapITC40:TImageFont=LoadImageFont("incbin::./fonts/snap_itc.TTF",40)
Global fntSnapITC60:TImageFont=LoadImageFont("incbin::./fonts/snap_itc.TTF",60)
Global fntSnapITC65:TImageFont=LoadImageFont("incbin::./fonts/snap_itc.TTF",65)
Global fntHabbo18:TImageFont=LoadImageFont("incbin::./fonts/habbo.ttf",18)
' Timers
Local tmrTimer25:TTimer=CreateTimer(25)
Local tmrTimer50:TTimer=CreateTimer(50)
Local tmrTimer500:TTimer=CreateTimer(500)
' Integers
Local iMichaelWidth:Int=ImageWidth(bmMichael)
Local iMichaelHeight:Int=ImageHeight(bmMichael)
Local iMichaelPosX:Int=0
Local iMichaelPosY:Int=0
Local iMichaelMoveStep:Int=3
' Local iMichaelLife:Int=2
Local iMichaelLife:Int=16
Local iMichaelRotation:Int=0
Local iMichaelScore:Int=0
Local iShootLockCntr:Int=0
Local iLifeIndicatorRefreshCntr:Int=0
Local iBkg1PosX:Int=0
Local iBkg2PosX:Int=1279
Local iOldRed:Int=0
Local iOldGreen:Int=0
Local iOldBlue:Int=0
Local iGlobalFrameCntr:Int=0
Local iEvilChaussureOldGlobalFrameCntr:Int=0
Local iCurrentTitleScreenFrame:Int=0
Local iBonusScreenCntr:Int=0
Local iBombSequenceStep:Int=1
Local iCurrentBonusNbr:Int=1
' Local iPlayerBonus:Int=0
Local iPlayerBonus:Int=1
Local iBonusActionStep:Int=1
Local iBonusActionCntr:Int=0
Local iGameOverCurrentStep:Int=1
Local iGameOverFrameCntr:Int=0
Local iCurrentAlphabetCharacter:Int=0
Local iCurrentPlayerNameCharacter:Int=0
Local iInitScoreTableCntr:Int=0
Local iBombActionBackgroundColor:Int=1
Local iBestScore:Int=0
' Booleans
Local bGameOver:Byte=False
Local bMichaelDamaged:Byte=False
Local bMichaelHasBomb:Byte=False
Local bBombSequenceRunning:Byte=False
Local bStartGame:Byte=False
Local bQuitGame:Byte=False
Local bBonusScreenOn:Byte=False
' Local bPlayerHasBonus:Byte=False
Local bPlayerHasBonus:Byte=True
Local bPlayerUsesBonus:Byte=False
Local bGameOverStep1Init:Byte=False
Local bGameOverStep2Init:Byte=False
Local bGameOverStep3Init:Byte=False
Local bGameOverStep4Init:Byte=False
Global bJoystickEnabled:Byte=False
Local bIsNewRecordEstablished:Byte=False
' Floats
Local fFloatingTextAlphaCounter:Float=0.0
Local fFade2BlackCntr:Float=0.0
Local fGameOverStep1Alpha:Float=0.0
Local fGameOverStep3Alpha:Float=0.0
' Sound samples
Local oggShoot:TSound=LoadSound("./sound/03.ogg",False)
Local oggBomb:TSound=LoadSound("./sound/19.ogg",False)
Local oggShoeDeath:TSound=LoadSound("./sound/01.ogg",False)
Local oggPiouDeath:TSound=LoadSound("./sound/02.ogg",False)
' Arrays
Global arAnimFramesPool:TImage[10]
Local arAlphabet:String[]=["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
Local arCurrentPlayerName:String[]=["","",""]

arAnimFramesPool[0]=LoadImage("incbin::./pictures/evilchaussure-1-small.png",FILTERED=-1)
arAnimFramesPool[1]=LoadImage("incbin::./pictures/evilchaussure-2-small.png",FILTERED=-1)
arAnimFramesPool[2]=LoadImage("incbin::./pictures/evilchaussure-3-small.png",FILTERED=-1)
arAnimFramesPool[3]=LoadImage("incbin::./pictures/evilchaussure-dead-1-small.png",FILTERED=-1)
arAnimFramesPool[4]=LoadImage("incbin::./pictures/evilchaussure-dead-2-small.png",FILTERED=-1)
arAnimFramesPool[5]=LoadImage("incbin::./pictures/evilpiou-1-small.png",FILTERED=-1)
arAnimFramesPool[6]=LoadImage("incbin::./pictures/evilpiou-2-small.png",FILTERED=-1)
arAnimFramesPool[7]=LoadImage("incbin::./pictures/evilpiou-3-small.png",FILTERED=-1)
arAnimFramesPool[8]=LoadImage("incbin::./pictures/evilpiou-dead-1-small.png",FILTERED=-1)
arAnimFramesPool[9]=LoadImage("incbin::./pictures/evilpiou-dead-2-small.png",FILTERED=-1)

' Custom types
Type TGraphicalObject
	Field iType:Int
	Field szOwner:String
	Field iInitialPosX:Int
	Field iInitialPosY:Int
	Field iCurrentPosX:Int
	Field iCurrentPosY:Int
	Field iWidth:Int
	Field iHeight:Int
	Field iXSpeed:Int
	Field iYSpeed:Int
	Field iMovePattern:Int
	Field iDamage:Int
	Field iLife:Int
	Field iAnimFirstFrame:Int
	Field iAnimLastFrame:Int
	Field iIterationsBetweenFrames:Int
	Field iCurrentAnimFrame:Int
	Field iNbrIterationsSinceLastFrame:Int
	Field fAlpha:Float
	Field szEmbeddedData:String
	Function CreateGO:TGraphicalObject(p_iType:Int, p_szOwner:String, p_iInitialPosX:Int, p_iInitialPosY:Int, p_iCurrentPosX:Int, p_iCurrentPosY:Int, p_iWidth:Int, p_iHeight:Int, p_iXSpeed:Int, p_iYSpeed:Int, p_iMovePattern:Int, p_iDamage:Int, p_iLife:Int, p_iAnimFirstFrame:Int, p_iAnimLastFrame:Int, p_iIterationsBetweenFrames:Int, p_iCurrentAnimFrame:Int, p_iNbrIterationsSinceLastFrame:Int, p_fAlpha:Float, p_szEmbeddedData:String)
		Local NewGO:TGraphicalObject = New TGraphicalObject
		' Type 0 = Shoot
		' Type 1 = EvilChaussure
		' Type 2 = EvilPiou
		' Type 3 = Floating Text
		' Type 4 = Bonus
		' Type 5 = Duck
		' Type 6 = Baignoire
		' Type 7 = Bomb
		' Type 8 = Dead EvilChaussure
		' Type 9 = Dead EvilPiou
		NewGO.iType=p_iType
		NewGO.szOwner=p_szOwner
		NewGO.iInitialPosX=p_iInitialPosX
		NewGO.iInitialPosY=p_iInitialPosY
		NewGO.iCurrentPosX=p_iCurrentPosX
		NewGO.iCurrentPosY=p_iCurrentPosY
		NewGO.iWidth=p_iWidth
		NewGO.iHeight=p_iHeight
		NewGO.iXSpeed=p_iXSpeed
		NewGO.iYSpeed=p_iYSpeed
		NewGO.iMovePattern=p_iMovePattern
		NewGO.iDamage=p_iDamage
		NewGO.iLife=p_iLife
		NewGO.iAnimFirstFrame=p_iAnimFirstFrame
		NewGO.iAnimLastFrame=p_iAnimLastFrame
		NewGO.iIterationsBetweenFrames=p_iIterationsBetweenFrames
		NewGO.iCurrentAnimFrame=p_iCurrentAnimFrame
		NewGO.iNbrIterationsSinceLastFrame=p_iNbrIterationsSinceLastFrame
		NewGO.fAlpha=p_fAlpha
		NewGO.szEmbeddedData=p_szEmbeddedData
		Return NewGO
	End Function
End Type

Type TScore
	Field szPlayerName:String
	Field iPlayerScore:Int
	Function InitScoreTable:TScore()
		Local NewScore:TScore = New TScore
			NewScore.szPlayerName=""
			NewScore.iPlayerScore=0
		Return NewScore
	End Function
	Function RegisterNewScore:Int(p_szPlayerName:String, p_iPlayerScore:Int)
		Local iRegistrationState:Int=0
		Local iScoreParsingCntr:Int=0
		Local bStopScoreParsing:Byte=False
		While bStopScoreParsing=False
			' The score table is parsed until
			' a score that is inferior to player's score is found
			' or until the end
			If arHallOfFame[iScoreParsingCntr].iPlayerScore<=p_iPlayerScore Then
				' The player enters the Hall of Fame !
				bStopScoreParsing=True
				iRegistrationState=0
				For iScoreInsertionCntr=4 To iScoreParsingCntr Step -1
					arHallOfFame[iScoreInsertionCntr+1]=arHallOfFame[iScoreInsertionCntr]
				Next
				arHallOfFame[iScoreParsingCntr].szPlayerName=p_szPlayerName
				arHallOfFame[iScoreParsingCntr].iPlayerScore=p_iPlayerScore
			EndIf
			iScoreParsingCntr:+1
			If iScoreParsingCntr=6 Then
				' The player won't enter the HoF...
				bStopScoreParsing=True
				iRegistrationState=1
			EndIf
		Wend
		Return iRegistrationState
	End Function
End Type

' Custom type variables
Local CurrentGO:TGraphicalObject
Local CurrentGO2:TGraphicalObject
Local CurrentGO3:TGraphicalObject
Global arHallOfFame:TScore[6]

' Initialization of the score table
For iInitScoreTableCntr=0 To 5
	arHallOfFame[iInitScoreTableCntr]=TScore.InitScoreTable()
Next

' Lists
Global GOList:TList = New TList

' The game

' Backup initial color panel
GetColor(iOldRed,iOldGreen,iOldBlue)

' Random numbers generator initialization
SeedRnd(MilliSecs())

' Enemies creation
generateNewEnemyBatch()

If JoyCount() Then
	bJoystickEnabled=True
EndIf

' Studio Line logo
Cls
DrawImage(bmStudioLineLogo,0,120)
Flip
Delay 3000
' Fade to black for Studio Line Logo
While fFade2BlackCntr<1.0
	Cls
	DrawImage(bmStudioLineLogo,0,120)
	SetAlpha fFade2BlackCntr
	fFade2BlackCntr:+0.1
	DrawImage(bmBlack,0,0)
	SetAlpha 1.0
	Flip
	WaitTimer(tmrTimer25)
Wend
' Fade to white for Title screen
While fFade2BlackCntr>0.0
	Cls
	DrawImage(bmTitleScreen,0,0)
	DrawImage(bmInvocation1,300,30)
	SetAlpha fFade2BlackCntr
	fFade2BlackCntr:-0.1
	DrawImage(bmBlack,0,0)
	SetAlpha 1.0
	Flip
	WaitTimer(tmrTimer25)
Wend

FlushKeys()

' Title screen loop
While bStartGame=False
	' Keyboard input management
	' SPACE = Start to play
	If KeyHit(KEY_SPACE) Then
		bStartGame=True
	EndIf
	If bJoystickEnabled=True Then
		' With joystick, FIRE = Start to play
		If JoyDown(0) Then
			bStartGame=True
		EndIf
	EndIf
	' ESCAPE = Quit the game
	If KeyHit(KEY_ESCAPE) Then
		bStartGame=True
		bQuitGame=True
	EndIf
	' Display refresh
	Cls
	' Background
	DrawImage(bmTitleScreen,0,0)
	' Michael animation
	iCurrentTitleScreenFrame:+1
	If iCurrentTitleScreenFrame=57 Then
		iCurrentTitleScreenFrame=0
	EndIf
	If iCurrentTitleScreenFrame<=20 Then
		DrawImage(bmInvocation1,300,30)
	Else
		If iCurrentTitleScreenFrame<=22 Then
			DrawImage(bmInvocation2,300,30)
		Else
			If iCurrentTitleScreenFrame<=24 Then
				DrawImage(bmInvocation3,300,30)
			Else
				If iCurrentTitleScreenFrame<=26 Then
					DrawImage(bmInvocation4,300,30)
				Else
					If iCurrentTitleScreenFrame<=56 Then
						DrawImage(bmInvocation1,300,30)
					EndIf
				EndIf
			EndIf
		EndIf
	EndIf
	If (iCurrentTitleScreenFrame>=0) And (iCurrentTitleScreenFrame<15) Then
		afficherTexte("Press SPACE or FIRE to start","habbo18",255,255,255,0,0,0,0,15,440,0)
	Else
		If (iCurrentTitleScreenFrame>=30) And (iCurrentTitleScreenFrame<45) Then
			afficherTexte("Press SPACE or FIRE to start","habbo18",255,255,255,0,0,0,0,15,440,0)
		EndIf
	EndIf
	' afficherTexte("X="+MouseX()+"   ---   Y="+MouseY(),"",255,255,255,0,0,0,0,10,240,0)
	WaitTimer(tmrTimer25)
	Flip
Wend

' Main loop
While bQuitGame=False
	Cls
	' Global frame counter incrementation
	iGlobalFrameCntr:+1
	' Keyboard input
	' ESCAPE = Quit the game
	If KeyHit(KEY_ESCAPE) Then
		bQuitGame=True
	EndIf
	Rem
	' Too slow on Macintosh
	If JoyCount() Then
		bJoystickEnabled=True
	Else
		bJoystickEnabled=False
	EndIf
	EndRem
	If (bGameOver=False) And (bBonusScreenOn=False) Then
		' UP
		' With keyboard
		If KeyDown(KEY_UP) Then
			iMichaelPosY:-iMichaelMoveStep
			If iMichaelPosY<0 Then
				iMichaelPosY=0
			EndIf
		EndIf
		If bJoystickEnabled=True Then
			' With joystick
			If JoyY(0)<-0.5 Then
				iMichaelPosY:-iMichaelMoveStep
				If iMichaelPosY<0 Then
					iMichaelPosY=0
				EndIf
			EndIf
		EndIf
		' DOWN
		' With keyboard
		If KeyDown(KEY_DOWN) Then
			iMichaelPosY:+iMichaelMoveStep
			If iMichaelPosY>407 Then
				iMichaelPosY=407
			EndIf
		EndIf
		If bJoystickEnabled=True Then
			' With joystick
			If JoyY(0)>0.5 Then
				iMichaelPosY:+iMichaelMoveStep
				If iMichaelPosY>407 Then
					iMichaelPosY=407
				EndIf
			EndIf
		EndIf
		' LEFT
		' With keyboard
		If KeyDown(KEY_LEFT) Then
			iMichaelPosX:-iMichaelMoveStep
			If iMichaelPosX<-20 Then
				iMichaelPosX=-20
			EndIf
		EndIf
		If bJoystickEnabled=True Then
			' With joystick
			If JoyX(0)<-0.5 Then
				iMichaelPosX:-iMichaelMoveStep
				If iMichaelPosX<-20 Then
					iMichaelPosX=-20
				EndIf
			EndIf
		EndIf
		' RIGHT
		' With keyboard
		If KeyDown(KEY_RIGHT) Then
			iMichaelPosX:+iMichaelMoveStep
			If iMichaelPosX>536 Then
				iMichaelPosX=536
			EndIf
		EndIf
		If bJoystickEnabled=True Then
			' With joystick
			If JoyX(0)>0.5 Then
				iMichaelPosX:+iMichaelMoveStep
				If iMichaelPosX>536 Then
					iMichaelPosX=536
				EndIf
			EndIf
		EndIf
		' SHOOT
		' With keyboard
		If (KeyDown(KEY_SPACE)) And (bPlayerUsesBonus=False) Then
			If iShootLockCntr=0 Then
				iShootLockCntr=15
				GOList.AddLast(TGraphicalObject.CreateGO(0, "player1", iMichaelPosX+90, iMichaelPosY+44, iMichaelPosX+90, iMichaelPosY+44, 10, 4, 10, 0, 999, 1, (640-(iMichaelPosX+90)), 999, 999, 0, 0, 0, 1.0, ""))
				PlaySound oggShoot
			EndIf
		EndIf
		If bJoystickEnabled=True Then
			' With joystick
			If JoyDown(0) Then
				If iShootLockCntr=0 Then
					iShootLockCntr=15
					GOList.AddLast(TGraphicalObject.CreateGO(0, "player1", iMichaelPosX+90, iMichaelPosY+44, iMichaelPosX+90, iMichaelPosY+44, 10, 4, 10, 0, 999, 1, (640-(iMichaelPosX+90)), 999, 999, 0, 0, 0, 1.0, ""))
					PlaySound oggShoot
				EndIf
			EndIf
		EndIf
		' TAB
		If KeyDown(KEY_TAB) Then
			debugMenu()
			SetColor iOldRed,iOldGreen,iOldBlue
		EndIf
		' iShootLockCntr update
		If iShootLockCntr>0 Then
			iShootLockCntr:-1
		EndIf
		' BOMB
		If (KeyHit(KEY_B) Or JoyDown(1)) And (bPlayerUsesBonus=False) Then
			' If the player presses B while having a bonus
			If bPlayerHasBonus=True Then
				bPlayerUsesBonus=True
				PlaySound oggBomb
				For CurrentGO3 = EachIn GOList
					If (CurrentGO3.iType=1) Then
						iMichaelScore:+iEVILCHAUSSURESSHOOTBONUS
						iMichaelScore:+iMichaelPosX
						' The EvilChaussure is transformed into a Dead EvilChaussure
						CurrentGO3.iType=8
						CurrentGO3.iXSpeed=0
						CurrentGO3.iYSpeed=4
						CurrentGO3.iDamage=0
						CurrentGO3.iLife=1
						CurrentGO3.iAnimFirstFrame=3
						CurrentGO3.iAnimLastFrame=4
						CurrentGO3.iIterationsBetweenFrames=30
						CurrentGO3.iCurrentAnimFrame=3
						CurrentGO3.iNbrIterationsSinceLastFrame=0
						' Floating text appears on screen
						GOList.AddLast(TGraphicalObject.CreateGO(3, "cpu", CurrentGO3.iCurrentPosX, CurrentGO3.iCurrentPosY, CurrentGO3.iCurrentPosX, CurrentGO3.iCurrentPosY, 0, 0, 1, 0, 666, 0, 20, 0, 0, 0, 0, 20, 1.0, "+"+(iEVILCHAUSSURESSHOOTBONUS+iMichaelPosX)))
					Else
						If (CurrentGO3.iType=2) Then
							iMichaelScore:+iEVILPIOUSSHOOTBONUS
							iMichaelScore:+(iMichaelPosX/2)
							' The EvilPiou is transformed into a Dead EvilPiou
							CurrentGO3.iType=9
							CurrentGO3.iXSpeed=0
							CurrentGO3.iYSpeed=4
							CurrentGO3.iDamage=0
							CurrentGO3.iLife=1
							CurrentGO3.iAnimFirstFrame=8
							CurrentGO3.iAnimLastFrame=9
							CurrentGO3.iIterationsBetweenFrames=30
							CurrentGO3.iCurrentAnimFrame=8
							CurrentGO3.iNbrIterationsSinceLastFrame=0
							' Floating text appears on screen
							GOList.AddLast(TGraphicalObject.CreateGO(3, "cpu", CurrentGO3.iCurrentPosX, CurrentGO3.iCurrentPosY, CurrentGO3.iCurrentPosX, CurrentGO3.iCurrentPosY, 0, 0, 1, 0, 666, 0, 20, 0, 0, 0, 0, 20, 1.0, "+"+(iEVILPIOUSSHOOTBONUS+(iMichaelPosX/2))))
						EndIf
					EndIf
				Next
			EndIf
		EndIf
	EndIf
	If bBonusScreenOn=False Then
		' Display refresh
		' Background
		' First background tile
		iBkg1PosX:-1
		If iBkg1PosX<=-1280 Then
			iBkg1PosX=1279
		EndIf
		DrawImage(bmBkg1,iBkg1PosX,0)
		' Second background tile
		iBkg2PosX:-1
		If iBkg2PosX<=-1280 Then
			iBkg2PosX=1279
		EndIf
		If (iBkg2PosX<640) And (iBkg2PosX<639) Then
			DrawImage(bmBkg2,iBkg2PosX,0)
		EndIf
		' Bonus action loop
		If bPlayerUsesBonus=True Then
			Select iBonusActionStep
				Case 1
					' The bonus is displayed in fullscreen
					If iPlayerBonus=1 Then
						' Bombe
						If iBonusActionCntr<50 Then
							If iBombActionBackgroundColor=1 Then
								iBombActionBackgroundColor=2
								SetColor 254,5,5
								DrawRect 0,0,640,480
							Else
								iBombActionBackgroundColor=1
								SetColor 254,251,5
								DrawRect 0,0,640,480
							EndIf
							SetColor(iOldRed,iOldGreen,iOldBlue)
							' DrawImage(bmBombAction,0,0)
							iBonusActionCntr:+1
						Else
							iBonusActionCntr=0
							iBonusActionStep:+1
						EndIf
					Else
						If iPlayerBonus=2 Then
							' Baignoire
							If iBonusActionCntr<250 Then
								DrawImage(bmBaignoireAction,0,0)
								iBonusActionCntr:+1
							Else
								iBonusActionCntr=0
								iBonusActionStep:+1
							EndIf
						Else
							If iPlayerBonus=3 Then
								' Canard
								If iBonusActionCntr<250 Then
									DrawImage(bmCanardAction,0,0)
									iBonusActionCntr:+1
								Else
									iBonusActionCntr=0
									iBonusActionStep:+1
								EndIf
							EndIf
						EndIf
					EndIf
				Case 2
					' End of bonus action
					iBonusActionStep=1
					bPlayerHasBonus=False
					bPlayerUsesBonus=False
			End Select
		EndIf
		' Michael Cochonou management
		' If Michael is dead
		If (bGameOver=True) And (iMichaelPosY<600) And (iMichaelRotation<360) Then
			' MidHandleImage bmMichael
			iMichaelPosY:+6
			iMichaelRotation:+4
		EndIf
		SetRotation iMichaelRotation
		If bMichaelDamaged=True Then
			bMichaelDamaged=False
			SetColor(iOldRed,0,iOldBlue)
		EndIf
		DrawImage(bmMichael,iMichaelPosX,iMichaelPosY)
		SetColor(iOldRed,iOldGreen,iOldBlue)
		SetRotation 0
		' Graphical Objects management
		' First, we fill the collision layer 2 (player's bullets)
		For CurrentGO = EachIn GOList
			Select CurrentGO.iType
				Case 0
					' Type 0 = Shoot
					' WriteStdout("Type 0 = Shoot"+Chr(13)+Chr(10))
					' Bullet movement
					Select CurrentGO.szOwner
						Case "cpu"
							' The current shoot is owned by the computer
							CurrentGO.iCurrentPosX:-CurrentGO.iXSpeed
						Case "player1"
							' The current shoot is owned by the player
							CurrentGO.iCurrentPosX:+CurrentGO.iXSpeed
					End Select
					' Bullet drawing
					DrawImage bmMichaelBullet,CurrentGO.iCurrentPosX,CurrentGO.iCurrentPosY
					' The bullet is added to the collison layer number 2
					CollideImage bmMichaelBullet,CurrentGO.iCurrentPosX,CurrentGO.iCurrentPosY,0,0,$0002
					' Bullet lifecycle
					CurrentGO.iLife:-1
					If (CurrentGO.iLife<=0) Or (CurrentGO.iCurrentPosX<0) Or (CurrentGO.iCurrentPosX>640) Then
						' If Time To Live = 0, the current shoot is erased
						GOList.remove(CurrentGO)
					EndIf
			End Select
		Next		
		' Once the collision layer 2 is filled, we process the other graphical objects
		For CurrentGO = EachIn GOList
			Select CurrentGO.iType
				Case 1
					' Type 1 = EvilChaussure
					' WriteStdout("Type 1 = EvilChaussure"+Chr(13)+Chr(10))
					' EvilChaussures management
					CurrentGO.iCurrentPosX:-CurrentGO.iXSpeed
					If CurrentGO.iCurrentPosX<-CurrentGO.iWidth Then
						CurrentGO.iCurrentPosX=760
					EndIf
					' Up and down
					CurrentGO.iCurrentPosY:+CurrentGO.iYSpeed
					If CurrentGO.iCurrentPosY>=CurrentGO.iInitialPosY+10 Then
						CurrentGO.iYSpeed=-1
					Else
						If CurrentGO.iCurrentPosY<=CurrentGO.iInitialPosY-5 Then
							CurrentGO.iYSpeed=1
						EndIf
					EndIf
					' The picture matching the current animation frame is displayed
					DrawImage(arAnimFramesPool[CurrentGO.iCurrentAnimFrame],CurrentGO.iCurrentPosX,CurrentGO.iCurrentPosY)
					' Collision with Michael (v2)
					' The picture is added to the collison layer number 3
					CollideImage bmMichael,iMichaelPosX,iMichaelPosY,0,0,$0004
					' Collision test
					If bGameOver=False Then
						If CollideImage(arAnimFramesPool[CurrentGO.iCurrentAnimFrame],CurrentGO.iCurrentPosX,CurrentGO.iCurrentPosY,0,$0004,0) Then
							' Collision with Michael
							GOList.remove(CurrentGO)
							iMichaelLife:-CurrentGO.iDamage
							bMichaelDamaged=True
							GOList.remove(CurrentGO)
							If iMichaelLife=-1 Then
								bGameOver=True
							EndIf
						Else
							If CollideImage(arAnimFramesPool[CurrentGO.iCurrentAnimFrame],CurrentGO.iCurrentPosX,CurrentGO.iCurrentPosY,0,$0002,0) Then
								' Collision with a bullet
								' Michael's score is increased
								iMichaelScore:+iEVILCHAUSSURESSHOOTBONUS
								' The EvilChaussure is transformed into a Dead EvilChaussure
								CurrentGO.iType=8
								CurrentGO.iXSpeed=0
								CurrentGO.iYSpeed=4
								CurrentGO.iDamage=0
								CurrentGO.iLife=1
								CurrentGO.iAnimFirstFrame=3
								CurrentGO.iAnimLastFrame=4
								CurrentGO.iIterationsBetweenFrames=30
								CurrentGO.iCurrentAnimFrame=3
								CurrentGO.iNbrIterationsSinceLastFrame=0
								' Floating text appears on screen
								GOList.AddLast(TGraphicalObject.CreateGO(3, "cpu", CurrentGO.iCurrentPosX, CurrentGO.iCurrentPosY, CurrentGO.iCurrentPosX, CurrentGO.iCurrentPosY, 0, 0, 1, 0, 666, 0, 20, 0, 0, 0, 0, 20, 1.0, "+"+(iEVILCHAUSSURESSHOOTBONUS+iMichaelPosX)))
								PlaySound oggShoeDeath
							EndIf
						EndIf
					EndIf
					ResetCollisions($0004)
				Case 2
					' Type 2 = EvilPiou
					' WriteStdout("Type 2 = EvilPiou"+Chr(13)+Chr(10))
					' EvilPious management
					CurrentGO.iCurrentPosX:-CurrentGO.iXSpeed
					If CurrentGO.iCurrentPosX<-CurrentGO.iWidth Then
						CurrentGO.iCurrentPosX=660
					EndIf
					' Up and down
					CurrentGO.iCurrentPosY:+CurrentGO.iYSpeed
					If CurrentGO.iCurrentPosY>=CurrentGO.iInitialPosY+4 Then
						CurrentGO.iYSpeed=-1
					Else
						If CurrentGO.iCurrentPosY<=CurrentGO.iInitialPosY-8 Then
							CurrentGO.iYSpeed=1
						EndIf
					EndIf
					' The picture matching the current animation frame is displayed
					DrawImage(arAnimFramesPool[CurrentGO.iCurrentAnimFrame],CurrentGO.iCurrentPosX,CurrentGO.iCurrentPosY)
					' Collision with Michael (v2)
					' The picture is added to the collison layer number 3
					CollideImage bmMichael,iMichaelPosX,iMichaelPosY,0,0,$0004
					' Collision test
					If bGameOver=False Then
						If CollideImage(arAnimFramesPool[CurrentGO.iCurrentAnimFrame],CurrentGO.iCurrentPosX,CurrentGO.iCurrentPosY,0,$0004,0) Then
							' Collision with Michael
							GOList.remove(CurrentGO)
							iMichaelLife:-CurrentGO.iDamage
							bMichaelDamaged=True
							GOList.remove(CurrentGO)
							If iMichaelLife=-1 Then
								bGameOver=True
							EndIf
						Else
							If CollideImage(arAnimFramesPool[CurrentGO.iCurrentAnimFrame],CurrentGO.iCurrentPosX,CurrentGO.iCurrentPosY,0,$0002,0) Then
								' Collision with a bullet
								' Michael's score is increased
								iMichaelScore:+iEVILPIOUSSHOOTBONUS
								' The EvilPiou is transformed into a Dead EvilPiou
								CurrentGO.iType=9
								CurrentGO.iXSpeed=0
								CurrentGO.iYSpeed=4
								CurrentGO.iDamage=0
								CurrentGO.iLife=1
								CurrentGO.iAnimFirstFrame=8
								CurrentGO.iAnimLastFrame=9
								CurrentGO.iIterationsBetweenFrames=30
								CurrentGO.iCurrentAnimFrame=8
								CurrentGO.iNbrIterationsSinceLastFrame=0
								' Floating text appears on screen
								GOList.AddLast(TGraphicalObject.CreateGO(3, "cpu", CurrentGO.iCurrentPosX, CurrentGO.iCurrentPosY, CurrentGO.iCurrentPosX, CurrentGO.iCurrentPosY, 0, 0, 1, 0, 666, 0, 20, 0, 0, 0, 0, 20, 1.0, "+"+(iEVILPIOUSSHOOTBONUS+(iMichaelPosX/2))))
								PlaySound oggPiouDeath
							EndIf
						EndIf
					EndIf
					ResetCollisions($0004)
				Case 3
					' Type 3 = Floating Text
					' WriteStdout("Type 3 = Floating Text"+Chr(13)+Chr(10))
					SetAlpha CurrentGO.fAlpha
					afficherTexte(CurrentGO.szEmbeddedData,"",225,18,25,0,255,255,255,CurrentGO.iCurrentPosX,CurrentGO.iCurrentPosY,0)
					SetAlpha 1.0
					' Internal counters update
					CurrentGO.iCurrentPosY:-1
					CurrentGO.iLife:-1
					CurrentGO.fAlpha:-0.01
					If CurrentGO.iLife<=0 Then
						' Current floating text is removed from the list when its lifetime is over
						GOList.remove(CurrentGO)
					EndIf
				Rem
				Case 4	
					' Type 4 = Bonus
					' WriteStdout("Type 4 = Bonus"+Chr(13)+Chr(10))
					CurrentGO.iCurrentPosX:-CurrentGO.iXSpeed
					If CurrentGO.iCurrentPosX<-CurrentGO.iWidth Then
						GOList.remove(CurrentGO)
					EndIf
					DrawImage(bmBonusMark,CurrentGO.iCurrentPosX,CurrentGO.iCurrentPosY)
					' Collision with Michael
					If (bGameOver=False) And (bPlayerHasBonus=False) Then
						If (CurrentGO.iCurrentPosX>iMichaelPosX) And (CurrentGO.iCurrentPosX<iMichaelPosX+iMichaelWidth) Then
							If (CurrentGO.iCurrentPosY>iMichaelPosY) And (CurrentGO.iCurrentPosY<iMichaelPosY+iMichaelHeight) Then
								GOList.remove(CurrentGO)
								If bPlayerHasBonus=False Then
									bBonusScreenOn=True
									iBonusScreenCntr=0
								Else
									GOList.AddLast(TGraphicalObject.CreateGO(3, "cpu", CurrentGO.iCurrentPosX, CurrentGO.iCurrentPosY, CurrentGO.iCurrentPosX, CurrentGO.iCurrentPosY, 0, 0, 1, 1, 666, 0, 999, 999, 999, 999, 0, 0, 1.0, "+"+Rand(50,1000)))
								EndIf
							EndIf
						Else
							If ((CurrentGO.iCurrentPosX+CurrentGO.iWidth)>iMichaelPosX) And ((CurrentGO.iCurrentPosX+CurrentGO.iWidth)<iMichaelPosX+iMichaelWidth) Then
								If ((CurrentGO.iCurrentPosY+CurrentGO.iHeight)>iMichaelPosY) And ((CurrentGO.iCurrentPosY+CurrentGO.iHeight)<iMichaelPosY+iMichaelHeight) Then
									GOList.remove(CurrentGO)
									If bPlayerHasBonus=False Then
										bBonusScreenOn=True
										iBonusScreenCntr=0
									Else
										GOList.AddLast(TGraphicalObject.CreateGO(3, "cpu", CurrentGO.iCurrentPosX, CurrentGO.iCurrentPosY, CurrentGO.iCurrentPosX, CurrentGO.iCurrentPosY, 0, 0, 1, 1, 666, 0, 999, 999, 999, 999, 0, 0, 1.0, "+"+Rand(50,1000)))
									EndIf
								EndIf
							EndIf
						EndIf
					EndIf
				End Rem
				Case 5
				Case 6
				Case 7
				Case 8
					' Type 8 = Dead EvilChaussure
					' WriteStdout("Type 8 = Dead EvilChaussure"+Chr(13)+Chr(10))
					' Dead EvilChaussures management
					CurrentGO.iCurrentPosY:+CurrentGO.iYSpeed
					' The picture matching the current animation frame is displayed
					DrawImage(arAnimFramesPool[CurrentGO.iCurrentAnimFrame],CurrentGO.iCurrentPosX,CurrentGO.iCurrentPosY)
					' If the Dead EvilChaussure gets out of screen, we delete it
					If CurrentGO.iCurrentPosY>480+CurrentGO.iWidth Then
						GOList.remove(CurrentGO)
					EndIf
				Case 9
					' Type 9 = Dead EvilPiou
					' WriteStdout("Type 9 = Dead EvilPiou"+Chr(13)+Chr(10))
					' Dead EvilPious management
					CurrentGO.iCurrentPosY:+CurrentGO.iYSpeed
					' The picture matching the current animation frame is displayed
					DrawImage(arAnimFramesPool[CurrentGO.iCurrentAnimFrame],CurrentGO.iCurrentPosX,CurrentGO.iCurrentPosY)
					' If the Dead EvilChaussure gets out of screen, we delete it
					If CurrentGO.iCurrentPosY>480+CurrentGO.iWidth Then
						GOList.remove(CurrentGO)
					EndIf
			End Select
			' Animation management
			CurrentGO.iNbrIterationsSinceLastFrame:+1
			If CurrentGO.iNbrIterationsSinceLastFrame>=CurrentGO.iIterationsBetweenFrames Then
				CurrentGO.iNbrIterationsSinceLastFrame=0
				CurrentGO.iCurrentAnimFrame:+1
				If CurrentGO.iCurrentAnimFrame>CurrentGO.iAnimLastFrame Then
					CurrentGO.iCurrentAnimFrame=CurrentGO.iAnimFirstFrame
				EndIf
			EndIf
		Next
		' Collision layer 2 is cleared (player's bullets)
		ResetCollisions($0002)		
		' Life counter refresh
		DrawImage(bmLife,0,0)
		SetAlpha 0.7
		For iLifeIndicatorRefreshCntr=0 To iMichaelLife
			DrawRect(130+(14*iLifeIndicatorRefreshCntr),444,10,20)
		Next
		If bGameOver=False Then
			' Score update
			afficherTexte("Score : "+iMichaelScore,"itc40",255,255,255,0,0,0,0,999,0,1)
		EndIf
		SetAlpha 1.0
		' Game over screen
		If bGameOver=True Then
			Select iGameOverCurrentStep
			Case 1
				' The text slowly appears
				If bGameOverStep1Init=False Then
					If iMichaelScore>iBestScore Then
						iBestScore=iMichaelScore
						bIsNewRecordEstablished=True
					EndIf
					fGameOverStep1Alpha=0.0
					bGameOverStep1Init=True
				EndIf
				SetAlpha 0.5
				DrawImage(bmBlack,0,0)
				If fGameOverStep1Alpha<1.0 Then
					fGameOverStep1Alpha:+0.01
				Else
					iGameOverCurrentStep:+1
				EndIf
				SetAlpha fGameOverStep1Alpha
				afficherTexte("Game Over","itc65",228,60,230,0,0,0,0,999,50,1)
				afficherTexte("Game Over","itc60",255,255,255,0,0,0,0,999,55,1)
				afficherTexte("Your score :","itc40",255,255,255,0,0,0,0,999,150,1)
				afficherTexte("== "+iMichaelScore+" ==","itc40",255,255,255,0,0,0,0,999,200,1)
				If bIsNewRecordEstablished=True Then
					afficherTexte("New high score !","itc40",255,255,255,0,0,0,0,999,250,1)
					afficherTexte(">> "+iBestScore+" <<","itc40",255,255,255,0,0,0,0,999,300,1)
				Else
					afficherTexte("High score :","itc40",255,255,255,0,0,0,0,999,250,1)
					afficherTexte("== "+iBestScore+" ==","itc40",255,255,255,0,0,0,0,999,300,1)
				EndIf
				SetAlpha 1.0
			Case 2
				' The text remains stable on the screen
				If bGameOverStep2Init=False Then
					bGameOverStep1Init=False
					iGameOverFrameCntr=0
					bGameOverStep2Init=True
				EndIf
				SetAlpha 0.5
				DrawImage(bmBlack,0,0)
				SetAlpha 1.0
				afficherTexte("Game Over","itc65",228,60,230,0,0,0,0,999,50,1)
				afficherTexte("Game Over","itc60",255,255,255,0,0,0,0,999,55,1)
				afficherTexte("Your score :","itc40",255,255,255,0,0,0,0,999,150,1)
				afficherTexte("== "+iMichaelScore+" ==","itc40",255,255,255,0,0,0,0,999,200,1)
				If bIsNewRecordEstablished=True Then
					afficherTexte("New high score !","itc40",255,255,255,0,0,0,0,999,250,1)
					afficherTexte(">> "+iBestScore+" <<","itc40",255,255,255,0,0,0,0,999,300,1)
				Else
					afficherTexte("High score :","itc40",255,255,255,0,0,0,0,999,250,1)
					afficherTexte("== "+iBestScore+" ==","itc40",255,255,255,0,0,0,0,999,300,1)
				EndIf
				iGameOverFrameCntr:+1
				If iGameOverFrameCntr=80 Then
					iGameOverCurrentStep:+1
				EndIf
			Case 3
				' The text changes : "SAVE SCORE ?" appears
				If bGameOverStep3Init=False Then
					bGameOverStep2Init=False
					fGameOverStep3Alpha=0.0
					bGameOverStep3Init=True
				EndIf
				SetAlpha 0.5
				DrawImage(bmBlack,0,0)
				If fGameOverStep3Alpha<1.0 Then
					fGameOverStep3Alpha:+0.01
				Else
					iGameOverCurrentStep:+1
				EndIf
				SetAlpha fGameOverStep3Alpha
				' afficherTexte("SAVE SCORE ?","itc40",255,255,255,0,0,0,0,999,270,1)
				SetAlpha 1.0
				afficherTexte("Game Over","itc65",228,60,230,0,0,0,0,999,50,1)
				afficherTexte("Game Over","itc60",255,255,255,0,0,0,0,999,55,1)
				afficherTexte("Your score :","itc40",255,255,255,0,0,0,0,999,150,1)
				afficherTexte("== "+iMichaelScore+" ==","itc40",255,255,255,0,0,0,0,999,200,1)
				If bIsNewRecordEstablished=True Then
					afficherTexte("New high score !","itc40",255,255,255,0,0,0,0,999,250,1)
					afficherTexte(">> "+iBestScore+" <<","itc40",255,255,255,0,0,0,0,999,300,1)
				Else
					afficherTexte("High score :","itc40",255,255,255,0,0,0,0,999,250,1)
					afficherTexte("== "+iBestScore+" ==","itc40",255,255,255,0,0,0,0,999,300,1)
				EndIf
			Case 4
				If bGameOverStep4Init=False Then
					bGameOverStep3Init=False
					iGameOverFrameCntr=0
					bGameOverStep4Init=True
				EndIf
				SetAlpha 0.5
				DrawImage(bmBlack,0,0)
				SetAlpha 1.0
				' afficherTexte("SAVE SCORE ?","itc40",255,255,255,0,0,0,0,999,270,1)
				afficherTexte("Game Over","itc65",228,60,230,0,0,0,0,999,50,1)
				afficherTexte("Game Over","itc60",255,255,255,0,0,0,0,999,55,1)
				afficherTexte("Your score :","itc40",255,255,255,0,0,0,0,999,150,1)
				afficherTexte("== "+iMichaelScore+" ==","itc40",255,255,255,0,0,0,0,999,200,1)
				If bIsNewRecordEstablished=True Then
					afficherTexte("New high score !","itc40",255,255,255,0,0,0,0,999,250,1)
					afficherTexte(">> "+iBestScore+" <<","itc40",255,255,255,0,0,0,0,999,300,1)
				Else
					afficherTexte("High score :","itc40",255,255,255,0,0,0,0,999,250,1)
					afficherTexte("== "+iBestScore+" ==","itc40",255,255,255,0,0,0,0,999,300,1)
				EndIf
				iGameOverFrameCntr:+1
				If iGameOverFrameCntr=200 Then
					' The game restarts
					bIsNewRecordEstablished=False
					bGameOverStep4Init=False
					iMichaelPosX=20
					iMichaelPosY=200
					iMichaelRotation=0
					iMichaelLife=16
					iPlayerBonus=1
					bPlayerHasBonus=True
					iGameOverCurrentStep=1
					iMichaelScore=0
					ClearList(GOList)
					bGameOver=False
					generateNewEnemyBatch
				EndIf
			Rem
			Case 4
				If bGameOverStep4Init=False Then
					iGameOverFrameCntr=0
					bGameOverStep4Init=True
				EndIf
				SetAlpha 0.5
				DrawImage(bmBlack,0,0)
				SetAlpha 1.0
				afficherTexte("Game Over","itc65",228,60,230,0,0,0,0,999,50,1)
				afficherTexte("Game Over","itc60",255,255,255,0,0,0,0,999,55,1)
				afficherTexte("Your score :","itc40",255,255,255,0,0,0,0,999,150,1)
				afficherTexte("== "+iMichaelScore+" ==","itc40",255,255,255,0,0,0,0,999,200,1)
				afficherTexte("SAVE SCORE ?","itc40",255,255,255,0,0,0,0,999,270,1)
				iGameOverFrameCntr:+1
				If iGameOverFrameCntr=40 Then
					iGameOverCurrentStep:+1
				EndIf
			Case 5
				If bGameOverStep5Init=False Then
					iGameOverFrameCntr=0
					iCurrentPlayerNameCharacter=0
					FlushKeys()
					bGameOverStep5Init=True
				EndIf
				SetAlpha 0.5
				DrawImage(bmBlack,0,0)
				SetAlpha 1.0
				afficherTexte("Game Over","itc65",228,60,230,0,0,0,0,999,50,1)
				afficherTexte("Game Over","itc60",255,255,255,0,0,0,0,999,55,1)
				afficherTexte("Your score :","itc40",255,255,255,0,0,0,0,999,150,1)
				afficherTexte("== "+iMichaelScore+" ==","itc40",255,255,255,0,0,0,0,999,200,1)
				afficherTexte("SAVE SCORE ?","itc40",255,255,255,0,0,0,0,999,270,1)
				If iCurrentPlayerNameCharacter<3 Then
					' Go to previous character
					' With keyboard
					If KeyHit(KEY_LEFT) Then
						iCurrentAlphabetCharacter:-1
						If iCurrentAlphabetCharacter<0 Then
							iCurrentAlphabetCharacter=25
						EndIf
					EndIf
					' With joystick
					If bJoystickEnabled=True Then
						If JoyX(0)<-0.5 Then
							iCurrentAlphabetCharacter:-1
							If iCurrentAlphabetCharacter<0 Then
								iCurrentAlphabetCharacter=25
							EndIf
						EndIf
					EndIf
					' Go to next character
					' With keyboard
					If KeyHit(KEY_RIGHT) Then
						iCurrentAlphabetCharacter:+1
						If iCurrentAlphabetCharacter>25 Then
							iCurrentAlphabetCharacter=0
						EndIf
					EndIf
					' With joystick
					If bJoystickEnabled=True Then
						If JoyX(0)>0.5 Then
							iCurrentAlphabetCharacter:+1
							If iCurrentAlphabetCharacter>25 Then
								iCurrentAlphabetCharacter=0
							EndIf
						EndIf
					EndIf
					' If A, B or X is pressed on joystick, the current character is added to the name of the player
					' With keyboard
					If KeyHit(KEY_ENTER) Then
						arCurrentPlayerName[iCurrentPlayerNameCharacter]=arAlphabet[iCurrentAlphabetCharacter]
						iCurrentPlayerNameCharacter:+1
					EndIf
					' With joystick
					If bJoystickEnabled=True Then
						If JoyHit(0) Or JoyHit(1) Or JoyHit(4) Then
							arCurrentPlayerName[iCurrentPlayerNameCharacter]=arAlphabet[iCurrentAlphabetCharacter]
							iCurrentPlayerNameCharacter:+1
						EndIf
					EndIf
				EndIf
				If iCurrentPlayerNameCharacter=3 Then
					' If A, B or X is pressed on joystick, the current player name is added to the Hall Of Fame
					' With keyboard
					If KeyHit(KEY_ENTER) Then
						TScore.RegisterNewScore(arCurrentPlayerName[0]+arCurrentPlayerName[1]+arCurrentPlayerName[2], iMichaelScore)
					EndIf
					' With joystick
					If bJoystickEnabled=True Then
						If JoyHit(0) Or JoyHit(1) Or JoyHit(4) Then
							TScore.RegisterNewScore(arCurrentPlayerName[0]+arCurrentPlayerName[1]+arCurrentPlayerName[2], iMichaelScore)
						EndIf
					EndIf
				EndIf
				If iCurrentPlayerNameCharacter>0 Then
					' Backspace
					' With keyboard
					If KeyHit(KEY_SPACE) Then
						iCurrentPlayerNameCharacter:-1
						arCurrentPlayerName[iCurrentPlayerNameCharacter]=""
					EndIf
					' With joystick
					If bJoystickEnabled=True Then
						If JoyHit(2) Or JoyHit(3) Or JoyHit(5) Then
							iCurrentPlayerNameCharacter:-1
							arCurrentPlayerName[iCurrentPlayerNameCharacter]=""
						EndIf
					EndIf
				EndIf
				If iCurrentPlayerNameCharacter<3 Then
					afficherTexte(arCurrentPlayerName[0]+arCurrentPlayerName[1]+arCurrentPlayerName[2]+" - "+arAlphabet[iCurrentAlphabetCharacter],"itc40",255,255,255,0,0,0,0,999,330,1)
				Else
					If iCurrentPlayerNameCharacter=3 Then
						afficherTexte(arCurrentPlayerName[0]+arCurrentPlayerName[1]+arCurrentPlayerName[2]+" - OK ?","itc40",255,255,255,0,0,0,0,999,330,1)
					EndIf
				EndIf
				DrawText(iCurrentPlayerNameCharacter,10,10)
			End Rem
			End Select
		EndIf
		' If there are no enemies left
		' we generate a new batch !
		' If ListIsEmpty(GOList) Then
		' If CountList(GOList)<3 Then
		Rem
		If CountList(GOList)<60 Then
			generateNewEnemyBatch
		EndIf
		End Rem
		If iMichaelScore<5000 Then
			If CountList(GOList)<9 Then
				generateNewEnemyBatch
			EndIf
		Else
			If iMichaelScore<1000000 Then
				If CountList(GOList)<(iMichaelScore/1000) Then
					generateNewEnemyBatch
				EndIf
			Else
				If CountList(GOList)<1200 Then
					generateNewEnemyBatch
				EndIf
			EndIf
		EndIf
		' Additional text
		' afficherTexte("X="+MouseX()+"   ---   Y="+MouseY(),"",255,127,0,0,0,0,0,999,460,0)
	EndIf
	' The icon of the bonus owned by the player is displayed in the bottom-right of the screen
	If (bGameOver=False) And (iPlayerBonus>0) And (bBonusScreenOn=False) And (bPlayerHasBonus=True) Then
		' Display current bonus acording to iCurrentBonusNbr value
		Select iPlayerBonus
			Case 1
				DrawImage(bmBombeIcon,560,400)
			Rem
			Case 2
				DrawImage(bmBaignoireIcon,560,420)
			Case 3
				DrawImage(bmCanardIcon,560,420)
			End Rem
		End Select
	EndIf
	WaitTimer(tmrTimer500)
	Flip
Wend

StopTimer(tmrTimer25)
StopTimer(tmrTimer50)
StopTimer(tmrTimer500)
ShowMouse()
End

Function afficherTexte(szTextToDisplay:String, szPolice:String, iR:Int, iV:Int, iB:Int, iOmbrage:Int, iROmbrage:Int, iVOmbrage:Int, iBOmbrage:Int, iPosX:Int, iPosY:Int, iAlignMode:Int)
	'Penser a faire un Flip pour que le texte apparaisse effectivement a l'ecran
	'RAPPEL : noir=0 / blanc=255
	' iAlignMode : 0=disabled -- 1=X axis centered -- 2=Y axis centered -- 3=Both X and Y axis centered
	'Si iOmbrage est a 0, alors pas d'ombre sous le texte
	Local iAncienRouge:Int=0
	Local iAncienVert:Int=0
	Local iAncienBleu:Int=0
	Local iRecomputedPosX:Int=iPosX
	Local iRecomputedPosY:Int=iPosY
	' Utilisation de la police dont la reference est passee en parametre
	Select szPolice
		Case ""
			SetImageFont(Null)
		Case "itc40"
			SetImageFont(fntSnapITC40)
		Case "itc60"
			SetImageFont(fntSnapITC60)
		Case "itc65"
			SetImageFont(fntSnapITC65)
		Case "habbo18"
			SetImageFont(fntHabbo18)
		Default
			SetImageFont(Null)
	End Select
	' Utilisation du mode d'alignement iAlignMode
	Select iAlignMode
		Case 0
			' Disabled
		Case 1
			' X axis centered
			iRecomputedPosX=((GraphicsWidth()/2)-(TextWidth(szTextToDisplay)/2))
		Case 2
			' Y axis centered
			iRecomputedPosY=((GraphicsHeight()/2)-(TextHeight(szTextToDisplay)/2))
		Case 3
			' X and Y axis centered
			' X axis centered
			iRecomputedPosX=((GraphicsWidth()/2)-(TextWidth(szTextToDisplay)/2))
			' Y axis centered
			iRecomputedPosY=((GraphicsHeight()/2)-(TextHeight(szTextToDisplay)/2))
		Default
	End Select
	' Sauvegarde des parametres de couleur originaux
	GetColor(iAncienRouge,iAncienVert,iAncienBleu)
	If iOmbrage=1 Then
		' Si ombre
		SetColor iROmbrage, iVOmbrage, iBOmbrage
		DrawText(szTextToDisplay,iRecomputedPosX+1,iRecomputedPosY+1)
	EndIf
	SetColor iR,iV,iB
	DrawText(szTextToDisplay,iRecomputedPosX,iRecomputedPosY)
	' Restauration des parametres de couleur originaux
	SetColor(iAncienRouge,iAncienVert,iAncienBleu)
End Function

Function generateNewEnemyBatch()
	Local iEnemyListFillCntr:Int=0
	Local iPosYCurrentEnemy:Int=0
	Local iPosYPreviousEnemy:Int=0
	Local iTMPInitialPosX:Int=0
	Local iTMPInitialPosY:Int=0
	' EvilChaussures
	For iEnemyListFillCntr=0 To 3
		While (iPosXCurrentEnemy>=iPosXPreviousEnemy) And ((iPosXCurrentEnemy<=iPosXPreviousEnemy+70))
			iPosXCurrentEnemy=Rand(50,240)
		Wend
		iPosXPreviousEnemy=iPosXCurrentEnemy
		iTMPInitialPosX=(760)+(65*iEnemyListFillCntr)
		iTMPInitialPosY=Rand(50,240)
		GOList.AddLast(TGraphicalObject.CreateGO(1, "cpu", iTMPInitialPosX, iTMPInitialPosY, iTMPInitialPosX, iTMPInitialPosY, 58, 53, Rand(1,4), 1, 666, 1, 20, 0, 2, iIBFEVILCHAUSSURES, Rand(1,3), 0, 1.0, ""))
	Next
	' EvilPious
	For iEnemyListFillCntr=0 To 3
		While (iPosXCurrentEnemy>=iPosXPreviousEnemy) And ((iPosXCurrentEnemy<=iPosXPreviousEnemy+70))
			iPosXCurrentEnemy=Rand(50,240)
		Wend
		iPosXPreviousEnemy=iPosXCurrentEnemy
		iTMPInitialPosX=(660)+(65*iEnemyListFillCntr)
		iTMPInitialPosY=Rand(260,450)
		GOList.AddLast(TGraphicalObject.CreateGO(2, "cpu", iTMPInitialPosX, iTMPInitialPosY, iTMPInitialPosX, iTMPInitialPosY, 59, 51, Rand(1,4), 1, 666, 1, 10, 5, 7, iIBFEVILPIOUS, Rand(5,7), 0, 1.0, ""))
	Next
End Function

Function debugMenu()
	While Not KeyHit(KEY_ESCAPE)
		Cls
		afficherTexte("== Debug menu ==","",255,255,255,0,0,0,0,999,50,1)
		afficherTexte("1/ testJoystick()","",255,255,255,0,0,0,0,20,200,0)
		If KeyHit(KEY_1) Then
			testJoystick()
		EndIf
		Flip
	Wend
End Function

Function testJoystick()
	' Joystick buttons identifiers :
	' A = 0
	' B = 1
	' X = 4
	' C = 2
	' D = 3
	' Y = 5
	Local t=0	
	While Not KeyHit(KEY_ESCAPE)
		Cls
		afficherTexte("== testJoystick() ==","",255,255,255,0,0,0,0,999,50,1)
		If JoyCount()>0 Then
			bJoystickEnabled=True
			afficherTexte("Nbr of joysticks : "+JoyCount(),"",255,255,255,0,0,0,0,20,300,0)
			afficherTexte("Name of default joystick : "+JoyName(0),"",255,255,255,0,0,0,0,20,320,0)
			afficherTexte("X : "+JoyX(0),"",255,255,255,0,0,0,0,20,340,0)
			afficherTexte("Y : "+JoyY(0),"",255,255,255,0,0,0,0,20,360,0)
			For Local i=0 To 5
				If JoyDown(i) Then
					SetColor 255,0,0
					afficherTexte("Button =","",255,255,255,0,0,0,0,20,380,0)
					afficherTexte(i,"",255,255,255,0,0,0,0,90+(i*10),380,0)
					' WriteStdout("Button = "+i+Chr(13)+Chr(10))
				EndIf
				DrawOval (i+17)*16,400,14,14
				SetColor 0,0,0
			Next
			DrawRect 0,260,t,10
			t=(t+1)&511
		EndIf
		If JoyCount()<=0 Then
			bJoystickEnabled=False
			afficherTexte("No joystick detected.","",255,255,255,0,0,0,0,20,460,0)
		EndIf
		Flip(sync=1)	
	Wend
	'Vidage du tampon clavier
	FlushKeys()
End Function

