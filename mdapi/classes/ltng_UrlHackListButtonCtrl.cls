/**
 * Controller for VisualForce page that performs a 'URL Hack' from a List Button.
 * <p>Note the places to update with the UPDATE THE LINES ABOVE and UPDATE THE LINES BELOW</p>
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
            results.baseInfo = [SELECT Id, Name, CustomDescription__c,
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

        //-- @CHANGE: Determine the RecordTypeId to use for the new object
        //-- replace YOUR_SOBJECT_NAME with with the API Name of SObject the new record should be (ex: Opportunity, or ChildObject__c)
        //-- replace YOUR_RECORDTYPE_NAME with the NAME of the record type to use (ex: Extended or FieldService)

        //-- the following line has the format:
        //-- Schema.SObjectType.YOUR_SOBJECT_NAME.getRecordTypeInfosByName().get('YOUR_RECORDTYPE_NAME').getRecordTypeId();

        results.recordTypeId = Schema.SObjectType.ltng_UrlHackChild__c
            .getRecordTypeInfosByName().get('Extended').getRecordTypeId();
                
        //-- optional fetch the user information
        results.currentUserLastName = UserInfo.getLastName();
        
        //-- optional fetch custom Settings
        try {
            results.customSettingInfo = ltng_UrlHackCustomSetting__c.getInstance();
        } catch(Exception err){
            System.debug('No Opportunity Settings instance found');
            System.debug(err);
        }
        
        //-- optional fetch custom metadata
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

        this.serializedDefaultValues = JSON.serialize(results);
    }


    public class UrlHackDefaultValues {


        //--	-	-	-	-	-	-	-	-	-	-	-
        //-- UPDATE THE LINES BELOW
        //--	-	-	-	-	-	-	-	-	-	-	-
        
        //-- @CHANGE: create public properties for the info to be used in defaulting
        //--    This can be for the entire object (like this example)
        //--    or simple values (like the Last Name of the person that created the record)
        //-- replace YOUR_BASE_SOBJECT_API_NAME__c with the API Name of the base SObject (ex: Account or CustomObject__c)
        
        /** base info you want to return **/
        public ltng_URLHackBase__c baseInfo;
        
        /** record type id for the new child **/
        public String recordTypeId;

        /** optional last name of the current user **/
        public String currentUserLastName;

        /** optional custom setting values **/
        public ltng_UrlHackCustomSetting__c customSettingInfo;

        /** optional custom metadata values **/
        public ltng_URLHackCustomMetadata__mdt customMetadataInfo;

        //--	-	-	-	-	-	-	-	-	-	-	-
        //-- UPDATE THE LINES ABOVE
        //--	-	-	-	-	-	-	-	-	-	-	-


    }
}