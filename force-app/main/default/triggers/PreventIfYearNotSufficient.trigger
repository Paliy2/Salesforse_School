trigger PreventIfYearNotSufficient on Class_Enrollment__c (before insert) {    
    for (Class_Enrollment__c ce : Trigger.new) {   
        Class__c curr_class = [SELECT Id, Year_of_Study__c FROM Class__c WHERE Id = :ce.Class__c]; 
        Student__c curr_student = [SELECT Id, Year_of_Study__c FROM Student__c WHERE Id = :ce.Student__c];

        List<String> selections = curr_class.Year_of_Study__c.split(';');
        if (!selections.contains(curr_student.Year_of_Study__c)) {
            ce.addError('Student Year of Study ' + curr_student.Year_of_Study__c + ' is not one of the Class Year of Study '+ curr_class.Year_of_Study__c);
        }
    }
}