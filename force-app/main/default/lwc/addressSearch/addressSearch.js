import { LightningElement, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getAddressRecommendations from '@salesforce/apex/GetMapLocation.getAddressRecommendations';
import getAddressDetailsByPlaceId from '@salesforce/apex/GetMapLocation.getAddressDetailsByPlaceId';


export default class AddressSearch extends LightningElement {

    @api recordId;
    @api objectApiName;
    openModal = false;
    showSpinner = false;
    fieldApiNames = ['BillingStreet', 'BillingCity', 'BillingState', 'BillingPostalCode', 'BillingCountry'];
    addressRecommendations;
    selectedAddress = '';
    addressDetail = {};
    hasRecommendations = false;
 
   /* get hasRecommendations() {
        return (this.addressRecommendations !== null && this.addressRecommendations.length);
    } */
    
    handleChange(event) {
        event.preventDefault();
        console.log('---->>>>>ssss')
        let searchText = event.target.value;
        if (searchText) this.getAddressRecommendations(searchText);
        else this.addressRecommendations = [];
    } 
 
    getAddressRecommendations(searchText) {
        getAddressRecommendations({ searchText: searchText })
            .then(response => {
                response = JSON.parse(response);
                let addressRecommendations = [];
                response.predictions.forEach(prediction => {
                    addressRecommendations.push({
                        main_text: prediction.structured_formatting.main_text,
                        secondary_text: prediction.structured_formatting.secondary_text,
                        place_id: prediction.place_id,
                    });
                });
                this.addressRecommendations = addressRecommendations;
                this.hasRecommendations = this.addressRecommendations !== null && this.addressRecommendations.length
            }).catch(error => {
                console.log('error : ' + JSON.stringify(error));
            });
    }
 
    handleAddressRecommendationSelect(event) {
        event.preventDefault();
        let placeId = event.currentTarget.dataset.value;
        this.addressRecommendations = [];
        this.selectedAddress = '';
        getAddressDetailsByPlaceId({ placeId: placeId })
            .then(response => {
                console.log('------>>>> JSON.parse(response) ', JSON.parse(response))
                response = JSON.parse(response);
                console.log('------>>>> JSON.parse(response) ', response.result.geometry.location)
                response.result.address_components.forEach(address => {
                    let type = address.types[0];
                    switch (type) {
                        case 'locality':
                            this.selectedAddress = this.selectedAddress + ' ' + address.long_name;
                            this.addressDetail.city = address.long_name;
                            break;
                        case 'country':
                            this.selectedAddress = this.selectedAddress + ' ' + address.long_name;
                            this.addressDetail.country = address.long_name;
                            break;
                        case 'administrative_area_level_1':
                            this.selectedAddress = this.selectedAddress + ' ' + address.short_name;
                            this.addressDetail.state = address.short_name;
                            break;
                        case 'postal_code':
                            this.selectedAddress = this.selectedAddress + ' ' + address.long_name;
                            this.addressDetail.postalCode = address.long_name;
                            break;
                        case 'sublocality_level_2':
                            this.selectedAddress = this.selectedAddress + ' ' + address.long_name;
                            this.addressDetail.subLocal2 = address.long_name;
                            break;
                        case 'sublocality_level_1':
                            this.selectedAddress = this.selectedAddress + ' ' + address.long_name;
                            this.addressDetail.subLocal1 = address.long_name;
                            break;
                        case 'street_number':
                            this.selectedAddress = this.selectedAddress + ' ' + address.long_name;
                            this.addressDetail.streetNumber = address.long_name;
                            break;
                        case 'route':
                            this.selectedAddress = this.selectedAddress + ' ' + address.short_name;
                            this.addressDetail.route = address.short_name;
                            break;
                        default:
                            break;
                    }
                });
                this.hasRecommendations = false;
                var getLatitude = JSON.stringify(response.result.geometry.location.lat)
                var getLongitude = JSON.stringify(response.result.geometry.location.lng)
                var getLocation = {lat:getLatitude, lng:getLongitude};
                const sendDataEvent = new CustomEvent('senddata', {
                    detail: {getLocation}
                });
        
                //Actually dispatching the event that we created above.
                this.dispatchEvent(sendDataEvent);
            })
            .catch(error => {
                console.log('error : ' + JSON.stringify(error));
            });
    } 
    
    /*handleModal(event) {
        event.preventDefault();
        this.openModal = true;
        this.addressRecommendations = [];
    }
 
    closeModal(event) {
        event.preventDefault();
        this.openModal = false;
        this.addressRecommendations = [];
    } */
 
    handleSearchResult(event) {
        event.preventDefault();
        this.openModal = false;
        this.showSpinner = true;        
    }
}