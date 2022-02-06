pragma SPARK_Mode (On);

with Ada.Directories; use Ada.Directories;

-- with Fehler;

package body SchreibenVerzeichnisse is

   procedure SchreibenVerzeichnisse
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
      
      case
        Exists (Name => "Grafik")
      is
         when True =>
            null;

         when False =>
            Create_Directory (New_Directory => "Grafik");
            -- Statt einer Fehlermeldung könnte man auch einfach keine Texturen verwenden und die reinen Farbfelder anzeigen.
            -- Später wieder Fehlermeldung einbauen?
            -- Fehler.LogikStopp (FehlermeldungExtern => "SchreibenVerzeichnisse.SchreibenVerzeichnisse - Grafikverzeichnis nicht vorhanden.");
      end case;
      
      case
        Exists (Name => "Grafik/Kartenfelder")
      is
         when True =>
            null;

         when False =>
            Create_Directory (New_Directory => "Grafik/Kartenfelder");
            -- Statt einer Fehlermeldung könnte man auch einfach keine Texturen verwenden und die reinen Farbfelder anzeigen.
            -- Später wieder Fehlermeldung einbauen?
            -- Fehler.LogikStopp (FehlermeldungExtern => "SchreibenVerzeichnisse.SchreibenVerzeichnisse - Grafikverzeichnis nicht vorhanden.");
      end case;
      
      case
        Exists (Name => "Audio")
      is
         when True =>
            null;

         when False =>
            Create_Directory (New_Directory => "Audio");
            -- Statt einer Fehlermeldung könnte man auch einfach keine Audiodateien abspielen.
            -- Später wieder Fehlermeldung einbauen?
            -- Fehler.LogikStopp (FehlermeldungExtern => "SchreibenVerzeichnisse.SchreibenVerzeichnisse - Audioverzeichnis nicht vorhanden.");
      end case;
      
      case
        Exists (Name => "Audio/Musik")
      is
         when True =>
            null;

         when False =>
            Create_Directory (New_Directory => "Audio/Musik");
            -- Statt einer Fehlermeldung könnte man auch einfach keine Musik spielen.
            -- Später wieder Fehlermeldung einbauen?
            -- Fehler.LogikStopp (FehlermeldungExtern => "SchreibenVerzeichnisse.SchreibenVerzeichnisse - Musikverzeichnis nicht vorhanden.");
      end case;
      
      case
        Exists (Name => "Audio/Sound")
      is
         when True =>
            null;

         when False =>
            Create_Directory (New_Directory => "Audio/Sound");
            -- Statt einer Fehlermeldung könnte man auch einfach keine Sounds spielen.
            -- Später wieder Fehlermeldung einbauen?
            -- Fehler.LogikStopp (FehlermeldungExtern => "SchreibenVerzeichnisse.SchreibenVerzeichnisse - Soundverzeichnis nicht vorhanden.");
      end case;
      
   end SchreibenVerzeichnisse;

end SchreibenVerzeichnisse;
