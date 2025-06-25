state("vacuoussugarquest")
{
	// The reason I want this variable is to avoid splitting on seeing signs. Signs will never change this to 0. Actual dialogue will.
	bool canAdvanceDialogue : "VacuousSugarQuest.exe", 0x5CAF540, 0x310, 0x160, 0x0, 0x18, 0x68, 0x28, 0xC8;
	int roomX : "VacuousSugarQuest.exe", 0x5CAF540, 0x2C8, 0x30, 0x138, 0x138, 0x68, 0x28, 0xC8;
	int roomY : "VacuousSugarQuest.exe", 0x5CAF540, 0x2D8, 0x290, 0x138, 0x138, 0x68, 0x28, 0xCC;
	float inDialogue : "VacuousSugarQuest.exe", 0x5CAF540, 0x220, 0x0, 0x80, 0x0, 0x68, 0x28, 0xB0;

	// 1.1.7 variables, thanks walfie.
	bool has_candy : "VacuousSugarQuest.exe", 0x5CAF540, 0x400, 0x268, 0x420, 0x38, 0x68, 0x28, 0x20;
	bool has_cookie : "VacuousSugarQuest.exe", 0x5CAF540, 0x310, 0x188, 0x38, 0x68, 0x28, 0x38;
	bool has_cake : "VacuousSugarQuest.exe", 0x5CAF540, 0x310, 0x1F8, 0x188, 0x38, 0x68, 0x28, 0x50;
	bool has_sugar : "VacuousSugarQuest.exe", 0x5CAF540, 0x310, 0x188, 0x38, 0x68, 0x28, 0x68;
	bool at_summit : "VacuousSugarQuest.exe", 0x5CAF540, 0x310, 0x188, 0x38, 0x68, 0x28, 0x80;
}

startup {
	timer.CurrentTimingMethod = TimingMethod.GameTime;
}
 
start
{
	return current.inDialogue == 0 && old.inDialogue != 0 && current.roomX == 0 && current.roomY == 0;
}
 
split
{
	if ((current.has_candy && !old.has_candy) ||
		(current.has_cookie && !old.has_cookie) ||
		(current.has_cake && !old.has_cake) ||
		(current.has_sugar && !old.has_sugar) ||
		(current.at_summit && !old.at_summit)) {
			return true;
		}
}