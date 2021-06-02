const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

const db = admin.firestore();

exports.onUserCreated = functions.firestore.document("Users/{userId}").onCreate(async(snapshot, context) => {
    const userId = context.params.userId;
        //1) get the userId and retrieve userData
        const userData = db.collection("Users");
        const userSnap = await userData.get();

            const userRef = db.doc("Account/{userId}");
            return userRef.set({
                name: userId.name,
                createdAt: context.timestamp,
                email: userId.email
            });
});