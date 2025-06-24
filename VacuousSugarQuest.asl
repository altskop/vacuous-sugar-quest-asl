state("vacuoussugarquest")
{
	float inDialogue : "VacuousSugarQuest.exe", 0x5CAF540, 0x220, 0x0, 0x80, 0x0, 0x68, 0x28, 0xB0;
	// The reason I want this variable is to avoid splitting on seeing signs. Signs will never change this to 0. Actual dialogue will.
	bool canAdvanceDialogue : "VacuousSugarQuest.exe", 0x5CAF540, 0x310, 0x160, 0x0, 0x18, 0x68, 0x28, 0xC8;
	int roomX : "VacuousSugarQuest.exe", 0x5CAF540, 0x2C8, 0x30, 0x138, 0x138, 0x68, 0x28, 0xC8;
	int roomY : "VacuousSugarQuest.exe", 0x5CAF540, 0x2D8, 0x290, 0x138, 0x138, 0x68, 0x28, 0xCC;
	bool timerEnabled : "VacuousSugarQuest.exe", 0x5CAF540, 0x2C8, 0x30, 0x138, 0x140, 0x68, 0x28, 0x138;
}
 
start
{
	return current.inDialogue == 0 && old.inDialogue != 0;
}
 
split
{
	if (current.inDialogue > 0 && old.inDialogue == 0 && current.canAdvanceDialogue == false && old.canAdvanceDialogue == true){ 
		return true;
	}
	if (current.roomX == 2 && current.roomY == -11 && current.timerEnabled == false && old.timerEnabled == true){
		// If we're at the end game location, and the timer gets disabled, that means we've hit the flag
		// There's a 0.2s hardcoded delay between that and showing the dialogue so this is more accurate
		return true;
	}
}

update {
	print("Timer enabled:"+current.timerEnabled.ToString());
	print("Dialog: "+current.inDialogue.ToString()+" ; Advance: "+current.canAdvanceDialogue.ToString());
	print(current.roomX.ToString()+","+ current.roomY.ToString()); 
	print("Player State:" + current.state.ToString());
}