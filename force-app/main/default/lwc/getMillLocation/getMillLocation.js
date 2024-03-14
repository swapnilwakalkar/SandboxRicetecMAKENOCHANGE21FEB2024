import { LightningElement ,api} from 'lwc';
import updateGeolocation from '@salesforce/apex/GetCoordinateforAccount.updateGeolocation';

export default class GetCoordinateforAccount extends LightningElement {

    @api recordId;

    captureLocation() {
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition((position) => {
                const latitude = position.coords.latitude;
                const longitude = position.coords.longitude;
                console.log('ID value',recordId);
                // Assuming you have the accountId from your LWC component context
                const accountId = recordId; // Replace with the actual Account Id

                // Call the Apex method to update the geolocation
                updateGeolocation({ accountId, latitude, longitude })
                    .then(() => {
                        // Handle success, e.g., show a success message
                        console.log('Geolocation updated successfully');
                    })
                    .catch(error => {
                        // Handle errors, e.g., show an error message
                        console.error('Error updating geolocation: ' + error);
                    });
            });
        } else {
            alert("Geolocation is not supported in this browser.");
        }
    }
}