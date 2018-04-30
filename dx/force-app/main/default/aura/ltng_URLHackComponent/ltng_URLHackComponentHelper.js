({
	/**
	 * Helper (Re-Usable Code) for the component
	 * 
	 * <p>Make changes in sections below marked @CHANGE</p>
	 */
	
	/**
	 * handles when all the default values are received
	 */
	handleDefaultValues : function(resultValue, component, helper){
		console.info('default values retrieved');

        //--	-	-	-	-	-	-	-	-	-	-	-
        //-- UPDATE THE LINES BELOW
        //--	-	-	-	-	-	-	-	-	-	-	-
		
		//-- @CHANGE: get the values to use for default
		//-- replace NEW_SOBJECT_API_NAME__c with the API Name of the type of object to create (ex: Account, CustomObject__c)
		//-- add in any other values to use for defaults
		
		//-- determine the values to use for defaulting
		var newObjectApiName = 'ltng_URLHackChild__c';
		var baseRecordId = resultValue.baseInfo.Id;
		var recordTypeId = resultValue.childRecordTypeId;

		var childName = resultValue.baseInfo.Name + ' Child';
		var childDescription = resultValue.baseInfo.CustomDescription__c;
		var childCheckbox = resultValue.baseInfo.SampleCheckbox__c;
		var childDate = resultValue.baseInfo.SampleDate__c;
		var childNumber = resultValue.baseInfo.SampleNumber__c;
		var childPicklist = resultValue.baseInfo.SamplePicklist__c;
		var createdByUserLastName = resultValue.currentUserLastName;
		var customSettingValue = resultValue.customMetadataInfo.MetadataValue__c;
		var customMetadataValue = resultValue.customSettingInfo.CustomSettingValue__c;

		//-- @CHANGE: default the values
		//-- replace FIELD_TO_DEFAULT_API_NAME__c with the API name of the field to default (ex: Name or CustomDescription__c)
		//-- replace DEFAULT_VALUE as the value to default - the variable from above
		var defaultValues = {
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
		};
		
		//--	-	-	-	-	-	-	-	-	-	-	-
		//-- UPDATE THE LINES ABOVE
		//--	-	-	-	-	-	-	-	-	-	-	-
		
		//-- the following uses this format:

		//-- call force:createRecord
		//-- see here for more info https://developer.salesforce.com/docs/atlas.en-us.lightning.meta/lightning/ref_force_createRecord.htm
		//-- createRecordEvent.setParams({
		//-- 	'entityApiName': 'SObject_Name',
		//--	'recordTypeId': RECORD_TYPE_OF_THE_OBJECT_TO_CREATE,
		//--	'defaultFieldValues': {
		//--		'FieldApi__c': defaultValue
		//--		...
		//--	}
		//-- })

		var createRecordEvent = $A.get("e.force:createRecord");
		createRecordEvent.setParams({
			'entityApiName': newObjectApiName,
			'recordTypeId': recordTypeId,
			'defaultFieldValues': defaultValues
		});

		//-- works
		//createRecordEvent.setParams({
		//	'entityApiName': newObjectApiName,
		//	'recordTypeId': recordTypeId,
		//	'defaultFieldValues': {
		//		'URLHackBase__c': baseRecordId,
		//		'Name': childName,
		//		'CustomDescription__c': childDescription,
		//		'CreatedByUserLastName__c': createdByUserLastName,
		//		'CustomSettingValue__c': customSettingValue,
		//		'CustomMetadataValue__c': customMetadataValue,
		//		'SampleCheckbox__c': childCheckbox,
		//		'SampleNumber__c': childNumber,
		//		'SampleDate__c': childDate,
		//		'SamplePicklist__c': childPicklist
		//	}
		//});

		//-- didn't work?
		//createRecordEvent.setParams({
		//	'entityApiName': newObjectApiName,
		//	'recordTypeId': recordTypeId,
		//	'defaultFieldValues': defaultValues
		//});

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