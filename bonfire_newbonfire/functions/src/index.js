const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();


exports.onCreateFollower = functions.firestore
  .document("/Dogs/bf_Id/usersNature/{userId}")
  .onCreate(async (snapshot, context) => {
    console.log("Follower Created", snapshot.id);
    const userId = context.params.userId;
    //const bf_Id = context.params.bf_Id;

    // 1) Create followed users posts ref
    const followedUserPostsRef = admin
      .firestore()
      .collection("Posts")
      .doc(userId)
      .collection("userPosts");

    // 2) Create following user's timeline ref
    const timelinePostsRef = admin
      .firestore()
      .collection("Timeline")
      .doc(userId)
      .collection("timelinePosts");

    // 3) Get followed users posts
    const querySnapshot = await followedUserPostsRef.get();

    // 4) Add each user post to following user's timeline
    querySnapshot.forEach(doc => {
      if (doc.exists) {
        const postId = doc.id;
        const postData = doc.data();
        timelinePostsRef.doc(postId).set(postData);
      }
    });
  });
