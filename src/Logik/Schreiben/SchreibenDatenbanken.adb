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
with TextKonstanten;

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
        Exists (Name => TextKonstanten.EinheitenDatenbank)
      is
         when True =>
            Open (File => DatenbankSpeichern,
                  Mode => Out_File,
                  Name => TextKonstanten.EinheitenDatenbank);
            
         when False =>
            Create (File => DatenbankSpeichern,
                    Mode => Out_File,
                    Name => TextKonstanten.EinheitenDatenbank);
      end case;
      
      EinheitenDatenbank.EinheitenlisteArray'Write (Stream (File => DatenbankSpeichern),
                                                    EinheitenDatenbank.Einheitenliste);
      
      Close (File => DatenbankSpeichern);
      
   end SchreibenEinheitenDatenbank;
   
   
   
   procedure SchreibenForschungenDatenbank
   is begin
      
      case
        Exists (Name => TextKonstanten.ForschungenDatenbank)
      is
         when True =>
            Open (File => DatenbankSpeichern,
                  Mode => Out_File,
                  Name => TextKonstanten.ForschungenDatenbank);
            
         when False =>
            Create (File => DatenbankSpeichern,
                    Mode => Out_File,
                    Name => TextKonstanten.ForschungenDatenbank);
      end case;
      
      ForschungenDatenbank.ForschungslisteArray'Write (Stream (File => DatenbankSpeichern),
                                                     ForschungenDatenbank.Forschungsliste);
      
      Close (File => DatenbankSpeichern);
      
   end SchreibenForschungenDatenbank;
   
   
   
   procedure SchreibenGebäudeDatenbank
   is begin
      
      case
        Exists (Name => TextKonstanten.GebaeudeDatenbank)
      is
         when True =>
            Open (File => DatenbankSpeichern,
                  Mode => Out_File,
                  Name => TextKonstanten.GebaeudeDatenbank);
            
         when False =>
            Create (File => DatenbankSpeichern,
                    Mode => Out_File,
                    Name => TextKonstanten.GebaeudeDatenbank);
      end case;
      
      GebaeudeDatenbank.GebäudelisteArray'Write (Stream (File => DatenbankSpeichern),
                                                  GebaeudeDatenbank.Gebäudeliste);
      
      Close (File => DatenbankSpeichern);
      
   end SchreibenGebäudeDatenbank;
   
   
   
   procedure SchreibenKartenDatenbanken
   is begin
      
      case
        Exists (Name => TextKonstanten.KartenGrundDatenbank)
      is
         when True =>
            Open (File => DatenbankSpeichern,
                  Mode => Out_File,
                  Name => TextKonstanten.KartenGrundDatenbank);
            
         when False =>
            Create (File => DatenbankSpeichern,
                    Mode => Out_File,
                    Name => TextKonstanten.KartenGrundDatenbank);
      end case;
      
      KartengrundDatenbank.KartengrundlisteArray'Write (Stream (File => DatenbankSpeichern),
                                                   KartengrundDatenbank.Kartengrundliste);
      
      Close (File => DatenbankSpeichern);
      
      
      
      case
        Exists (Name => TextKonstanten.KartenFlussDatenbank)
      is
         when True =>
            Open (File => DatenbankSpeichern,
                  Mode => Out_File,
                  Name => TextKonstanten.KartenFlussDatenbank);
            
         when False =>
            Create (File => DatenbankSpeichern,
                    Mode => Out_File,
                    Name => TextKonstanten.KartenFlussDatenbank);
      end case;
      
      KartenflussDatenbank.KartenflusslisteArray'Write (Stream (File => DatenbankSpeichern),
                                                   KartenflussDatenbank.Kartenflussliste);
      
      Close (File => DatenbankSpeichern);
      
      
      
      case
        Exists (Name => TextKonstanten.KartenRessourcenDatenbank)
      is
         when True =>
            Open (File => DatenbankSpeichern,
                  Mode => Out_File,
                  Name => TextKonstanten.KartenRessourcenDatenbank);
            
         when False =>
            Create (File => DatenbankSpeichern,
                    Mode => Out_File,
                    Name => TextKonstanten.KartenRessourcenDatenbank);
      end case;
      
      KartenressourcenDatenbank.KartenressourcenListeArray'Write (Stream (File => DatenbankSpeichern),
                                                        KartenressourcenDatenbank.KartenressourcenListe);
      
      Close (File => DatenbankSpeichern);
      
   end SchreibenKartenDatenbanken;
   
   
   
   procedure SchreibenVerbesserungenDatenbank
   is begin
      
      case
        Exists (Name => TextKonstanten.VerbesserungenDatenbank)
      is
         when True =>
            Open (File => DatenbankSpeichern,
                  Mode => Out_File,
                  Name => TextKonstanten.VerbesserungenDatenbank);
            
         when False =>
            Create (File => DatenbankSpeichern,
                    Mode => Out_File,
                    Name => TextKonstanten.VerbesserungenDatenbank);
      end case;
      
      VerbesserungenDatenbank.VerbesserungenlisteArray'Write (Stream (File => DatenbankSpeichern),
                                                              VerbesserungenDatenbank.Verbesserungenliste);
      
      Close (File => DatenbankSpeichern);
      
      
      
      case
        Exists (Name => TextKonstanten.WegeDatenbank)
      is
         when True =>
            Open (File => DatenbankSpeichern,
                  Mode => Out_File,
                  Name => TextKonstanten.WegeDatenbank);
            
         when False =>
            Create (File => DatenbankSpeichern,
                    Mode => Out_File,
                    Name => TextKonstanten.WegeDatenbank);
      end case;
      
      VerbesserungenDatenbank.WegelisteArray'Write (Stream (File => DatenbankSpeichern),
                                                    VerbesserungenDatenbank.Wegeliste);
      
      Close (File => DatenbankSpeichern);
      
   end SchreibenVerbesserungenDatenbank;
   
   
   
   procedure SchreibenRassenDatenbank
   is begin
      
      case
        Exists (Name => TextKonstanten.RassenDatenbank)
      is
         when True =>
            Open (File => DatenbankSpeichern,
                  Mode => Out_File,
                  Name => TextKonstanten.RassenDatenbank);
            
         when False =>
            Create (File => DatenbankSpeichern,
                    Mode => Out_File,
                    Name => TextKonstanten.RassenDatenbank);
      end case;
      
      RassenDatenbank.RassenlisteArray'Write (Stream (File => DatenbankSpeichern),
                                              RassenDatenbank.Rassenliste);
      
      Close (File => DatenbankSpeichern);
      
   end SchreibenRassenDatenbank;

end SchreibenDatenbanken;
