/**
 * Controller for for the ltng_URLHackComponent Lightning Component.
 *
 * <p>Make the changes below marked @CHANGE</p>
 * 
 * @author Your Name
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

        //-- retrieve all the info you need to default

        //-- @CHANGE: Retrieve the base object info - to use for default values.
        //-- replace YOUR_BASE_SOBJECT_API_NAME__c with the API Name of the base SObject (ex: Account or CustomObject__c)
        //-- replace YOUR_FIELD_API_NAME__c with the API Names of the fields to retrieve (ex: CustomField__c)
        try {
            results.baseInfo = [
                SELECT Id, Name, YOUR_FIELD_API_NAME__c, YOUR_FIELD_API_NAME__c, ....
                FROM YOUR_BASE_SOBJECT_API_NAME__c
                WHERE Id = :baseRecordId
                LIMIT 1
            ];
        } catch(Exception err){
            System.debug('exception when fetching the base record');
            System.debug(err);
        }

        //-- @CHANGE: Determine the RecordTypeId to use for the new object
        
        //-- the following line has the format:
        //-- Schema.SObjectType.NEW_OBJECT_API_NAME__c.getRecordTypeInfosByName().get('YOUR_RECORDTYPE_NAME').getRecordTypeId();

        //-- replace NEW_OBJECT_API_NAME__c with with the API Name of SObject the new record should be (ex: Opportunity, or ChildObject__c)
        //-- replace YOUR_RECORDTYPE_NAME with the NAME of the record type to use (ex: Extended or FieldService)
        results.childRecordTypeId = Schema.SObjectType.NEW_OBJECT_API_NAME__c
            .getRecordTypeInfosByName().get('YOUR_RECORDTYPE_NAME').getRecordTypeId();

        //-- any other Selects or data needed

        //--	-	-	-	-	-	-	-	-	-	-	-
        //-- UPDATE THE LINES ABOVE
        //--	-	-	-	-	-	-	-	-	-	-	-

        return results;
    }

    public class UrlHackDefaultValues {

        //--	-	-	-	-	-	-	-	-	-	-	-
        //-- UPDATE THE LINES BELOW
        //--	-	-	-	-	-	-	-	-	-	-	-

        //-- @CHANGE: create @AuraEnabled public properties for the info to be used in defaulting
        //--    This can be for the entire object (like this example)
        //--    or simple values (like the Last Name of the person that created the record)
        //-- replace YOUR_BASE_SOBJECT_API_NAME__c with the API Name of the base SObject (ex: Account or CustomObject__c)
        
        /** base info you want to return **/
        @AuraEnabled
        public YOUR_BASE_SOBJECT_API_NAME__c baseInfo;
        
        /** Record Type ID that the new child should use **/
        @AuraEnabled
        public Id childRecordTypeId;
        
        //-- add in any other properties here

        //--	-	-	-	-	-	-	-	-	-	-	-
        //-- UPDATE THE LINES ABOVE
        //--	-	-	-	-	-	-	-	-	-	-	-
    }    
}