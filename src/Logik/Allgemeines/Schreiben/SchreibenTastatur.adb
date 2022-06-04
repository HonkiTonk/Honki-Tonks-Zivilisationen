pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Directories; use Ada.Directories;

with OptionenVariablen;
with GrafikDatentypen;

with EingabeTerminal;
with EingabeSFML;

package body SchreibenTastatur is

   procedure TastenbelegungSchreiben
   is begin
      
      case
        OptionenVariablen.NutzerEinstellungen.Anzeigeart
      is
         when GrafikDatentypen.Grafik_Terminal_Enum =>
            BelegungTerminal;
            
         when GrafikDatentypen.Grafik_SFML_Enum =>
            BelegungSFML;
      end case;
      
   end TastenbelegungSchreiben;
   
   
   
   procedure BelegungTerminal
   is begin
            
      case
        Exists (Name => "Einstellungen/TastenbelegungTerminal")
      is
         when True =>
            Open (File => TastenbelegungSpeichern,
                  Mode => Out_File,
                  Name => "Einstellungen/TastenbelegungTerminal");
            
         when False =>
            Create (File => TastenbelegungSpeichern,
                    Mode => Out_File,
                    Name => "Einstellungen/TastenbelegungTerminal");
      end case;
      
      EingabeTerminal.TastenbelegungArray'Write (Stream (File => TastenbelegungSpeichern),
                                                EingabeTerminal.Tastenbelegung);
      
      Close (File => TastenbelegungSpeichern);
      
   end BelegungTerminal;
   
   
   
   procedure BelegungSFML
   is begin
      
      case
        Exists (Name => "Einstellungen/TastenbelegungSFML")
      is
         when True =>
            Open (File => TastenbelegungSpeichern,
                  Mode => Out_File,
                  Name => "Einstellungen/TastenbelegungSFML");
            
         when False =>
            Create (File => TastenbelegungSpeichern,
                    Mode => Out_File,
                    Name => "Einstellungen/TastenbelegungSFML");
      end case;
      
      EingabeSFML.TastenbelegungArray'Write (Stream (File => TastenbelegungSpeichern),
                                             EingabeSFML.Tastenbelegung);
      
      Close (File => TastenbelegungSpeichern);
      
   end BelegungSFML;

end SchreibenTastatur;
