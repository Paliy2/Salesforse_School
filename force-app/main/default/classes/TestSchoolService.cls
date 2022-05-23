@IsTest
public class TestSchoolService {
    @testSetup static void setup() {
        Student__c c = new Student__c();
        c.Email__c = 'mail@gmail.com';
        c.Name = 'Test Student';
        c.Year_of_Study__c = '1';
        insert c;
        
        Student__c c2 = new Student__c();
        c2.Email__c = 'mail_2@gmail.com';
        c2.Name = 'Test Two';
        c2.Year_of_Study__c = '2';
        insert c2;
        
         Class__c clas = new Class__c();
        clas.Subject__c = 'Geometry';
        clas.Year__c = '2022';
        clas.Year_of_Study__c = '1;2';
        insert clas;
        
 		Class__c clas2 = new Class__c();
        clas2.Subject__c = 'Geometry';
        clas2.Year__c = '2021';
        clas2.Year_of_Study__c = '2;3';
        insert clas2;
        
        SchoolService.enrollStudentToClass([Select Id From Class__c Limit 1].Id, [Select Id From Student__c Limit 1].Id);
    }
    
    static testmethod void testEnrollStudentToClass() {
        SchoolService.enrollStudentToClass([Select Id From Class__c Limit 1].Id, [Select Id From Student__c Limit 1].Id);
    }
    static testmethod void testSetGrade() {
        SchoolService.setGrade([Select Id From Class__c Limit 1].Id, [Select Id From Student__c Limit 1].Id, 20);
    }
    
    static testmethod void testSetGradeTwo() {
        SchoolService.setGrade([Select Id From Class_Enrollment__c Limit 1].Id, 20);
    }
	static testmethod void testSetAcademicScholarchip() {
        SchoolService.setAcademicScholarship([Select Id From Student__c Limit 1].Id);
    }
    static testmethod void testrecalculateScholarship() {
        SchoolService.recalculateScholarship([Select Id From Student__c Limit 1].Id);
    }
    static testmethod void testrecalculateScholarshipTwo() {
        SchoolService.setGrade([Select Id From Class_Enrollment__c Limit 1].Id, 90);
        SchoolService.recalculateScholarship([Select Id From Student__c Limit 1].Id);
    }
}