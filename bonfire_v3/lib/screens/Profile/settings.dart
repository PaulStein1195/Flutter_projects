
/*
AuthProvider _auth;

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(41, 39, 40, 150.0),
      appBar: AppBar(
        elevation: 1.0,
        title: Text("Settings"),
        centerTitle: true,
      ),
      body: ChangeNotifierProvider<AuthProvider>.value(
        value: AuthProvider.instance,
        child: Builder(
          builder: (BuildContext context) {
            var _auth = Provider.of<AuthProvider>(context);
            return StreamBuilder<User>(
              stream: DBService.instance.getUserData(_auth.user.uid),
              builder: (context, snapshot) {
                var _userData = snapshot.data;
                if (!snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: kAmberColor,
                      ),
                    ),
                  );
                }
                return SingleChildScrollView(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _auth.logoutUser(() {});
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.exit_to_app,
                                    size: 25.0,
                                    color: Colors.white70 //kBottomNavigationBar,
                                    ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: Text(
                                    "LOG OUT",
                                    style: TextStyle(
                                        fontSize: 16.5, color: Colors.white),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Divider(color: Colors.blueGrey,),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
*/