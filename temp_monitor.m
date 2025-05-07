function temp_monitor(a, voltagezero, temperaturecoefficient) 

%e = mc squared
clc
therm = 'A0';
red = 'D2';
yellow = 'D3';
green = 'D4';

voltagezero = 0.5;       
temperaturecoefficient = 0.01; 

results = [];
index = 1;
redblink = 0;
yellowblink = 0;

voltage = readVoltage(a,therm);
temperature = (voltage-voltagezero)/temperaturecoefficient;
results(index) = temperature;

while true
    voltage = readVoltage(a, therm);
    temperature = (voltage - voltagezero) / temperaturecoefficient;
    results(index) = temperature;
    index = index + 1;

if temperature >= 18 && temperature <= 24

    writeDigitalPin(a, red, 0);
    writeDigitalPin(a, yellow, 0);
    writeDigitalPin(a, green, 1);
    
elseif temperature > 24
    
    writeDigitalPin(a, green, 0);
    writeDigitalPin(a, yellow, 0);
    writeDigitalPin(a, red, 1);
   
    redblink = ~redblink;
    writeDigitalPin(a, red, redblink);

elseif temperature < 18
    writeDigitalPin(a,red, 0);
    writeDigitalPin(a, green, 0);
    writeDigitalPin(a,yellow, 1);

    yellowblink = ~yellowblink;
    writeDigitalPin(a, yellow, yellowblink);
end

pause(0.25);

end