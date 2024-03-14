({
    findGeolocation : function(component, helper) {
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(function(position) {
                var lat = position.coords.latitude;
                component.set("v.latitude", lat);
                var lng = position.coords.longitude;
                component.set("v.longitude", lng);
                
                 if (component.get("v.mapReady")) {
                    helper.setMapCoordinates(component);
                }
            });
        } else {
            console.error('Geolocation is not supported');
        }
    },
    
 captureLoginHelper: function(component, helper, callback) {
        var action = component.get("c.insertRecord");

        action.setParams({
            "lat": component.get("v.latitude"),
            "lng": component.get("v.longitude")
        });

        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var newAttendanceId = response.getReturnValue();
                component.set("v.recordId", newAttendanceId);
                console.log("Attendance record inserted with ID: " + newAttendanceId);

                if (typeof callback === 'function') {
                    callback(); // Call the callback function
                }
            } else if (state === "ERROR") {
                var errors = response.getError();
                console.error("Error:", errors);
            }
        });

        $A.enqueueAction(action);
        $A.get("e.force:closeQuickAction").fire();
    },

captureLogoutHelper: function(component, helper, callback) {
    var action = component.get("c.updateLogoutDetails");
    var logoutReason = "End of workday"; // Example logout reason
    var comments = "Logged out successfully"; // Example comments

    action.setParams({
        "lat": component.get("v.latitude"),
        "lng": component.get("v.longitude"),
    });

    action.setCallback(this, function(response) {
        var state = response.getState();
        if (state === "SUCCESS") {
            console.log("Attendance record updated with logout information.");
            // Update map coordinates with logout information
            helper.fetchAddress(component, function(address) {
                component.set("v.formattedAddress", address);
                helper.setMapCoordinates(component);
            });

            if (typeof callback === 'function') {
                callback();
            }
        } else if (state === "ERROR") {
            var errors = response.getError();
            console.error("Error:", errors);
        }
    });

    $A.enqueueAction(action);
    $A.get("e.force:closeQuickAction").fire();
},

      fetchAddress: function(component, actionName, updateMapMarker) {
        var latitude = component.get("v.latitude");
        var longitude = component.get("v.longitude");
        var action = component.get('c.fetchAddressFromCoordinates');
        action.setParams({
            "lat": latitude,
            "lng": longitude
        });

        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var address = response.getReturnValue();
                component.set("v.formattedAddress", address);

                if (updateMapMarker) {
                    this.setMapCoordinates(component);
                }
            } else if (state === "ERROR") {
                console.error("Error fetching address:", response.getError());
            }
        });

        $A.enqueueAction(action);
    },

   setMapCoordinates: function(component) {
    var latitude = parseFloat(component.get("v.latitude"));
    var longitude = parseFloat(component.get("v.longitude"));
    var formattedAddress = component.get("v.formattedAddress");
    var name = component.get('v.simpleRecord.Name');

    if (isNaN(latitude) || isNaN(longitude)) {
        component.set('v.mapReady', false);
    } else {
        var markers = [
            {
                location: {
                    Latitude: latitude,
                    Longitude: longitude
                },
                title: name || "Location - " + formattedAddress,
            }
        ];

        localStorage.setItem('markers', JSON.stringify(markers));

        component.set('v.mapMarkers', markers);
        component.set('v.mapReady', true);
    }
},
    
     saveMarkerAddressData: function(component) {
        var localStorageKey = "markerAddressData";
        var markerAddressData = JSON.parse(localStorage.getItem(localStorageKey)) || [];

        var formattedAddress = component.get("v.formattedAddress");
        markerAddressData.push(formattedAddress);

        // Save only the last two entries in local storage
        if (markerAddressData.length > 2) {
            markerAddressData.shift();
        }

        localStorage.setItem(localStorageKey, JSON.stringify(markerAddressData));
    }
})