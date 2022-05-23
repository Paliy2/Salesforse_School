public class SchoolDAO  {
        public static Map<Id, Decimal> getStudentPerformance(Set<Id> studentIds) {
            Map<Id, Decimal> res = new Map<Id, Decimal>();
            for(Student__c student : [SELECT Id, Average_Grade__c FROM Student__c WHERE Id in :studentIds]){
                res.put(student.Id, student.Average_Grade__c);
            }
            return res;
        }
        
        public static Map<Id, Integer> getClassAttendance() {
            Map<Id, Integer> res = new Map<Id, Integer>();
            for(Class_Enrollment__c enrollment : [SELECT Id, Class__c, Student__c FROM Class_Enrollment__c]) {
                if ( res.get(enrollment.Id) == null) {
                    res.put(enrollment.Id, 0);
                }
                res.put(enrollment.Id, res.get(enrollment.Id)+1);
            }
            return res;
        }
        
        public static List<Class_Enrollment__c> getTopStudents(Id classId) {
            List<Class_Enrollment__c> res = [SELECT Id, Student__c
                                                FROM Class_Enrollment__c
                                                WHERE Class__r.Id = :classId
                                                ORDER BY Grade__c
                                                LIMIT 10];
            return res;
        }
        
        public static List<Student__c> getStudentsWithScholarship(Id classId) {
          List<Student__c> res = new List<Student__c>();
          for(Class_Enrollment__c enr: [SELECT Id, Student__c
                                        FROM Class_Enrollment__c
                                        WHERE Class__r.Id = :classId
                                        AND 
                                        Student__r.Scholarship__c != 'Unassigned'
                                       ]) {
              res.add([SELECT Id FROM Student__c WHERE Id = :enr.Student__c Limit 1]);
          }                     
          return res;
        }
    
    @AuraEnabled
    public static List<Student__c> getStudentsNoScholarship() {
          List<Student__c> res = new List<Student__c>([SELECT Id, Name,
                                                       Average_Grade__c,
                                                       Email__c	,
                                                       Year_of_Study__c
                                        FROM Student__c
                                        WHERE Scholarship__c = 'Unassigned'
                                       ]);            
          return res;
        }
}