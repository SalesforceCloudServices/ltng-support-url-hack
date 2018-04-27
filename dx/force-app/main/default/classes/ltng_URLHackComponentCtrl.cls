/**
 * Controller for for the ltng_URLHackComponent Lightning Component.
 */
public with sharing class ltng_URLHackComponentCtrl {
    
    /**
     * Determines the list of default values to use
     * when creating the child record.
     * @param baseRecordId (Id)
     * @return UrlHackDefaultValues - custom object that contains everything it needs.
     */
    @AuraEnabled
    public static UrlHackDefaultValues getUrlHackDefaultValues(Id baseRecordId){

        UrlHackDefaultValues results = new UrlHackDefaultValues();


        //--	-	-	-	-	-	-	-	-	-	-	-
        //-- UPDATE THE LINES BELOW
        //--	-	-	-	-	-	-	-	-	-	-	-

        //-- get the base object info
        try {
            results.baseInfo = [
                SELECT Id, Name, CustomDescription__c,
                    SampleCheckbox__c, SampleDate__c, SampleNumber__c,
                    SamplePicklist__c
                FROM ltng_UrlHackBase__c
                WHERE Id = :baseRecordId
                LIMIT 1
            ];
        } catch(Exception err){
            System.debug('exception when fetching the base record');
            System.debug(err);
        }

        //-- get the record type that the child should be
        //-- Schema.SObjectType.SOBJECT_NAME.getRecordTypeInfosByName().get('RECORD_TYPE_NAME').getRecordTypeId();

        results.childRecordTypeId = Schema.SObjectType.ltng_UrlHackChild__c
            .getRecordTypeInfosByName().get('Extended').getRecordTypeId();
        
        //-- get the current user's last name;
        results.currentUserLastName = UserInfo.getLastName();

        //-- fetch custom Settings
        try {
            results.customSettingInfo = ltng_UrlHackCustomSetting__c.getInstance();
        } catch(Exception err){
            System.debug('No Opportunity Settings instance found');
            System.debug(err);
        }
        
        //-- fetch custom metadata
        try {
            results.customMetadataInfo = [
                SELECT id, MetadataValue__c, QualifiedAPIName
                FROM ltng_URLHackCustomMetadata__mdt
                WHERE QualifiedApiName = 'ExampleCustomMetadata'
                LIMIT 1
            ];
        } catch(Exception err){
            System.debug('No custom metadata found');
            System.debug(err);
        }
        //--	-	-	-	-	-	-	-	-	-	-	-
        //-- UPDATE THE LINES ABOVE
        //--	-	-	-	-	-	-	-	-	-	-	-

        return results;
    }

    public class UrlHackDefaultValues {

        //--	-	-	-	-	-	-	-	-	-	-	-
        //-- UPDATE THE LINES BELOW
        //--	-	-	-	-	-	-	-	-	-	-	-
        /** base info you want to return **/
        @AuraEnabled
        public ltng_URLHackBase__c baseInfo;
        
        /** record type id for the new child **/
        @AuraEnabled
        public String childRecordTypeId;

        /** last name of the current user **/
        @AuraEnabled
        public String currentUserLastName;

        /** custom setting values **/
        @AuraEnabled
        public ltng_UrlHackCustomSetting__c customSettingInfo;

        /** custom metadata values **/
        @AuraEnabled
        public ltng_URLHackCustomMetadata__mdt customMetadataInfo;
        //--	-	-	-	-	-	-	-	-	-	-	-
        //-- UPDATE THE LINES ABOVE
        //--	-	-	-	-	-	-	-	-	-	-	-
    }    
}