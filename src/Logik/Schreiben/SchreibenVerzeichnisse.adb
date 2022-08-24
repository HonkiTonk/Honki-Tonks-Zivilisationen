pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Directories; use Ada.Directories;

with Warnung;
with Fehler;

package body SchreibenVerzeichnisse is

   procedure SchreibenVerzeichnisse
   is begin
      
      SchreibeGrafikVerzeichnisse;
      SchreibeAudioVerzeichnisse;
      SchreibeSonstigeVerzeichnisse;
      
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
            Warnung.LogikWarnung (WarnmeldungExtern => "SchreibenVerzeichnisse.SchreibeGrafikVerzeichnisse - Grafik erstellt.");
      end case;
      
      case
        Exists (Name => "Grafik/Bauwerke")
      is
         when True =>
            null;

         when False =>
            Create_Directory (New_Directory => "Grafik/Bauwerke");
            Warnung.LogikWarnung (WarnmeldungExtern => "SchreibenVerzeichnisse.SchreibeGrafikVerzeichnisse - Bauwerke erstellt.");
      end case;
      
      case
        Exists (Name => "Grafik/Einheiten")
      is
         when True =>
            null;

         when False =>
            Create_Directory (New_Directory => "Grafik/Einheiten");
            Warnung.LogikWarnung (WarnmeldungExtern => "SchreibenVerzeichnisse.SchreibeGrafikVerzeichnisse - Einheiten erstellt.");
      end case;
      
      case
        Exists (Name => "Grafik/Hintergrund")
      is
         when True =>
            null;

         when False =>
            Create_Directory (New_Directory => "Grafik/Hintergrund");
            Warnung.LogikWarnung (WarnmeldungExtern => "SchreibenVerzeichnisse.SchreibeGrafikVerzeichnisse - Hintergrund erstellt.");
      end case;
      
      case
        Exists (Name => "Grafik/Kartenfelder")
      is
         when True =>
            null;

         when False =>
            Create_Directory (New_Directory => "Grafik/Kartenfelder");
            Warnung.LogikWarnung (WarnmeldungExtern => "SchreibenVerzeichnisse.SchreibeGrafikVerzeichnisse - Kartenfelder erstellt.");
      end case;
      
      case
        Exists (Name => "Grafik/Kartenfluss")
      is
         when True =>
            null;

         when False =>
            Create_Directory (New_Directory => "Grafik/Kartenfluss");
            Warnung.LogikWarnung (WarnmeldungExtern => "SchreibenVerzeichnisse.SchreibeGrafikVerzeichnisse - Kartenfluss erstellt.");
      end case;
      
      case
        Exists (Name => "Grafik/Kartenressourcen")
      is
         when True =>
            null;

         when False =>
            Create_Directory (New_Directory => "Grafik/Kartenressourcen");
            Warnung.LogikWarnung (WarnmeldungExtern => "SchreibenVerzeichnisse.SchreibeGrafikVerzeichnisse - Kartenressourcen erstellt.");
      end case;
      
      case
        Exists (Name => "Grafik/Verbesserungen")
      is
         when True =>
            null;

         when False =>
            Create_Directory (New_Directory => "Grafik/Verbesserungen");
            Warnung.LogikWarnung (WarnmeldungExtern => "SchreibenVerzeichnisse.SchreibeGrafikVerzeichnisse - Verbesserungen erstellt.");
      end case;
      
      case
        Exists (Name => "Grafik/Wege")
      is
         when True =>
            null;

         when False =>
            Create_Directory (New_Directory => "Grafik/Wege");
            Warnung.LogikWarnung (WarnmeldungExtern => "SchreibenVerzeichnisse.SchreibeGrafikVerzeichnisse - Wege erstellt.");
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
            Warnung.LogikWarnung (WarnmeldungExtern => "SchreibenVerzeichnisse.SchreibeAudioVerzeichnisse - Audio erstellt.");
      end case;
      
      case
        Exists (Name => "Audio/Musik")
      is
         when True =>
            null;

         when False =>
            Create_Directory (New_Directory => "Audio/Musik");
            Warnung.LogikWarnung (WarnmeldungExtern => "SchreibenVerzeichnisse.SchreibeAudioVerzeichnisse - Musik erstellt.");
      end case;
      
      case
        Exists (Name => "Audio/Sound")
      is
         when True =>
            null;

         when False =>
            Create_Directory (New_Directory => "Audio/Sound");
            Warnung.LogikWarnung (WarnmeldungExtern => "SchreibenVerzeichnisse.SchreibeAudioVerzeichnisse - Sound erstellt.");
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
            Fehler.LogikFehler (FehlermeldungExtern => "SchreibenVerzeichnisse.SchreibeSonstigeVerzeichnisse - Sprachen nicht vorhanden.");
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
        Exists (Name => "Datenbanken")
      is
         when True =>
            null;

         when False =>
            Create_Directory (New_Directory => "Datenbanken");
      end case;
      
   end SchreibeSonstigeVerzeichnisse;

end SchreibenVerzeichnisse;
