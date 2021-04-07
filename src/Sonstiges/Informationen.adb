pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO, Ada.Characters.Wide_Wide_Latin_9;
use Ada.Wide_Wide_Text_IO, Ada.Characters.Wide_Wide_Latin_9;

package body Informationen is

   procedure Informationen
   is begin

      Put (Item => CSI & "2J" & CSI & "3J" & CSI & "H");
      
      Put_Line (Item => "Aktuelle Version:");
      Put_Line (Item => Versionsnummer);
      New_Line;

      Put_Line (Item => "Die aktuelle Version des Source Codes gibt es auf:");
      Put_Line (Item => "https://github.com/HonkiTonk/Civ-Klon");
      New_Line;

      Put_Line (Item => "Livestream Channels:");
      Put_Line (Item => "https://gaming.youtube.com/user/tpHonkiTonk/live");
      Put_Line (Item => "https://www.twitch.tv/tphonkitonk");
      New_Line;
      
      Put_Line (Item => "Spendenmöglichkeiten:");
      Put_Line (Item => "https://www.tipeeestream.com/tphonkitonk/donation");
      Put_Line (Item => "http://www.amazon.de/registry/wishlist/2DNQHH9AI6JGR");
      Put_Line (Item => "http://steamcommunity.com/profiles/76561197989126693/wishlist/");
      New_Line;
      
      Put_Line (Item => "Meine Internetseite:");
      Put_Line (Item => "http://www.totalplanlos.de/");
      New_Line;
      
      Put_Line (Item => "Taste drücken um zurück ins Hauptmenü zu kommen.");
      Get_Immediate (Item => Taste);
      
   end Informationen;

end Informationen;
