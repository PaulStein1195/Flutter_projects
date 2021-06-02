const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

const db = admin.firestore();

exports.onBonfireCreated = functions.firestore
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

        //3) Get Posts and TODO: Filter where or orderBy to get the ones with a specific label of the subcategory
            const followedUserPostsRef = db
              .collection("Posts")
              .doc(userId)
              .collection("userPosts");

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
/*exports.onCreatePost = functions.firestore
  .document("/Posts/{userId}/userPosts/{postId}")
  .onCreate(async (snapshot, context) => {
    const postCreated = snapshot.data();
    const userId = context.params.userId;
    const postId = context.params.postId;

    //3) Get Posts and TODO: Filter where or orderBy to gte the ones with a specific label of the subcategory
    const followedUserPostsRef = db
      .collection("Posts")
      .doc(userId)
      .collection("userPosts");

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


  exports.onDeletePost = functions.firestore
  .document("/Posts/{userId}/userPosts/{postId}")
    .onDelete(async (snapshot, context) => {
      const userId = context.params.userId;
      const postId = context.params.postId;

       // 1) Get all the followers of the user who made the post
       const userFollowersRef = admin
         .firestore()
         .collection("FollowingTech")
          .doc(userId);

       const querySnapshot = await userFollowersRef.get();
       // 2) Delete each post in each follower's timeline
       querySnapshot.forEach(doc => {
         const followerId = doc.id;

         admin
           .firestore()
           .collection(TimelineTech)
           .doc("time_tech")
           .collection("timelinePosts")
           .doc(postId)
           .where("ownerId", "==", userId)
           .get()
           .then(doc => {
             if (doc.exists) {
               doc.ref.delete();
             }
           });
       });
     });
*/