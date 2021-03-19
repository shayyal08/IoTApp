# StaytionIoT
iOS home automation app

This app enables home automation using IoT devices controlled by the app. The list of IoT devices are displayed , update on/off for light/climate and lock/unLock for Locks. The temperature of the climate, brightness of the Light and on/off status for the light/climate/Door is displayed.

Features:
	1.	Connect to WebSocket with authentication using access token
	2.	Fetch IOT device lists from webSocket , parse json and display in scrollable screen.
	3.	From list of devices response filter  to remove Person Station, Notification related items  
	4.	Show IoT devices list on the screen with name displayed  
	5.	Tap on each devices to show a screen with IoT device title
	6.	Tap on Lock  which shows the lock/unlock status
	7.	Tap on Climate which shows device title, on/off status and temperature
	8.	Tap on Light shows device title, brightness value if present and on/off status
	9.	Climate on/off changes from UI is sent to WebSocket with response as success on console
	10.	Climate change in temperature is sent to WebSocket with success response
	11.	Change in Lock lock/unlock  is sent to WebSocket with success response
	12.	Change in Light  on/off  is sent to WebSocket with success or failure response 
	13.	App runs on iPhone devices in Portrait mode with iOS 13+ installed


