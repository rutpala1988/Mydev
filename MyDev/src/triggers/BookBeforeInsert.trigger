trigger BookBeforeInsert on Book__c (before insert) {

Book__c[] books=Trigger.new;
BookClass.applyDiscount(books);

}