public class SchoolService {
    public static void enrollStudentToClass(Id classId, Id studentId) {
        Student__c student = [SELECT Id FROM Student__c WHERE Id = :studentId];
        Class__c clas = [SELECT Id FROM Class__c WHERE Id = :classId];
        
        Class_Enrollment__c newClassEnrollment = new Class_Enrollment__c(Student__c=student.Id, Class__c=clas.Id);
        try {
            insert newClassEnrollment; 
        }
        catch (DmlException e) {}
    }
    
    public static void setGrade(Id classId, Id studentId, Integer grade) {
        Class_Enrollment__c ce = [SELECT Id, Grade__c FROM Class_Enrollment__c WHERE Student__r.Id = :studentId AND Class__r.Id = :classId];
        ce.Grade__c = grade;
        try {
            update ce;
        }
        catch (DmlException e) {}
    }
    
    public static void setGrade(Id classEnrollmentId, Integer grade) {
        Class_Enrollment__c ce = [SELECT Id, Grade__c FROM Class_Enrollment__c WHERE Id = :classEnrollmentId];
        ce.Grade__c = grade;
        try {
            update ce;
        }
        catch (DmlException e) {}
    }
    
    public static void setAcademicScholarship(Id studentId) {
        Student__c student = [SELECT Id, Scholarship__c FROM Student__c WHERE Id = :studentId];
        student.Scholarship__c = 'Academic';
        try {
            update student;
        }
        catch (DmlException e) {}
    }
    
    public static void recalculateScholarship(Id studentId) {
        Student__c student = [SELECT Id, Scholarship__c, Average_Grade__c FROM Student__c WHERE Id = :studentId];
        List<Class_Enrollment__c> studentEnrollments = [SELECT Id, Grade__c FROM Class_Enrollment__c Where Student__r.Id = :studentId];
        // have 71 to 87 in all attended classws
        for(Class_Enrollment__c enr : studentEnrollments ) {
            if (enr.Grade__c == null) {return;}
            if (enr.Grade__c < 71 || enr.Grade__c > 87 ) {
            // cant have scholarship
            return;
            }
        }
        student.Scholarship__c = 'Regular';
        if (student.Average_Grade__c > 88) {
            student.Scholarship__c = 'Increased';
        }
        try {
            update student;
        }
        catch (DmlException e) {}
    }
}