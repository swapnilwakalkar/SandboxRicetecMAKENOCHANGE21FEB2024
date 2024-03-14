public class OrderFormCX{
    ApexPages.standardController ordercontroller;
    public Work_Order_for_Spares__c order {get;set;}
    public Products__c orderlineitem {get;set;}
    Public List<orderWrapper> orderWrapperList {get;set;} 
    Public Integer rowToRemove {get;set;}
    Public List<String> orderId = new List<String>();
    Public List<String> mobileOrderId = new List<String>();


    public OrderFormCX(ApexPages.StandardController controller){
        ordercontroller = controller;
        order = new Work_Order_for_Spares__c();
        orderlineitem = new Products__c();
        orderWrapperList = new List<orderWrapper>();
        addNewRowToExpList();

    }

    public PageReference saveTo(){

        Work_Order_for_Spares__c order2 = new Work_Order_for_Spares__c();
        order2.Rice_Mill_Name__c = order.Rice_Mill_Name__c;
        order2.Rice_Mill_Name__c = order.Rice_Mill_Name__c;
        
        insert order2;


        Pagereference pageref = new Pagereference('/' + order2.Id);
        pageref.setRedirect(true);
        return pageref; 

    }

    public PageReference doCancel(){
        return ordercontroller.cancel();
    }

    public void addNewRowToExpList() {  

        List<orderWrapper> tempOrderWrapperList = new List<orderWrapper>();
        orderWrapper newRecord = new orderWrapper();
        Products__c newOrderItemRecord = new Products__c();
        newRecord.ord = newOrderItemRecord;
        newRecord.index = tempOrderWrapperList.size();
        tempOrderWrapperList.add(newRecord);


        for(orderWrapper ow : tempOrderWrapperList) {

            ow.ord.Quantity_In_no_s__c = 0;
            orderWrapperList.add(ow);
        }
    }

     public void removeRowFromExpList() {

        List<orderWrapper> remOrderWrapperList = new List<orderWrapper>();
        for(orderWrapper ow : orderWrapperList) {
            remOrderWrapperList.add(ow);
        }
        remOrderWrapperList.remove(rowToRemove);
        orderWrapperList.clear();

        for(orderWrapper row : remOrderWrapperList) {
            orderWrapperList.add(row);
        }
    }


    public class orderWrapper{
        public Integer index {get; set;}
        public Products__c ord {get; set;}
        public Work_Order_for_Spares__c ordform {get; set;}
    }


}