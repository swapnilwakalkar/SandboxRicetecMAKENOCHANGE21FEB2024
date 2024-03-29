public class NumberTOWordConvertion {
    public string wordText { get; set; }
    public Integer numberVal { get; set; }
    // Action method to be called by button or link
    public void convert() {
        wordText = numberToEnglish(numberVal);
    }

    static String[] firstTwenty = new String[] { 'NIL','One','Two','Three','Four','Five','Six','Seven','Eight','Nine',
            'Ten','Eleven','Twelve','Thirteen','Fourteen','Fifteen','Sixteen','Seventeen','Eighteen','Ninteen' };
    static String[] tens = new String[] { '','','Twenty','Thirty','Forty','Fifty','Sixty','Seventy','Eighty','Ninety' };
    static String[] powers = new String[] { 'Crore','Lakh','Thousand','Hundred' };
    static Integer[] thresholds = new Integer[] { 100000000, 100000, 1000, 100 };

    static String[] convert(Integer value) {
        String[] result = new String[0];
        Boolean less20 = value < 20, less100 = value < 100;
        if(less20) {
            result.add(firstTwenty[value]);
        } else if(less100) {
            Integer tenValue = value / 10, oneValue = Math.mod(value, 10);
            result.add(tens[tenValue]);
            if(oneValue > 0) {
                result.add(firstTwenty[oneValue]);
            }
        }
        if(less100) {
            return result;
        }
        if(value > 0) {
            for(Integer index = 0; index < thresholds.size(); index++) {
                if(thresholds[index] <= value) {
                    result.addAll(convert(value / thresholds[index]));
                    result.add(powers[index]);
                    value = Math.mod(value, thresholds[index]);
                }
            }
            if(value > 0) {
                result.addAll(convert(value));
            }
        }
        return result;
    }
    public static String numberToEnglish(Integer value) {
        return value != null && value >= 0? String.join(convert(value),' '): '';
    }
}