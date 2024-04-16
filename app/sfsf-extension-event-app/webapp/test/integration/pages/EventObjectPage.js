sap.ui.define(['sap/fe/test/ObjectPage'], function(ObjectPage) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {},
        assertions: {}
    };

    return new ObjectPage(
        {
            appId: 'com.sap.event.app.sfsfextensioneventapp',
            componentId: 'EventObjectPage',
            contextPath: '/Event'
        },
        CustomPageDefinitions
    );
});