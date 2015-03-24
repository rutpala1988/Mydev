public class EnhancedLookupController
{
	public SObject obj    { get; set; }
	public String objName { get {
		if (obj != null) {
  		return this.obj.getSObjectType().getDescribe().getName();
		}
		return null;
	} set; }
	
	public class Item
	{
		public String value;
    public String label;
		
		public Item(String v, String l)
		{
			value = v;
      label = l;
		}
	}
  
  @RemoteAction
  public static String getValues(String name, String field, String term, String filter)
  {
		Schema.DescribeSObjectResult objDescribe = Schema.getGlobalDescribe().get(name).getDescribe();
		Schema.DescribeFieldResult fieldDescribe = objDescribe.fields.getMap().get(field).getDescribe();
  	
  	if (fieldDescribe.getType() != Schema.DisplayType.Reference)
  		return '[]';
  	
  	if (filter != '')
  	  filter = ' And (' + filter + ')';
  	
  	List<Item> values = new List<Item>();
  	List<SObject> recList = Database.query('Select Id, Name From ' + fieldDescribe.getReferenceTo()[0] + ' Where Name Like \'%' + String.escapeSingleQuotes(term) + '%\'' + filter);
  	for (SObject rec : recList) {
  		values.add(new Item((String)rec.get('Id'), (String)rec.get('Name')));
  	}
  	
  	return JSON.serialize(values);
  }
  
  public static testMethod void EnhancedLookupControllerTest()
  {
  	String test = EnhancedLookupController.getValues('User', 'ProfileId', 'Standard Customer Portal Manager', 'Name Like \'Standard%\'');
  	System.assertEquals(test, '[{"value":"00e300000021NQdAAM","label":"Standard Customer Portal Manager"}]');
  	test = EnhancedLookupController.getValues('User', 'Name', '', '');
  	System.assertEquals(test, '[]');
  	EnhancedLookupController c = new EnhancedLookupController();
    System.assertEquals(c.objName, null);
  	c.obj = new Account();
  	System.assertEquals(c.objName, 'Account');
  }
}