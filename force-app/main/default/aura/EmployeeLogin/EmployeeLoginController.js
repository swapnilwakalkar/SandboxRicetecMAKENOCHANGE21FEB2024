({
doInit: function(component, event, helper) {
    // Load saved markers from localStorage
    var savedMarkers = JSON.parse(localStorage.getItem('markers'));
    if (savedMarkers) {
        component.set('v.mapMarkers', savedMarkers);
        component.set('v.mapReady', true);
    }

    helper.findGeolocation(component, helper);
    component.set('v.zoomLevel', 12);
    console.log('doInit called');
},

    
      captureLogin: function(component, event, helper) {
        component.set("v.isLoginButtonDisabled", true);
        helper.findGeolocation(component, helper);

        
          helper.captureLoginHelper(component, helper, function() {
            console.log('Login Made');

            // Update map markers after successful login
          helper.setMapCoordinates(component);
          helper.fetchAddress(component, 'captureLoginHelper',true);
       
              component.set("v.popupMessage", "You have successfully logged in.");
            
              helper.saveMarkerAddressData(component);
            
              setTimeout(function() {
                component.set("v.isLoginButtonDisabled", false);
            }, 120000); 
        });
           
    },

    captureLogout: function(component, event, helper) {
        helper.findGeolocation(component, helper); // Fetch geolocation
        helper.captureLogoutHelper(component, helper, function() {
            console.log('Logout Made');

            // Update map markers after successful logout
            helper.setMapCoordinates(component);
            helper.fetchAddress(component, 'captureLogoutHelper');

            component.set("v.popupMessage", "You have successfully logged out.");
        });     
    },
    closePopup: function(component, event, helper) {
        component.set("v.popupMessage", ""); // Clear the popup message
    }
})