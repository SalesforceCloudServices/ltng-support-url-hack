/**
 * Controller for the LightningEventFromVF page
 **/
public class LightningEventFromVF_C {
    
    /** Record with info to pass in defaulted properties **/
    public Contact contactInfo {get;set;}
    
    /** Custom Setting with info to pass in defaulted properties **/ 
    public OpportunitySettings__c opptySettings {get;set;}
    
    /** Constructor **/
    public LightningEventFromVF_C( ApexPages.StandardSetController controller ){
        
        //-- get the context from the originating Parent Account
        Map<String,String> params = new Map<String,String>();
        params = ApexPages.currentPage().getParameters();

        String contactId = params.get('id');
        this.contactInfo = new Contact();
        
        try {
            this.contactInfo = [SELECT Id, Name, AccountId, SourceSystem__c
                FROM Contact
                WHERE Id = :contactId
                LIMIT 1
            ];
        } catch(Exception err){
            System.debug('exception when finding contact');
            System.debug(err);
        }
        
        //-- optionally get information from Custom Settings
        this.opptySettings = new OpportunitySettings__c();
        
        try {
            this.opptySettings = OpportunitySettings__c.getInstance();
        } catch(Exception err){
            System.debug('No Opportunity Settings instance found');
            System.debug(err);
        }
    }
}