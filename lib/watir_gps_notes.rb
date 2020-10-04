b = Watir::Browser.new
b.goto("https://gcgeo.maps.arcgis.com/apps/webappviewer/index.html?id=19227102adf34489bb7311fc1ddb39f0")
 => "https://gcgeo.maps.arcgis.com/apps/webappviewer/index.html?id=19227102adf34489bb7311fc1ddb39f0"
i = b.img(:alt => "Search_2")
i.click
b.send_keys("R113900")
b.send_keys :enter
ci = b.div(:class => "coordinate-info")
ci.text.split