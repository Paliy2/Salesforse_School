trigger PreventDuplicates on Class_Enrollment__c (before insert) {     
     Map<Id, Class_Enrollment__c> existingEnrollmentMap = new  Map<Id, Class_Enrollment__c>([Select Id, Class__c, Student__c From Class_Enrollment__c]); 

     for(Class_Enrollment__c ce : Trigger.new){ 
         System.debug(ce);
         for (String key : existingEnrollmentMap.keySet()) {
             Class_Enrollment__c curr_class_enr = existingEnrollmentMap.get(key);
             
             if(ce.Class__c == curr_class_enr.Class__c && ce.Student__c == curr_class_enr.Student__c){
              ce.addError('You cannot create a dulplicate Class Enrllment');
       		}
         }
     }
}