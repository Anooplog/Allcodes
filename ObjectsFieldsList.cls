public class ObjectsFieldsList{
    @AuraEnabled
    public static List<string> getAllObjects(){
        List<string> SObjectList = new List<string>();
        for(Schema.SObjectType objectType : Schema.getGlobalDescribe().Values()){
            String label = objectType.getDescribe().getLabel();
            //Exclude all the unwanted Sobjects e.g. History,Share etc...
            
            if(!label.containsignorecase('history') && !label.containsignorecase('tag')&& 
               !label.containsignorecase('share') && !label.containsignorecase('feed')){
                   sObjectList.add(label);
                   System.debug('Name:' + label);
               }
        }
        sObjectList.sort();
        return SObjectList;
    }
    @AuraEnabled
    public static String getAllFields(String selectedObject){
        Map<String,String> allfieldName = new Map<String,String>();
        Map<String,Schema.SObjectType> globalDescriber=Schema.getGlobalDescribe();
        Schema.SObjectType sobjectType = globalDescriber.get(selectedObject);
        Schema.DescribeSObjectResult describeResult = sobjectType.getDescribe();
        Map<String,Schema.SObjectField> fieldsMap = describeResult.fields.getMap();
        for(string fieldsValue: fieldsMap.keySet()){
            String typeString = string.valueOf(fieldsMap.get(fieldsValue).getDescribe().getType());
            if(typeString == 'PICKLIST' || typeString=='ID' || typeString== 'STRING' || typeString== 'REFERENCE' || typeString == 'DATETIME' || typeString == 'TEXTAREA' || typeString == 'ADDRESS' || typeString == 'DOUBLE'){
             allfieldName.put(fieldsMap.get(fieldsValue).getDescribe().getName(), 'TEXT');
            }
            else {
               allfieldName.put(fieldsMap.get(fieldsValue).getDescribe().getName(), string.valueOf(fieldsMap.get(fieldsValue).getDescribe().getType()));
  
            }
                }
        String fieldsNameAndType=JSON.serialize(allfieldName);
        System.debug(fieldsNameAndType);
        return fieldsNameAndType;
    } 
    @AuraEnabled
    public static List<sObject> getQuery(String query){
      return Database.query(query);
    }    
    }