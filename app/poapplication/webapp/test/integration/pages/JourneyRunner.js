sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"poapplication/test/integration/pages/POSrvList.gen",
	"poapplication/test/integration/pages/POSrvObjectPage.gen",
	"poapplication/test/integration/pages/POItemSrvObjectPage.gen"
], function (JourneyRunner, POSrvListGenerated, POSrvObjectPageGenerated, POItemSrvObjectPageGenerated) {
    'use strict';

    const runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('poapplication') + '/test/flp.html#app-preview',
        pages: {
			onThePOSrvListGenerated: POSrvListGenerated,
			onThePOSrvObjectPageGenerated: POSrvObjectPageGenerated,
			onThePOItemSrvObjectPageGenerated: POItemSrvObjectPageGenerated
        },
        async: true
    });

    return runner;
});

