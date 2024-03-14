public virtual class PDFOrderPage {
    public Id id { get; set; }
    public List<Order__c> OrderList {get;set;}
    public List<Order_Line_Item__c> ORDL {get;set;}
    public Integer currentPageIndex {get;set;}
    public Integer totalPages { get; set; }
    public String ordercaller { get; set; }
    
    public PDFOrderPage(ApexPages.StandardController controller) {
        id = controller.getId();
        OrderList = [SELECT Id, SL_No__c,Village__c,Transportation_Charges__c,
                     Transit_Insurance_Amount__c,Transit_Insurance__c,
                     Supplier_Name__c,SGST__c,State__c,Sub_Total__c,SGST_Amount__c,
                     Second_Concern_Person__c,Advance__c,Balance__c,Basic_Order_Value__c,
                     Building_No_Street__c,CGST__c,CGST_Amount__c,  City__c,
                     Commissioning_Charges__c, Country__c,Customer_Name__c,
                     Date__c,District__c,  Email__c,   Engineering_Charges__c,
                     FAX_No__c,First_Concern_Person__c,Forwarding_Charge__c,
                     Forwarding_Charges__c,Grand_Amount__c,GST_No__c,  IGST__c,
                     IGST_Amount__c,Old_Price__c,Name,Package_Charges__c,    
                     Packing_Charges__c,Phone__c,Phone_1__c,Product_Code__c,
                     Proforma_Invoice__c, Quanity__c,Quotes__c,Remarks__c,
                     Taxes_Duties__c,Insurance_Transit_Risk__c,Commissioning__c,
                     Period_of_Warranty__c,Force_Majaure__c, Arbitration__c, Jurisdiction__c,Confidentiality__c 
                     FROM Order__c WHERE id = :id];
        totalPages = OrderList.size();
        currentPageIndex = 0;
        ORDL = new List<Order_Line_Item__c>();
        
        Set<Id> ORDlIds = new Set<Id>();
        
        for (Order__c OrderRecord : OrderList) {
            ORDlIds.add(OrderRecord.Id);
        }
        ORDL = [SELECT Name, Orders__r.Name,
                Product_Description__c, Quantity__c, Final_Price_After_Discount__c, 
                Unit_Rate__c, Value__c, Serial_No__c,
                Productes__c, Machine_Name__c 
                FROM Order_Line_Item__c 
                WHERE Orders__c IN :ORDlIds];
        generateSerialNumbers();
        
        ordercaller = ApexPages.currentPage().getParameters().get('id');
    }
    public String formattedUnitRate {
    get {
        if (ORDL != null && ORDL.size() > 0) {
                Decimal unitRate = ORDL[0].Unit_Rate__c;
                return formatIndianCurrency(unitRate);
            }
            return null; 
        }
    }
    public String formattedvalue {
        get {
            if (ORDL != null && ORDL.size() > 0) {
                Decimal value = ORDL[0].Value__c;
                return formatIndianCurrency(value);
            }
            return null;
        }
    }
    
    public String formattedTransitInsuranceAmount {
        get {
           
            if (ORDL != null && ORDL.size() > 0) {
                Decimal transitInsuranceAmount = OrderList[0].Transit_Insurance_Amount__c;
                return formatIndianCurrency(TransitInsuranceAmount);
            }
            return null;
        }
    
    }
    public String formattedBasicOrderValue {
        get {
            if (ORDL != null && ORDL.size() > 0) {
                Decimal BasicOrderValue = OrderList[0].Basic_Order_Value__c;
                return formatIndianCurrency(BasicOrderValue);
            }
            return null;
        }
    }
    public String formattedpackingCharges {
        get {
            if (ORDL != null && ORDL.size() > 0) {
                Decimal packingCharges = OrderList[0].Packing_Charges__c;
                return formatIndianCurrency(packingCharges);
            }
            return null;
        }
    }
    public String formattedCommissioningCharges {
        get {
           
            if (ORDL != null && ORDL.size() > 0) {
                Decimal CommissioningCharges = OrderList[0].Commissioning_Charges__c;
                return formatIndianCurrency(CommissioningCharges);
            }
            return null;
        }
    }
    public String formattedTransportationCharges {
        get {
            if (ORDL != null && ORDL.size() > 0) {
                Decimal TransportationCharges = OrderList[0].Transportation_Charges__c;
                return formatIndianCurrency(TransportationCharges);
            }
            return null;
        }
    }  
    public String formattedSubtotal {
        get {
            if (ORDL != null && ORDL.size() > 0) {
                Decimal Subtotal = OrderList[0].Sub_Total__c;
                return formatIndianCurrency(Subtotal);
            }
            return null;
        }
    }
    public String formattedCGSTCharges {
        get {
            if (ORDL != null && ORDL.size() > 0) {
                Decimal CGSTCharges = OrderList[0].CGST_Amount__c;
                return formatIndianCurrency(CGSTCharges);
            }
            return null;
        }
    }
    public String formattedSGSTCharges {
        get {
            if (ORDL != null && ORDL.size() > 0) {
                Decimal SGSTCharges = OrderList[0].SGST_Amount__c;
                return formatIndianCurrency(SGSTCharges);
            }
            return null;
        }
    }
    public String formattedIGSTCharges {
        get {
            if (ORDL != null && ORDL.size() > 0) {
                Decimal IGSTCharges = OrderList[0].IGST_Amount__c;
                return formatIndianCurrency(IGSTCharges);
            }
            return null;
        }
    }
    public String formattedGrandTotal {
        get {
            if (ORDL != null && ORDL.size() > 0) {
                Decimal GrandTotal = OrderList[0].Grand_Amount__c;
                return formatIndianCurrency(GrandTotal);
            }
            return null;
        }
    }
    public String formattedAdvance {
        get {
            if (ORDL != null && ORDL.size() > 0) {
                Decimal Advance = OrderList[0].Advance__c;
                return formatIndianCurrency(Advance);
            }
            return null;
        }
    }
    public String formattedBalance {
        get {
            if (ORDL != null && ORDL.size() > 0) {
                Decimal Balance = OrderList[0].Balance__c;
                return formatIndianCurrency(Balance);
            }
            return null;
        }
    }
    public String formattedForwardingCharges {
        get {
            if (ORDL != null && ORDL.size() > 0) {
                Decimal ForwardingCharges = OrderList[0].Forwarding_Charge__c;
                return formatIndianCurrency(ForwardingCharges);
            }
            return null;
        }
    }
    public String formattedEngineeringCharges {
        get {
            if (ORDL != null && ORDL.size() > 0) {
                Decimal engineeringCharges = OrderList[0].Engineering_Charges__c;
                return formatIndianCurrency(engineeringCharges);
            }
            return null;
        }
    }
    Public String formatIndianCurrency(Decimal amount) {
        if (amount != null) {
            String formattedAmount = amount.setScale(2).format();
            return formattedAmount;
        } else {
            return null;
        }
    }
    private void generateSerialNumbers() {
        for (Integer i = 0; i < ORDL.size(); i++) {
            ORDL[i].Serial_No__c = currentPageIndex * 10 + i + 1;
        }
    }
    public PageReference next() {
        if (currentPageIndex < totalPages) {
            currentPageIndex++;
        }return null;
    }
    public PageReference previous() {
        if (currentPageIndex > 0) {
            currentPageIndex--;
        }return null;
    }
    public PageReference save() {
        try {
            PageReference pdfPage = Page.PDFOrder;
            pdfPage.getParameters().put('id', ordercaller);
            Blob pdfBlob;
            
            if (!Test.isRunningTest()) {
                pdfBlob =  pdfPage.getContent();
            } else {
                pdfBlob = Blob.valueOf('Order PDF File');
            }
            Datetime timestamp = System.now();
            String pdfFileName = 'Order' + timestamp;
            Attachment attach = new Attachment();
            attach.Body = pdfBlob;
            attach.Name = pdfFileName + '.pdf';
            attach.ParentId = ordercaller;
            attach.IsPrivate = false;
            attach.ContentType = 'application/pdf';
            insert attach;
            
            PageReference Pdf = new PageReference('/' + ordercaller);
            Pdf.setRedirect(true);
            return Pdf;
        } catch (Exception e) {
            System.debug('An exception occurred: ' + e.getMessage());
            return null;
        }
    }
}