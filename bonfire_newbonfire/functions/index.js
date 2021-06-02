/*var onTech = require('./src/tech');
var onNature = require('./src/nature');

exports.onTech = onTech.onTechCreated;
exports.onNature = onNature.onNatureCreated;
*/

const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

const db = admin.firestore();

// 1) TECHNOLOGY
exports.onTechCreated = functions.firestore
    .document("/Tech/bf_tech/usersTech/{userId}")
    .onCreate(async (snapshot, context) => {
        console.log("Tech created")
        const userId = context.params.userId;

        //1) get the userId and retrieve userData
        const userData = db.collection("Users");
        const userSnap = await userData.get();

        //2) Create user into followings collection
        const addUserToFollowing = db.collection("FollowingTech").doc(userId);

        userSnap.forEach(doc => {
            if(doc.exists) {
            const _userData = doc.data();
            addUserToFollowing.set(_userData);
            }
        });

        //3) Get Posts and TODO: Filter where or orderBy to gte the ones with a specific label of the subcategory
            const followedUserPostsRef = db
              .collection("Posts")
              .doc(userId)
              .collection("userPosts").where("category", "==", "Technology");

        //Get users Posts data
        const querySnapshot = await followedUserPostsRef.get();
        //Create following user's timeline ref
            const timelinePostsRef = db
              .collection("TimelineTech")
              .doc("time_tech")
              .collection("timelinePosts");

        // 4) Add each user post to following user's timeline
            querySnapshot.forEach(doc => {
              if (doc.exists) {
                const postId = doc.id;
                const postData = doc.data();
                timelinePostsRef.doc(postId).set(postData).orderBy("timestamp", "desc");
              }
            });

    });

// when a post is created, add post to timeline of each follower (of post owner)
exports.onCreateTechPost = functions.firestore
  .document("/Posts/{userId}/userPosts/{postId}")
  .onCreate(async (snapshot, context) => {
    const postCreated = snapshot.data();
    const userId = context.params.userId;
    const postId = context.params.postId;

    //TODO: Add "where" category == "Tech"
     //3) Get Posts and TODO: Filter where or orderBy to gte the ones with a specific label of the subcategory
            const followedUserPostsRef = db
              .collection("Posts")
              .doc(userId)
              .collection("userPosts").where("category", "==", "Technology");

        //Get users Posts data
        const querySnapshot = await followedUserPostsRef.get();
        //Create following user's timeline ref
            const timelinePostsRef = db
              .collection("TimelineTech")
              .doc("time_tech")
              .collection("timelinePosts");

        // 4) Add each user post to following user's timeline
            querySnapshot.forEach(doc => {
              if (doc.exists) {
                const postId = doc.id;
                const postData = doc.data();
                timelinePostsRef.doc(postId).set(postData);
              }
            });
  });

  exports.onDeleteTechPost = functions.firestore
    .document("/Posts/{userId}/userPosts/{postId}")
    .onDelete(async (snapshot, context) => {
      const userId = context.params.userId;
      const postId = context.params.postId;

           db
          .collection("TimelineTech")
          .doc("time_tech")
          .collection("timelinePosts")
          .doc(postId)
          .get()
          .then(doc => {
            if (doc.exists) {
              doc.ref.delete();
            }
          });
    });


// 2) NATURE
exports.onNatureCreated = functions.firestore
    .document("/Nature/bf_nat/usersNature/{userId}")
    .onCreate(async (snapshot, context) => {
        console.log("Nature created")
        const userId = context.params.userId;

        //1) get the userId and retrieve userData
        const userData = db.collection("Users");
        const userSnap = await userData.get();

        //2) Create user into followings collection
        const addUserToFollowing = db.collection("FollowingNature").doc(userId);

        userSnap.forEach(doc => {
            if(doc.exists) {
            const _userData = doc.data();
            addUserToFollowing.set(_userData);
            }
        });

        //3) Get Posts and TODO: Filter where or orderBy to gte the ones with a specific label of the subcategory
            const followedUserPostsRef = db
              .collection("Posts")
              .doc(userId)
              .collection("userPosts").where("category", "==", "Nature");

        //Get users Posts data
        const querySnapshot = await followedUserPostsRef.get();
        //Create following user's timeline ref
            const timelinePostsRef = db
              .collection("TimelineNat")
              .doc("time_nature")
              .collection("timelinePosts");

        // 4) Add each user post to following user's timeline
            querySnapshot.forEach(doc => {
              if (doc.exists) {
                const postId = doc.id;
                const postData = doc.data();
                timelinePostsRef.doc(postId).set(postData).orderBy("timestamp", "desc");
              }
            });

    });

