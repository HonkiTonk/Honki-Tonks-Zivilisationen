pragma SPARK_Mode (On);

with Ada.Directories; use Ada.Directories;

with GlobaleVariablen;
with SystemDatentypen;

with EingabeKonsole;
with EingabeSFML;
with Eingabe;

package body EinlesenTastatur is

   procedure EinlesenTastaturbelegung
   is begin
      
      case
        GlobaleVariablen.AnzeigeArt
      is
         when SystemDatentypen.Konsole =>
            BelegungKonsole;
            
         when SystemDatentypen.SFML | SystemDatentypen.Beides =>
            BelegungSFML;
      end case;
      
   end EinlesenTastaturbelegung;
   
   
   
   procedure BelegungKonsole
   is begin
      
      case
        Exists (Name => "Einstellungen/TastenbelegungKonsole")
      is
         when True =>
            Open (File => TastenbelegungLaden,
                  Mode => In_File,
                  Name => "Einstellungen/TastenbelegungKonsole");

         when False =>
            Eingabe.StandardTastenbelegungLaden;
            return;
      end case;
      
      EingabeKonsole.TastenbelegungArray'Read (Stream (File => TastenbelegungLaden),
                                               EingabeKonsole.Tastenbelegung);
      
      Close (File => TastenbelegungLaden);
      
   end BelegungKonsole;
   
   
   
   procedure BelegungSFML
   is begin
      
      case
        Exists (Name => "Einstellungen/TastenbelegungSFML")
      is
         when True =>
            Open (File => TastenbelegungLaden,
                  Mode => In_File,
                  Name => "Einstellungen/TastenbelegungSFML");

         when False =>
            Eingabe.StandardTastenbelegungLaden;
            return;
      end case;
      
      EingabeSFML.TastenbelegungArray'Read (Stream (File => TastenbelegungLaden),
                                            EingabeSFML.Tastenbelegung);
      
      Close (File => TastenbelegungLaden);
      
   end BelegungSFML;

end EinlesenTastatur;
