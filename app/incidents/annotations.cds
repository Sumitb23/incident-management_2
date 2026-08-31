using ProcessorService as service from '../../srv/services';
using from '../../db/schema';

annotate service.Incidents with @(
    UI.SelectionFields : [
        status.code,
        urgency.code,
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : title,
            Label : '{i18n>Title}',
        },
        {
            $Type : 'UI.DataField',
            Value : customer.name,
            Label : '{i18n>Customer}',
        },
        {
            $Type : 'UI.DataField',
            Value : status.descr,
            Label : '{i18n>Status}',
            Criticality : status.criticality,
        },
        {
            $Type : 'UI.DataField',
            Value : urgency.descr,
            Label : '{i18n>Urgency}',
        },
    ],
    UI.HeaderInfo : {
        Title : {
            $Type : 'UI.DataField',
            Value : title,
        },
        TypeName : '',
        TypeNamePlural : '',
        Description : {
            $Type : 'UI.DataField',
            Value : customer.name,
        },
        TypeImageUrl : 'sap-icon://alert',
    },
    UI.Facets : [
        {
            $Type : 'UI.CollectionFacet',
            Label : '{i18n>Overview}',
            ID : 'i18nOverview',
            Facets : [
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : '{i18n>GeneralInformation}',
                    ID : 'i18nGeneralInformation',
                    Target : '@UI.FieldGroup#i18nGeneralInformation',
                },
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : '{i18n>Details}',
                    ID : 'i18nDetails',
                    Target : '@UI.FieldGroup#i18nDetails',
                },
            ],
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>Conversation}',
            ID : 'i18nCoversation',
            Target : 'conversation/@UI.LineItem#i18nCoversation',
        },
    ],
    UI.FieldGroup #i18nDetails : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : status_code,
                Label : 'Status',
            },
            {
                $Type : 'UI.DataField',
                Value : urgency_code,
                Label : 'Urgency',
            },
        ],
    },
    UI.FieldGroup #i18nGeneralInformation : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : title,
            },
            {
                $Type : 'UI.DataField',
                Value : customer_ID,
                Label : '{i18n>Customer}',
            },
            {
                $Type : 'UI.DataField',
                Value : urgency_code,
                Label : 'urgency_code',
            },
            {
                $Type : 'UI.DataField',
                Value : status_code,
                Label : 'status_code',
            },
        ],
    },
    UI.FieldGroup #i18nAddress : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : customer.addresses.streetAddress,
                Label : 'StreetAddress',
            },
            {
                $Type : 'UI.DataField',
                Value : customer.addresses.postCode,
                Label : 'postCode',
            },
            {
                $Type : 'UI.DataField',
                Value : customer.addresses.city,
                Label : 'city',
            },
        ],
    },
);

annotate service.Status with {
    code @(
        Common.Label : '{i18n>Status}',
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Status',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : code,
                    ValueListProperty : 'code',
                },
            ],
        },
        Common.ValueListWithFixedValues : true,
        Common.Text : descr,
        Common.Text.@UI.TextArrangement : #TextFirst,
    )
};

annotate service.Urgency with {
    code @(
        Common.Label : '{i18n>Urgency}',
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Urgency',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : code,
                    ValueListProperty : 'code',
                },
            ],
        },
        Common.ValueListWithFixedValues : true,
        Common.Text : descr,
        Common.Text.@UI.TextArrangement : #TextFirst,
    )
};

annotate service.Incidents with {
    customer @(
        Common.Text : customer.name,
        Common.Text.@UI.TextArrangement : #TextFirst,
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Customers',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : customer_ID,
                    ValueListProperty : 'ID',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'name',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'email',
                },
            ],
        },
        Common.ValueListWithFixedValues : false,
    )
};

annotate service.Incidents with {
    status @(
        Common.Text : status.descr,
        Common.Text.@UI.TextArrangement : #TextFirst,
        Common.ValueListWithFixedValues : true,
)};

annotate service.Incidents with {
    urgency @(
        Common.Text : urgency.descr,
        Common.ValueListWithFixedValues : true,
        )};

annotate service.Incidents.conversation with @(
    UI.LineItem #i18nCoversation : [
        {
            $Type : 'UI.DataField',
            Value : author,
            Label : '{i18n>Author}',
        },
        {
            $Type : 'UI.DataField',
            Value : message,
            Label : '{i18n>Message}',
        },
        {
            $Type : 'UI.DataField',
            Value : timestamp,
            Label : '{i18n>Date}',
        },
    ]
);

