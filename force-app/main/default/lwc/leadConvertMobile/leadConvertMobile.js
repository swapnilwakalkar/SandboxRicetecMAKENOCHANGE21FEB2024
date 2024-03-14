import { LightningElement, wire, track, api } from 'lwc';
import { CloseActionScreenEvent } from 'lightning/actions';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getLeadRecords from '@salesforce/apex/LeadButtonController.getLeadRecords';
import updateLead from '@salesforce/apex/LeadButtonController.updateLead';
import submitAccount from '@salesforce/apex/LeadButtonController.submitAccount';
import submitContact from '@salesforce/apex/LeadButtonController.submitContact';
import submitOpportunity from '@salesforce/apex/LeadButtonController.submitOpportunity';
//import searchAccounts from '@salesforce/apex/LeadButtonController.searchAccounts';
import searchAccountsPhoneNumber from '@salesforce/apex/LeadButtonController.searchAccountsPhoneNumber';
import searchContacts from '@salesforce/apex/LeadButtonController.searchContacts';
import searchOpty from '@salesforce/apex/LeadButtonController.searchOpty';
import updateAccountName from '@salesforce/apex/LeadButtonController.updateAccountName';  
import updateContactAccount from '@salesforce/apex/LeadButtonController.updateContactAccount';
import updateOpportunityAccount from '@salesforce/apex/LeadButtonController.updateOpportunityAccount';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import OPPORTUNITY_OBJECT from '@salesforce/schema/Opportunities__c';
import CONTACT_OBJECT from '@salesforce/schema/Contact';
import { NavigationMixin } from 'lightning/navigation';
console.log('90');
const FIELDS = ['Account.Name'];
export default class LeadConvertMobile extends NavigationMixin(LightningElement) {
  activeSectionMessage = '';

  salutationsList = [
    { label: 'Mr.', value: 'Mr.' },
    { label: 'Ms.', value: 'Ms.' },
    { label: 'Mrs.', value: 'Mrs.' },
    { label: 'Dr.', value: 'Dr.' },
    { label: 'Prof.', value: 'Prof.' },
  ];
  get salutationOptions() {
    return this.salutationsList;
  }

  @api recordId;
  @track isButtonDisabled = false; //new
  selectedValue;
  @track selectedOption;
  isExistingRecordSearch = false;
  isExistingRecordConSearch = false;
  isExistingRecordOppSearch = false;
  accountRecordId = '';
  value = 'Closed - Converted';
  @track isCreateNew = true;
  @track isCreateNewCon = true;
  @track isCreateNewOpp = true;
  @track SkipContact = false;
  @track SkipOpportunity = false;
  accountName = '';
  accountMobile1 = '';
  accountMobile2 = '';
  accountEmail = '';
  accountMillType = '';
  accountBillingStreet = '';
  accountBillingVillage = '';
  accountBillingCity = '';
  accountBillingMandal = '';
  accountBillingState = '';
  accountDistrict = '';
  accountBillingCountry = '';
  accountBillingTerritory = '';
  accountpincode = '';
  accountLeadSource = '';
  opportunityName = '';
  opportunityMillType = '';
  opportunityLeadSource = '';
  opportunityFirstName = '';
  opportunityLastName = '';
  salutation = '';
  contactName = '';
  contactFirstName = '';
  contactLastName = '';
  contactMobile1 = '';
  contactMobile2 = '';
  contactEmail = '';
  contactMailingStreet = '';
  contactMailingVillage = '';
  contactMailingMandal = '';
  contactMailingCity = '';
  contactMailingState = '';
  contactMailingDistrict = '';
  contactMailingCountry = '';
  contactpincode = '';
  contactMailingTerritory = '';
  contactLeadSource = '';
  contactMillType = '';
  OwnerName = '';
  @track actName = '';
  @track actPhoneNumber = '';
  @track accountList = [];
  @track objectApiName = 'Account';
  @track accountId;
  @track isShow = false;
  @track messageResult = false;
  @track messageResult1 = false;
  @track isShowResult = true;
  @track showSearchedValues = false;
  @track accountRecordId;
  @track contactRecordId;
  @wire(getObjectInfo, { objectApiName: ACCOUNT_OBJECT })
  accountObjectInfo;
  @track conName = '';
  @track contactList = [];
  @track objectApiName = 'Contact';
  @track contactId;
  @wire(getObjectInfo, { objectApiName: CONTACT_OBJECT })
  contactObjectInfo;
  @track oppName = '';
  @track opportunityList = [];
  @track objectApiName = 'Opportunities__c';
  @track opportunityId;
  @wire(getObjectInfo, { objectApiName: OPPORTUNITY_OBJECT })
  opportunityObjectInfo;

