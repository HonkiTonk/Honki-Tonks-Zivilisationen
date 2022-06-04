pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Directories; use Ada.Directories;

with OptionenVariablen;
with GrafikDatentypen;

with EingabeTerminal;
with EingabeSFML;
with Eingabe;

package body EinlesenTastatur is

   procedure EinlesenTastaturbelegung
   is begin
      
      case
        OptionenVariablen.NutzerEinstellungen.Anzeigeart
      is
         when GrafikDatentypen.Grafik_Terminal_Enum =>
            BelegungTerminal;
            
         when GrafikDatentypen.Grafik_SFML_Enum =>
            BelegungSFML;
      end case;
      
   end EinlesenTastaturbelegung;
   
   
   
   procedure BelegungTerminal
   is begin
      
      case
        Exists (Name => "Einstellungen/TastenbelegungTerminal")
      is
         when True =>
            Open (File => TastenbelegungLaden,
                  Mode => In_File,
                  Name => "Einstellungen/TastenbelegungTerminal");

         when False =>
            Eingabe.StandardTastenbelegungLaden;
            return;
      end case;
      
      EingabeTerminal.TastenbelegungArray'Read (Stream (File => TastenbelegungLaden),
                                               EingabeTerminal.Tastenbelegung);
      
      Close (File => TastenbelegungLaden);
      
   end BelegungTerminal;
   
   
   
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
