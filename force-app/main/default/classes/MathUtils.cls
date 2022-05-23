public class MathUtils {    
    public static Decimal calculateAverage(List<Decimal> nums) {
        Decimal total = 0.0;
        for (Decimal n : nums) {
            total += n;
        }
        return total / nums.size();
    }
}