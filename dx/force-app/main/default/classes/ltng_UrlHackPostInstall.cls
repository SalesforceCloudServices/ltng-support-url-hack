/**
 * Post installer for the URL Hack Demo.
 * <p>Creates the specific URL Hack Base records and custom setting records,
 *      so salesforce CLI is not needed</p>
 * 
 * <p>Please note, this is not intended for deployment to production,
 *      and is meant as an illustration tool</p>
 * 
 * @author Paul Roth <proth@salesforce.com>
 **/
global class ltng_UrlHackPostInstall implements InstallHandler {
    
    /**
     * Method called after installation
     * <p>For More information, please see:
     *      https://developer.salesforce.com/docs/atlas.en-us.packagingGuide.meta/packagingGuide/apex_post_install_script_create.htm
     * </p>
     **/
    global void onInstall(InstallContext context){
        
        if(context.previousVersion() != null){
            //-- not a fresh install
            //-- for now, remove all data
            
            this.removeAllBaseRecords();
            this.removeAllCustomSettingRecords();
        }
        
        this.createBaseRecords();
        this.createCustomSettingRecords();
    }
    
    global ltng_UrlHackBase__c[] removeAllBaseRecords(){
        ltng_UrlHackBase__c[] recordsToDelete = null;
        try {
            recordsToDelete = [
                SELECT Id
                FROM ltng_UrlHackBase__c
            ];
            
            delete recordsToDelete;
        } catch(Exception err){
            //-- do nothing for now.
            System.debug('Error occurred while attempting to delete all base records');
        }
        return(recordsToDelete);
    }
    
    global ltng_URLHackCustomSetting__c[] removeAllCustomSettingRecords(){
        ltng_URLHackCustomSetting__c[] recordsToDelete = null;
        try {
            recordsToDelete = [
                SELECT Id
                FROM ltng_URLHackCustomSetting__c
            ];
            
            delete recordsToDelete;
        } catch(Exception err){
            //-- do nothing for now.
            System.debug('Error occurred while attempting to delete all base records');
        }
        return(recordsToDelete);
    }
    
    global ltng_UrlHackBase__c[] createBaseRecords(){
        ltng_UrlHackBase__c[] results = new ltng_UrlHackBase__c[]{};
        
        //-- generated from data/trees/ltng_UrlHackBase__cs.json
        results.add( new ltng_UrlHackBase__c(
            Name = 'Demo Quick Action',
            CustomDescription__c = 'Simply click the \'Quick Action\' button on the top right.\r\nValues here (and from the custom setting & username) will be defaulted with special lay\r\nNOTE= Custom Metadata is not available for defaulting. Resulting record is under Related List.',
            SampleCheckbox__c = false,
            SampleDate__c = date.parse('2018-04-16'),
            SampleNumber__c = 11,
            SamplePicklist__c = 'Pending'
        ));
        
        results.add( new ltng_UrlHackBase__c(
            Name = 'Demo Lightning Action',
            CustomDescription__c = 'Click Lightning Action button on top right. This uses the page layout and specific record type.\r\nCompleting it takes you directly to the record / cancel leaves you on the same page.',
            SampleCheckbox__c = true,
            SampleDate__c = date.parse('2018-04-15'),
            SampleNumber__c = 22,
            SamplePicklist__c = 'Pending'
        ));
        
        results.add( new ltng_UrlHackBase__c(
            Name = 'Demo List Button',
            CustomDescription__c = 'List buttons must use VisualForce. Select the Related List and click \'VF Lightning\'.\r\nThis uses the page layout and specific recordType (similar to Lightning Action).\r\nCompleting it takes you to the record, but cancel requires a Lightning Button Click.',
            SampleCheckbox__c = true,
            SampleDate__c = date.parse('2018-04-12'),
            SampleNumber__c = 33,
            SamplePicklist__c = 'Validating'
        ));
        
        insert results;
        
        return results;
    }
    
    global ltng_URLHackCustomSetting__c[] createCustomSettingRecords(){
        ltng_URLHackCustomSetting__c[] results = new ltng_URLHackCustomSetting__c[]{
            new ltng_URLHackCustomSetting__c( CustomSettingValue__c = 'Value from Custom Setting' )
        };
        
        insert results;
        
        return results;
    }
}