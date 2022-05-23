@IsTest
public class TestTriggers {
    static Class__c createClass() {
        Class__c c = new Class__c();
        c.Subject__c = 'Geometry';
        c.Year__c = '2022';
        c.Year_of_Study__c = '1;2';
        insert c;
        return c;
    }
    
    static Class__c createClassTwo() {
        Class__c c = new Class__c();
        c.Subject__c = 'Geometry';
        c.Year__c = '2022';
        c.Year_of_Study__c = '2;3;4';
        insert c;
        return c;
    }
    
    static Student__c createStudent() {
        Student__c c = new Student__c();
        c.Email__c = 'mail@gmail.com';
        c.Name = 'Test Studnt';
        c.Year_of_Study__c = '1';
        insert c;
        return c;
    }
    
    @testSetup static void setup() {
        createStudent();
        createClass();
        createClassTwo();
    }
    
    static testmethod void insertClassEnrollment() {
        Class_Enrollment__c ce = new Class_Enrollment__c();
        ce.Student__c = [SELECT Id FROM Student__c LIMIT 1].Id;
        ce.Class__c = [SELECT Id FROM Class__c LIMIT 1].Id;
        insert ce;
    }
    
    static testmethod void insertDuplicateClassEnrollment() {
        Class_Enrollment__c ce = new Class_Enrollment__c();
        ce.Student__c = [SELECT Id FROM Student__c LIMIT 1].Id;
        ce.Class__c = [SELECT Id FROM Class__c LIMIT 1].Id;
        insert ce;
        
        Class_Enrollment__c ceDuplicate = new Class_Enrollment__c();
        ceDuplicate.Student__c = [SELECT Id FROM Student__c LIMIT 1].Id;
        ceDuplicate.Class__c = [SELECT Id FROM Class__c LIMIT 1].Id;
        
        Test.startTest();
        	Database.SaveResult duplicateCeResult = Database.insert(ceDuplicate, false);
        Test.stopTest();
		System.assert(duplicateCeResult.isSuccess() == false, 'You cannot create a dulplicate Class Enrllment');
        System.assert(duplicateCeResult.getErrors().size() == 1);
    }
    
    static testmethod void createEnrollmentWrongStudentYear() {
        Class_Enrollment__c ce = new Class_Enrollment__c();
        ce.Student__c = [SELECT Id FROM Student__c LIMIT 1].Id;
        // ith offset -  select class Two
        ce.Class__c = [SELECT Id FROM Class__c LIMIT 1 offset 1].Id;

        Test.startTest();
        	Database.SaveResult duplicateCeResult = Database.insert(ce, false);
        Test.stopTest();
		System.assert(duplicateCeResult.isSuccess() == false,
                      'Student Year of Study 1 is not one of the Class Year of Study 2;3;4');
        System.assert(duplicateCeResult.getErrors().size() == 1);
    }
}