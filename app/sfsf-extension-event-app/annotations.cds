using EventService as service from '../../srv/event-service';
using from '../common';

annotate service.Event with @(UI.TextArrangement: #TextOnly);

annotate service.Event with @(UI: {
    HeaderInfo     : {
        Title         : {
            $Type: 'UI.DataField',
            Value: name,
        },
        TypeName      : '{i18n>events}',
        TypeNamePlural: '{i18n>event}',
        Description   : {Value: ID}
    },
    LineItem       : [
        {
            $Type: 'UI.DataField',
            Value: ID,
        },
        {
            $Type: 'UI.DataField',
            Value: name,
        },
        {
            $Type: 'UI.DataField',
            Value: description,
        },
        {
            $Type: 'UI.DataField',
            Label: '{i18n>type}',
            Value: eventType_name,
        },
        {
            $Type: 'UI.DataField',
            Value: startDateTime,
        },
        {
            $Type: 'UI.DataField',
            Value: endDateTime,
        },
        {
            $Type : 'UI.DataField',
            Value : users.user.username,
            Label : '{i18n>participants}',
        }
    ],
    SelectionFields: [
        eventType_name,
        users.user_userId
    ],


}, ) {
    eventType @(Common: {
        ValueListWithFixedValues,
        ValueList: {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'EventType',
            Parameters    : [{
                $Type            : 'Common.ValueListParameterOut',
                LocalDataProperty: eventType_name,
                ValueListProperty: 'name',
            }, ]
        }
    })
};


annotate service.Event with @(UI: {
    FieldGroup #GeneratedGroup1: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: ID,
            },
            {
                $Type: 'UI.DataField',
                Value: name,
            },
            {
                $Type: 'UI.DataField',
                Value: description,
            },
            {
                $Type: 'UI.DataField',
                Value: eventType_name,
            },
            {
                $Type: 'UI.DataField',
                Value: startDateTime,
            },
            {
                $Type: 'UI.DataField',
                Value: endDateTime,
            }
        ],
    },
    FieldGroup #Admin          : {Data: [
        {
            $Type: 'UI.DataField',
            Value: createdBy
        },
        {
            $Type: 'UI.DataField',
            Value: modifiedBy
        },
        {
            $Type: 'UI.DataField',
            Value: createdAt
        },
        {
            $Type: 'UI.DataField',
            Value: modifiedAt
        }
    ]},
    Facets                     : [
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'GeneratedFacet1',
            Label : '{i18n>eventInfo}',
            Target: '@UI.FieldGroup#GeneratedGroup1',
        },
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'AdminFacet',
            Label : '{i18n>adminInfo}',
            Target: '@UI.FieldGroup#Admin',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>participants}',
            Target: 'users/@UI.LineItem'
        },
    ]
}, );


annotate service.UsersEvents with @(
    UI       : {
        LineItem           : [
            {
                $Type: 'UI.DataField',
                Label: '{i18n>userId}',
                Value: user_userId,
            },
            {
                $Type                  : 'UI.DataField',
                Label                  : '{i18n>firstname}',
                Value                  : user.firstName,
                ![@Common.FieldControl]: #ReadOnly,
            },
            {
                $Type                  : 'UI.DataField',
                Label                  : '{i18n>lastname}',
                Value                  : user.lastName,
                ![@Common.FieldControl]: #ReadOnly,
            },
            {
                $Type                  : 'UI.DataField',
                Label                  : '{i18n>department}',
                Value                  : user.department,
                ![@Common.FieldControl]: #ReadOnly,
            },
            {
                $Type                  : 'UI.DataField',
                Label                  : '{i18n>email}',
                Value                  : user.email,
                ![@Common.FieldControl]: #ReadOnly,
            }
        ],
        PresentationVariant: {SortOrder: [{
            $Type     : 'Common.SortOrderType',
            Property  : user_userId,
            Descending: false
        }]},

    },
    UI       : {
        HeaderInfo             : {
            Title         : {
                $Type: 'UI.DataField',
                Value: user_userId
            },
            TypeName      : '{i18n>user}',
            TypeNamePlural: '{i18n>user}',
            Description   : {Value: user_userId}
        },
        FieldGroup #Description: {Data: [
            {
                $Type: 'UI.DataField',
                Label: '{i18n>userId}',
                Value: user_userId,
            },
            {
                $Type                  : 'UI.DataField',
                Label                  : '{i18n>firstname}',
                Value                  : user.firstName,
                ![@Common.FieldControl]: #ReadOnly,
                ![@UI.Importance]      : #High
            },
            {
                $Type                  : 'UI.DataField',
                Label                  : '{i18n>lastname}',
                Value                  : user.lastName,
                ![@Common.FieldControl]: #ReadOnly,
                ![@UI.Importance]      : #High
            },
            {
                $Type                  : 'UI.DataField',
                Label                  : '{i18n>department}',
                Value                  : user.department,
                ![@Common.FieldControl]: #ReadOnly,
                ![@UI.Importance]      : #High
            },
            {
                $Type                  : 'UI.DataField',
                Label                  : '{i18n>email}',
                Value                  : user.email,
                ![@Common.FieldControl]: #ReadOnly,
                ![@UI.Importance]      : #High
            },
        ]}

    },
    // Page Facets
    UI.Facets: [{
        $Type : 'UI.CollectionFacet',
        ID    : 'UsersEventsDetails',
        Label : '{i18n>details}',
        Facets: [{
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>details}',
            Target: '@UI.FieldGroup#Description'
        }]
    }]
);

annotate service.UsersEvents with {
    ID @Common.Text: user_userId
};

annotate service.UserEntity with {
    username @Common.FieldControl : #ReadOnly
};
