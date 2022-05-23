public class ScholarshipRateService implements Database.Batchable<sObject>{
	public Database.QueryLocator start(Database.BatchableContext bc) {
        return 	Database.getQueryLocator(
        	'Select Id FROM Student__c'
        );
    }
		
    public void execute(Database.BatchableContext BC, list<Student__c> students){
        for (Student__c s : students) {
            if (s.Scholarship__c == 'Unassigned') {
                s.Scholarship_Rate__c = 0;
            }
            else if (s.Scholarship__c == 'Regular') {
                s.Scholarship_Rate__c = 100;
            }
            else if (s.Scholarship__c == 'Increased') {
                s.Scholarship_Rate__c = 125;
            }
            else if (s.Scholarship__c == 'Academic') {
                s.Scholarship_Rate__c = 250;
            } else {
                s.Scholarship_Rate__c = -1;
            }
        }
        update students;
    }

    public void finish(Database.BatchableContext BC){}

}