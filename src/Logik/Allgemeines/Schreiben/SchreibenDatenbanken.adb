pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Directories; use Ada.Directories;

with EinheitenDatenbank;
with ForschungenDatenbank;
with GebaeudeDatenbank;
with KartenDatenbank;
with VerbesserungenDatenbank;
with RassenDatenbank;

package body SchreibenDatenbanken is
   
   procedure SchreibenAlleDatenbanken
   is begin
      
      SchreibenEinheitenDatenbank;
      SchreibenForschungenDatenbank;
      SchreibenGebäudeDatenbank;
      SchreibenKartenDatenbank;
      SchreibenVerbesserungenDatenbank;
      SchreibenRassenDatenbank;
      
   end SchreibenAlleDatenbanken;
   
   
   
   procedure SchreibenEinheitenDatenbank
   is begin
      
      case
        Exists (Name => "Einstellungen/EinheitenDatenbank")
      is
         when True =>
            Open (File => DatenbankSpeichern,
                  Mode => Out_File,
                  Name => "Datenbanken/EinheitenDatenbank");
            
         when False =>
            Create (File => DatenbankSpeichern,
                    Mode => Out_File,
                    Name => "Datenbanken/EinheitenDatenbank");
      end case;
      
      EinheitenDatenbank.EinheitenlisteArray'Write (Stream (File => DatenbankSpeichern),
                                                    EinheitenDatenbank.Einheitenliste);
      
      Close (File => DatenbankSpeichern);
      
   end SchreibenEinheitenDatenbank;
   
   
   
   procedure SchreibenForschungenDatenbank
   is begin
      
      case
        Exists (Name => "Einstellungen/ForschungenDatenbank")
      is
         when True =>
            Open (File => DatenbankSpeichern,
                  Mode => Out_File,
                  Name => "Datenbanken/ForschungenDatenbank");
            
         when False =>
            Create (File => DatenbankSpeichern,
                    Mode => Out_File,
                    Name => "Datenbanken/ForschungenDatenbank");
      end case;
      
      ForschungenDatenbank.ForschungslisteArray'Write (Stream (File => DatenbankSpeichern),
                                                     ForschungenDatenbank.Forschungsliste);
      
      Close (File => DatenbankSpeichern);
      
   end SchreibenForschungenDatenbank;
   
   
   
   procedure SchreibenGebäudeDatenbank
   is begin
      
      case
        Exists (Name => "Einstellungen/GebaeudeDatenbank")
      is
         when True =>
            Open (File => DatenbankSpeichern,
                  Mode => Out_File,
                  Name => "Datenbanken/GebaeudeDatenbank");
            
         when False =>
            Create (File => DatenbankSpeichern,
                    Mode => Out_File,
                    Name => "Datenbanken/GebaeudeDatenbank");
      end case;
      
      GebaeudeDatenbank.GebäudelisteArray'Write (Stream (File => DatenbankSpeichern),
                                                  GebaeudeDatenbank.Gebäudeliste);
      
      Close (File => DatenbankSpeichern);
      
   end SchreibenGebäudeDatenbank;
   
   
   
   procedure SchreibenKartenDatenbank
   is begin
      
      case
        Exists (Name => "Einstellungen/KartenGrundDatenbank")
      is
         when True =>
            Open (File => DatenbankSpeichern,
                  Mode => Out_File,
                  Name => "Datenbanken/KartenGrundDatenbank");
            
         when False =>
            Create (File => DatenbankSpeichern,
                    Mode => Out_File,
                    Name => "Datenbanken/KartenGrundDatenbank");
      end case;
      
      KartenDatenbank.KartengrundlisteArray'Write (Stream (File => DatenbankSpeichern),
                                                   KartenDatenbank.Kartengrundliste);
      
      Close (File => DatenbankSpeichern);
      
      
      
      case
        Exists (Name => "Einstellungen/KartenFlussDatenbank")
      is
         when True =>
            Open (File => DatenbankSpeichern,
                  Mode => Out_File,
                  Name => "Datenbanken/KartenFlussDatenbank");
            
         when False =>
            Create (File => DatenbankSpeichern,
                    Mode => Out_File,
                    Name => "Datenbanken/KartenFlussDatenbank");
      end case;
      
      KartenDatenbank.KartenflusslisteArray'Write (Stream (File => DatenbankSpeichern),
                                                   KartenDatenbank.Kartenflussliste);
      
      Close (File => DatenbankSpeichern);
      
      
      
      case
        Exists (Name => "Einstellungen/KartenRessourcenDatenbank")
      is
         when True =>
            Open (File => DatenbankSpeichern,
                  Mode => Out_File,
                  Name => "Datenbanken/KartenRessourcenDatenbank");
            
         when False =>
            Create (File => DatenbankSpeichern,
                    Mode => Out_File,
                    Name => "Datenbanken/KartenRessourcenDatenbank");
      end case;
      
      KartenDatenbank.KartenRessourcenListeArray'Write (Stream (File => DatenbankSpeichern),
                                                        KartenDatenbank.KartenRessourcenListe);
      
      Close (File => DatenbankSpeichern);
      
   end SchreibenKartenDatenbank;
   
   
   
   procedure SchreibenVerbesserungenDatenbank
   is begin
      
      case
        Exists (Name => "Einstellungen/VerbesserungenDatenbank")
      is
         when True =>
            Open (File => DatenbankSpeichern,
                  Mode => Out_File,
                  Name => "Datenbanken/VerbesserungenDatenbank");
            
         when False =>
            Create (File => DatenbankSpeichern,
                    Mode => Out_File,
                    Name => "Datenbanken/VerbesserungenDatenbank");
      end case;
      
      VerbesserungenDatenbank.VerbesserungenListeArray'Write (Stream (File => DatenbankSpeichern),
                                                              VerbesserungenDatenbank.VerbesserungenListe);
      
      Close (File => DatenbankSpeichern);
      
      
      
      case
        Exists (Name => "Einstellungen/WegeDatenbank")
      is
         when True =>
            Open (File => DatenbankSpeichern,
                  Mode => Out_File,
                  Name => "Datenbanken/WegeDatenbank");
            
         when False =>
            Create (File => DatenbankSpeichern,
                    Mode => Out_File,
                    Name => "Datenbanken/WegeDatenbank");
      end case;
      
      VerbesserungenDatenbank.WegeListeArray'Write (Stream (File => DatenbankSpeichern),
                                                    VerbesserungenDatenbank.WegeListe);
      
      Close (File => DatenbankSpeichern);
      
   end SchreibenVerbesserungenDatenbank;
   
   
   
   procedure SchreibenRassenDatenbank
   is begin
      
      case
        Exists (Name => "Einstellungen/RassenDatenbank")
      is
         when True =>
            Open (File => DatenbankSpeichern,
                  Mode => Out_File,
                  Name => "Datenbanken/RassenDatenbank");
            
         when False =>
            Create (File => DatenbankSpeichern,
                    Mode => Out_File,
                    Name => "Datenbanken/RassenDatenbank");
      end case;
      
      RassenDatenbank.RassenListeArray'Write (Stream (File => DatenbankSpeichern),
                                              RassenDatenbank.RassenListe);
      
      Close (File => DatenbankSpeichern);
      
   end SchreibenRassenDatenbank;

end SchreibenDatenbanken;
