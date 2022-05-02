pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Directories; use Ada.Directories;

with Warnung;

package body SchreibenVerzeichnisse is

   procedure SchreibenVerzeichnisse
   is begin
      
      SchreibeGrafikVerzeichnisse;
      SchreibeAudioVerzeichnisse;
      SchreibeSonstigeVerzeichnisse;
      
   end SchreibenVerzeichnisse;
   
   
   
   ------------------------ Das hier mal ein wenig anpassen, was welche Meldung gibt.
   procedure SchreibeGrafikVerzeichnisse
   is begin
      
      case
        Exists (Name => "Grafik")
      is
         when True =>
            null;

         when False =>
            Create_Directory (New_Directory => "Grafik");
            Warnung.LogikWarnung (WarnmeldungExtern => "SchreibenVerzeichnisse.SchreibeGrafikVerzeichnisse - Ordner Grafik wurde erstellt.");
      end case;
      
      case
        Exists (Name => "Grafik/Kartenfelder")
      is
         when True =>
            null;

         when False =>
            Create_Directory (New_Directory => "Grafik/Kartenfelder");
            Warnung.LogikWarnung (WarnmeldungExtern => "SchreibenVerzeichnisse.SchreibeGrafikVerzeichnisse - Ordner Grafik/Kartenfelder wurde erstellt.");
      end case;
      
      case
        Exists (Name => "Grafik/Verbesserungen")
      is
         when True =>
            null;

         when False =>
            Create_Directory (New_Directory => "Grafik/Verbesserungen");
            Warnung.LogikWarnung (WarnmeldungExtern => "SchreibenVerzeichnisse.SchreibeGrafikVerzeichnisse - Ordner Grafik/Verbesserungen wurde erstellt.");
      end case;
      
      case
        Exists (Name => "Grafik/Einheiten")
      is
         when True =>
            null;

         when False =>
            Create_Directory (New_Directory => "Grafik/Einheiten");
            Warnung.LogikWarnung (WarnmeldungExtern => "SchreibenVerzeichnisse.SchreibeGrafikVerzeichnisse - Ordner Grafik/Einheiten wurde erstellt.");
      end case;
      
      case
        Exists (Name => "Grafik/Bauwerke")
      is
         when True =>
            null;

         when False =>
            Create_Directory (New_Directory => "Grafik/Bauwerke");
            Warnung.LogikWarnung (WarnmeldungExtern => "SchreibenVerzeichnisse.SchreibeGrafikVerzeichnisse - Ordner Grafik/Bauwerke wurde erstellt.");
      end case;
      
      case
        Exists (Name => "Grafik/Hintergrund")
      is
         when True =>
            null;

         when False =>
            Create_Directory (New_Directory => "Grafik/Hintergrund");
            Warnung.LogikWarnung (WarnmeldungExtern => "SchreibenVerzeichnisse.SchreibeGrafikVerzeichnisse - Ordner Grafik/Hintergrund wurde erstellt.");
      end case;
      
   end SchreibeGrafikVerzeichnisse;
   
   
   
   procedure SchreibeAudioVerzeichnisse
   is begin
      
      case
        Exists (Name => "Audio")
      is
         when True =>
            null;

         when False =>
            Create_Directory (New_Directory => "Audio");
            Warnung.LogikWarnung (WarnmeldungExtern => "SchreibenVerzeichnisse.SchreibeAudioVerzeichnisse - Ordner Audio wurde erstellt.");
      end case;
      
      case
        Exists (Name => "Audio/Musik")
      is
         when True =>
            null;

         when False =>
            Create_Directory (New_Directory => "Audio/Musik");
            Warnung.LogikWarnung (WarnmeldungExtern => "SchreibenVerzeichnisse.SchreibeAudioVerzeichnisse - Ordner Audio/Musik wurde erstellt.");
      end case;
      
      case
        Exists (Name => "Audio/Sound")
      is
         when True =>
            null;

         when False =>
            Create_Directory (New_Directory => "Audio/Sound");
            Warnung.LogikWarnung (WarnmeldungExtern => "SchreibenVerzeichnisse.SchreibeAudioVerzeichnisse - Ordner Audio/Sound wurde erstellt.");
      end case;
      
   end SchreibeAudioVerzeichnisse;
   
   
   
   procedure SchreibeSonstigeVerzeichnisse
   is begin
      
      case
        Exists (Name => "Sprachen")
      is
         when True =>
            null;
            
         when False =>
            ----------------------- Hier auch eine Fehlermeldung einbauen? Ohne Vorhandene Sprachen kann ja nichts angezeigt werden. Oder deutsch als festgelegten Standard einbauen? 
            Create_Directory (New_Directory => "Sprachen");
            Warnung.LogikWarnung (WarnmeldungExtern => "SchreibenVerzeichnisse.SchreibeSonstigeVerzeichnisse - Ordner Sprachen wurde erstellt.");
      end case;
      
      case
        Exists (Name => "Spielstand")
      is
         when True =>
            null;

         when False =>
            Create_Directory (New_Directory => "Spielstand");
      end case;
      
      case
        Exists (Name => "Einstellungen")
      is
         when True =>
            null;

         when False =>
            Create_Directory (New_Directory => "Einstellungen");
      end case;
      
      case
        Exists (Name => "Datenbanken")
      is
         when True =>
            null;

         when False =>
            Create_Directory (New_Directory => "Datenbanken");
      end case;
      
   end SchreibeSonstigeVerzeichnisse;

end SchreibenVerzeichnisse;
