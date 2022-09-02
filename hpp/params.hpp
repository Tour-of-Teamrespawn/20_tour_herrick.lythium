class Params
{
	class TOUR_param_Respawn
	{
		//paramsArray[0]
		title = "Respawn Time (s):";
		values[] = {0, 30, 60, 300, 600, 900};
		default = 30;
		texts[] = {"None", "30 Seconds", "1 Minute", "5 Minutes", "10 Minutes", "15 Minutes"};
	};
	
	class TOUR_param_tickets
	{
		//paramsArray[1]
		title = "Lives:";
		values[] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 20, 30, 40, 50, 100};
		default = 1;
		texts[] = {"1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "20", "30", "40", "50", "100"};
	};	

	class TOUR_param_intro
	{
		//paramsArray[2]
		title = "Enable Intro:";
		values[] = {true, false};
		default = true;
		texts[] = {"ON", "OFF"};
	};	

	class TOUR_param_playTime
	{
		//paramsArray[3]
		title = "Play Time:";
		values[] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 20, 30, 40, 50, 100};
		default = 3;
		texts[] = {"1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "18", "24"};
	};	

	class TOUR_param_start
	{
		//paramsArray[4]
		title = "Start Time:";
		values[] = {1, 2, 3, 4};
		default = 2;
		texts[] = {"Sunrise", "Noon", "Sunset", "Night"};
	};	

	class TOUR_param_fogSettings
	{
		//paramsArray[45]
		title = "Fog Settings:";
		values[] = {1, 2, 3, 4};
		default = 1;
		texts[] = {"No Fog", "Low Level Light Fog", "Low Level Heavy Fog", "Heavy Fog"};
	};	

	class TOUR_param_weather
	{
		//paramsArray[6]
		title = "Weather Settings:";
		values[] = {0, 0.65, 0.80, 1};
		default = 0;
		texts[] = {"Clear Skies", "Overcast", "Rain", "Storm"};
	};
	class TOUR_param_baseAssaultProb
	{
		//paramsArray[7]
		title = "Probability Of Attack On Base:";
		values[] = {0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100};
		default = 70;
		texts[] = {"0", "10", "20", "30", "40", "50", "60", "70", "80", "90", "100"};
	};
	class TOUR_param_randomAttackProb
	{
		//paramsArray[8]
		title = "Probability Of Random Attacks Per Hour:";
		values[] = {0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100};
		default = 50;
		texts[] = {"0", "10", "20", "30", "40", "50", "60", "70", "80", "90", "100"};
	};	
};