  handleToggleSection(event) {
    this.activeSectionMessage =
      'Open section name:  ' + event.detail.openSections;
  }
  get options() {
    return [
      { label: 'Closed - Converted', value: 'Closed - Converted' },
    ];
  }
  connectedCallback() {
    setTimeout(() => {
      getLeadRecords({ LeadId: this.recordId })
        .then(data => {
          console.log('Lead Id: ', this.recordId);
          this.accountName = data.Company__c;
          this.accountMobile1 = data.Phone__c;
          this.accountMobile2 = data.Mobile__c;
          this.accountEmail = data.Email__c;
          this.accountAddress = data.Address__c;
          this.accountMillType = data.Mill_Type__c;
          this.accountBillingTerritory = data.Territorys__c;
          this.accountBillingStreet = data.Area__c;
          this.accountBillingCity = data.City__c;
          this.accountBillingVillage = data.Village__c;
          this.accountBillingMandal = data.Mandal__c;
          this.accountDistrict = data.District__c;
          this.accountBillingState = data.State__c;
          this.accountBillingCountry = data.Country__c;
          this.accountLeadSource = data.Lead_Source__c;
          this.accountpincode = data.Pincode__c;
          this.opportunityName = data.Company__c;
          this.opportunityMillType = data.Mill_Type__c;
          this.opportunityLeadSource = data.Lead_Source__c;
          this.opportunityFirstName = data.FirstName__c;
          this.opportunityLastName = data.LastName__c;
          this.contactName = data.FirstName__c + ' ' + data.LastName__c;
          this.salutation = data.Salutation__c;
          this.contactFirstName = data.LastName__c;
          this.contactLastName = data.FirstName__c;
          this.contactMobile1 = data.Phone__c;
          this.contactMobile2 = data.Mobile__c;
          this.contactEmail = data.Email__c;
          this.contactLeadSource = data.Lead_Source__c;
          this.contactMailingStreet = data.Area__c;
          this.contactMailingCity = data.City__c;
          this.contactMailingVillage = data.Village__c;
          this.contactMailingMandal = data.Mandal__c;
          this.contactMailingDistrict = data.District__c
          this.contactMailingState = data.State__c;
          this.contactMailingCountry = data.Country__c;
          this.contactMailingTerritory = data.Territorys__c;
          this.contactMillType = data.Mill_Type__c;
          this.contactpincode = data.Pincode__c;
          this.OwnerName = data.Owner.Name;
          console.log(data);
        });
    }, 10);
  }
  closeAction() {
    this.dispatchEvent(new CloseActionScreenEvent());
  }
  handleCheckboxChange(event) {
    const checkboxName = event.target.label;
    const isChecked = event.target.checked;

    if (checkboxName === "Don't create a contact upon conversion") {
      this.SkipContact = isChecked;
    } else if (checkboxName === "Don't create an opportunity upon conversion") {
      this.SkipOpportunity = isChecked;
    }
  }
  handleRadioChange(event) {
    this.selectedOption = event.target.value;
    console.log('testRadio', event.target.value);

    if (this.selectedOption === 'radio-61') {
      this.isCreateNew = true;
      this.isExistingRecordSearch = false;
      this.isShowResult = false;
    } else if (this.selectedOption === 'radio-62') {
      this.isCreateNew = false;
      this.isExistingRecordSearch = true;
      this.isShowResult = true;
    } else if (this.selectedOption === 'radio-63') {
      this.isCreateNewCon = true;
      this.isExistingRecordConSearch = false;
      this.isShowResult = false;
    } else if (this.selectedOption === 'radio-64') {
      this.isCreateNewCon = false;
      this.isExistingRecordConSearch = true;
      this.isShowResult = true;
    } else if (this.selectedOption === 'radio-65') {
      this.isCreateNewOpp = true;
      this.isExistingRecordOppSearch = false;
      this.isShowResult = false;
    } else if (this.selectedOption === 'radio-66') {
      this.isCreateNewOpp = false;
      this.isExistingRecordOppSearch = true;
      this.isShowResult = true;
    }
  }
  handleAccountNameChange(event) {
    this.accountName = event.target.value;
    if (this.selectedOption === 'radio-61') {
      this.accountName = event.target.value;
      this.accountRecordId = '';
    }
  }
  handleConNameChange(event) {
    this.contactLastName = event.detail.lastName;
    this.contactFirstName = event.detail.firstName;
  }
  handleOppNameChange(event) {
    this.opportunityName = event.target.value;
    if (this.selectedOption === 'radio-61') {
      this.opportunityName = event.target.value;
      this.accountRecordId = '';
    }
  }
 /* @wire(searchAccounts, { searchTerm: '$actName' })
  retrieveAccounts({ error, data }) {
    this.messageResult = false;
    if (data) {
      console.log('data## ' + data.length);
      if (data.length > 0 && this.isShowResult) {
        this.accountList = data;
        this.showSearchedValues = true;
        this.messageResult = false;
      } else if (data.length === 0) {
        this.accountList = [];
        this.showSearchedValues = false;
        if (this.actName !== '') {
          this.messageResult = true;
        }
      } else if (error) {
        this.accountId = '';
        this.actName = '';
        this.accountList = [];
        this.showSearchedValues = false;
        this.messageResult = true;
      }
    }
  }*/
  @wire(searchAccountsPhoneNumber, { searchTerm1: '$actPhoneNumber' })
  retrieveAccounts({ error, data }) {
    this.messageResult1 = false;
    if (data) {
      console.log('data## ' + data.length);
      if (data.length > 0 && this.isShowResult) {
        this.accountList = data;
        this.showSearchedValues = true;
        this.messageResult1 = false;
      } else if (data.length === 0) {
        this.accountList = [];
        this.showSearchedValues = false;
        if (this.actPhoneNumber !== '') {
          this.messageResult1 = true;
        }
      } else if (error) {
        this.accountId = '';
        this.actPhoneNumber = '';
        this.accountList = [];
        this.showSearchedValues = false;
        this.messageResult1 = true;
      }
    }
  }
  searchHandleAccountClick1(event) {
    this.isShowResult = true;
    this.messageResult = false;
  }
  searchHandleAccountKeyChange(event) {
    this.messageResult = false;
    this.actName = event.target.value;
  }
  searchHandlePhoneKeyChange(event) {
    this.messageResult1 = false;
    this.actPhoneNumber = event.target.value;
  }
  parentHandleAccountAction(event) {
    this.showSearchedValues = false;
    this.isShowResult = false;
    this.messageResult = false;
    this.messageResult1 = false;
    this.accountId = event.target.dataset.value;
    this.actName = event.target.dataset.label;
    this.actPhoneNumber = event.target.phone;
    console.log('accountId: Parent:' + this.accountId);
    const selectedEvent = new CustomEvent('selected', { detail: this.accountId });
    this.dispatchEvent(selectedEvent);
  }
  handleAccountSelection(event) {
    this.accountRecordId = event.detail;
    console.log('Handle record id ', this.accountRecordId);
  }
  @wire(searchContacts, { searchTerm: '$conName' })
  retrieveContacts({ error, data }) {
    this.messageResult = false;
    if (data) {
      if (data.length > 0 && this.isShowResult) {
        this.contactList = data;
        this.showSearchedValues = true;
        this.messageResult = false;
      } else if (data.length === 0) {
        this.contactList = [];
        this.showSearchedValues = false;
        if (this.conName !== '') {
          this.messageResult = true;
        }
      }
    } else if (error) {
      this.contactId = '';
      this.conName = '';
      this.contactList = [];
      this.showSearchedValues = false;
      this.messageResult = true;
      console.error('Error retrieving contacts:', error);
    }
  }
  searchHandleContactClick(event) {
    this.isShowResult = true;
    this.messageResult = false;
  }
  searchHandleContactKeyChange(event) {
    this.messageResult = false;
    this.conName = event.target.value;
  }
  parentHandleContactAction(event) {
    this.showSearchedValues = false;
    this.isShowResult = false;
    this.messageResult = false;
    this.contactId = event.target.dataset.value;
    this.conName = event.target.dataset.label;
    console.log('Contact ID:', this.contactId);
    console.log('Contact Name:', this.conName);
    const selectedEvent = new CustomEvent('selected', { detail: this.contactId });
    this.dispatchEvent(selectedEvent);
  }
  @wire(searchOpty, { searchTerm: '$oppName' })
  retrieveOpportunities({ error, data }) {
    this.messageResult = false;
    if (data) {
      console.log('data## ' + data.length);
      if (data.length > 0 && this.isShowResult) {
        this.opportunityList = data;
        this.showSearchedValues = true;
        this.messageResult = false;
      } else if (data.length === 0) {
        this.opportunityList = [];
        this.showSearchedValues = false;
        if (this.oppName !== '') {
          this.messageResult = true;
        }
      } else if (error) {
        this.opportunityId = '';
        this.oppName = '';
        this.opportunityList = [];
        this.showSearchedValues = false;
        this.messageResult = true;
      }
    }
  }

