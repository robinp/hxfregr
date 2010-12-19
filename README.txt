hxfregr - (very simple) regression testing for Haxe/Flash
---------------------------------------------------------

Aim

   To test the swf output of new Haxe releases against a variety of flash players

Usage

   1) Compile the server (tested with Haxe 2.06)
      
      haxe build-server.hxml

   2) Modify the build-client.hxml for your own need

   3) Compile any swf which calls new fregr.client.Client().finish() after 
      testing a few things, possibly using a different Haxe release

         HAXE_LIBRARY_PATH=/the/new/std /the/new/haxe build-client.hxml

   4) Create a file listing the standalone debug flash player executables

   5) Run the testing framework

         neko bin/fregr_server.n resource/player_list.txt bin/simple_client_swf9.swf


Sample player list file

   /usr/local/bin/dp9
   /usr/local/bin/dp9r115
   /usr/local/bin/dp9r124
   /usr/local/bin/dp9r151
   /usr/local/bin/dp9r152
   /usr/local/bin/dp9r159
   /usr/local/bin/dp9r227
   /usr/local/bin/dp9r246
   /usr/local/bin/dp9r260
   /usr/local/bin/dp9r262
   /usr/local/bin/dp101
   /usr/local/bin/dp101v2

Sample output

   ok      /usr/local/bin/dp9
   ok      /usr/local/bin/dp9r115
   ok      /usr/local/bin/dp9r124
   ok      /usr/local/bin/dp9r151
   ok      /usr/local/bin/dp9r152
   ok      /usr/local/bin/dp9r159
   ok      /usr/local/bin/dp9r227
   ok      /usr/local/bin/dp9r246
   ok      /usr/local/bin/dp9r260
   ok      /usr/local/bin/dp9r262
   fail    /usr/local/bin/dp101     <-- 15 secods waiting (timeout). You can lower the timeout in fregr.common.Settings, but not really recommended
   ok      /usr/local/bin/dp101v2

