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
with VerzeichnisKonstanten;

package body SchreibenDatenbankenLogik is
   
   procedure SchreibenAlleDatenbanken
   is begin
      
      SchreibenEinheitenDatenbank;
      SchreibenForschungenDatenbank;
      SchreibenGebäudeDatenbank;
      SchreibenKartenDatenbanken;
      SchreibenVerbesserungenDatenbank;
      SchreibenRassenDatenbank;
      
   end SchreibenAlleDatenbanken;
   
   
   
   -- Schreibt Stream nicht eh immer alles neu und muss deswegen gar nicht auf Existenz geprüft werden? äöü
   -- Gilt auch für alle anderen Datenbanken. äöü
   procedure SchreibenEinheitenDatenbank
   is begin
      
      case
        Exists (Name => VerzeichnisKonstanten.EinheitenDatenbank)
      is
         when True =>
            Open (File => DatenbankSpeichern,
                  Mode => Out_File,
                  Name => VerzeichnisKonstanten.EinheitenDatenbank);
            
         when False =>
            Create (File => DatenbankSpeichern,
                    Mode => Out_File,
                    Name => VerzeichnisKonstanten.EinheitenDatenbank);
      end case;
      
      EinheitenDatenbank.EinheitenlisteArray'Write (Stream (File => DatenbankSpeichern),
                                                    EinheitenDatenbank.Einheitenliste);
      
      Close (File => DatenbankSpeichern);
      
   end SchreibenEinheitenDatenbank;
   
   
   
   procedure SchreibenForschungenDatenbank
   is begin
      
      case
        Exists (Name => VerzeichnisKonstanten.ForschungenDatenbank)
      is
         when True =>
            Open (File => DatenbankSpeichern,
                  Mode => Out_File,
                  Name => VerzeichnisKonstanten.ForschungenDatenbank);
            
         when False =>
            Create (File => DatenbankSpeichern,
                    Mode => Out_File,
                    Name => VerzeichnisKonstanten.ForschungenDatenbank);
      end case;
      
      ForschungenDatenbank.ForschungslisteArray'Write (Stream (File => DatenbankSpeichern),
                                                     ForschungenDatenbank.Forschungsliste);
      
      Close (File => DatenbankSpeichern);
      
   end SchreibenForschungenDatenbank;
   
   
   
   procedure SchreibenGebäudeDatenbank
   is begin
      
      case
        Exists (Name => VerzeichnisKonstanten.GebaeudeDatenbank)
      is
         when True =>
            Open (File => DatenbankSpeichern,
                  Mode => Out_File,
                  Name => VerzeichnisKonstanten.GebaeudeDatenbank);
            
         when False =>
            Create (File => DatenbankSpeichern,
                    Mode => Out_File,
                    Name => VerzeichnisKonstanten.GebaeudeDatenbank);
      end case;
      
      GebaeudeDatenbank.GebäudelisteArray'Write (Stream (File => DatenbankSpeichern),
                                                  GebaeudeDatenbank.Gebäudeliste);
      
      Close (File => DatenbankSpeichern);
      
   end SchreibenGebäudeDatenbank;
   
   
   
   -- Das mal in eine Datei zusammenfassen? äöü
   procedure SchreibenKartenDatenbanken
   is begin
      
      case
        Exists (Name => VerzeichnisKonstanten.KartenGrundDatenbank)
      is
         when True =>
            Open (File => DatenbankSpeichern,
                  Mode => Out_File,
                  Name => VerzeichnisKonstanten.KartenGrundDatenbank);
            
         when False =>
            Create (File => DatenbankSpeichern,
                    Mode => Out_File,
                    Name => VerzeichnisKonstanten.KartenGrundDatenbank);
      end case;
      
      KartengrundDatenbank.KartengrundlisteArray'Write (Stream (File => DatenbankSpeichern),
                                                   KartengrundDatenbank.Kartengrundliste);
      
      Close (File => DatenbankSpeichern);
      
      
      
      case
        Exists (Name => VerzeichnisKonstanten.KartenFlussDatenbank)
      is
         when True =>
            Open (File => DatenbankSpeichern,
                  Mode => Out_File,
                  Name => VerzeichnisKonstanten.KartenFlussDatenbank);
            
         when False =>
            Create (File => DatenbankSpeichern,
                    Mode => Out_File,
                    Name => VerzeichnisKonstanten.KartenFlussDatenbank);
      end case;
      
      KartenflussDatenbank.KartenflusslisteArray'Write (Stream (File => DatenbankSpeichern),
                                                   KartenflussDatenbank.Kartenflussliste);
      
      Close (File => DatenbankSpeichern);
      
      
      
      case
        Exists (Name => VerzeichnisKonstanten.KartenRessourcenDatenbank)
      is
         when True =>
            Open (File => DatenbankSpeichern,
                  Mode => Out_File,
                  Name => VerzeichnisKonstanten.KartenRessourcenDatenbank);
            
         when False =>
            Create (File => DatenbankSpeichern,
                    Mode => Out_File,
                    Name => VerzeichnisKonstanten.KartenRessourcenDatenbank);
      end case;
      
      KartenressourcenDatenbank.KartenressourcenlisteArray'Write (Stream (File => DatenbankSpeichern),
                                                        KartenressourcenDatenbank.Kartenressourcenliste);
      
      Close (File => DatenbankSpeichern);
      
   end SchreibenKartenDatenbanken;
   
   
   
   -- Das mal in eine Datei zusammenfassen? äöü
   procedure SchreibenVerbesserungenDatenbank
   is begin
      
      case
        Exists (Name => VerzeichnisKonstanten.VerbesserungenDatenbank)
      is
         when True =>
            Open (File => DatenbankSpeichern,
                  Mode => Out_File,
                  Name => VerzeichnisKonstanten.VerbesserungenDatenbank);
            
         when False =>
            Create (File => DatenbankSpeichern,
                    Mode => Out_File,
                    Name => VerzeichnisKonstanten.VerbesserungenDatenbank);
      end case;
      
      VerbesserungenDatenbank.VerbesserungenlisteArray'Write (Stream (File => DatenbankSpeichern),
                                                              VerbesserungenDatenbank.Verbesserungenliste);
      
      Close (File => DatenbankSpeichern);
      
      
      
      case
        Exists (Name => VerzeichnisKonstanten.WegeDatenbank)
      is
         when True =>
            Open (File => DatenbankSpeichern,
                  Mode => Out_File,
                  Name => VerzeichnisKonstanten.WegeDatenbank);
            
         when False =>
            Create (File => DatenbankSpeichern,
                    Mode => Out_File,
                    Name => VerzeichnisKonstanten.WegeDatenbank);
      end case;
      
      VerbesserungenDatenbank.WegelisteArray'Write (Stream (File => DatenbankSpeichern),
                                                    VerbesserungenDatenbank.Wegeliste);
      
      Close (File => DatenbankSpeichern);
      
   end SchreibenVerbesserungenDatenbank;
   
   
   
   procedure SchreibenRassenDatenbank
   is begin
      
      case
        Exists (Name => VerzeichnisKonstanten.RassenDatenbank)
      is
         when True =>
            Open (File => DatenbankSpeichern,
                  Mode => Out_File,
                  Name => VerzeichnisKonstanten.RassenDatenbank);
            
         when False =>
            Create (File => DatenbankSpeichern,
                    Mode => Out_File,
                    Name => VerzeichnisKonstanten.RassenDatenbank);
      end case;
      
      RassenDatenbank.RassenlisteArray'Write (Stream (File => DatenbankSpeichern),
                                              RassenDatenbank.Rassenliste);
      
      Close (File => DatenbankSpeichern);
      
   end SchreibenRassenDatenbank;

end SchreibenDatenbankenLogik;
