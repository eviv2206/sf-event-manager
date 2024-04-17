using {sap.capire.eventmanager as my} from '../db/schema';


service EventService @(path: '/event') {

    entity UserEntity as projection on my.UserEntity;
    entity EventType as projection on my.EventType;

    entity Event @(restrict : [
            {
                grant : [ 'READ' ],
                to : [ 'EventViewer' ]
            },
            {
                grant : [ '*' ],
                to : [ 'EventManager' ]
            }
      ]) as projection on my.Event;

    entity UsersEvents as
        projection on my.UsersEvents {
            *, user: redirected to UserEntity, event: redirected to Event,
        }
        excluding {
            createdAt,
            createdBy,
            modifiedAt,
            modifiedBy
        };
}
