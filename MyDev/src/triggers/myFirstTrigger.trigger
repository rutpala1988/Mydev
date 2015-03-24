trigger myFirstTrigger on Account (after insert) {

    //Create a list to hold all new records
    List<Account> newRecords = new List<Account>();

    //Loop around all records in the trigger transaction
    for(Account theRecord : Trigger.new){

        //Evaluate the record against our critieria
        if(theRecord.Name == 'Raghunath'){

            //The line below creates a new Account record and adds it to our list of new records. Add your field assigments (examples below). Make sure to assign all required fields.
            Account newRecord = new Account();
            //newRecord.Name = theRecord.name;
            //newRecord.Description = 'My New Record';
            newRecords.add(newRecord);

        }
    }

    //Insert the new records if any exist
    if(newRecords.size() > 0)
        upsert newRecords;
}