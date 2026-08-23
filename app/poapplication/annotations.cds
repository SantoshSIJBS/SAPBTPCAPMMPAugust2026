using CatalogService as service from '../../srv/service';

annotate service.POSrv with @(
    UI.SelectionFields       : [
        PO_ID,
        PARTNER.COMPANY_NAME,
        PARTNER.AD.COUNTRY,
        GROSS_AMOUNT
    ],

    UI.LineItem              : [
        {
            $Type: 'UI.DataField',
            Value: PO_ID
        },
        {
            $Type: 'UI.DataField',
            Value: PARTNER.COMPANY_NAME
        },
        {
            $Type: 'UI.DataField',
            Value: GROSS_AMOUNT
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'CatalogService.discountPrice',
            Label : 'Discount',
            Inline : false
        },
        {
            $Type      : 'UI.DataField',
            Value      : LSS,
            Criticality: LSC
        },
        {
            $Type      : 'UI.DataField',
            Value      : OSS,
            Criticality: OSC
        },
        {
            $Type: 'UI.DataField',
            Value: PARTNER.AD.COUNTRY
        }
    ],

    UI.HeaderInfo            : {
        TypeName      : 'Purchase Order',
        TypeNamePlural: 'Purchase Orders',
        Title         : {
            Label: 'Purchase Order ID',
            Value: PO_ID
        },
        Description   : {
            Label: 'Company Name',
            Value: PARTNER.COMPANY_NAME
        },
        ImageUrl      : 'https://images.vexels.com/media/users/3/140583/isolated/preview/905dd25934b7a05516389863f7cb9417-ibm-logo.png'
    },

    UI.Facets                : [
        {
            $Type : 'UI.CollectionFacet',
            Label : 'Purchase Order Details',
            Facets: [
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'More details about the purchase order',
                    Target: '@UI.FieldGroup#MoreInfo'
                },
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Amount details about the purchase order',
                    Target: '@UI.FieldGroup#AmountInfo'
                }
            ]
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Lineitem Details',
            Target: 'Items/@UI.LineItem'
        }
    ],
    UI.FieldGroup #MoreInfo  : {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: PO_ID
            },
            {
                $Type: 'UI.DataField',
                Value: PARTNER_NODE_KEY
            },
            {
                $Type      : 'UI.DataField',
                Value      : LSS,
                Criticality: LSC
            },
            {
                $Type      : 'UI.DataField',
                Value      : OSS,
                Criticality: OSC
            }
        ]
    },
    UI.FieldGroup #AmountInfo: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: GROSS_AMOUNT
            },
            {
                $Type: 'UI.DataField',
                Value: NET_AMOUNT
            },
            {
                $Type: 'UI.DataField',
                Value: TAX_AMOUNT
            },
            {
                $Type: 'UI.DataField',
                Value: CURRENCY_code
            }
        ]
    }
);

annotate service.POItemSrv with @(UI.LineItem: [
    {
        $Type: 'UI.DataField',
        Value: PO_ITEMS_POS
    },
    {
        $Type: 'UI.DataField',
        Value: PROD_NODE_KEY
    },
    {
        $Type: 'UI.DataField',
        Value: GROSS_AMOUNT
    },
    {
        $Type: 'UI.DataField',
        Value: NET_AMOUNT
    },
    {
        $Type: 'UI.DataField',
        Value: TAX_AMOUNT
    },
    {
        $Type: 'UI.DataField',
        Value: CURRENCY_code
    }
],
UI.HeaderInfo : {
    TypeName : 'Purchase Item',
    TypeNamePlural : 'Purchase Items',
    Title : {
        $Type : 'UI.DataField',
        Value : PO_ITEMS_POS
    },
    Description : {
        $Type : 'UI.DataField',
        Value : PROD.DESCRIPTION
    },
     ImageUrl      : 'https://images.vexels.com/media/users/3/140583/isolated/preview/905dd25934b7a05516389863f7cb9417-ibm-logo.png'
},
UI.Facets : [
    {
        $Type : 'UI.CollectionFacet',
        Label : 'Purchase Item Details',
        Facets : [
            {
                $Type : 'UI.ReferenceFacet',
                Label : 'Price Info',
                Target : '@UI.FieldGroup#PriceDet'
            },
            {
                $Type : 'UI.ReferenceFacet',
                Label : 'Product Info',
                Target : '@UI.FieldGroup#ProdInfo'
            }
        ]
    }
],
UI.FieldGroup #PriceDet : {
    $Type : 'UI.FieldGroupType',
    Data : [
        {
            $Type : 'UI.DataField',
            Value : GROSS_AMOUNT
        },
        {
            $Type : 'UI.DataField',
            Value : NET_AMOUNT
        },
        {
            $Type : 'UI.DataField',
            Value : TAX_AMOUNT
        },
        {
            $Type : 'UI.DataField',
            Value : CURRENCY_code
        }
    ]
},

UI.FieldGroup #ProdInfo : {
    $Type : 'UI.FieldGroupType',
    Data : [
        {
            $Type : 'UI.DataField',
            Value : PROD.PRODUCT_ID
        },
        {
            $Type : 'UI.DataField',
            Value : PROD.DESCRIPTION
        },
        {
            $Type : 'UI.DataField',
            Value : PROD.CATEGORY
        },
        {
            $Type : 'UI.DataField',
            Value : PROD.PRICE
        },
        {
            $Type : 'UI.DataField',
            Value : PROD.DIM_UNIT
        },
        {
            $Type : 'UI.DataField',
            Value : PROD.WEIGHT_UNIT
        },
        {
            $Type : 'UI.DataField',
            Value : PROD.WEIGHT_MEASURE
        },
        {
            $Type : 'UI.DataField',
            Value : PROD.HEIGHT
        },
        {
            $Type : 'UI.DataField',
            Value : PROD.WIDTH
        },
        {
            $Type : 'UI.DataField',
            Value : PROD.DEPTH
        }
    ]
})