/**
 * Controller for VisualForce page that performs a 'URL Hack' from a List Button.
 * @class ltng_UrlHackListButtonCtrl
 **/
public class ltng_UrlHackListButtonCtrl {
    
    //-- store properties for all data to be available for defaulting.
    
    /** Current user's info **/
    public String currentUserLastName {get;set;}
    
    /** RecordType Id for the new Child **/
    public String recordTypeId {get;set;}
    
    /** Record with info to pass in defaulted properties **/
    public ltng_UrlHackBase__c baseInfo {get;set;}
    
    /** Custom Setting info to pass in defaulted properties **/ 
    public ltng_UrlHackCustomSetting__c customSettingInfo {get;set;}
    
    /** Custom Metadata info to pass in defaulted properties **/ 
    public ltng_UrlHackCustomMetadata__mdt customMetadataInfo {get;set;}
    
    /** Constructor **/
    public ltng_UrlHackListButtonCtrl( ApexPages.StandardSetController controller ){
        //-- get the context from the originating Parent Account
        Map<String,String> params = new Map<String,String>();
        params = ApexPages.currentPage().getParameters();
		
        //-- get the ID of the Base Record to pull from
        String baseRecordId = params.get('id');
        
        //-- UPDATE THE LINES BELOW
        //--	-	-	-	-	-	-	-	-	-	-	-
        
        //-- retrieve all the info you need to default
        //-- recordTypeIds are needed if there are multiple
        
        try {
            this.recordTypeId = [
                SELECT Id, DeveloperName, Name, SObjectType
                FROM RecordType
                WHERE SObjectType = 'ltng_URLHackChild__c'
                AND DeveloperName = 'Extended'
            ].Id;
        } catch(Exception err){
            System.debug('unable to find record type ID');
            System.debug(err);
        }
        
        //-- fetch the user information
        this.currentUserLastName = UserInfo.getLastName();
        
        //-- fetch the base object info
        try {
            this.baseInfo = [SELECT Id, Name, CustomDescription__c,
                	SampleCheckbox__c, SampleDate__c, SampleNumber__c,
                	SamplePicklist__c
                FROM ltng_UrlHackBase__c
                WHERE Id = :baseRecordId
                LIMIT 1
            ];
        } catch(Exception err){
            System.debug('exception when finding contact');
            System.debug(err);
        }
                
        //-- fetch custom Settings
        try {
            this.customSettingInfo = ltng_UrlHackCustomSetting__c.getInstance();
        } catch(Exception err){
            System.debug('No Opportunity Settings instance found');
            System.debug(err);
        }
        
        //-- fetch custom metadata
        try {
            this.customMetadataInfo = [
                SELECT id, MetadataValue__c, QualifiedAPIName
                FROM ltng_URLHackCustomMetadata__mdt
                WHERE QualifiedApiName = 'ExampleCustomMetadata'
                LIMIT 1
            ];
        } catch(Exception err){
            System.debug('No custom metadata found');
            System.debug(err);
        }
        
        //-- optionally get information from custom metadata
    }
}