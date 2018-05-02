/**
 * Controller for the ltng_UrlHackDemoSetup page.
 **/
global with sharing class ltng_URLHackDemoSetupCtrl {

    //-- static
    global static final String PERMISSION_SET_NAME = 'UrlHackDemoParticipant';

    //-- setup step (conveys to the component what was or will be run)
    /**
     * Internal class that represents an item to be completed.
     **/
    global class SetupStep {
        @AuraEnabled
        global boolean isComplete;

        @AuraEnabled
        global String errMsg;

        @AuraEnabled
        global String devErrMsg;

        @AuraEnabled
        global String completionDate;
        
        @AuraEnabled
        global String title;
        
        @AuraEnabled
        global String descr;

        @AuraEnabled
        global String reasoning;

        @AuraEnabled
        global String seeMore;

        @AuraEnabled
        global String seeMoreLabel;

        SetupStep( Map<String,Object> props){
            //-- make similar to sObject inline definition
            if( props.containsKey('isComplete')){
                this.isComplete = (boolean)props.get('isComplete');
            }
            if( props.containsKey('errMsg')){
                this.errMsg = (String)props.get('errMsg');
            }
            if( props.containsKey('devErrMsg')){
                this.devErrMsg = (String)props.get('devErrMsg');
            }
            if( props.containsKey('completionDate')){
                this.completionDate = (String)props.get('completionDate');
            }
            if( props.containsKey('title')){
                this.title = (String)props.get('title');
            }
            if( props.containsKey('descr')){
                this.descr = (String)props.get('descr');
            }
            if( props.containsKey('reasoning')){
                this.reasoning = (String)props.get('reasoning');
            }
            if( props.containsKey('seeMore')){
                this.seeMore = (String)props.get('seeMore');
            }
            if( props.containsKey('seeMoreLabel')){
                this.seeMoreLabel = (String)props.get('seeMoreLabel');
            }
        }

        void markCompleted(){
            this.isComplete = true;
            this.completionDate = System.now().format();
        }
    }

    //--    -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -
    //--    CHANGE - BELOW
    //--    -   -   -   -   -   -   -   -   -   -   -   -   -   -   -   -

    /**
     * Actually runs the setup
     * @return SetupStep[] - list of setup steps ran and the status for each.
     **/
    @AuraEnabled
    global static SetupStep[] runSetup(boolean getInfoOnly){
        SetupStep[] results = new SetupStep[]{
            removeAllBaseRecords(getInfoOnly),
            removeAllCustomSettingRecords(getInfoOnly),
            createBaseRecords(getInfoOnly),
            createCustomSettingRecords(getInfoOnly),
            addUserToPermissionSet(getInfoOnly)
        };
        return results;
    }

    //-- actual steps to run

    /**
     * Remove any of the base records that are currently there.
     **/
    global static SetupStep removeAllBaseRecords( boolean getInfoOnly){
        SetupStep step = new SetupStep( new Map<String,Object>{
            'title' => 'Remove any existing base objects'
        });

        if(getInfoOnly){
            return step;
        }

        ltng_UrlHackBase__c[] recordsToDelete = null;
        try {
            recordsToDelete = [
                SELECT Id
                FROM ltng_UrlHackBase__c
            ];
            
            delete recordsToDelete;
        } catch(Exception err){
            step.errMsg = 'Error occurred while attempting to delete all base records';
            step.devErrMsg = err.getMessage();
            //-- do nothing for now.
            System.debug(step.errMsg);
        }
        
        step.markCompleted();
        return(step);
    }

    /**
     * remove any custom setting records that are currently there.
     **/
    global static SetupStep removeAllCustomSettingRecords( boolean getInfoOnly ){
        SetupStep step = new SetupStep( new Map<String,Object>{
            'title' => 'Remove any existing custom setting records'
        });

        if(getInfoOnly){
            return step;
        }

        ltng_URLHackCustomSetting__c[] recordsToDelete = null;
        try {
            recordsToDelete = [
                SELECT Id
                FROM ltng_URLHackCustomSetting__c
            ];
            
            delete recordsToDelete;
        } catch(Exception err){
            step.errMsg = 'Error occurred while attempting to delete all base records';
            step.devErrMsg = err.getMessage();
            //-- do nothing for now.
            System.debug(step.errMsg);
        }
        
        step.markCompleted();
        return(step);
    }

    /**
     * Create the base records.
     **/
    global static SetupStep createBaseRecords( boolean getInfoOnly ){
        SetupStep step = new SetupStep( new Map<String,Object>{
            'title' => 'Create Base Objects',
            'descr' => 'Url Hack Base - objects (ltng_UrlHackBase__c)',
            'reasoning' => '(These are the objects you initiate the demo / URL Hack from)'
        });

        if(getInfoOnly){
            return step;
        }

        //-- generated from data/trees/ltng_UrlHackBase__cs.json
        ltng_UrlHackBase__c[] baseRecords = new ltng_UrlHackBase__c[]{};
        baseRecords.add( new ltng_UrlHackBase__c(
            Name = 'Demo Quick Action',
            CustomDescription__c = 'Simply click the \'Quick Action\' button on the top right.\r\nValues here (and from the custom setting & username) will be defaulted with special lay\r\nNOTE= Custom Metadata is not available for defaulting. Resulting record is under Related List.',
            SampleCheckbox__c = false,
            SampleDate__c = date.valueOf('2018-04-16'),
            SampleNumber__c = 11,
            SamplePicklist__c = 'Pending'
        ));
        
        baseRecords.add( new ltng_UrlHackBase__c(
            Name = 'Demo Lightning Action',
            CustomDescription__c = 'Click Lightning Action button on top right. This uses the page layout and specific record type.\r\nCompleting it takes you directly to the record / cancel leaves you on the same page.',
            SampleCheckbox__c = true,
            SampleDate__c = date.valueOf('2018-04-15'),
            SampleNumber__c = 22,
            SamplePicklist__c = 'Pending'
        ));
        
        baseRecords.add( new ltng_UrlHackBase__c(
            Name = 'Demo List Button',
            CustomDescription__c = 'List buttons must use VisualForce. Select the Related List and click \'VF Lightning\'.\r\nThis uses the page layout and specific recordType (similar to Lightning Action).\r\nCompleting it takes you to the record, but cancel requires a Lightning Button Click.',
            SampleCheckbox__c = true,
            SampleDate__c = date.valueOf('2018-04-12'),
            SampleNumber__c = 33,
            SamplePicklist__c = 'Validating'
        ));
        
        try {
            insert baseRecords;

            step.seeMore = baseRecords[0].Id;
        } catch( Exception err){
            step.errMsg = 'error occurred while creating base records';
            step.devErrMsg = err.getMessage();
            System.debug(step.errMsg);
        }

        step.markCompleted();
        return(step);
    }

    /**
     * Create the custom setting record.
     **/
    global static SetupStep createCustomSettingRecords( boolean getInfoOnly){
        SetupStep step = new SetupStep( new Map<String,Object>{
            'title' => 'Create CustomSetting record',
            'descr' => 'URL Hack Custom Setting - custom Setting (ltng_URLHackCustomSetting__c)',
            'reasoning' => '(Only created if needed). This is used in some of the demos to show how custom settings can be leveraged.'
        });

        if(getInfoOnly){
            return step;
        }
        
        ltng_URLHackCustomSetting__c[] results = new ltng_URLHackCustomSetting__c[]{
            new ltng_URLHackCustomSetting__c( CustomSettingValue__c = 'Value from Custom Setting' )
        };
        
        try {
            insert results;
        } catch( Exception err){
            step.errMsg = 'error occurred while creating custom setting records';
            step.devErrMsg = err.getMessage();
            System.debug(step.errMsg);
        }

        step.markCompleted();
        return(step);
    }

    /**
     * Assign the user to the custom setting.
     * <p>Note: actual work must be a future to avoid a MixedDML issue</p>
     **/
    global static SetupStep addUserToPermissionSet( boolean getInfoOnly ){
        SetupStep step = new SetupStep( new Map<String,Object>{
            'title' => 'Assign current user PermissionSet to see the Demo',
            'descr' => 'PermissionSet: ' + PERMISSION_SET_NAME + '. May take a second to take effect.',
            'reasoning' => 'All access is granted by PermissionSet. Only those with this PermissionSet can see the demo'
        });

        if( getInfoOnly ){
            return(step);
        }

        addUserToPermissionSetImpl();

        step.markCompleted();
        return(step);
    }

    /**
     * Implementation that actually adds the user to the permission set.
     **/
    @future
    global static void addUserToPermissionSetImpl(){    
        Id userId = UserInfo.getUserId();
        PermissionSetAssignment[] results = null;
        
        try {
            PermissionSet ps = [
                SELECT Id, Name
                FROM PermissionSet
                WHERE Name = :PERMISSION_SET_NAME
                LIMIT 1
            ];

            results = [
                SELECT Id, PermissionSetId, AssigneeId
                FROM PermissionSetAssignment
                WHERE AssigneeId = :userId
                    AND PermissionSetId = :ps.Id 
                LIMIT 1
            ];
            
            if(results.size() > 0){
                System.debug('User is already assigned to the PermissionSet');
            } else {
                results = new PermissionSetAssignment[]{
                    new PermissionSetAssignment( PermissionSetId = ps.Id, AssigneeId = UserInfo.getUserId() )
                };

                insert results;
            }
        } catch(Exception err){
            //-- do nothing
            System.debug('ERROR - could not assign user to permission set');
            System.debug(err.getMessage());
        }
    }


}
