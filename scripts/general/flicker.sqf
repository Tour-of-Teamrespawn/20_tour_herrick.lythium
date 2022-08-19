
_light = "#lightpoint" createVehicleLocal getpos _this;   
_light setLightAttenuation [1, 4, 4, 0, 2, 4];
_light setLightAmbient [1, 1, 1];
_light setLightColor [255, 100, 1];

while {true} do
{
	if (inflamed _this) then 
	{
		_light setLightBrightness 0.015;
	}else
	{
		_light setLightBrightness 0;	
	};
	sleep 0.5;
};

