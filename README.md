Where-Fi
========

Project Two Where-Fi App
------------------------
Jackson Lee

Tony DeFreitas

Caroline Morgan

Where-Fi is a web-app that allows users to find open, public, free Wifi Hotspots geographically. Currently, our app finds Public Wifi locations as listed by our data course, the City of New York. Where-Fi was developed using Ruby on Rails Web Development Framework, Active Record for Object Relationship Mapping, and Postgresql for Database Management.  Further, the following Ruby Gems were used for the following purposes:  

HTTParty - retreiving data as JSON objects.  
Geocoder - assigining lat/long values to locations and providing calculations for distance between locations.
Fusion_Tables - storing data on a Google Fusion Table for creating iframe Google Maps.
Twitter - posting updates on Wifi Locations via Twitter.  

Users can search for hotspots by address on any page.  Search results can by sorting by search radius (2 blocks, 6 blocks, 1/2 mile, 1 mile) or popularity (based on how many favorites a hotspot has).  Users may also create a profile to store favorite hotspot locations, comment on existing hotspots via our comment section, add new hotspots to our database, and provide edits to existing hotspots.