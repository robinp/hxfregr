package fregr.server;

import neko.vm.Thread;
import neko.io.Process;
import neko.io.File;
import neko.Lib;
import neko.Sys;

import fregr.common.Settings;

using Lambda;

class HxFlashRegress {

   static function main() {
      var m = new HxFlashRegress();
      m.run();
   }

   function new() {
   }

   function run() {

      var args = Sys.args();
      
      if (args.length < 2) {
         Lib.print("Usage: fregr_server.n <player list file> <cli swf>\n");
         return;
      }

      var player_list = File.getContent(args[0]).split("\n")
            .map(StringTools.trim)
            .filter(function (s) return s.length > 0);

      var cli_swf = args[1];

      main_thread = Thread.current();
      comm_thread = Thread.create(runComm);

      for (player in player_list) {
         if (doTest(player, cli_swf)) {
            Lib.print("ok\t" + player + "\n");
         }
         else {
            Lib.print("fail\t" + player + "\n");
         }
      }

      Lib.print("Done");
   }

   function runComm() {
      sock = new neko.net.Socket();
      sock.bind(new neko.net.Host("127.0.0.1"), Settings.PORT);
      sock.listen(1);
      sock.setBlocking(false);

      while (Thread.readMessage(false) == null) {
         Sys.sleep(0.001);

         var peer : neko.net.Socket = null;
         try {
            peer = sock.accept();
         }
         catch (e: Dynamic) {
            // noone there yet
         }

         if (peer == null)
            continue;

         main_thread.sendMessage("connected");
         peer.close();
      }


   }

   function doTest(player_path, cli_swf): Bool {

      var proc = new Process(player_path, [cli_swf]);
      var start_time = Sys.time();

      var test_ok = false;
      while (!test_ok && Sys.time() - start_time < Settings.TIMEOUT) {
         Sys.sleep(0.001);

         if (Thread.readMessage(false) != null)
            test_ok = true;
      }

      proc.kill();

      return test_ok;
   }

   private var sock: neko.net.Socket;
   private var comm_thread: Thread;
   private var main_thread: Thread;

}
