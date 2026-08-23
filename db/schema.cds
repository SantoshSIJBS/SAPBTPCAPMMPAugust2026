// Generally namespace will be created with the name <Company Name>.<Module Name>.<Application Name>
// namespace ibm.sd.purchaseordersappl ;
namespace purchaseordersappl.db;

using {purchaseordersappl.reuse as reuse} from './common';
using {
    Currency,
    cuid
} from '@sap/cds/common';


context master {
    entity BusinessPartners {
        key NODE_KEY     : reuse.identity @(title: '{i18n>NODE_KEY}');
            BP_ROLE      : reuse.Role @(title: '{i18n>BP_ROLE}');
            EMAIL        : reuse.Email @(title: '{i18n>EMAIL}');
            MOBILE       : reuse.PhoneNumber @(title: '{i18n>MOBILE}');
            FAX          : String(32) @(title: '{i18n>FAX}');
            WEB          : String(255) @(title: '{i18n>WEB}');
            BP_ID        : reuse.identity @(title: '{i18n>BP_ID}');
            COMPANY_NAME : String(255) @(title: '{i18n>COMPANY_NAME}');
            AD           : Association to Addresses @(title: '{i18n>ADDRESS_GUID}');
    }

    entity Addresses : reuse.Address {
        key NODE_KEY     : reuse.identity @(title: '{i18n>NODE_KEY}');
            ADDRESS_TYPE : String(32) @(title: '{i18n>ADDRESS_TYPE}');
            VAL_START    : Date @(title: '{i18n>VAL_START}');
            VAL_END      : Date @(title: '{i18n>VAL_END}');
            LATITUDE     : Decimal @(title: '{i18n>LATITUDE}');
            LONGITUDE    : Decimal @(title: '{i18n>LONGITUDE}');
            // Unmanaged Association - to One
            BP           : Association to one BusinessPartners
                               on BP.AD = $self
    }

    entity Products {
        key NODE_KEY       : reuse.identity @(title: '{i18n>NODE_KEY}');
            PRODUCT_ID     : String(32) @(title: '{i18n>PRODUCT_ID}');
            TYPE_CODE      : String(2) @(title: '{i18n>TYPE_CODE}');
            CATEGORY       : String(32) @(title: '{i18n>CATEGORY}');
            DESCRIPTION    : reuse.Name @(title: '{i18n>DESCRIPTION}');
            TAX_TARIF_CODE : Integer @(title: '{i18n>TAX_TARIF_CODE}');
            MEASURE_UNIT   : String(2) @(title: '{i18n>MEASURE_UNIT}');
            WEIGHT_MEASURE : Decimal(5, 2) @(title: '{i18n>WEIGHT_MEASURE}');
            WEIGHT_UNIT    : String(2) @(title: '{i18n>WEIGHT_UNIT}');
            PRICE          : Decimal(15, 2) @(title: '{i18n>PRICE}');
            CURRENCY_CODE  : String(4) @(title: '{i18n>CURRENCY_CODE}');
            WIDTH          : Decimal(5, 2) @(title: '{i18n>WIDTH}');
            DEPTH          : Decimal(5, 2) @(title: '{i18n>DEPTH}');
            HEIGHT         : Decimal(5, 2) @(title: '{i18n>HEIGH}');
            DIM_UNIT       : String(2) @(title: '{i18n>DIM_UNIT}');
            // Managed Association - to One
            SUP            : Association to BusinessPartners;
    }

    entity Employees : cuid {
        nameFirst     : reuse.Name;
        nameLast      : reuse.Name;
        nameInitials  : reuse.Name;
        nameMidlle    : reuse.Name;
        gender        : reuse.Gender;
        language      : String(2);
        loginName     : String(16);
        phoneNumber   : reuse.PhoneNumber;
        email         : reuse.Email;
        Currency      : Currency;
        salaryAmount  : reuse.AmountT;
        accountNumber : String(16);
        bankId        : String(16);
        bankName      : String(64);
    }
}

context transaction {
    entity PurchaseOrders : reuse.Amount {
        key NODE_KEY         : reuse.identity @(title: '{i18n>NODE_KEY}');
            PO_ID            : reuse.identity @(title: '{i18n>PO_ID}');
            // Managed Association
            PARTNER          : Association to master.BusinessPartners @(title: '{i18n>PARTNER}');
            LIFECYCLE_STATUS : String(1) @(title: '{i18n>LIFECYCLE_STATUS}');
            OVERALL_STATUS   : String(1) @(title: '{i18n>OVERALL_STATUS}');
            // Unmanaged Association - to Many
            Items            : Composition of many PurchaseItems
                                   on Items.PARENT = $self;
    }

    entity PurchaseItems : reuse.Amount {
        key NODE_KEY     : reuse.identity @(title: '{i18n>NODE_KEY}');
            PO_ITEMS_POS : Integer @(title: '{i18n>PO_ITEMS_POS}');
            // Managed Association 
            PARENT       : Association to PurchaseOrders @(title: '{i18n>PARENT_KEY}');
            
            // Managed Association - to One
            PROD         : Association to master.Products @(title: '{i18n>PRODUCT_GUID}');
    }
}