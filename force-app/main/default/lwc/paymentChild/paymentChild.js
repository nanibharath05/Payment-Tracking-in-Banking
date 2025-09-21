import { LightningElement, api, wire } from 'lwc';
import getPayments from '@salesforce/apex/PaymentController.getPayments';

export default class PaymentChild extends LightningElement {
    @api recordId;
    payments;

    @wire(getPayments, { loanId: '$recordId' })
    wiredPayments({ error, data }) {
        if (data) {
            this.payments = data;
        } else if (error) {
            console.error('Error fetching payments:', error);
            this.payments = null;
        }
    }
}
