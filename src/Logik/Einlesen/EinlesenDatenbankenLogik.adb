with Ada.Directories; use Ada.Directories;

with VerzeichnisKonstanten;

with KartenDatenbank;
with VerbesserungenDatenbank;

with StandardVerbesserungenDatenbank;
with StandardSpeziesDatenbank;
with StandardKartenDatenbank;
with StandardGebaeudeDatenbank;
with StandardForschungenDatenbank;
with StandardEinheitenDatenbank;

-- Alle Datenbanken müssen vor dem Einlesen ebenfalls geprüft werden. äöü
package body EinlesenDatenbankenLogik is
   
   procedure AlleDatenbanken
   is begin
      
      Einheiten;
      Forschungen;
      Gebäude;
      Kartengrund;
      Verbesserungen;
      Spezies;
      
   end AlleDatenbanken;
   
   

   procedure Einheiten
   is begin
      
      case
        Exists (Name => VerzeichnisKonstanten.EinheitenDatenbank)
      is
         when False =>
            StandardEinheitenDatenbank.StandardEinheitenDatenbankLaden;
            return;
            
         when True =>
            Open (File => DatenbankEinlesen,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.EinheitenDatenbank);
            
            PrüfungErfolgreich := EinheitenDurchgehen (LadenPrüfenExtern => False);
      
            Close (File => DatenbankEinlesen);
      end case;
      
      case
        PrüfungErfolgreich
      is
         when True =>
            Open (File => DatenbankEinlesen,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.EinheitenDatenbank);
            
            Nullwert := EinheitenDurchgehen (LadenPrüfenExtern => True);
      
            Close (File => DatenbankEinlesen);
            
         when False =>
            StandardEinheitenDatenbank.StandardEinheitenDatenbankLaden;
      end case;
      
   end Einheiten;
   
   
   
   function EinheitenDurchgehen
     (LadenPrüfenExtern : in Boolean)
      return Boolean
   is begin
      
      EinheitenDatenbank.EinheitenlisteArray'Read (Stream (File => DatenbankEinlesen),
                                                   Einheitenliste);
      
      case
        LadenPrüfenExtern
      is
         when False =>
            null;
            
         when True =>
            EinheitenDatenbank.Einheitenliste := Einheitenliste;
      end case;
      
      return True;
      
   exception
      when Constraint_Error | End_Error =>
         return False;
         
   end EinheitenDurchgehen;
   
   
   
   procedure Forschungen
   is begin
      
      case
        Exists (Name => VerzeichnisKonstanten.ForschungenDatenbank)
      is
         when False =>
            StandardForschungenDatenbank.StandardForschungenDatenbankLaden;
            return;
            
         when True =>
            Open (File => DatenbankEinlesen,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.ForschungenDatenbank);
      
            PrüfungErfolgreich := ForschungenDurchgehen (LadenPrüfenExtern => False);
      
            Close (File => DatenbankEinlesen);
      end case;
      
      case
        PrüfungErfolgreich
      is
         when True =>
            Open (File => DatenbankEinlesen,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.ForschungenDatenbank);
            
            Nullwert := ForschungenDurchgehen (LadenPrüfenExtern => True);
      
            Close (File => DatenbankEinlesen);
            
         when False =>
            StandardForschungenDatenbank.StandardForschungenDatenbankLaden;
      end case;
      
   end Forschungen;
   
   
   
   function ForschungenDurchgehen
     (LadenPrüfenExtern : in Boolean)
      return Boolean
   is begin
   
      ForschungenDatenbank.ForschungslisteArray'Read (Stream (File => DatenbankEinlesen),
                                                      Forschungsliste);
      
      ForschungRecordKonstanten.TechnologieVerbesserungenArray'Read (Stream (File => DatenbankEinlesen),
                                                                     Verbesserungsforschung);
      
      ForschungRecordKonstanten.TechnologieWegeArray'Read (Stream (File => DatenbankEinlesen),
                                                           Wegeforschung);
      
      ForschungRecordKonstanten.TechnologieUmgebungsgrößeArray'Read (Stream (File => DatenbankEinlesen),
                                                                       Umgebungsforschung);
      
      case
        LadenPrüfenExtern
      is
         when False =>
            null;
            
         when True =>
            ForschungenDatenbank.Forschungsliste := Forschungsliste;
            ForschungenDatenbank.TechnologieVerbesserungen := Verbesserungsforschung;
            ForschungenDatenbank.TechnologieWege := Wegeforschung;
            ForschungenDatenbank.TechnologieUmgebungsgröße := Umgebungsforschung;
      end case;
      
      return True;
      
   exception
      when Constraint_Error | End_Error =>
         return False;
         
   end ForschungenDurchgehen;
   
   
   
   procedure Gebäude
   is begin
      
      case
        Exists (Name => VerzeichnisKonstanten.GebaeudeDatenbank)
      is
         when False =>
            StandardGebaeudeDatenbank.StandardGebaeudeDatenbankLaden;
            return;
            
         when True =>
            Open (File => DatenbankEinlesen,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.GebaeudeDatenbank);
            
            PrüfungErfolgreich := GebäudeDurchgehen (LadenPrüfenExtern => False);
      
            Close (File => DatenbankEinlesen);
      end case;
      
      case
        PrüfungErfolgreich
      is
         when True =>
            Open (File => DatenbankEinlesen,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.GebaeudeDatenbank);
            
            Nullwert := GebäudeDurchgehen (LadenPrüfenExtern => True);
      
            Close (File => DatenbankEinlesen);
            
         when False =>
            StandardGebaeudeDatenbank.StandardGebaeudeDatenbankLaden;
      end case;
      
   end Gebäude;
   
   
   
   function GebäudeDurchgehen
     (LadenPrüfenExtern : in Boolean)
      return Boolean
   is begin
      
      GebaeudeDatenbank.GebäudelisteArray'Read (Stream (File => DatenbankEinlesen),
                                                 Gebäudeliste);
   
      case
        LadenPrüfenExtern
      is
         when False =>
            null;
            
         when True =>
            GebaeudeDatenbank.Gebäudeliste := Gebäudeliste;
      end case;
      
      return True;
      
   exception
      when Constraint_Error | End_Error =>
         return False;
         
   end GebäudeDurchgehen;


   
   procedure Kartengrund
   is begin
      
      case
        Exists (Name => VerzeichnisKonstanten.BasisgrundDatenbank)
      is
         when True =>
            Open (File => DatenbankEinlesen,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.BasisgrundDatenbank);
      
            KartenDatenbank.BasisgrundlisteArray'Read (Stream (File => DatenbankEinlesen),
                                                       KartenDatenbank.Basisgrundliste);
      
            Close (File => DatenbankEinlesen);

         when False =>
            StandardKartenDatenbank.StandardBasisgrundDatenbankLaden;
      end case;
      
      case
        Exists (Name => VerzeichnisKonstanten.ZusatzgrundDatenbank)
      is
         when True =>
            Open (File => DatenbankEinlesen,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.ZusatzgrundDatenbank);
      
            KartenDatenbank.ZusatzgrundlisteArray'Read (Stream (File => DatenbankEinlesen),
                                                        KartenDatenbank.Zusatzgrundliste);
      
            Close (File => DatenbankEinlesen);

         when False =>
            StandardKartenDatenbank.StandardZusatzgrundDatenbankLaden;
      end case;
      
      case
        Exists (Name => VerzeichnisKonstanten.KartenFlussDatenbank)
      is
         when True =>
            Open (File => DatenbankEinlesen,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.KartenFlussDatenbank);
      
            KartenDatenbank.KartenflusslisteArray'Read (Stream (File => DatenbankEinlesen),
                                                        KartenDatenbank.Kartenflussliste);
      
            Close (File => DatenbankEinlesen);

         when False =>
            StandardKartenDatenbank.StandardKartenflussDatenbankLaden;
      end case;
      
      case
        Exists (Name => VerzeichnisKonstanten.KartenDatenbank)
      is
         when True =>
            Open (File => DatenbankEinlesen,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.KartenDatenbank);
      
            KartenDatenbank.KartenressourcenlisteArray'Read (Stream (File => DatenbankEinlesen),
                                                             KartenDatenbank.Kartenressourcenliste);
      
            Close (File => DatenbankEinlesen);

         when False =>
            StandardKartenDatenbank.StandardKartenressourcenDatenbankLaden;
      end case;
      
   end Kartengrund;
   
   
   
   procedure Verbesserungen
   is begin
      
      case
        Exists (Name => VerzeichnisKonstanten.VerbesserungenDatenbank)
      is
         when True =>
            Open (File => DatenbankEinlesen,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.VerbesserungenDatenbank);
      
            VerbesserungenDatenbank.VerbesserungenlisteArray'Read (Stream (File => DatenbankEinlesen),
                                                                   VerbesserungenDatenbank.Verbesserungenliste);
      
            Close (File => DatenbankEinlesen);

         when False =>
            StandardVerbesserungenDatenbank.StandardVerbesserungenDatenbankLaden;
      end case;
      
      case
        Exists (Name => VerzeichnisKonstanten.WegeDatenbank)
      is
         when True =>
            Open (File => DatenbankEinlesen,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.WegeDatenbank);
      
            VerbesserungenDatenbank.WegelisteArray'Read (Stream (File => DatenbankEinlesen),
                                                         VerbesserungenDatenbank.Wegeliste);
      
            Close (File => DatenbankEinlesen);

         when False =>
            StandardVerbesserungenDatenbank.StandardWegeDatenbankLaden;
      end case;
      
   end Verbesserungen;
   
   
   
   procedure Spezies
   is begin
      
      case
        Exists (Name => VerzeichnisKonstanten.SpeziesDatenbank)
      is
         when False =>
            StandardSpeziesDatenbank.StandardSpeziesDatenbankLaden;
            return;
            
         when True =>
            Open (File => DatenbankEinlesen,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.SpeziesDatenbank);
      
            PrüfungErfolgreich := SpeziesDurchgehen (LadenPrüfenExtern => False);
      
            Close (File => DatenbankEinlesen);
      end case;
      
      case
        PrüfungErfolgreich
      is
         when True =>
            Open (File => DatenbankEinlesen,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.SpeziesDatenbank);
      
            Nullwert := SpeziesDurchgehen (LadenPrüfenExtern => True);
      
            Close (File => DatenbankEinlesen);
            
         when False =>
            StandardSpeziesDatenbank.StandardSpeziesDatenbankLaden;
      end case;
      
   end Spezies;
      
   
   
   function SpeziesDurchgehen
     (LadenPrüfenExtern : in Boolean)
      return Boolean
   is begin
      
      SpeziesDatenbank.SpezieslisteArray'Read (Stream (File => DatenbankEinlesen),
                                               Speziesliste);
   
      case
        LadenPrüfenExtern
      is
         when False =>
            null;
            
         when True =>
            SpeziesDatenbank.Speziesliste := Speziesliste;
      end case;
      
      return True;
      
   exception
      when Constraint_Error | End_Error =>
         return False;
         
   end SpeziesDurchgehen;

end EinlesenDatenbankenLogik;
