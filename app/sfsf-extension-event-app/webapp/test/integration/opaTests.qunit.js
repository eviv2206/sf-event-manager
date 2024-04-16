sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'com/sap/event/app/sfsfextensioneventapp/test/integration/FirstJourney',
		'com/sap/event/app/sfsfextensioneventapp/test/integration/pages/EventList',
		'com/sap/event/app/sfsfextensioneventapp/test/integration/pages/EventObjectPage',
		'com/sap/event/app/sfsfextensioneventapp/test/integration/pages/UsersEventsObjectPage'
    ],
    function(JourneyRunner, opaJourney, EventList, EventObjectPage, UsersEventsObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('com/sap/event/app/sfsfextensioneventapp') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheEventList: EventList,
					onTheEventObjectPage: EventObjectPage,
					onTheUsersEventsObjectPage: UsersEventsObjectPage
                }
            },
            opaJourney.run
        );
    }
);