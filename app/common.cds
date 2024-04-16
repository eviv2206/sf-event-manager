using {sap.capire.eventmanager as my} from '../db/schema';

annotate my.Event with @(Capabilities: {
    InsertRestrictions: {Insertable: true, },
    FilterRestrictions: {FilterExpressionRestrictions: [
        {
            Property          : 'startDateTime',
            AllowedExpressions: 'SingleRange'
        },
        {
            Property          : 'endDateTime',
            AllowedExpressions: 'SingleRange'
        },
    ], }
}) {
    ID             @label: '{i18n>ID}'             @title: '{i18n>eventId}'           @mandatory;
    name           @label: '{i18n>name}'           @title: '{i18n>eventName}'         @mandatory;
    description    @label: '{i18n>description}'    @title: '{i18n>eventDescription}'  @mandatory  @UI.MultiLineText;
    eventType      @label: '{i18n>type}'           @title: '{i18n>eventType}'         @mandatory;
    startDateTime  @label: '{i18n>startDateTime}'  @title: '{i18n>eventDateTime}'     @mandatory;
    endDateTime    @label: '{i18n>endDateTime}'    @title: '{i18n>eventDateTime}'     @mandatory;
    users          @label: '{i18n>users}'          @title: '{i18n>eventUsers}';
};

annotate my.Event with @odata.draft.enabled;

annotate my.EventType with {
    name  @label: '{i18n>type}'  @title: '{i18n>eventType}';
}

annotate my.UserEntity with @(
    title             : '{i18n>user}',
    UI.TextArrangement: #TextOnly,
    cds.odata.valuelist,
    Common.SemanticKey: [userId],
    UI.Identification : [{
        $Type: 'UI.DataField',
        Value: userId

    }, ]
) {
    userId @(
        title                          : '{i18n>userId}',
        label                          : '{i18n>username}',
        Common.ValueListWithFixedValues: false,
        Common.ValueList               : {
            CollectionPath: 'UserEntity',
            Parameters    : [{
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: 'userId',
                ValueListProperty: 'userId'
            }]
        }
    );
};

annotate my.UsersEvents with {
    event @(
        Common.Text                    : event.name,
        Common.TextArrangement         : #TextOnly,
        title                          : '{i18n>event}',
        Common.ValueListWithFixedValues: false,
        Common.ValueList               : {
            CollectionPath: 'Event',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: 'event_ID',
                    ValueListProperty: 'ID'
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'name'
                },
            ]
        }
    );
    user  @(
        Common.Text                    : user.userId,
        Common.TextArrangement         : #TextOnly,
        title                          : '{i18n>user}',
        Common.ValueListWithFixedValues: false,
        Common.ValueList               : {
            CollectionPath: 'UserEntity',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: 'user_userId',
                    ValueListProperty: 'userId'
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'firstName'
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'lastName'
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'email'
                }
            ]
        }
    );
};
