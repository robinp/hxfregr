package fregr.client;

import fregr.common.Settings;

class Client {

   public function new() {
   }

   public function finished() {
      // bye-bye world
      var sock = new flash.net.Socket("127.0.0.1", Settings.PORT);
   }

}
