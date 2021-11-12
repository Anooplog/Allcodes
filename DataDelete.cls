global class DataDelete implements Database.Batchable<sObject>,Schedulable{
    static Date today2 = Date.today().addDays(-2);

    public Database.QueryLocator start(Database.BatchableContext context)
    {
        return Database.getQueryLocator('Select Name from Trainee__c where CreatedDate  :today2');
       
      
    
}
    public void execute(Database.BatchableContext context, List<SObject> records)
    {
        delete records;
    }

    global void execute(SchedulableContext ctx) 
    {
        Database.executeBatch(new DataDelete ());
        
        
    }
global void finish(Database.BatchableContext BC){
}
}