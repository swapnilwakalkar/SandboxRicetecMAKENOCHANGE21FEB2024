({
    doInit : function(component, event, helper) {        		
       helper.getStageNameHelper(component, event, helper);       
	},
 
	stagePicklistSelect : function (component, event, helper) {
        var stepName = event.getParam("detail").value;
        alert('stepName ' + stepName);
        component.set("v.PicklistField.StageName", stepName);
 
        component.find("record").saveRecord($A.getCallback(function(response) {
            if (response.state === "SUCCESS") {
                $A.get('e.force:refreshView').fire();
            }
        }));
    },
 
})