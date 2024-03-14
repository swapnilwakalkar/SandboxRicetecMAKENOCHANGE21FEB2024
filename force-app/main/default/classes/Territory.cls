public class Territory {
    public static void tory(){
        List<Territory__c> x = new List<Territory__c>();
        Territory__c y = [SELECT ID, Name, Parent_Location__c,State_Province__c, Country__c FROM Territory__c WHERE Name ='Assam Districts' LIMIT 1];
        if(y!=NULL){
            ID yID = y.id;
            
            Territory__c territory1 = new Territory__c();
            territory1.Parent_Location__c = yID;
            territory1.State_Province__c = 'Assam';
            territory1.Country__c = 'India';
            territory1.Name = 'Baksa'; 
            territory1.Active__c = true;
            
            x.add(territory1);
       
            Territory__c territory2 = new Territory__c();
            territory2.Parent_Location__c = yID;
            territory2.State_Province__c = 'Assam';
            territory2.Country__c = 'India';
            territory2.Name = 'Barpeta '; 
            territory2.Active__c = true;
            
            x.add(territory2); 
            
            Territory__c territory3 = new Territory__c();
            territory3.Parent_Location__c = yID;
            territory3.State_Province__c = 'Assam';
            territory3.Country__c = 'India';
            territory3.Name = 'Bongaigaon'; 
            territory3.Active__c = true;
            
            x.add(territory3);
            
            Territory__c territory4 = new Territory__c();
            territory4.Parent_Location__c = yID;
            territory4.State_Province__c = 'Assam';
            territory4.Country__c = 'India';
            territory4.Name = 'Cachar'; 
            territory4.Active__c = true;
           
            x.add(territory4);
            
            Territory__c territory5 = new Territory__c();
            territory5.Parent_Location__c = yID;
            territory5.State_Province__c = 'Assam';
            territory5.Country__c = 'India';
            territory5.Name = 'Chirang '; 
            territory5.Active__c = true;
           
            x.add(territory5);
            
            Territory__c territory6 = new Territory__c();
            territory6.Parent_Location__c = yID;
            territory6.State_Province__c = 'Assam';
            territory6.Country__c = 'India';
            territory6.Name = 'Darrang '; 
            territory6.Active__c = true;
            
            x.add(territory6);
             
            Territory__c territory7 = new Territory__c();
            territory7.Parent_Location__c = yID;
            territory7.State_Province__c = 'Assam';
            territory7.Country__c = 'India';
            territory7.Name = 'Dhuburi '; 
            territory7.Active__c = true;
            
            x.add(territory7);
            
            Territory__c territory8 = new Territory__c();
            territory8.Parent_Location__c = yID;
            territory8.State_Province__c = 'Assam';
            territory8.Country__c = 'India';
            territory8.Name = 'Dibrugarh'; 
            territory8.Active__c = true;
           
            x.add(territory8);
            
            Territory__c territory9 = new Territory__c();
            territory9.Parent_Location__c = yID;
            territory9.State_Province__c = 'Assam';
            territory9.Country__c = 'India';
            territory9.Name = 'Dima Hasao'; 
            territory9.Active__c = true;
            
            x.add(territory9);
            
            Territory__c territory10 = new Territory__c();
            territory10.Parent_Location__c = yID;
            territory10.State_Province__c = 'Assam';
            territory10.Country__c = 'India';
            territory10.Name = 'Golaghat'; 
            territory10.Active__c = true;
            
            x.add(territory10);
            
            Territory__c territory11 = new Territory__c();
            territory11.Parent_Location__c = yID;
            territory11.State_Province__c = 'Assam';
            territory11.Country__c = 'India';
            territory11.Name = 'Goalpara'; 
            territory11.Active__c = true;
            
            x.add(territory11);
            
            Territory__c territory12 = new Territory__c();
            territory12.Parent_Location__c = yID;
            territory12.State_Province__c = 'Assam';
            territory12.Country__c = 'India';
            territory12.Name = 'Hailakandi'; 
            territory12.Active__c = true;
            
            x.add(territory12);
                        
            Territory__c territory13 = new Territory__c();
            territory13.Parent_Location__c = yID;
            territory13.State_Province__c = 'Assam';
            territory13.Country__c = 'India';
            territory13.Name = 'Jorhat'; 
            territory13.Active__c = true;
           
            x.add(territory13);
            
            Territory__c territory14 = new Territory__c();
            territory14.Parent_Location__c = yID;
            territory14.State_Province__c = 'Assam';
            territory14.Country__c = 'India';
            territory14.Name = 'Kamrup'; 
            territory14.Active__c = true;
           
            x.add(territory14);
            
            Territory__c territory15 = new Territory__c();
            territory15.Parent_Location__c = yID;
            territory15.State_Province__c = 'Assam';
            territory15.Country__c = 'India';
            territory15.Name = 'Karbi Anglong'; 
            territory15.Active__c = true;
            
            x.add(territory15);
            
            Territory__c territory16 = new Territory__c();
            territory16.Parent_Location__c = yID;
            territory16.State_Province__c = 'Assam';
            territory16.Country__c = 'India';
            territory16.Name = 'Karimganj'; 
            territory16.Active__c = true;
            
            x.add(territory16);
           
            Territory__c territory17 = new Territory__c();
            territory17.Parent_Location__c = yID;
            territory17.State_Province__c = 'Assam';
            territory17.Country__c = 'India';
            territory17.Name = 'Lakhimpur'; 
            territory17.Active__c = true;
            
            x.add(territory17);
            
            Territory__c territory18 = new Territory__c();
            territory18.Parent_Location__c = yID;
            territory18.State_Province__c = 'Assam';
            territory18.Country__c = 'India';
            territory18.Name = 'Morigaon'; 
            territory18.Active__c = true;
            
            x.add(territory18);
            
            Territory__c territory19 = new Territory__c();
            territory19.Parent_Location__c = yID;
            territory19.State_Province__c = 'Assam';
            territory19.Country__c = 'India';
            territory19.Name = 'Nagaon'; 
            territory19.Active__c = true;
            
            x.add(territory19);
            
            Territory__c territory20 = new Territory__c();
            territory20.Parent_Location__c = yID;
            territory20.State_Province__c = 'Assam';
            territory20.Country__c = 'India';
            territory20.Name = 'Nalbari'; 
            territory20.Active__c = true;
            
            x.add(territory20);
            
            Territory__c territory21 = new Territory__c();
            territory21.Parent_Location__c = yID;
            territory21.State_Province__c = 'Assam';
            territory21.Country__c = 'India';
            territory21.Name = 'Sivasagar'; 
            territory21.Active__c = true;
            
            x.add(territory21);
            
            Territory__c territory22 = new Territory__c();
            territory22.Parent_Location__c = yID;
            territory22.State_Province__c = 'Assam';
            territory22.Country__c = 'India';
            territory22.Name = 'Sonitpur'; 
            territory22.Active__c = true;
            
            x.add(territory22);
            
            Territory__c territory23 = new Territory__c();
            territory23.Parent_Location__c = yID;
            territory23.State_Province__c = 'Assam';
            territory23.Country__c = 'India';
            territory23.Name = 'Tinsukia'; 
            territory23.Active__c = true;
            
            x.add(territory23);
          
            Territory__c territory24 = new Territory__c();
            territory24.Parent_Location__c = yID;
            territory24.State_Province__c = 'Assam';
            territory24.Country__c = 'India';
            territory24.Name = 'Udalguri'; 
            territory24.Active__c = true;
            
            x.add(territory24);
  /*            
            Territory__c territory25 = new Territory__c();
            territory25.Parent_Location__c = yID;
            territory25.State_Province__c = 'Assam';
            territory25.Country__c = 'India';
            territory25.Name = 'Amalapuram'; 
            territory25.Active__c = true;
            
            x.add(territory25);
            
            Territory__c territory26 = new Territory__c();
            territory26.Parent_Location__c = yID;
            territory26.State_Province__c = 'Assam';
            territory26.Country__c = 'India';
            territory26.Name = 'Kakinada'; 
            territory26.Active__c = true;
            
            x.add(territory26);
            
            Territory__c territory27 = new Territory__c();
            territory27.Parent_Location__c = yID;
            territory27.State_Province__c = 'Andhra Pradesh';
            territory27.Country__c = 'India';
            territory27.Name = 'Alluri Sitharamaraju'; 
            territory27.Active__c = true;
            
            x.add(territory27);
            
            Territory__c territory28 = new Territory__c();
            territory28.Parent_Location__c = yID;
            territory28.State_Province__c = 'Andhra Pradesh';
            territory28.Country__c = 'India';
            territory28.Name = 'Anakapalli'; 
            territory28.Active__c = true;
            
            x.add(territory28);
            
            Territory__c territory29 = new Territory__c();
            territory29.Parent_Location__c = yID;
            territory29.State_Province__c = 'Andhra Pradesh';
            territory29.Country__c = 'India';
            territory29.Name = 'Paderu'; 
            territory29.Active__c = true;
            
            x.add(territory29);
            
            Territory__c territory30 = new Territory__c();
            territory30.Parent_Location__c = yID;
            territory30.State_Province__c = 'Andhra Pradesh';
            territory30.Country__c = 'India';
            territory30.Name = 'Visakhapatnam'; 
            territory30.Active__c = true;
            
            x.add(territory30);
            
            Territory__c territory31 = new Territory__c();
            territory31.Parent_Location__c = yID;
            territory31.State_Province__c = 'Andhra Pradesh';
            territory31.Country__c = 'India';
            territory31.Name = 'Vizianagaram'; 
            territory31.Active__c = true;
            
            x.add(territory31);
           
            Territory__c territory32 = new Territory__c();
            territory32.Parent_Location__c = yID;
            territory32.State_Province__c = 'Andhra Pradesh';
            territory32.Country__c = 'India';
            territory32.Name = 'Parvathipuram'; 
            territory32.Active__c = true;
            
            x.add(territory32);
            
            Territory__c territory33 = new Territory__c();
            territory33.Parent_Location__c = yID;
            territory33.State_Province__c = 'Andhra Pradesh';
            territory33.Country__c = 'India';
            territory33.Name = 'Srikakulam'; 
            territory33.Active__c = true;
            
            x.add(territory33);
           
            Territory__c territory34 = new Territory__c();
            territory34.Parent_Location__c = yID;
            territory34.State_Province__c = 'Andhra Pradesh';
            territory34.Country__c = 'India';
            territory34.Name = 'Kamepalle'; 
            territory34.Active__c = true;
            
            x.add(territory34);
            
            Territory__c territory35 = new Territory__c();
            territory35.Parent_Location__c = yID;
            territory35.State_Province__c = 'Andhra Pradesh';
            territory35.Country__c = 'India';
            territory35.Name = 'Chintur'; 
            territory35.Active__c = true;
            
            x.add(territory35);
            
            Territory__c territory52 = new Territory__c();
            territory52.Parent_Location__c = yID;
            territory52.State_Province__c = 'Andhra Pradesh';
            territory52.Country__c = 'India';
            territory52.Name = 'Kattangoor'; 
            territory52.Active__c = true;
            
            x.add(territory52);
            
            Territory__c territory36 = new Territory__c();
            territory36.Parent_Location__c = yID;
            territory36.State_Province__c = 'Andhra Pradesh';
            territory36.Country__c = 'India';
            territory36.Name = 'Garla'; 
            territory36.Active__c = true;
            
            x.add(territory36);

            Territory__c territory37 = new Territory__c();
            territory37.Parent_Location__c = yID;
            territory37.State_Province__c = 'Andhra Pradesh';
            territory37.Country__c = 'India';
            territory37.Name = 'Enkuru'; 
            territory37.Active__c = true;
           
            x.add(territory37);

            Territory__c territory38 = new Territory__c();
            territory38.Parent_Location__c = yID;
            territory38.State_Province__c = 'Telangana';
            territory38.Country__c = 'India';
            territory38.Name = 'Mulkalapalle'; 
            territory38.Active__c = true;
           
            x.add(territory38);

            Territory__c territory39 = new Territory__c();
            territory39.Parent_Location__c = yID;
            territory39.State_Province__c = 'Telangana';
            territory39.Country__c = 'India';
            territory39.Name = 'Julurpad'; 
            territory39.Active__c = true;
            
            x.add(territory39);

            Territory__c territory40 = new Territory__c();
            territory40.Parent_Location__c = yID;
            territory40.State_Province__c = 'Telangana';
            territory40.Country__c = 'India';
            territory40.Name = 'Venkatapuram'; 
            territory40.Active__c = true;
            
            x.add(territory40);

            Territory__c territory41 = new Territory__c();
            territory41.Parent_Location__c = yID;
            territory41.State_Province__c = 'Telangana';
            territory41.Country__c = 'India';
            territory41.Name = 'Kukunoor'; 
            territory41.Active__c = true;
            
            x.add(territory41);

            Territory__c territory42 = new Territory__c();
            territory42.Parent_Location__c = yID;
            territory42.State_Province__c = 'Telangana';
            territory42.Country__c = 'India';
            territory42.Name = 'Gundala'; 
            territory42.Active__c = true;
            
            x.add(territory42);

            Territory__c territory43 = new Territory__c();
            territory43.Parent_Location__c = yID;
            territory43.State_Province__c = 'Telangana';
            territory43.Country__c = 'India';
            territory43.Name = 'Kunavaram'; 
            territory43.Active__c = true;
            
            x.add(territory43);

            Territory__c territory44 = new Territory__c();
            territory44.Parent_Location__c = yID;
            territory44.State_Province__c = 'Telangana';
            territory44.Country__c = 'India';
            territory44.Name = 'Vararamachandrapuram'; 
            territory44.Active__c = true;
            
            x.add(territory44);

            Territory__c territory45 = new Territory__c();
            territory45.Parent_Location__c = yID;
            territory45.State_Province__c = 'Telangana';
            territory45.Country__c = 'India';
            territory45.Name = 'Wazeed'; 
            territory45.Active__c = true;
            
            x.add(territory45);

            Territory__c territory46 = new Territory__c();
            territory46.Parent_Location__c = yID;
            territory46.State_Province__c = 'Telangana';
            territory46.Country__c = 'India';
            territory46.Name = 'Velairpadu'; 
            territory46.Active__c = true;
            
            x.add(territory46);

            Territory__c territory47 = new Territory__c();
            territory47.Parent_Location__c = yID;
            territory47.State_Province__c = 'Telangana';
            territory47.Country__c = 'India';
            territory47.Name = 'Nampalle'; 
            territory47.Active__c = true;
            
            x.add(territory47);

            Territory__c territory48 = new Territory__c();
            territory48.Parent_Location__c = yID;
            territory48.State_Province__c = 'Telangana';
            territory48.Country__c = 'India';
            territory48.Name = 'Jaji Reddi Gudem'; 
            territory48.Active__c = true;
            
            x.add(territory48);

            Territory__c territory49 = new Territory__c();
            territory49.Parent_Location__c = yID;
            territory49.State_Province__c = 'Telangana';
            territory49.Country__c = 'India';
            territory49.Name = 'Penpahad'; 
            territory49.Active__c = true;
            
            x.add(territory49);

            Territory__c territory50 = new Territory__c();
            territory50.Parent_Location__c = yID;
            territory50.State_Province__c = 'Telangana';
            territory50.Country__c = 'India';
            territory50.Name = 'Nadigudem'; 
            territory50.Active__c = true;
            
            x.add(territory50);

            Territory__c territory51 = new Territory__c();
            territory51.Parent_Location__c = yID;
            territory51.State_Province__c = 'Telangana';
            territory51.Country__c = 'India';
            territory51.Name = 'Chilkur'; 
            territory51.Active__c = true;
            
            x.add(territory51);            

            Territory__c territory58 = new Territory__c();
            territory58.Parent_Location__c = yID;
            territory58.State_Province__c = 'Telangana';
            territory58.Country__c = 'India';
            territory58.Name = 'Atmakur (M)'; 
            territory58.Active__c = true;
            
            x.add(territory58);            

            Territory__c territory59 = new Territory__c();
            territory59.Parent_Location__c = yID;
            territory59.State_Province__c = 'Telangana';
            territory59.Country__c = 'India';
            territory59.Name = 'Rajapet'; 
            territory59.Active__c = true;
            
            x.add(territory59);            

            Territory__c territory53 = new Territory__c();
            territory53.Parent_Location__c = yID;
            territory53.State_Province__c = 'Telangana';
            territory53.Country__c = 'India';
            territory53.Name = 'Kethe Palle'; 
            territory53.Active__c = true;
       
            x.add(territory53);            

            Territory__c territory54 = new Territory__c();
            territory54.Parent_Location__c = yID;
            territory54.State_Province__c = 'Telangana';
            territory54.Country__c = 'India';
            territory54.Name = 'Bommalaramaram'; 
            territory54.Active__c = true;
           
            x.add(territory54);            

            Territory__c territory55 = new Territory__c();
            territory55.Parent_Location__c = yID;
            territory55.State_Province__c = 'Telangana';
            territory55.Country__c = 'India';
            territory55.Name = 'Marriguda'; 
            territory55.Active__c = true;
           
            x.add(territory55);            

            Territory__c territory56 = new Territory__c();
            territory56.Parent_Location__c = yID;
            territory56.State_Province__c = 'Telangana';
            territory56.Country__c = 'India';
            territory56.Name = 'Gundala'; 
            territory56.Active__c = true;
           
            x.add(territory56);            

            Territory__c territory57 = new Territory__c();
            territory57.Parent_Location__c = yID;
            territory57.State_Province__c = 'Telangana';
            territory57.Country__c = 'India';
            territory57.Name = 'M.Turkapalle'; 
            territory57.Active__c = true;
           
            x.add(territory57);  
*/
            
        }
        if (!x.isEmpty()) {
            try{
        insert x;    
            }catch(exception e){
                System.debug(e);
            }
        }
    }
    /*
    public class GeolocationWrapper {
        @AuraEnabled
        public Decimal latitude;
        @AuraEnabled
        public Decimal longitude;

        public GeolocationWrapper(Decimal latitude, Decimal longitude) {
            this.latitude = latitude;
            this.longitude = longitude;
        }
    }

    @AuraEnabled
    public static List<GeolocationWrapper> retrieveGeolocationData() {
        List<GeolocationWrapper> geolocationData = new List<GeolocationWrapper>();

        List<Day_Planner__c> dayPlanners = [SELECT Id, Representative_Initial_Location__Latitude__s,
                                                Representative_Initial_Location__Longitude__s,
                                                Representative_End_Location__Latitude__s,
                                                Representative_End_Location__Longitude__s,
                                                (SELECT Start_Location__Latitude__s, Start_Location__Longitude__s,
                                                        End_Location__Latitude__s, End_Location__Longitude__s
                                                 FROM Day_Schedules__r)
                                             FROM Day_Planner__c];

        for (Day_Planner__c dayPlanner : dayPlanners) {
            GeolocationWrapper representativeInitialLocation = new GeolocationWrapper(
                dayPlanner.Representative_Initial_Location__Latitude__s,
                dayPlanner.Representative_Initial_Location__Longitude__s
            );
            GeolocationWrapper representativeEndLocation = new GeolocationWrapper(
                dayPlanner.Representative_End_Location__Latitude__s,
                dayPlanner.Representative_End_Location__Longitude__s
            );

            geolocationData.add(representativeInitialLocation);
            geolocationData.add(representativeEndLocation);

            for (Day_Schedule__c daySchedule : dayPlanner.Day_Schedules__r) {
                GeolocationWrapper startLocation = new GeolocationWrapper(
                    daySchedule.Start_Location__Latitude__s,
                    daySchedule.Start_Location__Longitude__s
                );
                GeolocationWrapper endLocation = new GeolocationWrapper(
                    daySchedule.End_Location__Latitude__s,
                    daySchedule.End_Location__Longitude__s
                );

                geolocationData.add(startLocation);
                geolocationData.add(endLocation);
            }
        }

        return geolocationData;
    }
*/
}