import { LightningElement } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';

export default class LoanNavigator extends NavigationMixin(LightningElement) {
    navigateToLoan() {
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: 'a0123456789ABC', // replace with dynamic Loan Id
                objectApiName: 'Loan__c',
                actionName: 'view'
            }
        });
    }

    navigateToPaymentList() {
        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName: 'Payment__c',
                actionName: 'list'
            },
            state: { filterName: 'All' }
        });
    }

    navigateToNewRecovery() {
        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName: 'Recovery__c',
                actionName: 'new'
            }
        });
    }
}
