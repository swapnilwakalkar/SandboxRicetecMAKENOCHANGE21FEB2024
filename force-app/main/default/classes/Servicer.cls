public class Servicer {
    public Id id { get; set; }
    public List<Service_Report__c> serviceList { get; set; }
    public Integer currentPageIndex { get; set; }
    public Integer totalPages { get; set; }    
    public String servicerId { get; set; } 
    public Servicer(ApexPages.StandardController controller) {
        id = controller.getId();                       
        serviceList = [SELECT Id,Water_Pump_Pressure_Reading__c,Service_Charge_Amount__c,Total_Amount__c,
                       Cheque_no__c,Dated__c,Spares_Others_Amount__c,To_and_Fro_and_Conveyance_Charges__c,
                       Paid_By__c,Volume_of_Air_Utilization__c,Vol_of_air_Utilization_for_VD__c,
                       Vol_of_Air_Utilization_for_Blowers__c,Vibro_Scale_Reading__c,Variety_of_Rice_Sieve_SIze__c,
                       Variety_of_Rice__c,Using_Sieve_sizes_of_the_machine__c,Type_of_Rice__c,Through_put_of_the_machine_per_hr__c,
                       Through_put_of_machine_for_S_H__c,Samples_of_Husk_Immature__c,Samples_Collection_Input_or_Output__c,
                       Samples_collection_from_conveyor__c,Samples_Collection_for_Vibro_Destoner__c,Samples_Collection_for_Paddy_Seperator__c,
                       Samples_collection_for_Length_Grader__c,Sample_Collection_for_Whitener__c,
                       Sample_Collection_for_Silky_Polisher__c,Sample_collection_for_Sifter__c,
                       RPM_of_Machine__c,Pressure_Gauge_Reading__c,Pitch_of_the_Bucket__c,
                       Percent_of_Stone_Input_or_Output__c,Percent_of_Shelling__c,Percent_of_Sand_Input_or_Output__c,
                       Percent_of_Paddy_with_stones__c,Percent_of_Impurity__c,Percent_of_Immature__c,
                       Percent_of_Dust_Input_or_Output__c,Percent_of_Damper_Checking_No__c,
                       Percent_of_Broken_Input_or_Output__c,Number_of_Blowers__c,Number_of_Airlocks__c,No_of_Kgs_per_Min_Output__c,
                       No_of_Kgs_per_min_for_Sifter__c,No_of_Kgs_per_Min_for_Length_Grader__c,
                       No_of_Kgs_per_Min__c,No_of_Kgs_per_min_for_Whitener__c,Machiner_RPM__c,Loses_of_Grain_in_Husk__c,
                       Degree_of_Inclination__c,Input_and_Output__c,Impeller_Direction__c,
                       Husker_Floppers_Adjustments__c,Husk_Output__c,Height_of_the_Elevator__c,
                       Extra_sieve_sizes__c,Check_Noise_Vibration__c,Chain_Coupling_Alignment__c,Aspiration_setting_No__c,
                       AMP_meter_Reading__c,AMP_meter_Reading_for_Silky_Polisher__c,Nature_Of_Work__c,
                       Customer_Satisfaction_Score__c,Address__c,Contact_No__c,Contact_Person__c,
                       Contact_Person_No__c,Customer_Name__c,Customer_Feedback__c, Mill_Name__r.Name,Machinery__r.Name,
                       Day_1_Date__c,Day_2_Date__c,Day_3_Date__c,End_Time_1d__c,End_Time_2d__c,End_Time_3d__c, 
                       GST_No__c,Machinery__c,Machinery_Sl_Nos__c,Mill_Name__c,Name_of_the_Engineer__c,
                       Pin_Code__c,Reason__c,Service_Engineer_Remarks__c,Service_Performed_or_Commssioning_Report__c,
                       Name,Start_Time_1d__c,Start_Time_2d__c,Start_Time_3d__c,	X1__c,X10__c,X2__c,X3__c,X4__c,X5__c,X6__c,X7__c,X8__c,X9__c,
                       X11__c,X12__c,X13__c,X14__c,X15__c,X16__c,X17__c,X18__c,
                       Stone_Grit__c,Total_No_of_Days__c,Year_Of_Manufacture__c FROM Service_Report__c WHERE id = :id];
             totalPages = serviceList.size();
             currentPageIndex = 0;
        servicerId = ApexPages.currentPage().getParameters().get('id');
       }
        public Service_Report__c getCurrentServiceReport() {
        if (currentPageIndex >= 0 && currentPageIndex < serviceList.size()) {
            return serviceList[currentPageIndex];
        }
        return null;
    }
      public PageReference next() {
        if (currentPageIndex < totalPages - 1) {
            currentPageIndex++;
        }
        return null;
    }
        public PageReference previous() {
        if (currentPageIndex > 0) {
            currentPageIndex--;
        }
        return null;
    }
    public PageReference save() {
        Service_Report__c currentService = getCurrentServiceReport();
        if(!test.isRunningTest()){
        if (currentService != null && id != null) {
            Blob pdfBlob = generatePdfContent(currentService.Id);

            if (pdfBlob != null) {
                Datetime timestamp = System.now();
                    String pdfFileName = 'Service Report' + timestamp + '.pdf';
                    savePdfAsAttachment(currentService.Id, pdfFileName, pdfBlob);                
            }
        }
        }else{
            if (currentService != null && id != null) {
                blob pdfBlob = blob.valueof('TEST');
                if (pdfBlob != null) {
                    Datetime timestamp = System.now();
                    String pdfFileName = 'Service Report' + timestamp + '.pdf';
                    pdfBlob = blob.valueof('TEST');
                    savePdfAsAttachment(currentService.Id, pdfFileName, pdfBlob);
                }
            }
        }           
    PageReference recordDetailPage = new PageReference('/' + currentService.Id);
    recordDetailPage.setRedirect(true);
    return recordDetailPage;
    }

    public Blob generatePdfContent(Id servicerId) {
        if (Test.isRunningTest()) {
            // Return a dummy Blob for testing
            return Blob.valueOf('TEST');
        }
        PageReference pdfPage = Page.ServicerPDF;
        pdfPage.getParameters().put('id', servicerId);
        return pdfPage.getContentAsPDF();
    }
    
    public void savePdfAsAttachment(Id servicerId, String pdfFileName, Blob pdfBlob) {
        Attachment attachment = new Attachment();
        attachment.ParentId = servicerId;
        attachment.Name = pdfFileName;
        attachment.Body = pdfBlob;
        insert attachment;
    }
}