const cds = require('@sap/cds');

module.exports = cds.service.impl(async function() {

    
    const bupa = await cds.connect.to('PLTUserManagement');

    this.on('READ', 'UserEntity', async req => {
        return bupa.run(req.query);
    });

    this.on("READ", ['UsersEvents', 'UsersEvents.drafts'], async (req, next) => {
        if (!req.query.SELECT.columns) return next();
        const expandIndex = req.query.SELECT.columns.findIndex(
            ({ expand, ref }) => expand && ref[0] === "user"
        );
        if (expandIndex < 0) return next();

        req.query.SELECT.columns.splice(expandIndex, 1);

        if (!req.query.SELECT.columns.indexOf('*') >= 0 &&
            !req.query.SELECT.columns.find(
                column => column.ref && column.ref.find((ref) => ref == "user_userId"))
        ) {
            req.query.SELECT.columns.push({ ref: ["user_userId"] });
        }

        const usersEvents = await next();

        const asArray = x => Array.isArray(x) ? x : [ x ];

        const userIds = asArray(usersEvents).map(userEvent => userEvent.user_userId);
        const users = userIds.length ? await bupa.run(SELECT.from('PLTUserManagement.User').where({ userId: userIds })) : [];

        const usersMap = {};
        for (const user of users)
            usersMap[user.userId] = user;

        for (const note of asArray(usersEvents)) {
            note.user = usersMap[note.user_userId];
        }

        return usersEvents;
    });

    this.before(['CREATE', 'UPDATE'], 'Event', async req => {
        const startDateTime = new Date(req.data.startDateTime);
        const endDateTime = new Date(req.data.endDateTime);

        if (startDateTime < new Date()) {
            throw new Error('Start date cannot be in the past');
        }

        if (startDateTime > endDateTime) {
            throw new Error('Start date cannot be after end date');
        }

        return req;
    })

});