  searchHandleOpportunityClick(event) {
    this.isShowResult = true;
    this.messageResult = false;
  }

  searchHandleOpportunityKeyChange(event) {
    this.messageResult = false;
    this.oppName = event.target.value;
  }

  parentHandleOpportunityAction(event) {
    this.showSearchedValues = false;
    this.isShowResult = false;
    this.messageResult = false;
    this.opportunityId = event.target.dataset.value;
    this.oppName = event.target.dataset.label;
    console.log('Opportunity ID: ', this.opportunityId);
    console.log('Opportunity Name: ', this.oppName);
    const selectedEvent = new CustomEvent('selected', { detail: this.opportunityId });
    this.dispatchEvent(selectedEvent);
  }

  handleOpportunityNameChange(event) {
    this.opportunityName = event.target.value;
  }
  async convertLead(event) {

    try {
      if ((this.isCreateNew) && (!(this.isExistingRecordConSearch) && !(this.isExistingRecordOppSearch))) {
        this.isButtonDisabled = true;
        const account = await this.createAccount();
        await this.updateLeadRecord();
        const contact = await this.createContact(account.Id);
        const opportunity = await this.createOpportunity(account.Id);
      } else if ((!(this.isExistingRecordConSearch)) && (!(this.isExistingRecordOppSearch))) {
        this.isButtonDisabled = true;
        await this.updateLeadRecord();
        const contact = await this.createContact(this.accountId);
        const opportunity = await this.createOpportunity(this.accountId);
        console.log('Selected Account Id:', this.accountId);
        console.log('Selected Account Name:', this.actName);
        this.accountRecordId = this.accountId;
        await this.updateExistingAccountName(this.accountRecordId, this.actName);
      }
      if ((this.isExistingRecordConSearch) && (this.isExistingRecordSearch)) {
        this.isButtonDisabled = true;
        await this.updateContactAccount(this.contactId, this.accountId);
        await this.updateExistingAccountName(this.accountId, this.actName);
        console.log('Contact Updated Account Id', this.accountId);
      }
      if ((this.isExistingRecordOppSearch) && (this.isExistingRecordSearch)) {
        this.isButtonDisabled = true;
        await this.updateOpportunityAccount(this.opportunityId, this.accountId);
        console.log('Opportunity Updated Account Id', this.accountId);
        await this.updateExistingAccountName(this.accountId, this.actName);
      }
      if ((this.isExistingRecordSearch) && (this.isCreateNewCon) && (this.isExistingRecordOppSearch)) {
        this.isButtonDisabled = true;
        await this.createContact(this.accountId);
        await this.updateExistingAccountName(this.accountId, this.actName);
      }
      if ((this.isExistingRecordSearch) && (this.isCreateNewOpp) && (this.isExistingRecordConSearch)) {
        this.isButtonDisabled = true;
        await this.createOpportunity(this.accountId);
        await this.updateExistingAccountName(this.accountId, this.actName);
      }
      if ((this.isCreateNew) && (this.isExistingRecordConSearch) && (this.isExistingRecordOppSearch)) {
        this.isButtonDisabled = true;
        const account = await this.createAccount();
        await this.updateLeadRecord();
        await this.updateOpportunityAccount(this.opportunityId, this.accountId);
        await this.updateContactAccount(this.contactId, this.accountId);
      }
      if ((this.isCreateNew) && (this.isCreateNewOpp) && (this.isExistingRecordConSearch)) {
        this.isButtonDisabled = true;
        const account = await this.createAccount();
        await this.updateLeadRecord();
        await this.createOpportunity(this.accountId);
        await this.updateContactAccount(this.contactId, this.accountId);
      }
      this.showToast('Success', 'Lead Converted Successfully', 'success');
      this.updateRecordView();
    } catch (error) {
      console.error('Error converting lead:', error);
      this.showToast('Error', 'An error occurred', 'error');
    }
  }

