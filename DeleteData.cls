global class DeleteData implements Database.Batchable<sObject>,Schedulable{
    static Date today2 = Date.today().addDays(-2);
    
    public Database.QueryLocator start(Database.BatchableContext context)
    {
        return Database.getQueryLocator('SELECT Name, Mark_for_Delete__c FROM Trainee__c WHERE Mark_for_Delete__c= \'YES\'');  
    }
    
    global void execute(Database.BatchableContext context, List<Trainee__c> scope)
    {                                           
        delete scope;   
   }
 
    global void execute(SchedulableContext ctx) 
    {
        Database.executeBatch(new DeleteData ());       
    }
      
    global void finish(Database.BatchableContext BC){
    }
}