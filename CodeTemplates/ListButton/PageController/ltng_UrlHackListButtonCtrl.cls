/**
 * Controller for VisualForce page that performs a 'URL Hack' from a List Button.
 * <p>Make the changes below marked @CHANGE</p>
 * <p>Note the places to update with the UPDATE THE LINES ABOVE and UPDATE THE LINES BELOW</p>
 * 
 * @author Your Name
 * @class ltng_UrlHackListButtonCtrl
 **/
public class ltng_UrlHackListButtonCtrl {
    
    //-- store properties for all data to be available for defaulting.

    //-- we only want a single property to store the serialized version of the results
    public String serializedDefaultValues {get;set;}
    
    /** Constructor **/
    public ltng_UrlHackListButtonCtrl( ApexPages.StandardSetController controller ){
        //-- get the context from the originating Parent Account
        Map<String,String> params = new Map<String,String>();
        params = ApexPages.currentPage().getParameters();
		
        //-- get the ID of the Base Record to pull from
        String baseRecordId = params.get('id');
        
        //-- place to store the results
        UrlHackDefaultValues results = new UrlHackDefaultValues();
        String serializedResults;


        //--	-	-	-	-	-	-	-	-	-	-	-
        //-- UPDATE THE LINES BELOW
        //--	-	-	-	-	-	-	-	-	-	-	-

        //-- retrieve all the info you need to default

        //-- @CHANGE: Retrieve the base object info - to use for default values.
        //-- replace YOUR_BASE_SOBJECT_API_NAME__c with the API Name of the base SObject (ex: Account or CustomObject__c)
        //-- replace YOUR_FIELD_API_NAME__c with the customFields to retrieve (ex: CustomField__c)
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
        //-- replace YOUR_SOBJECT_NAME with with the API Name of SObject the new record should be (ex: Opportunity, or ChildObject__c)
        //-- replace YOUR_RECORDTYPE_NAME with the NAME of the record type to use (ex: Extended or FieldService)

        //-- the following line has the format:
        //-- Schema.SObjectType.YOUR_SOBJECT_NAME.getRecordTypeInfosByName().get('YOUR_RECORDTYPE_NAME').getRecordTypeId();

        results.childRecordTypeId = Schema.SObjectType.YOUR_SOBJECT_NAME
            .getRecordTypeInfosByName().get('YOUR_RECORDTYPE_NAME').getRecordTypeId();
        
        //--	-	-	-	-	-	-	-	-	-	-	-
        //-- UPDATE THE LINES ABOVE
        //--	-	-	-	-	-	-	-	-	-	-	-
        

        this.serializedDefaultValues = JSON.serialize(results);
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
        public YOUR_BASE_SOBJECT_API_NAME__c baseInfo;
        
        /** Record Type ID that the new child should use **/
        public Id childRecordTypeId;
        
        //-- add in any other properties here

        //--	-	-	-	-	-	-	-	-	-	-	-
        //-- UPDATE THE LINES ABOVE
        //--	-	-	-	-	-	-	-	-	-	-	-


    }
}