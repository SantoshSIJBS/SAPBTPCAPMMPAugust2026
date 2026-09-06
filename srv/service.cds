using { purchaseordersappl.db as db } from '../db/schema';

using {
    Currency
} from '@sap/cds/common';

using {purchaseordersappl.reuse as reuse} from '../db/common';

service CatalogService @(requires: 'authenticated-user'){

    entity ProductSrv as projection on db.master.Products;

    @Capabilities: {
        Insertable : true,
        Readable : true,
        Updatable : false,
        Deletable : false
    }
    entity EmployeeSrv as projection on db.master.Employees;

    entity AddressSrv @(restrict: [
        {grant: ['READ'], to : 'Viewer', where: 'COUNTRY = $user.country'},
        {grant: ['WRITE'], to : 'Admin'}
    ]) as projection on db.master.Addresses;

    entity BPSrv as projection on db.master.BusinessPartners;

    //@odata.draft.enabled: true
    entity POSrv as projection on db.transaction.PurchaseOrders{
        *,
        case OVERALL_STATUS
            when 'N' then 'New'
            when 'P' then 'Pending'
            when 'R' then 'Returned'
            else 'Delivered'
        end as OSS : String(20) @(title: '{i18n>OVERALL_STATUS}'),
        case LIFECYCLE_STATUS
            when 'N' then 'Not Paid'
            when 'P' then 'Paid'
            when 'R' then 'Rejected'
            else 'Approved'
        end as LSS : String(20) @(title: '{i18n>LIFECYCLE_STATUS}'),
        case OVERALL_STATUS
            when 'N' then 1
            when 'P' then 2
            when 'R' then 3
            else 1
        end as OSC: Int16,
        case LIFECYCLE_STATUS
            when 'N' then 1
            when 'P' then 2
            when 'R' then 3
            else 1
        end as LSC: Int16,
    } actions {
        // Declare - Instance boudned action
        @cds.odata.bindingparameter.name: 'DP'
        @Common.SideEffects: {
            TargetProperties : ['DP/GROSS_AMOUNT', 'DP/NET_AMOUNT', 'DP/TAX_AMOUNT']
        }
        action discountPrice();
    };

    entity POItemSrv as projection on db.transaction.PurchaseItems;

    // Functions are light-weight components.
    // Declare custom fuction - function <function_name>() returns <return_parameters>
    function getHighestSalariesEmp() returns array of EmployeeSrv;

    // Actions are heavy-weight components used to perform insert, update, delete operations in the DB.
    // Declare custom action - action <action_name>() returns <return_parameters>
    action createEmployee(
    Currency_code: String,
    accountNumber: String(16),
    bankId: String(16),
    bankName: String(64),
    email: reuse.Email,
    gender: reuse.Gender,
    language: String(2),
    loginName: String(16),
    nameFirst: reuse.Name,
    nameInitials: reuse.Name,
    nameLast: reuse.Name,
    nameMidlle: reuse.Name,
    phoneNumber: reuse.PhoneNumber,
    salaryAmount: reuse.AmountT
    ) returns array of EmployeeSrv;
}