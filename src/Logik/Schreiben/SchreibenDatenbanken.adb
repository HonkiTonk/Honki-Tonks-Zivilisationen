pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Directories; use Ada.Directories;

with EinheitenDatenbank;
with ForschungenDatenbank;
with GebaeudeDatenbank;
with KartengrundDatenbank;
with VerbesserungenDatenbank;
with RassenDatenbank;
with KartenflussDatenbank;
with KartenressourcenDatenbank;

package body SchreibenDatenbanken is
   
   procedure SchreibenAlleDatenbanken
   is begin
      
      SchreibenEinheitenDatenbank;
      SchreibenForschungenDatenbank;
      SchreibenGebäudeDatenbank;
      SchreibenKartenDatenbanken;
      SchreibenVerbesserungenDatenbank;
      SchreibenRassenDatenbank;
      
   end SchreibenAlleDatenbanken;
   
   
   
   procedure SchreibenEinheitenDatenbank
   is begin
      
      case
        Exists (Name => "Datenbanken/EinheitenDatenbank")
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
        Exists (Name => "Datenbanken/ForschungenDatenbank")
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
        Exists (Name => "Datenbanken/GebaeudeDatenbank")
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
   
   
   
   procedure SchreibenKartenDatenbanken
   is begin
      
      case
        Exists (Name => "Datenbanken/KartenGrundDatenbank")
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
      
      KartengrundDatenbank.KartengrundlisteArray'Write (Stream (File => DatenbankSpeichern),
                                                   KartengrundDatenbank.Kartengrundliste);
      
      Close (File => DatenbankSpeichern);
      
      
      
      case
        Exists (Name => "Datenbanken/KartenFlussDatenbank")
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
      
      KartenflussDatenbank.KartenflusslisteArray'Write (Stream (File => DatenbankSpeichern),
                                                   KartenflussDatenbank.Kartenflussliste);
      
      Close (File => DatenbankSpeichern);
      
      
      
      case
        Exists (Name => "Datenbanken/KartenRessourcenDatenbank")
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
      
      KartenressourcenDatenbank.KartenressourcenListeArray'Write (Stream (File => DatenbankSpeichern),
                                                        KartenressourcenDatenbank.KartenressourcenListe);
      
      Close (File => DatenbankSpeichern);
      
   end SchreibenKartenDatenbanken;
   
   
   
   procedure SchreibenVerbesserungenDatenbank
   is begin
      
      case
        Exists (Name => "Datenbanken/VerbesserungenDatenbank")
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
      
      VerbesserungenDatenbank.VerbesserungenlisteArray'Write (Stream (File => DatenbankSpeichern),
                                                              VerbesserungenDatenbank.Verbesserungenliste);
      
      Close (File => DatenbankSpeichern);
      
      
      
      case
        Exists (Name => "Datenbanken/WegeDatenbank")
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
      
      VerbesserungenDatenbank.WegelisteArray'Write (Stream (File => DatenbankSpeichern),
                                                    VerbesserungenDatenbank.Wegeliste);
      
      Close (File => DatenbankSpeichern);
      
   end SchreibenVerbesserungenDatenbank;
   
   
   
   procedure SchreibenRassenDatenbank
   is begin
      
      case
        Exists (Name => "Datenbanken/RassenDatenbank")
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
      
      RassenDatenbank.RassenlisteArray'Write (Stream (File => DatenbankSpeichern),
                                              RassenDatenbank.Rassenliste);
      
      Close (File => DatenbankSpeichern);
      
   end SchreibenRassenDatenbank;

end SchreibenDatenbanken;
