pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Directories; use Ada.Directories;

with EinheitenDatenbank;
with ForschungenDatenbank;
with GebaeudeDatenbank;
with KartenDatenbank;
with VerbesserungenDatenbank;
with RassenDatenbank;
with VerzeichnisKonstanten;
with ForschungKonstanten;

-- Die Datenbanken wieder einzeln schreiben, damit die Editoren sie auch einzeln schreiben können. äöü
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
   -- Gilt auch für alle Schreibevorgänge. äöü
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
      
      ForschungKonstanten.TechnologieVerbesserungenArray'Write (Stream (File => DatenbankSpeichern),
                                                                ForschungenDatenbank.TechnologieVerbesserungen);
      
      ForschungKonstanten.TechnologieWegeArray'Write (Stream (File => DatenbankSpeichern),
                                                      ForschungenDatenbank.TechnologieWege);
      
      ForschungKonstanten.TechnologieUmgebungsgrößeArray'Write (Stream (File => DatenbankSpeichern),
                                                                  ForschungenDatenbank.TechnologieUmgebungsgröße);
      
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
      
      KartenDatenbank.KartengrundlisteArray'Write (Stream (File => DatenbankSpeichern),
                                                   KartenDatenbank.Kartengrundliste);
      
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
      
      KartenDatenbank.KartenflusslisteArray'Write (Stream (File => DatenbankSpeichern),
                                                   KartenDatenbank.Kartenflussliste);
      
      Close (File => DatenbankSpeichern);
      
      
      
      case
        Exists (Name => VerzeichnisKonstanten.KartenDatenbank)
      is
         when True =>
            Open (File => DatenbankSpeichern,
                  Mode => Out_File,
                  Name => VerzeichnisKonstanten.KartenDatenbank);
            
         when False =>
            Create (File => DatenbankSpeichern,
                    Mode => Out_File,
                    Name => VerzeichnisKonstanten.KartenDatenbank);
      end case;
      
      KartenDatenbank.KartenressourcenlisteArray'Write (Stream (File => DatenbankSpeichern),
                                                        KartenDatenbank.Kartenressourcenliste);
      
      Close (File => DatenbankSpeichern);
      
   end SchreibenKartenDatenbanken;
   
   
   
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
