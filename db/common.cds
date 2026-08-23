namespace purchaseordersappl.reuse;

using {Currency} from '@sap/cds/common';


// Reusable Types
type identity    : UUID;
type PhoneNumber : String(32);
type Email       : String(255);
type Role        : String(2);
type Name        : String(255);

// Enumerator
type Gender      : String(1) enum {
    male = 'M';
    female = 'F';
    undisclosed = 'U';
}


// Reusable Type for Amount

type AmountT     : Decimal(10, 2) @(
    Semantics.amount.currencyCode: 'CURRENCY_CODE',
    sap.unit                     : 'CURRENCY_CODE'
);

type QuantityT   : Decimal(10, 2) @(
    Semantics.quantity.unitOfMeasure: 'UOM',
    sap.unit                        : 'UOM'
);


// Reusable Aspect - Amount - Group of fields
aspect Amount {
    CURRENCY     : Currency @(title: '{i18n>CURRENCY_CODE}');
    GROSS_AMOUNT : AmountT  @(title: '{i18n>GROSS_AMOUNT}');
    NET_AMOUNT   : AmountT  @(title: '{i18n>NET_AMOUNT}');
    TAX_AMOUNT   : AmountT  @(title: '{i18n>TAX_AMOUNT}');
}


// Reusable Aspect - Addresses
aspect Address {
    STREET   : Name       @(title: '{i18n>STREET}');
    POSTAL   : String(12) @(title: '{i18n>POSTAL}');
    CITY     : Name       @(title: '{i18n>CITY}');
    COUNTRY  : Name       @(title: '{i18n>COUNTRY}');
    BUILDING : Name       @(title: '{i18n>BUILDING}');
}