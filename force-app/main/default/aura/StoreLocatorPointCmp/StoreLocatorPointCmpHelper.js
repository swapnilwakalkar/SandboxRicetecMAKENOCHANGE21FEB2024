({
    
    fetchDayVisit : function(component, event, helper) {
        let action = component.get("c.fetchDayVist");
        action.setParams({
            "dayVisitId":component.get("v.recordId"),
            "storename":component.get("v.sname")
        });
        action.setCallback(this,function(response){
            let state = response.getState();
            if(state =='SUCCESS'){
                let result = response.getReturnValue();
                console.log('Result returned: ' +JSON.stringify(result));
                component.set("v.conObj",result);
                var contacts = component.get("v.conObj");
                helper.loadMap(component,event,helper,contacts);
            }else{
                console.log('Something went wrong! ');
            }
        });
        $A.enqueueAction(action);  
    },
    
    loadMap : function(component,event,helper,contacts) {
        var mapsArray = [];
        console.log('------->>>>>> contacts '+contacts);
        component.set('v.dayStartLocation', contacts[0].Day_Planner__r.Representative_Initial_Location__Latitude__s);
        for(let index=0; index < contacts.length; index++){
            
            var Mobj = {
                location: {
                    
                    Latitude: contacts[index].Mill_Name__r.Geo_Location__Latitude__s,
                    Longitude: contacts[index].Mill_Name__r.Geo_Location__Longitude__s,
                    Street: contacts[index].Mill_Name__r.Area__c + ' - ' + $A.localizationService.formatDate(contacts[index].Plan_Date_Time__c, "MMM dd yyyy, hh:mm:ss a")
                },
              icon: 'standard:contact',
               title: contacts[index].Mill_Name__r.Name,
               description: 'Store Location at - '  +contacts[index].Area__c  +  
               ', Store Visit Time&Date - ' + $A.localizationService.formatDate(contacts[index].Plan_Date_Time__c,"MMM dd yyyy, hh:mm:ss a")
            }
            mapsArray.push(Mobj);
        }
        component.set('v.mapMarkers', mapsArray);
        // alert(JSON.stringify(mapsArray));
        /* component.set('v.dayStartLocation', contacts[0].dms123__p360_Day_Visit_Start_Latitude__s); 
        changed to below line as we are getting undefined this field is not mentioned in controller */
        
        component.set('v.centerObj', {
            location: {
                Latitude: contacts[0].Day_Planner__r.Representative_Initial_Location__Latitude__s,
                Longitude: contacts[0].Day_Planner__r.Representative_Initial_Location__Longitude__s,
            },
        });
        component.set('v.zoomLevel', 11);
        component.set('v.markersTitle', 'Stores Locations');
        component.set('v.showFooter', true);
    },
    
    getRemainingStores : function(component,event,helper, getRadius, getPinCode) {
        component.set("v.spinner", true);
        if(getRadius){
            let action = component.get("c.getNearestAccount");
            console.log("capability is there");
            
            console.log('--->>>component.get("v.latitude")  ',component.get("v.latitude"));
            console.log('--->>>component.get("v.longitude")  ',component.get("v.longitude"));
            setTimeout(function(){
                action.setParams({
                    "dayVisitId" : component.get("v.recordId"),
                    "latitude" : component.get("v.latitude"),
                    "longitude" : component.get("v.longitude"),
                    "getRadius" : getRadius            
                });
                action.setCallback(this,function(response){
                    let state = response.getState();
                    if(state =='SUCCESS'){
                        component.set("v.spinner", false);
                        let result = response.getReturnValue();
                        component.set("v.remainingStores", result);
                        if(result.acc.length !== 0){
                            component.set("v.noStoresToLocate", false);
                            console.log('---HAS STORES');
                            helper.loadMapForRemainingStores(component,event,helper, component.get("v.remainingStores"), true);
                        }else{
                            console.log('--->>>>NOOSTORES');
                            component.set("v.noStoresToLocate", true);
                            var radiusMessage = 'There are no stores which are in radius of ' + getRadius +' km.'
                            component.set("v.noStoresMessage", radiusMessage);
                        }
                    }else{
                        component.set("v.spinner", false);
                        console.log('Something went wrong! ');
                    }
                });
                $A.enqueueAction(action);
            }, 100);
        }else if(getPinCode){
            let action = component.get("c.getNearestAccountBasedOnPinCode");
            setTimeout(function(){
                action.setParams({
                    "dayVisitId" : component.get("v.recordId"),
                    "pinCode" : getPinCode      
                });
                action.setCallback(this,function(response){
                    let state = response.getState();
                    if(state =='SUCCESS'){
                        component.set("v.spinner", false);
                        let result = response.getReturnValue();
                        component.set("v.remainingStores", result);
                        if(result.acc.length !== 0){
                            component.set("v.noStoresToLocate", false);
                            console.log('---HAS STORES');
                            helper.loadMapForRemainingStores(component,event,helper, component.get("v.remainingStores"), false);
                        }else{
                            console.log('--->>>>NOOSTORES');
                            component.set("v.noStoresToLocate", true);
                             var pincodeMessage = 'There are no stores with the entered Pincode.'
                            component.set("v.noStoresMessage", pincodeMessage);
                        }
                    }else{
                        component.set("v.spinner", false);
                        console.log('Something went wrong! ');
                    }
                });
                $A.enqueueAction(action);
            }, 100);
        }
    },
    
    loadMapForRemainingStores : function(component,event,helper, remainingStores, byRadius) {
        var mapsArray = [];
        if(byRadius){
            var contacts = remainingStores.acc;      
            var getDayVisitPlan = remainingStores.dayVisitPlan;
            var mapOfAccountIdToDistance = remainingStores.mapOfAccountIdToDistance;
            //window.addEventListener("click", function(event) {
            for(let index=0; index < contacts.length; index++){            
                var Mobj = {
                    location: {  
                        Latitude: contacts[index].Geo_Location__Latitude__s,
                        Longitude: contacts[index].Geo_Location__Longitude__s,
                        Street: contacts[index].Name
                    },
                    icon: 'standard:contact',
                    title: contacts[index].Name,
                    description: 'Store Location at - '  +contacts[index].Name + ' Distance - '+ mapOfAccountIdToDistance[contacts[index].Id] + ' KM'
                }
                mapsArray.push(Mobj);
            }
            component.set('v.mapMarkers', mapsArray);
            component.set('v.centerObj', {
                location: {
                    Latitude: component.get("v.latitude"),
                    Longitude: component.get("v.longitude"),
                }
            });
        }else{
            var contacts = remainingStores.acc;      
            var getDayVisitPlan = remainingStores.dayVisitPlan;
            for(let index=0; index < contacts.length; index++){            
                var Mobj = {
                    location: {  
                        Latitude: contacts[index].Geo_Location__Latitude__s,
                        Longitude: contacts[index].Geo_Location__Longitude__s,
                        Street: contacts[index].Name
                    },
                    icon: 'standard:contact',
                    title: contacts[index].Name,
                    description: 'Store Location at - '  +contacts[index].Name + 'pinCode ' + contacts[index].BillingPostalCode
                }
                mapsArray.push(Mobj);
            }
            component.set('v.mapMarkers', mapsArray);
            component.set('v.centerObj', {
                location: {
                    Latitude: getDayVisitPlan.Representative_Initial_Location__Latitude__s,
                    Longitude: getDayVisitPlan.Representative_Initial_Location__Longitude__s,
                }
            });
        }
        component.set('v.zoomLevel', 11);
        component.set('v.markersTitle', 'Nearest Stores Locations');
        component.set('v.showFooter', true);        
        
    }
})