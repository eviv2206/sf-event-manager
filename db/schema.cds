using { managed, cuid, temporal } from '@sap/cds/common';
using { PLTUserManagement as PUM } from '../srv/external/PLTUserManagement.cds';

namespace sap.capire.eventmanager;


entity UserEntity as projection on PUM.User {
    key userId,
    username,
    firstName,
    lastName,
    email,
    department
}

entity EventType {
    key name : String;
}

@odata.draft.enabled : true
entity Event : cuid, managed {
    name: String not null;
    description: String not null;
    eventType: Association to one EventType not null;
    startDateTime: DateTime not null;
    endDateTime: DateTime not null;
    users: Composition of many UsersEvents on users.event = $self;
}


entity UsersEvents: cuid {
    user: Association to UserEntity;
    event: Association to Event;
}

