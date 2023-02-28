public without sharing class QboUtils {
    
    // Seconds Minutes Hours Day_of_month Month Day_of_week Optional_year
    public static string createCronStringForXMinutesFrom(Datetime startTime, integer xMinutes){
        string cronStart = '0 {0} * * * ? *';
        string xMinutesValue = string.valueOf(xMinutes);
        return String.format(cronStart, new List<String>{xMinutesValue});
    }


}