  async updateLeadRecord() {
    try {
      const result = await updateLead({ leadId: this.recordId, ConvertedAccId: this.accountId, skpCon: this.SkipContact, skpOpp: this.SkipOpportunity });
      console.log('Lead is updated', result);
      this.leadId = result.Id;
    } catch (error) {
      console.error('Error updating lead:', error);
      throw error;
    }
  }
  async createAccount() {
    try {
      const account = await submitAccount({
        LeadCompany: this.accountName, LeadMobile1: this.accountMobile1,
        LeadMobile2: this.accountMobile2, LeadEmail: this.accountEmail,
        LeadMillType: this.accountMillType, AccountBillingStreet: this.accountBillingStreet, AccountBillingVillage: this.accountBillingVillage,
        AccountBillingMandal: this.accountBillingMandal, AccountBillingCity: this.accountBillingCity,
        AccountBillingDistrict: this.accountDistrict, AccountBillingState: this.accountBillingState,
        AccountBillingTerritory: this.accountBillingTerritory, AccountBillingCountry: this.accountBillingCountry, accountpincode: this.accountpincode,
        LeadSource: this.accountLeadSource
      });
      console.log('Account is created', account);
      this.accountId = account.Id;
      return account;
    } catch (error) {
      console.error('Error creating account:', error);
      throw error;
    }
  }
  async createContact(accId) {
    try {
      if (!this.SkipContact) {
        const contact = await submitContact({
          Salutation: this.salutationValue,
          FirstName: this.contactFirstName,
          LastName: this.contactLastName,
          LeadMobile1: this.contactMobile1,
          LeadMobile2: this.contactMobile2,
          Email: this.contactEmail,
          LeadMillType: this.contactMillType,
          LeadSource: this.contactLeadSource,
          ContactMailingStreet: this.contactMailingStreet,
          ContactMailingCity: this.contactMailingCity,
          ContactMailingState: this.contactMailingState,
          ContactMailingDistrict: this.contactMailingDistrict,
          ContactMailingCountry: this.contactMailingCountry,
          ContactMailingVillage: this.contactMailingVillage,
          ContactMailingMandal: this.contactMailingMandal,
          ContactMailingTerritory: this.contactMailingTerritory,
          ContactPincode: this.contactpincode,
          AccId: accId
        });
        console.log('Contact is created', contact);
        this.contactId = contact.Id;
        return contact;
      } else {
        return null;
      }
    } catch (error) {
      console.error('Error creating contact:', error);
      throw error;
    }
  }
  async createOpportunity(accId) {
    try {
      if (!this.SkipOpportunity) {
        const opportunity = await submitOpportunity({
          LeadCompany: this.opportunityName,
          LeadMillType: this.opportunityMillType,
          LeadSource: this.opportunityLeadSource,
          FirstName: this.opportunityFirstName,
          LastName: this.opportunityLastName,
          AccId: accId
        });
        console.log('Opportunity is created', opportunity);
        this.opportunityId = opportunity.Id;
        return opportunity;
      } else {
        return null;
      }
    } catch (error) {
      console.error('Error creating opportunity:', error);
      throw error;
    }
  }
  async updateExistingAccountName() {
    try {
      await updateAccountName({ accountId: this.accountId, accountName: this.actName });
      console.log('Account name updated successfully');
    } catch (error) {
      console.error('Error updating account name:', error);
      throw error;
    }
  }
  async updateContactAccount() {
    try {
      await updateContactAccount({ contactId: this.contactId, AccountId: this.accountId });
      console.log('Contact AccountId updated successfully');
    } catch (error) {
      console.error('Error updating Contact AccountId:', error);
      throw error;
    }
  }
  async updateOpportunityAccount() {
    try {
      await updateOpportunityAccount({ opportunityId: this.opportunityId, AcID: this.accountId });
      console.log('Opportunity AccountId updated successfully');
    } catch (error) {
      console.error('Error updating Opportunity AccountId:', error);
      throw error;
    }
  }
  /*updateRecordView() {
    try {
      setTimeout(() => {
        eval("$A.get('e.force:refreshView').fire();");
      }, 0);
      this.navigateToAccountDetail(this.accountId);
    } catch (error) {
      console.error('Error refreshing view:', error);
      throw error;
    }
  }
  navigateToAccountDetail(accountId) {
    this[NavigationMixin.Navigate]({
      type: 'standard__recordPage',
      attributes: {
        recordId: accountId,
        objectApiName: 'Account',
        actionName: 'view'
      }
    });
  }*/
    updateRecordView() {
    try {
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: this.accountId,
                objectApiName: 'Account',
                actionName: 'view'
            }
        });
    } catch (error) {
        console.error('Error refreshing view:', error);
        throw error;
    }
}
  showToast(title, message, variant) {
    const toastEvent = new ShowToastEvent({
      title: title,
      message: message,
      variant: variant,
      mode: 'dismissable'
    });
    this.dispatchEvent(toastEvent);
  }
  
}