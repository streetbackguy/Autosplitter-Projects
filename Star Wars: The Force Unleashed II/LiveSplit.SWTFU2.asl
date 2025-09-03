state("SWTFU2", "1.1")
{
	byte loadingLvl : 0xFCD8C2;
}

init
{
	switch (modules.First().FileVersionInfo.FileVersion)	
	{
		case "1.1.0.0":
			version = "1.1";
			break;
	}
}

isLoading
{		
	return current.loadingLvl > 0;
}
