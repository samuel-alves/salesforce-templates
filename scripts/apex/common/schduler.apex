DateTime now = Datetime.now().addSeconds(5);
String cronExp = String.format('{0} {1} {2} {3} {4} ?', new List<Object> {
    now.second(),
    now.minute(),
    now.hour(),
    now.day(),
    now.month()
});
System.debug(cronExp);
Id jiobId = System.schedule('MyBatchClass', cronExp, new MyBatchClass());