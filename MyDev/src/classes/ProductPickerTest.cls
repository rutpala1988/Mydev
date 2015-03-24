@isTest
public class ProductPickerTest {
	public static testMethod void runTests() {
		PageReference pageRef = Page.ProductPicker;
        Test.setCurrentPage(pageRef);
         
        Pricebook2 pb2 = [select id from Pricebook2 limit 1];
        
        Account a = new Account();
        a.name = 'test account';
        insert a;
        
        Opportunity o = new Opportunity();
        o.Pricebook2Id = pb2.id;
        o.name = 'test opportunity';
        o.AccountId = a.id;
        o.CloseDate = Date.today();
        o.StageName = 'prospecting';
        insert o;
        
        ApexPages.StandardController sc = new ApexPages.standardController(o);
        ProductPicker pp = new ProductPicker(sc);
        pp.keyword = 'product';
        pp.getProducts();
        pp.keyword = '';
        pp.getProducts();
        pp.getProductFamily();
        for(ProductPicker.ProductWrapper pw:pp.pwList) { 
        	pw.quantity = '1';
        }
        pp.GetSelectedProducts();
        String id = pp.pwList[0].product.id;
        pp.deleteId = id;
        pp.DeleteSelectedItem();
        pp.SaveProducts();
        pp.clearSearch();
	}
}