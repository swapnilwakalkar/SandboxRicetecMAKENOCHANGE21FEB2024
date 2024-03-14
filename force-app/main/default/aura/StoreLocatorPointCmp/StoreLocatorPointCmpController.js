({
    doInit : function(component, event, helper) {
        helper.fetchDayVisit(component, event, helper);
    },    
    
    toggleSection : function(component, event, helper) {        
        var sectionAuraId = event.target.getAttribute("data-auraId");        
        var sectionDiv = component.find(sectionAuraId).getElement();        
        var sectionState = sectionDiv.getAttribute('class').search('slds-is-open');        
        if(sectionState == -1){
            sectionDiv.setAttribute('class' , 'slds-section slds-is-open');
        }else{
            sectionDiv.setAttribute('class' , 'slds-section slds-is-close');
        }
    },
    
    handleClick : function(component, event, helper) {
        component.set("v.noStoresToLocate", false);
        component.set("v.isShowNearestLocations", false);
        helper.fetchDayVisit(component, event, helper);
        var getLocations = component.get("v.dayStartLocation");
        if(getLocations=="" || getLocations==null){
            alert('Please select Start Day Visit');
        }
        else{
            var recordId = component.get("v.recordId");
            component.set("v.isloaded", true);
            component.set("v.isShowdirections", true);
            component.set("v.frameSrc",'/apex/GoogleMapDistanceCtrlVf?Id='+recordId); 
        }
    },
    
    ShowDirections : function(component, event, helper) {
        component.set("v.noStoresToLocate", false);
        component.set("v.isShowNearestLocations", false);
        helper.fetchDayVisit(component, event, helper);
        var getLocations = component.get("v.dayStartLocation");
        if(getLocations=="" || getLocations==null){
            alert('Please select Start Day Visit');
        }
        else{
            var recordId = component.get("v.recordId");
            component.set("v.isloaded", true);
            component.set("v.isShowdirections", false);
            component.set("v.frameSrc",'/apex/GoogleMapShowDirections?Id='+recordId);
        }  
    },
    
    handleNearestLocations :  function(component, event, helper) {
        component.set("v.isShowNearestLocations", true);
        component.set("v.minimumRadius", "5");
        component.set("v.value", 'curentLoc');
        component.set("v.showAddressSearch", false);
        component.set("v.showRadiusButton", true); 
    },
    
    getNearestLocations : function(component, event, helper) { 
        var getRadius =  component.find("minRadius").get("v.value");
        component.set("v.minimumRadius", getRadius);
        if(getRadius){
            component.set("v.noStoresToLocate", false);
            component.set("v.searchByOption", true);
            component.set("v.value", 'curentLoc');
            component.set("v.showAddressSearch", false);
            var latitude; 
            var longitude;
            navigator.geolocation.getCurrentPosition(function(e) {
                latitude = e.coords.latitude;
                longitude = e.coords.longitude;
                component.set("v.latitude",latitude);
                component.set("v.longitude",longitude);
            }, function() {
                console.log('There was an error.');
            },{maximumAge:600000})
        }else{
            alert('Please Enter Radius to Search');
        }
    },
    
    handleSearchOptions: function(component, event, helper) {
        var changeValue = event.getParam("value");
        var addressSearch = component.get("v.value");
        component.set("v.latitude",'');
        component.set("v.longitude",'');
        if(changeValue === 'curentLoc'){
            component.set("v.showAddressSearch", false);
            component.set("v.showRadiusButton", true); 
             component.set("v.showpinCodeSearch", false);
            var latitude;
            var longitude;
            navigator.geolocation.getCurrentPosition(function(e) {
                latitude = e.coords.latitude;
                longitude = e.coords.longitude;
                component.set("v.latitude",latitude);
                component.set("v.longitude",longitude);
            }, function() {
                console.log('There was an error.');
            },{maximumAge:600000})
        }else if(changeValue === 'addressSearch'){
            component.set("v.showAddressSearch", true);
             component.set("v.showRadiusButton", true); 
            component.set("v.showpinCodeSearch", false);
        }else if(changeValue === 'pinCodeSearch'){
            component.set("v.showpinCodeSearch", true);
            component.set("v.showAddressSearch", false);
            component.set("v.showRadiusButton", false); 
            component.set("v.minimumRadius", '');
        }
    },
    
    handleNearestLocationSearch:  function(component, event, helper) {
        var getRadius =  component.get("v.minimumRadius");
        var getPinCode = component.get("v.pinCode");
        var showpinCodeSearch = component.get("v.showpinCodeSearch");
        var showRadiusButton = component.get("v.showRadiusButton");
        console.log('---->>>> getRadius ', getRadius );
        console.log('---->>>> getPinCode ', getPinCode );
        console.log('---->>>> showpinCodeSearch ', showpinCodeSearch );
        console.log('---->>>> showRadiusButton ', showRadiusButton );
        if((showpinCodeSearch && (getPinCode === undefined || getPinCode === '')) || (showRadiusButton && (getRadius === undefined || getRadius === ''))){
            alert('Please Enter the required input to Search');
           }else{
           helper.getRemainingStores(component, event, helper, getRadius, getPinCode);
    }
},
    
    handleReceivedLocation :  function(component, event, helper) {
        var getLoc = event.getParam("getLocation");
        component.set("v.latitude",getLoc.lat);
        component.set("v.longitude",getLoc.lng);        
    },
 
    
    handleClickBack : function(component, event, helper) {
        helper.fetchDayVisit(component, event, helper);
        component.set("v.isShowdirections", false);
        component.set("v.isloaded", false);
        component.set("v.noStoresToLocate", false);
        component.set("v.isShowNearestLocations", false); 
    }
    
})