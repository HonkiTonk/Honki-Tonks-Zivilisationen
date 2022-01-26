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
      
      -- Erstellung eines Grafik- oder Soundordners ist sinnfrei, da das Programm ja keine Grafiken/Sounds generieren kann.
      case
        Exists (Name => "Grafik")
      is
         when True =>
            null;

         when False =>
            Create_Directory (New_Directory => "Datenbanken");
            -- Später wieder Fehlermeldung einbauen, aktuell aber eher störend.
            -- Fehler.LogikStopp (FehlermeldungExtern => "SchreibenVerzeichnisse.SchreibenVerzeichnisse - Grafikverzeichnis nicht vorhanden.");
      end case;
      
      case
        Exists (Name => "Audio")
      is
         when True =>
            null;

         when False =>
            Create_Directory (New_Directory => "Audio");
            -- Später wieder Fehlermeldung einbauen, aktuell aber eher störend.
            -- Fehler.LogikStopp (FehlermeldungExtern => "SchreibenVerzeichnisse.SchreibenVerzeichnisse - Audioverzeichnis nicht vorhanden.");
      end case;
      
      case
        Exists (Name => "Audio/Musik")
      is
         when True =>
            null;

         when False =>
            Create_Directory (New_Directory => "Audio/Musik");
            -- Später wieder Fehlermeldung einbauen, aktuell aber eher störend.
            -- Fehler.LogikStopp (FehlermeldungExtern => "SchreibenVerzeichnisse.SchreibenVerzeichnisse - Musikverzeichnis nicht vorhanden.");
      end case;
      
      case
        Exists (Name => "Audio/Sound")
      is
         when True =>
            null;

         when False =>
            Create_Directory (New_Directory => "Audio/Sound");
            -- Später wieder Fehlermeldung einbauen, aktuell aber eher störend.
            -- Fehler.LogikStopp (FehlermeldungExtern => "SchreibenVerzeichnisse.SchreibenVerzeichnisse - Soundverzeichnis nicht vorhanden.");
      end case;
      
   end SchreibenVerzeichnisse;

end SchreibenVerzeichnisse;
