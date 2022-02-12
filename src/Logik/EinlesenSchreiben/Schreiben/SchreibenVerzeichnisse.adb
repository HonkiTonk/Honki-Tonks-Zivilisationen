pragma SPARK_Mode (On);

with Ada.Directories; use Ada.Directories;

package body SchreibenVerzeichnisse is

   procedure SchreibenVerzeichnisse
   is begin
      
      -- Überall noch eine Meldung einbauen dass die Verzeichnisse erzeugt wurden, sie sollten ja theoretisch von Anfang an vorhanden sein.
      SchreibeGrafikVerzeichnisse;
      SchreibeAudioVerzeichnisse;
      SchreibeSonstigesVerzeichnisse;
      
   end SchreibenVerzeichnisse;
   
   
   
   procedure SchreibeGrafikVerzeichnisse
   is begin
      
      case
        Exists (Name => "Grafik")
      is
         when True =>
            null;

         when False =>
            Create_Directory (New_Directory => "Grafik");
      end case;
      
      case
        Exists (Name => "Grafik/Kartenfelder")
      is
         when True =>
            null;

         when False =>
            Create_Directory (New_Directory => "Grafik/Kartenfelder");
      end case;
      
      case
        Exists (Name => "Grafik/Einheiten")
      is
         when True =>
            null;

         when False =>
            Create_Directory (New_Directory => "Grafik/Einheiten");
      end case;
      
      case
        Exists (Name => "Grafik/Bauwerke")
      is
         when True =>
            null;

         when False =>
            Create_Directory (New_Directory => "Grafik/Bauwerke");
      end case;
      
      case
        Exists (Name => "Grafik/Hintergrund")
      is
         when True =>
            null;

         when False =>
            Create_Directory (New_Directory => "Grafik/Hintergrund");
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
      end case;
      
      case
        Exists (Name => "Audio/Musik")
      is
         when True =>
            null;

         when False =>
            Create_Directory (New_Directory => "Audio/Musik");
      end case;
      
      case
        Exists (Name => "Audio/Sound")
      is
         when True =>
            null;

         when False =>
            Create_Directory (New_Directory => "Audio/Sound");
      end case;
      
   end SchreibeAudioVerzeichnisse;
   
   
   
   procedure SchreibeSonstigesVerzeichnisse
   is begin
      
      case
        Exists (Name => "Sprachen")
      is
         when True =>
            null;
            
         when False =>
            -- Hier auch eine Fehlermeldung einbauen? Ohne Vorhandene Sprachen kann ja nichts angezeigt werden. Oder deutsch als festgelegten Standard einbauen?
            Create_Directory (New_Directory => "Sprachen");
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
      
   end SchreibeSonstigesVerzeichnisse;

end SchreibenVerzeichnisse;
