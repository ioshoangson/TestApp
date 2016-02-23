# TestApp

Have 2 ways to solve the test
- Socket programming
- Sync from backend

Solution:
- Using PubNub to set up registered listener event from Appdelegate
- When the user created a account will be sent post a message to handle load new user
- Using Pub to broadcast a message to all devices registered listener event
- The message format is info of user object that created previous step
- Handle broadcast message from Pub, get object user from message
- Add to first index of array and reload data in first row.

Requiment:
- Have to test on 2 devices
- Have been connected to internet
- User some third party:
+ PubNub: realtime mobile SDK
+ SDWebImage: category to load and cache image
+ MBProcessHUD: animation HUD when request to server
+ SVPullToRefresh: pull to refresh with block
