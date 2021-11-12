public with sharing class InstituteData{
    public String instituteString{ get; set; }
    public List<SelectOption> instituteList{ get; set; }
    public String mentorString {get; set; }
    public List<Mentor__c> mentorList{ get; set; }
    public List<Student__c> studentList{
        get{
         studentList=new List<Student__c>();
            if(mentorString!=''){
                studentList=[SELECT Name, Class__c,City__c,State__c from Student__c where Mentor__c=: mentorString];                
            }
            return studentList;   
        }
        set;
    }
    public PageReference mentorData(){
        mentorString='';
        mentorList=new List<Mentor__c>();
        if(instituteString!=''){
            try{
                mentorList=[SELECT Name,Designation__c From Mentor__c where Institute__c=:instituteString];
                
            }
            
            catch(exception e){}            
        }
        return null;        
    }
    public InstituteData(){
        instituteString='';
        instituteList=new List<SelectOption>();
        List<Institute__c> institute=new List<Institute__c>([SELECT Id,Name From Institute__c]);
        instituteList.add(new SelectOption('','---SelectInstitute---'));
        for(Institute__c institutes:institute){
            instituteList.add(new SelectOption(institutes.ID, institutes.Name));            
        }
        mentorString='';
        StudentList= new List<Student__c>();  
  }
}