exports.onCreateNaturePost = functions.firestore
  .document("/Posts/{userId}/userPosts/{postId}")
  .onCreate(async (snapshot, context) => {
    const postCreated = snapshot.data();
    const userId = context.params.userId;
    const postId = context.params.postId;

    //TODO: Add "where" category == "Tech"
     //3) Get Posts and TODO: Filter where or orderBy to gte the ones with a specific label of the subcategory
            const followedUserPostsRef = db
              .collection("Posts")
              .doc(userId)
              .collection("userPosts").where("category", "==", "Nature");

        //Get users Posts data
        const querySnapshot = await followedUserPostsRef.get();
        //Create following user's timeline ref
            const timelinePostsRef = db
              .collection("TimelineNat")
              .doc("time_nature")
              .collection("timelinePosts");

        // 4) Add each user post to following user's timeline
            querySnapshot.forEach(doc => {
              if (doc.exists) {
                const postId = doc.id;
                const postData = doc.data();
                timelinePostsRef.doc(postId).set(postData);
              }
            });
  });

  exports.onDeleteNaturePost = functions.firestore
    .document("/Posts/{userId}/userPosts/{postId}")
    .onDelete(async (snapshot, context) => {
      const userId = context.params.userId;
      const postId = context.params.postId;

           db
          .collection("TimelineNat")
          .doc("time_nature")
          .collection("timelinePosts")
          .doc(postId)
          .get()
          .then(doc => {
            if (doc.exists) {
              doc.ref.delete();
            }
          });
    });


// 3) HEALTH
exports.onHealthCreated = functions.firestore
    .document("/Health/bf_health/usersHealth/{userId}")
    .onCreate(async (snapshot, context) => {
        console.log("Health created")
        const userId = context.params.userId;

        //1) get the userId and retrieve userData
        const userData = db.collection("Users");
        const userSnap = await userData.get();

        //2) Create user into followings collection
        const addUserToFollowing = db.collection("FollowingHealth").doc(userId);

        userSnap.forEach(doc => {
            if(doc.exists) {
            const _userData = doc.data();
            addUserToFollowing.set(_userData);
            }
        });

        //3) Get Posts and TODO: Filter where or orderBy to gte the ones with a specific label of the subcategory
            const followedUserPostsRef = db
              .collection("Posts")
              .doc(userId)
              .collection("userPosts").where("category", "==", "Health");

        //Get users Posts data
        const querySnapshot = await followedUserPostsRef.get();
        //Create following user's timeline ref
            const timelinePostsRef = db
              .collection("TimelineHealth")
              .doc("time_health")
              .collection("timelinePosts");

        // 4) Add each user post to following user's timeline
            querySnapshot.forEach(doc => {
              if (doc.exists) {
                const postId = doc.id;
                const postData = doc.data();
                timelinePostsRef.doc(postId).set(postData).orderBy("timestamp", "desc");
              }
            });

    });

exports.onCreateHealthPost = functions.firestore
  .document("/Posts/{userId}/userPosts/{postId}")
  .onCreate(async (snapshot, context) => {
    const postCreated = snapshot.data();
    const userId = context.params.userId;
    const postId = context.params.postId;

    //TODO: Add "where" category == "Tech"
     //3) Get Posts and TODO: Filter where or orderBy to gte the ones with a specific label of the subcategory
            const followedUserPostsRef = db
              .collection("Posts")
              .doc(userId)
              .collection("userPosts").where("category", "==", "Health");

        //Get users Posts data
        const querySnapshot = await followedUserPostsRef.get();
        //Create following user's timeline ref
            const timelinePostsRef = db
              .collection("TimelineHealth")
              .doc("time_health")
              .collection("timelinePosts");

        // 4) Add each user post to following user's timeline
            querySnapshot.forEach(doc => {
              if (doc.exists) {
                const postId = doc.id;
                const postData = doc.data();
                timelinePostsRef.doc(postId).set(postData);
              }
            });
  });

  exports.onDeleteHealthPost = functions.firestore
    .document("/Posts/{userId}/userPosts/{postId}")
    .onDelete(async (snapshot, context) => {
      const userId = context.params.userId;
      const postId = context.params.postId;

           db
          .collection("TimelineHealth")
          .doc("time_health")
          .collection("timelinePosts")
          .doc(postId)
          .get()
          .then(doc => {
            if (doc.exists) {
              doc.ref.delete();
            }
          });
    });