pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Directories; use Ada.Directories;

with OptionenVariablen;
with GrafikDatentypen;

with EingabeKonsole;
with EingabeSFML;
with Eingabe;

package body EinlesenTastatur is

   procedure EinlesenTastaturbelegung
   is begin
      
      case
        OptionenVariablen.NutzerEinstellungen.Anzeigeart
      is
         when GrafikDatentypen.Grafik_Konsole_Enum =>
            BelegungKonsole;
            
         when GrafikDatentypen.Grafik_SFML_Enum =>
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
