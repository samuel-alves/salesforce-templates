public static void sleep(Integer secs) {
    Long epochToDate = System.currentTimeMillis();
    Long epochStop = epochToDate + (secs * 1000);

    while (epochToDate <= epochStop) {
        epochToDate = System.currentTimeMillis();
    }
}

public static void createContact(String email) {
    Account acc = [SELECT Id FROM Account LIMIT 1];
    Contact newContact = new Contact(
        FirstName = '1st',
        LastName = 'RaceCondition',
        AccountId = acc.Id,
        Email = email
    );
    insert newContact;
}

public static void getAndDeleteContact(Integer sleepSeconds, String email) {
    Contact testRaceCondition = [SELECT Id, FirstName, LastName FROM Contact WHERE Email = :email FOR UPDATE];

    sleep(sleepSeconds);

    delete testRaceCondition;
}

public static void getContact(String email) {
    Contact testRaceCondition = [SELECT Id, FirstName, LastName FROM Contact WHERE Email = :email FOR UPDATE];

    System.debug(JSON.serialize(testRaceCondition));
}



/**
 * Test Race condition
 * 1. run "createContact" to create the test contact
 * 2. start the long running process
 * 3. get contact while step 2. is running
 */
// System.debug('FIRST');
// createContact('samuelalves+racecondition@loba.com');

// System.debug('SECOND');
// getAndDeleteContact(10, 'samuelalves+racecondition@loba.com');

System.debug('THIRD');
getContact('username+racecondition@test.com');

