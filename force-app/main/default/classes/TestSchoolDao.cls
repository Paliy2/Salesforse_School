@IsTest
public class TestSchoolDao {
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
        SchoolService.enrollStudentToClass([Select Id From Class__c Limit 1 Offset 1].Id, [Select Id From Student__c Limit 1 Offset 1].Id);
    }
    
    static testmethod void testGetStudentPerformance() {
        
        map<Id, Student__c> studentsMap = new map<Id, Student__c>([Select Id, Year_of_Study__c From Student__c]);
        SchoolDao.getStudentPerformance(studentsMap.keySet());
    }
    static testmethod void testGetClassAttendance() {
        SchoolDao.getClassAttendance();
    }
    static testmethod void testGetTopStudents() {
        SchoolDao.getTopStudents([Select Id From Class__c Limit 1].Id);
    }
    static testmethod void testGetStudentsWithScholarship() {
        SchoolDao.getStudentsWithScholarship([Select Id From Class__c Limit 1].Id);
    }
}