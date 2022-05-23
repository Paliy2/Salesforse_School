public class UpdateScholarshipRate implements Schedulable {
    public void execute(SchedulableContext sc) {
      ScholarshipRateService srBatch = new ScholarshipRateService(); 
      database.executebatch(srBatch);
   }
}