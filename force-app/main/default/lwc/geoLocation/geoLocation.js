import { LightningElement, track, wire, api } from 'lwc';
import { getRecord, updateRecord } from 'lightning/uiRecordApi';
import getAttendanceRecordId from '@salesforce/apex/LocationTrackerController.getAttendanceRecordId';

const CUSTOM_OBJECT_NAME = 'Attendance__c';
const LATITUDE_FIELD = 'Present_Coordinates__latitude__s';
const LONGITUDE_FIELD = 'Present_Coordinates__Longitude__s';

export default class LocationTracker extends LightningElement {
  @track markerVar = [];
  @wire(getRecord, { recordId: '$recordId', fields: [LATITUDE_FIELD, LONGITUDE_FIELD] })
  customObjectRecord;

  @api recordId;

  connectedCallback() {
    this.getRecordId();
  }

  getRecordId() {
    getAttendanceRecordId()
      .then(result => {
        this.recordId = result;
      })
      .catch(error => {
        console.error('Error retrieving Attendance record ID', error);
      });
  }

  handleCheckInClick() {
    navigator.geolocation.getCurrentPosition(
      (position) => {
        const latitude = position.coords.latitude;
        const longitude = position.coords.longitude;

        this.markerVar = [
          {
            location: {
              Latitude: latitude,
              Longitude: longitude
            },
            title: 'Current Location',
            description: `Latitude: ${latitude}, Longitude: ${longitude}`
          }
        ];

        this.updateCustomObjectRecord(latitude, longitude);
      },
      (error) => {
        console.error('Error getting current position', error);
      }
    );
  }

  updateCustomObjectRecord(latitude, longitude) {
    const fields = {};
    fields[LATITUDE_FIELD] = latitude;
    fields[LONGITUDE_FIELD] = longitude;

    updateRecord({ fields, recordId: this.recordId })
      .then(() => {
        console.log('Custom Object record updated successfully');
      })
      .catch((error) => {
        console.error('Error updating Custom Object record', error);
      });
  }

  get currentLocation() {
    if (this.customObjectRecord.data) {
      return `${this.customObjectRecord.data.fields[LATITUDE_FIELD].value}, ${this.customObjectRecord.data.fields[LONGITUDE_FIELD].value}`;
    }
    return '';
  }
}