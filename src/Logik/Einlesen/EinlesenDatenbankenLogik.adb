with Ada.Directories; use Ada.Directories;

with VerzeichnisKonstanten;

with StandardVerbesserungenDatenbank;
with StandardSpeziesDatenbank;
with StandardKartenDatenbank;
with StandardGebaeudeDatenbank;
with StandardForschungenDatenbank;
with StandardEinheitenDatenbank;

package body EinlesenDatenbankenLogik is
   
   procedure AlleDatenbanken
   is begin
      
      Einheiten;
      Forschungen;
      Gebäude;
      Karten;
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
                  Name => VerzeichnisKonstanten.EinheitenDatenbank,
                  Form => "WCEM=8");
            
            PrüfungErfolgreich := EinheitenDurchgehen (LadenPrüfenExtern => False);
      
            Close (File => DatenbankEinlesen);
      end case;
      
      case
        PrüfungErfolgreich
      is
         when True =>
            Open (File => DatenbankEinlesen,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.EinheitenDatenbank,
                  Form => "WCEM=8");
            
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
                  Name => VerzeichnisKonstanten.ForschungenDatenbank,
                  Form => "WCEM=8");
      
            PrüfungErfolgreich := ForschungenDurchgehen (LadenPrüfenExtern => False);
      
            Close (File => DatenbankEinlesen);
      end case;
      
      case
        PrüfungErfolgreich
      is
         when True =>
            Open (File => DatenbankEinlesen,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.ForschungenDatenbank,
                  Form => "WCEM=8");
            
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
                  Name => VerzeichnisKonstanten.GebaeudeDatenbank,
                  Form => "WCEM=8");
            
            PrüfungErfolgreich := GebäudeDurchgehen (LadenPrüfenExtern => False);
      
            Close (File => DatenbankEinlesen);
      end case;
      
      case
        PrüfungErfolgreich
      is
         when True =>
            Open (File => DatenbankEinlesen,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.GebaeudeDatenbank,
                  Form => "WCEM=8");
            
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


   
   procedure Karten
   is begin
      
      case
        Exists (Name => VerzeichnisKonstanten.KartenDatenbank)
      is
         when False =>
            StandardKartenDatenbank.StandardBasisgrundDatenbankLaden;
            StandardKartenDatenbank.StandardZusatzgrundDatenbankLaden;
            StandardKartenDatenbank.StandardKartenflussDatenbankLaden;
            StandardKartenDatenbank.StandardKartenressourcenDatenbankLaden;
            return;
            
         when True =>
            Open (File => DatenbankEinlesen,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.KartenDatenbank,
                  Form => "WCEM=8");
            
            PrüfungErfolgreich := KartenDurchgehen (LadenPrüfenExtern => False);
      
            Close (File => DatenbankEinlesen);
      end case;
      
      case
        PrüfungErfolgreich
      is
         when True =>
            Open (File => DatenbankEinlesen,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.KartenDatenbank,
                  Form => "WCEM=8");
            
            Nullwert := KartenDurchgehen (LadenPrüfenExtern => True);
      
            Close (File => DatenbankEinlesen);
            
         when False =>
            StandardKartenDatenbank.StandardBasisgrundDatenbankLaden;
            StandardKartenDatenbank.StandardZusatzgrundDatenbankLaden;
            StandardKartenDatenbank.StandardKartenflussDatenbankLaden;
            StandardKartenDatenbank.StandardKartenressourcenDatenbankLaden;
      end case;
      
   end Karten;
   
   
   
   function KartenDurchgehen
     (LadenPrüfenExtern : in Boolean)
      return Boolean
   is begin
      
      KartenDatenbank.BasisgrundlisteArray'Read (Stream (File => DatenbankEinlesen),
                                                 Basisgrund);
      
      KartenDatenbank.ZusatzgrundlisteArray'Read (Stream (File => DatenbankEinlesen),
                                                  Zusatzgrund);
      
      KartenDatenbank.KartenflusslisteArray'Read (Stream (File => DatenbankEinlesen),
                                                  Flüsse);
      
      KartenDatenbank.KartenressourcenlisteArray'Read (Stream (File => DatenbankEinlesen),
                                                       Ressourcen);
      
      case
        LadenPrüfenExtern
      is
         when False =>
            null;
            
         when True =>
            KartenDatenbank.Basisgrundliste := Basisgrund;
            KartenDatenbank.Zusatzgrundliste := Zusatzgrund;
            KartenDatenbank.Kartenflussliste := Flüsse;
            KartenDatenbank.Kartenressourcenliste := Ressourcen;
      end case;
   
      return True;
      
   exception
      when Constraint_Error | End_Error =>
         return False;
         
   end KartenDurchgehen;
   
   
   
   procedure Verbesserungen
   is begin
      
      case
        Exists (Name => VerzeichnisKonstanten.VerbesserungenDatenbank)
      is
         when False =>
            StandardVerbesserungenDatenbank.StandardVerbesserungenDatenbankLaden;
            StandardVerbesserungenDatenbank.StandardWegeDatenbankLaden;
            return;
            
         when True =>
            Open (File => DatenbankEinlesen,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.VerbesserungenDatenbank,
                  Form => "WCEM=8");
            
            PrüfungErfolgreich := VerbesserungenDurchgehen (LadenPrüfenExtern => False);
      
            Close (File => DatenbankEinlesen);

      end case;
      
      case
        PrüfungErfolgreich
      is
         when True =>
            Open (File => DatenbankEinlesen,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.VerbesserungenDatenbank,
                  Form => "WCEM=8");
            
            Nullwert := VerbesserungenDurchgehen (LadenPrüfenExtern => True);
      
            Close (File => DatenbankEinlesen);
            
         when False =>
            StandardVerbesserungenDatenbank.StandardVerbesserungenDatenbankLaden;
            StandardVerbesserungenDatenbank.StandardWegeDatenbankLaden;
      end case;
      
   end Verbesserungen;
   
   
   
   function VerbesserungenDurchgehen
     (LadenPrüfenExtern : in Boolean)
      return Boolean
   is begin
      
      VerbesserungenDatenbank.VerbesserungenlisteArray'Read (Stream (File => DatenbankEinlesen),
                                                             Verbesserung);
      
      VerbesserungenDatenbank.WegelisteArray'Read (Stream (File => DatenbankEinlesen),
                                                   Wege);
      
      case
        LadenPrüfenExtern
      is
         when False =>
            null;
            
         when True =>
            VerbesserungenDatenbank.Verbesserungenliste := Verbesserung;
            VerbesserungenDatenbank.Wegeliste := Wege;
      end case;
      
      return True;
      
   exception
      when Constraint_Error | End_Error =>
         return False;
      
   end VerbesserungenDurchgehen;
   
   
   
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
                  Name => VerzeichnisKonstanten.SpeziesDatenbank,
                  Form => "WCEM=8");
      
            PrüfungErfolgreich := SpeziesDurchgehen (LadenPrüfenExtern => False);
      
            Close (File => DatenbankEinlesen);
      end case;
      
      case
        PrüfungErfolgreich
      is
         when True =>
            Open (File => DatenbankEinlesen,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.SpeziesDatenbank,
                  Form => "WCEM=8");
      
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
