public class WayPointsWrapper {
    
    public cls_geocoded_waypoints[] geocoded_waypoints;
    public cls_routes[] routes;
    public String status;	
    
    
    public class cls_geocoded_waypoints {
        public String geocoder_status;	
        public String place_id;	
        //   public cls_types[] types;
    }
    
    public class cls_routes {
        public cls_bounds bounds;
        public String copyrights;	
        public cls_legs[] legs;
        public cls_overview_polyline overview_polyline;
        public String summary;	
    }
    
    public class cls_bounds {
        public cls_northeast northeast;
        public cls_southwest southwest;
    }
    
    public class cls_northeast {
        public Double lat;	
        public Double lng;	
    }
    
    public class cls_southwest {
        public Double lat;	
        public Double lng;	
    }
    
    public class cls_legs {
        public cls_distance distance;
        public cls_duration duration;
        public String end_address;	
        public cls_end_location end_location;
        public String start_address;	
        public cls_start_location start_location;
        public cls_steps[] steps;
    }
    
    public class cls_distance {
        public String text;	
        public Integer value;	
    }
    
    public class cls_duration {
        public String text;	
        public Integer value;	
    }
    
    public class cls_end_location {
        public Double lat;	
        public Double lng;	
    }
    
    public class cls_start_location {
        public Double lat;	
        public Double lng;	
    }
    
    public class cls_steps {
        public cls_distance distance;
        public cls_duration duration;
        public cls_end_location end_location;
        public String html_instructions;
        public cls_polyline polyline;
        public cls_start_location start_location;
        public String travel_mode;
    }
    
    public class cls_polyline {
        public String points;
    }
    
    public class cls_overview_polyline {
        public String points;
    }
    
    
    public static WayPointsWrapper parse(String json){
        return (WayPointsWrapper) System.JSON.deserialize(json, WayPointsWrapper.class);
    }
    
    public Static Map < String, Object > mapResult(Map < String, Object > resultMap) {
        List < Map < String, Object >> data = new List < Map < String, Object >> ();
        for (Object instance: (List < Object > ) resultMap.get('routes')) {
            data.add((Map < String, Object > ) instance);
        }
        
        
        Map < String, Object > mapObject = new Map < String, Object > ();
        for (Map < String, Object > stringObjectMap: data) {
            mapObject = (Map < String, Object > ) stringObjectMap;
        }
        
        List < Map < String, Object >> elementsData = new List < Map < String, Object >> ();
        for (Object stringObjectMap: (List < Object > ) mapObject.get('legs')) {
            elementsData.add((Map < String, Object > ) stringObjectMap);
        }
        
        List < Map < String, Object >> mapData = new List < Map < String, Object >> ();
        for (Map < String, Object > stringObjectMap: elementsData) {
            mapData.add((Map < String, Object > ) stringObjectMap);
        }
        
        Map < String, Object > mapObjectData = new Map < String, Object > ();
        for (Object stringObjectMap: mapData) {
            mapObjectData = (Map < String, Object > ) stringObjectMap;
        }
        System.debug('mapObjectData=======>>>' + mapObjectData);
        return mapObjectData;
    }
}