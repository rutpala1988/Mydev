public class ProductPicker {
    
    public String keyword {get;set;}
    public String family {get;set;}
    public String deleteId {get;set;}
    
    public List<ProductWrapper> pwList {get;set;}
    public List<ProductWrapper> selectedList {get;set;} 
    
    public Opportunity myOp {get;set;}
    public String hostname {get;set;}
    
    public ProductPicker(ApexPages.StandardController ctrl) { 
        family = '--';
        pwList = new List<ProductWrapper>();
        selectedList = new List<ProductWrapper>();
        String myId = ctrl.getId(); 
        myOp = [Select o.Type, o.TotalOpportunityQuantity, o.SystemModstamp, o.StageName, o.Probability, o.Pricebook2Id, o.OwnerId, o.NextStep, o.Name, o.LeadSource, o.LastModifiedDate, o.LastModifiedById, o.LastActivityDate, o.IsWon, o.IsDeleted, o.IsClosed, o.HasOpportunityLineItem, o.ForecastCategoryName, o.ForecastCategory, o.FiscalYear, o.FiscalQuarter, o.Fiscal, o.ExpectedRevenue, o.Description, o.CreatedDate, o.CreatedById, o.CloseDate, o.CampaignId, o.Amount, o.AccountId From Opportunity o where o.Id = :myId][0];
        Map<String,String> header = ApexPages.CurrentPage().getHeaders();
        hostname = header.get('Referer');
    }
    
    public void addPricebook() {
        if (myOp.pricebook2Id == null) {
            Pricebook2 stdPricebook = [select id, isStandard from Pricebook2 where isStandard = true];
            myOp.pricebook2id = stdPricebook.id;
            update myOp;
        }
    }
    
    public List<SelectOption> getProductFamily() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('--','--'));
        
        Schema.DescribeFieldResult fieldResult = Product2.Family.getDescribe();
        List<Schema.PicklistEntry> familyValues = fieldResult.getPickListValues();
        for (Schema.PicklistEntry f: familyValues) {
            options.add(new SelectOption(f.getLabel(),f.getValue()));
        }
        return options;
    }
    
    public void getProducts() {
        List<List<SObject>> searchList;
        String query = getQuery();
        System.debug('*** Query: ' + query + ' ***');
        if (query.length() > 0) {
            searchList = search.query(getQuery());
            if (searchList.size() == 1) {
                pwList.clear();
                List<Product2> pList = (List<Product2>) searchList[0];
                for (Product2 p : pList) {
                    ProductWrapper pw = new ProductWrapper(p,myOp);
                    if (pw.pe != null) pwList.add(pw);
                }
            }
        } else {
            String query2 = 'Select p.SystemModstamp, p.Product_Bundle__c, p.ProductCode, p.Name, p.LastModifiedDate, p.LastModifiedById, p.IsDeleted, p.IsActive, p.Id, p.Family, p.Description, p.CreatedDate, p.CreatedById From Product2 p ';
            query2 = getWhereClaus(query2);
            query2 += ' ORDER BY p.Product_Bundle__c ';
            pwList.clear();
            System.debug('*** Query2: ' + query2 + ' ***');
            List<Product2> pList = (List<Product2>) Database.query(query2);
            for (Product2 p : pList) {
                ProductWrapper pw = new ProductWrapper(p,myOp);
                if (pw.pe != null) pwList.add(pw);
            }
        }
    }
    
    
    public String getQuery() { 
        
        String startQuery ='FIND {';
        String restOfQuery = '} IN ALL FIELDS RETURNING Product2 (Name,Product_Bundle__c,family,description,Id';
        String endOfQuery = ')';
         
         
        String query = startQuery;
        boolean hasQuery = false;
        boolean hasWhere = false;
        if (keyword != '' && keyword != null && keyword.length() > 1) {
            keyword = escapeReservedCharacters(keyword);
            query += keyword + '*';
            hasQuery = true;
        }
        restOfQuery = getWhereClaus(restOfQuery);
        query += restOfQuery + endOfQuery;
        if (hasQuery)
          return query;
        else
          return '';
    }
    
    public String getWhereClaus(String query) {
        Boolean hasWhere = false;
        if(family != '--') {
            query += ' WHERE family =  \'' + Family + '\'';
            hasWhere = true;
        } 
        return query;
        
    }
    
    public void clearSearch() {
        family='--';
        keyword = '';
        pwList.clear();
    }
    
    public void ClearSelectedProducts() {
        selectedList.clear();
    }
    
    public void GetSelectedProducts() {
        for(ProductWrapper p1 : pwList)
        {
            if( p1.quantity != null && p1.quantity !='' && p1.quantity != '0') {
                 p1.oli.quantity = Double.valueOf(p1.quantity);
                 p1.oli.OpportunityId = myOp.id;
                 p1.oli.PriceBookEntryId = p1.pe.id;
                 p1.oli.unitPrice = Double.valueOf(p1.salesPrice);
                 selectedList.add(p1);
                 
                //BUNDLES!!!
                Bundle__c b;
                List<Bundle__c> bundleList  = [Select b.SystemModstamp, b.OwnerId, b.Name, b.LastModifiedDate, b.LastModifiedById, b.IsDeleted, b.Id, b.CreatedDate, b.CreatedById From Bundle__c b where b.id = :p1.product.Product_Bundle__c];
                if (bundleList.size() > 0) {
                    b = bundleList[0];
                    List<Bundle_Product__c> bpList = [Select b.SystemModstamp, b.Qty__c, b.Product__c, b.Product_Name__c, b.Product_Family__c, b.Product_Bundle__c, b.Name, b.LastModifiedDate, b.LastModifiedById, b.IsDeleted, b.Id, b.CreatedDate, b.CreatedById From Bundle_Product__c b where b.Product_Bundle__c =:b.id];
                    for(Bundle_Product__c bp:bpList) {                       
                         Product2 p2 = [Select p.Product_Bundle__c, p.ProductCode,  p.Name, p.LastModifiedDate, p.LastModifiedById, p.IsDeleted, p.IsActive, p.Id, p.Family, p.Description, p.CreatedDate, p.CreatedById From Product2 p where p.id = :bp.Product__c];
                         if (p2.id != p1.product.id) {
                             ProductWrapper pw2 = new ProductWrapper(p2,myOp);
                             pw2.quantity = p1.quantity;
                             pw2.salesPrice = p1.salesPrice;
                             pw2.oli.quantity = Double.valueOf(pw2.quantity);
                             pw2.oli.OpportunityId = myOp.id;
                             pw2.oli.PriceBookEntryId = pw2.pe.id;
                             pw2.oli.unitPrice = Double.valueOf(pw2.salesPrice);
                             pw2.bundle = p1.bundle;
                             selectedList.add(pw2);
                         }
                    }
                }
            }
        } 
    }
    
    private String escapeReservedCharacters(String s) {
       String reservedCharacters = '—&|!{}[]()^~:\\\"\'+-';
     
       for (Integer i = 0; i < reservedCharacters.length(); i++)
         s = s.replace(reservedCharacters.substring(i,i+1), '\\' + reservedCharacters.substring(i,i+1));
     
        return s;
    }
    
    public void DeleteSelectedItem() {
        Integer i;
        for ( i = 0;i<selectedList.size();i++) {
            if (selectedList.get(i).product.id == deleteId) {
                break;
            }
        }
        selectedList.remove(i);     
    }
    
    public PageReference SaveProducts() {
        for (ProductWrapper p: selectedList) {
            insert p.oli;
        }
        keyword = '';
        pwList.clear();
        selectedList.clear();
        return new PageReference('/' + myOp.id);
    }
    
    public class ProductWrapper{
        public Product2 product {get;set;}
        public PricebookEntry pe {get;set;}
        public OpportunityLineItem oli {get;set;}
        public boolean selected {get;set;} 
        public boolean hasLineItem {get;set;}
        public String quantity {get;set;}
        public String discount {get;set;}
        public String salesPrice {Get;set;}
        public String bundle {get;set;}
        public String bundleId {get;set;}        
        public List<OpportunityLineItem> oList {get;set;}
        public Opportunity myOp {get;set;}
        
        public ProductWrapper(Product2 p,Opportunity myOp2) {
            myOp = myOp2;
            oList = new List<OpportunityLineItem>();
            product = p;
            hasLineItem = false;
            System.debug('DEBUG: Product Id:' + product.id + 'pricebookID:' + myOp.Pricebook2Id);
            List<PricebookEntry> peList = [Select p.UseStandardPrice, p.UnitPrice, p.SystemModstamp, p.ProductCode, p.Product2Id, p.Pricebook2Id, p.Name, p.LastModifiedDate, p.LastModifiedById, p.IsDeleted, p.IsActive, p.Id, p.CreatedDate, p.CreatedById From PricebookEntry p where p.Product2Id = :product.Id AND p.Pricebook2Id = :myOp.Pricebook2Id];
            if (peList.size() > 0) {
                pe = peList[0];
                salesPrice = String.valueOf(pe.UnitPrice);
            } else {
                salesPrice = '0';                
            }
            oli = new OpportunityLineItem();
            if (product.Product_Bundle__c != null) {
                List<Bundle__c> bundleList  = [Select b.SystemModstamp, b.OwnerId, b.Name, b.LastModifiedDate, b.LastModifiedById, b.IsDeleted, b.Id, b.CreatedDate, b.CreatedById From Bundle__c b where b.id = :product.Product_Bundle__c];
                if (bundleList.size() > 0) { 
                    bundleId = bundleList[0].id;
                    bundle = bundleList[0].Name;
                }
            }else bundle = '';
            selected = false;
        }
    }


}