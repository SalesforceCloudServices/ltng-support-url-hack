({
	/**
	 * handles when all the default values are received
	 */
	handleDefaultValues : function(resultValue, component, helper){
		console.info('default values retrieved');
		debugger;

		var baseRecordId = resultValue.baseInfo.Id;
		var childName = resultValue.baseInfo.Name + ' Child';
		var childDescription = 'Child of ' + resultValue.baseInfo.CustomDescription__c;
		var childCheckbox = resultValue.baseInfo.SampleCheckbox__c;
		var childDate = resultValue.baseInfo.SampleDate__c;
		var childNumber = resultValue.baseInfo.SampleNumber__c;
		var childPicklist = resultValue.baseInfo.SamplePicklist__c;
		var createdByUserLastName = resultValue.currentUserLastName;
		var customSettingValue = resultValue.customMetadataInfo.MetadataValue__c;
		var customMetadataValue = resultValue.customSettingInfo.CustomSettingValue__c;

		var createRecordEvent = $A.get("e.force:createRecord");
		createRecordEvent.setParams({
			'entityApiName': 'ltng_URLHackChild__c',
			'recordTypeId': null,
			'defaultFieldValues': {
				'URLHackBase__c': baseRecordId,
				'Name': childName,
				'CustomDescription__c': childDescription,
				'CreatedByUserLastName__c': createdByUserLastName,
				'CustomSettingValue__c': customSettingValue,
				'CustomMetadataValue__c': customMetadataValue,
				'SampleCheckbox__c': childCheckbox,
				'SampleNumber__c': childNumber,
				'SampleDate__c': childDate,
				'SamplePicklist__c': childPicklist
			}
		});
		createRecordEvent.fire();

		helper.closeWindow();
	},

	/**
	 * Closes the modal window
	 */
	closeWindow : function(){
		$A.get("e.force:closeQuickAction").fire()
	},
	
	/**
	 * method called when base info has finished loading
	 **/
	checkAllDataLoaded : function(component, event, helper) {

		//-- if all data has loaded - we can create the child
		helper.createChildFromBaseInfo(component, helper);
	},

	/**
	 * Create a child using info from base object
	 * @param baseInfo ()
	 */
	createChildFromBaseInfo : function(component, helper){
		//-- determine the default values
		debugger;

		var baseInfo = component.get('v.baseInfo');
		var baseRecordId = baseInfo.Id;
		var childName = baseInfo.Name + " Child";
		var childDescription = baseInfo.CustomDescription__c;
		var childCheckbox = baseInfo.SampleCheckbox__c;
		var childDate = baseInfo.SampleDate__c;
		var childNumber = baseInfo.SampleNumber__c;
		var childPicklist = baseInfo.SamplePicklist__c;
		    

		createRecordEvent = $A.get('e.force:createRecord');
		createRecordEvent.setParams({
			'entityApiName': 'ltng_URLHackChild__c',
			'recordTypeId': null,
			'defaultFieldValues': {
				'Name': childName,
				'CustomDescription__c': childDescription,
				'SampleCheckbox__c': childCheckbox,
				'SampleNumber__c': childNumber,
				'SampleDate__c': childDate,
				'SamplePicklist__c': childPicklist
			}
		});
		createRecordEvent.fire();
	},

    /**
     * Displays an error
     * @param errorTitle (String)
     * @param errorMsg (String)
     **/
    displayError: function(errorCode, component, event, helper){
        var errorTitle = 'Error';
        var errorMsg = 'An error occurred: ' + errorCode + '. Please contact your System Administrator';
        
        //-- send a toast message
        var resultsToast = $A.get('e.force:showToast');
        resultsToast.setParams({
            'title': errorTitle,
            'message': errorMsg
        });
        resultsToast.fire();
    },
})