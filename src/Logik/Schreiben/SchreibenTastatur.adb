pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Directories; use Ada.Directories;

with GlobaleVariablen;
with GrafikDatentypen;

with EingabeKonsole;
with EingabeSFML;

package body SchreibenTastatur is

   procedure TastenbelegungSchreiben
   is begin
      
      case
        GlobaleVariablen.AnzeigeArt
      is
         when GrafikDatentypen.Grafik_Konsole_Enum =>
            BelegungKonsole;
            
         when GrafikDatentypen.Grafik_SFML_Enum =>
            BelegungSFML;
      end case;
      
   end TastenbelegungSchreiben;
   
   
   
   procedure BelegungKonsole
   is begin
            
      case
        Exists (Name => "Einstellungen/TastenbelegungKonsole")
      is
         when True =>
            Open (File => TastenbelegungSpeichern,
                  Mode => Out_File,
                  Name => "Einstellungen/TastenbelegungKonsole");
            
         when False =>
            Create (File => TastenbelegungSpeichern,
                    Mode => Out_File,
                    Name => "Einstellungen/TastenbelegungKonsole");
      end case;
      
      EingabeKonsole.TastenbelegungArray'Write (Stream (File => TastenbelegungSpeichern),
                                                EingabeKonsole.Tastenbelegung);
      
      Close (File => TastenbelegungSpeichern);
      
   end BelegungKonsole;
   
   
   
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
