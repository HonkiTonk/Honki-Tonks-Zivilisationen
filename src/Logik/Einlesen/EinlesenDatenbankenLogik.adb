with Ada.Exceptions; use Ada.Exceptions;

with DateizugriffssystemHTSEB;
with DateisystemtestsHTSEB;
with MeldungssystemHTSEB;
with UmwandlungssystemHTSEB;
with TextKonstantenHTSEB;

with VerzeichnisKonstanten;

with StandardVerbesserungenDatenbank;
with StandardSpeziesDatenbank;
with StandardKartenDatenbank;
with StandardGebaeudeDatenbank;
with StandardForschungenDatenbank;
with StandardEinheitenDatenbank;
with StandardEffekteDatenbank;

package body EinlesenDatenbankenLogik is
   
   procedure AlleDatenbanken
   is begin
      
      Einheiten;
      Forschungen;
      Gebäude;
      Karten;
      Verbesserungen;
      Spezies;
      Effekte;
      
   end AlleDatenbanken;
   
   

   procedure Einheiten
   is begin
      
      case
        DateisystemtestsHTSEB.StandardwerteEinleseprüfung (LinuxTextExtern   => TextKonstantenHTSEB.LeerString,
                                                            WindowsTextExtern => UmwandlungssystemHTSEB.Decode (TextExtern => VerzeichnisKonstanten.EinheitenDatenbank))
      is
         when False =>
            StandardEinheitenDatenbank.StandardEinheitenDatenbankLaden;
            return;
            
         when True =>
            DateizugriffssystemHTSEB.ÖffnenStream (DateiartExtern => DatenbankEinlesen,
                                                    NameExtern     => VerzeichnisKonstanten.EinheitenDatenbank);
      end case;
      
      case
        EinheitenDurchgehen (LadenPrüfenExtern => False)
      is
         when True =>
            Set_Index (File => DatenbankEinlesen,
                       To   => 1);
            
            Nullwert := EinheitenDurchgehen (LadenPrüfenExtern => True);
            
         when False =>
            StandardEinheitenDatenbank.StandardEinheitenDatenbankLaden;
      end case;
            
      DateizugriffssystemHTSEB.SchließenStream (DateiartExtern => DatenbankEinlesen,
                                                 NameExtern     => VerzeichnisKonstanten.EinheitenDatenbank);
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "EinlesenDatenbankenLogik.Einheiten: Konnte nicht geladen werden: "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         StandardEinheitenDatenbank.StandardEinheitenDatenbankLaden;
            
         DateizugriffssystemHTSEB.SchließenStream (DateiartExtern => DatenbankEinlesen,
                                                    NameExtern     => VerzeichnisKonstanten.EinheitenDatenbank);
      
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
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "EinlesenDatenbankenLogik.EinheitenDurchgehen: Konnte nicht geladen werden: "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
         
   end EinheitenDurchgehen;
   
   
   
   procedure Forschungen
   is begin
      
      case
        DateisystemtestsHTSEB.StandardwerteEinleseprüfung (LinuxTextExtern   => TextKonstantenHTSEB.LeerString,
                                                            WindowsTextExtern => UmwandlungssystemHTSEB.Decode (TextExtern => VerzeichnisKonstanten.ForschungenDatenbank))
      is
         when False =>
            StandardForschungenDatenbank.StandardForschungenDatenbankLaden;
            return;
            
         when True =>
            DateizugriffssystemHTSEB.ÖffnenStream (DateiartExtern => DatenbankEinlesen,
                                                    NameExtern     => VerzeichnisKonstanten.ForschungenDatenbank);
      end case;
      
      case
        ForschungenDurchgehen (LadenPrüfenExtern => False)
      is
         when True =>
            Set_Index (File => DatenbankEinlesen,
                       To   => 1);
            
            Nullwert := ForschungenDurchgehen (LadenPrüfenExtern => True);
            
         when False =>
            StandardForschungenDatenbank.StandardForschungenDatenbankLaden;
      end case;
            
      DateizugriffssystemHTSEB.SchließenStream (DateiartExtern => DatenbankEinlesen,
                                                 NameExtern     => VerzeichnisKonstanten.ForschungenDatenbank);
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "EinlesenDatenbankenLogik.Forschungen: Konnte nicht geladen werden: "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         StandardForschungenDatenbank.StandardForschungenDatenbankLaden;
            
         DateizugriffssystemHTSEB.SchließenStream (DateiartExtern => DatenbankEinlesen,
                                                    NameExtern     => VerzeichnisKonstanten.ForschungenDatenbank);
      
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
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "EinlesenDatenbankenLogik.ForschungenDurchgehen: Konnte nicht geladen werden: "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
         
   end ForschungenDurchgehen;
   
   
   
   procedure Gebäude
   is begin
      
      case
        DateisystemtestsHTSEB.StandardwerteEinleseprüfung (LinuxTextExtern   => TextKonstantenHTSEB.LeerString,
                                                            WindowsTextExtern => UmwandlungssystemHTSEB.Decode (TextExtern => VerzeichnisKonstanten.GebaeudeDatenbank))
      is
         when False =>
            StandardGebaeudeDatenbank.StandardGebaeudeDatenbankLaden;
            return;
            
         when True =>
            DateizugriffssystemHTSEB.ÖffnenStream (DateiartExtern => DatenbankEinlesen,
                                                    NameExtern     => VerzeichnisKonstanten.GebaeudeDatenbank);
      end case;
      
      case
        GebäudeDurchgehen (LadenPrüfenExtern => False)
      is
         when True =>
            Set_Index (File => DatenbankEinlesen,
                       To   => 1);
            
            Nullwert := GebäudeDurchgehen (LadenPrüfenExtern => True);
            
         when False =>
            StandardGebaeudeDatenbank.StandardGebaeudeDatenbankLaden;
      end case;
            
      DateizugriffssystemHTSEB.SchließenStream (DateiartExtern => DatenbankEinlesen,
                                                 NameExtern     => VerzeichnisKonstanten.GebaeudeDatenbank);
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "EinlesenDatenbankenLogik.Gebäude: Konnte nicht geladen werden: "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         StandardGebaeudeDatenbank.StandardGebaeudeDatenbankLaden;
            
         DateizugriffssystemHTSEB.SchließenStream (DateiartExtern => DatenbankEinlesen,
                                                    NameExtern     => VerzeichnisKonstanten.GebaeudeDatenbank);
      
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
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "EinlesenDatenbankenLogik.GebäudeDurchgehen: Konnte nicht geladen werden: "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
         
   end GebäudeDurchgehen;


   
   procedure Karten
   is begin
      
      case
        DateisystemtestsHTSEB.StandardwerteEinleseprüfung (LinuxTextExtern   => TextKonstantenHTSEB.LeerString,
                                                            WindowsTextExtern => UmwandlungssystemHTSEB.Decode (TextExtern => VerzeichnisKonstanten.KartenDatenbank))
      is
         when False =>
            StandardKartenDatenbank.StandardBasisgrundDatenbankLaden;
            StandardKartenDatenbank.StandardZusatzgrundDatenbankLaden;
            StandardKartenDatenbank.StandardKartenflussDatenbankLaden;
            StandardKartenDatenbank.StandardKartenressourcenDatenbankLaden;
            return;
            
         when True =>
            DateizugriffssystemHTSEB.ÖffnenStream (DateiartExtern => DatenbankEinlesen,
                                                    NameExtern     => VerzeichnisKonstanten.KartenDatenbank);
      end case;
      
      case
        KartenDurchgehen (LadenPrüfenExtern => False)
      is
         when True =>
            Set_Index (File => DatenbankEinlesen,
                       To   => 1);
            
            Nullwert := KartenDurchgehen (LadenPrüfenExtern => True);
            
         when False =>
            StandardKartenDatenbank.StandardBasisgrundDatenbankLaden;
            StandardKartenDatenbank.StandardZusatzgrundDatenbankLaden;
            StandardKartenDatenbank.StandardKartenflussDatenbankLaden;
            StandardKartenDatenbank.StandardKartenressourcenDatenbankLaden;
      end case;
            
      DateizugriffssystemHTSEB.SchließenStream (DateiartExtern => DatenbankEinlesen,
                                                 NameExtern     => VerzeichnisKonstanten.KartenDatenbank);
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "EinlesenDatenbankenLogik.Karten: Konnte nicht geladen werden: "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         StandardKartenDatenbank.StandardBasisgrundDatenbankLaden;
         StandardKartenDatenbank.StandardZusatzgrundDatenbankLaden;
         StandardKartenDatenbank.StandardKartenflussDatenbankLaden;
         StandardKartenDatenbank.StandardKartenressourcenDatenbankLaden;
            
         DateizugriffssystemHTSEB.SchließenStream (DateiartExtern => DatenbankEinlesen,
                                                    NameExtern     => VerzeichnisKonstanten.KartenDatenbank);
      
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
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "EinlesenDatenbankenLogik.KartenDurchgehen: Konnte nicht geladen werden: "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
         
   end KartenDurchgehen;
   
   
   
   procedure Verbesserungen
   is begin
      
      case
        DateisystemtestsHTSEB.StandardwerteEinleseprüfung (LinuxTextExtern   => TextKonstantenHTSEB.LeerString,
                                                            WindowsTextExtern => UmwandlungssystemHTSEB.Decode (TextExtern => VerzeichnisKonstanten.VerbesserungenDatenbank))
      is
         when False =>
            StandardVerbesserungenDatenbank.StandardVerbesserungenDatenbankLaden;
            StandardVerbesserungenDatenbank.StandardWegeDatenbankLaden;
            return;
            
         when True =>
            DateizugriffssystemHTSEB.ÖffnenStream (DateiartExtern => DatenbankEinlesen,
                                                    NameExtern     => VerzeichnisKonstanten.VerbesserungenDatenbank);
      end case;
      
      case
        VerbesserungenDurchgehen (LadenPrüfenExtern => False)
      is
         when True =>
            Set_Index (File => DatenbankEinlesen,
                       To   => 1);
            
            Nullwert := VerbesserungenDurchgehen (LadenPrüfenExtern => True);
            
         when False =>
            StandardVerbesserungenDatenbank.StandardVerbesserungenDatenbankLaden;
            StandardVerbesserungenDatenbank.StandardWegeDatenbankLaden;
      end case;
            
      DateizugriffssystemHTSEB.SchließenStream (DateiartExtern => DatenbankEinlesen,
                                                 NameExtern     => VerzeichnisKonstanten.VerbesserungenDatenbank);
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "EinlesenDatenbankenLogik.Verbesserungen: Konnte nicht geladen werden: "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         StandardVerbesserungenDatenbank.StandardVerbesserungenDatenbankLaden;
         StandardVerbesserungenDatenbank.StandardWegeDatenbankLaden;
            
         DateizugriffssystemHTSEB.SchließenStream (DateiartExtern => DatenbankEinlesen,
                                                    NameExtern     => VerzeichnisKonstanten.VerbesserungenDatenbank);
      
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
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "EinlesenDatenbankenLogik.VerbesserungenDurchgehen: Konnte nicht geladen werden: "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end VerbesserungenDurchgehen;
   
   
   
   procedure Spezies
   is begin
      
      case
        DateisystemtestsHTSEB.StandardwerteEinleseprüfung (LinuxTextExtern   => TextKonstantenHTSEB.LeerString,
                                                            WindowsTextExtern => UmwandlungssystemHTSEB.Decode (TextExtern => VerzeichnisKonstanten.SpeziesDatenbank))
      is
         when False =>
            StandardSpeziesDatenbank.StandardSpeziesDatenbankLaden;
            return;
            
         when True =>
            DateizugriffssystemHTSEB.ÖffnenStream (DateiartExtern => DatenbankEinlesen,
                                                    NameExtern     => VerzeichnisKonstanten.SpeziesDatenbank);
      end case;
      
      case
        SpeziesDurchgehen (LadenPrüfenExtern => False)
      is
         when True =>
            Set_Index (File => DatenbankEinlesen,
                       To   => 1);
      
            Nullwert := SpeziesDurchgehen (LadenPrüfenExtern => True);
            
         when False =>
            StandardSpeziesDatenbank.StandardSpeziesDatenbankLaden;
      end case;
            
      DateizugriffssystemHTSEB.SchließenStream (DateiartExtern => DatenbankEinlesen,
                                                 NameExtern     => VerzeichnisKonstanten.SpeziesDatenbank);
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "EinlesenDatenbankenLogik.Spezies: Konnte nicht geladen werden: "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         StandardSpeziesDatenbank.StandardSpeziesDatenbankLaden;
            
         DateizugriffssystemHTSEB.SchließenStream (DateiartExtern => DatenbankEinlesen,
                                                    NameExtern     => VerzeichnisKonstanten.SpeziesDatenbank);
      
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
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "EinlesenDatenbankenLogik.SpeziesDurchgehen: Konnte nicht geladen werden: "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
         
   end SpeziesDurchgehen;
   
   
   
   procedure Effekte
   is begin
      
      case
        DateisystemtestsHTSEB.StandardwerteEinleseprüfung (LinuxTextExtern   => TextKonstantenHTSEB.LeerString,
                                                            WindowsTextExtern => UmwandlungssystemHTSEB.Decode (TextExtern => VerzeichnisKonstanten.EffekteDatenbank))
      is
         when False =>
            StandardEffekteDatenbank.StandardEffekteDatenbankLaden;
            return;
            
         when True =>
            DateizugriffssystemHTSEB.ÖffnenStream (DateiartExtern => DatenbankEinlesen,
                                                    NameExtern     => VerzeichnisKonstanten.EffekteDatenbank);
      end case;
      
      case
        EffekteDurchgehen (LadenPrüfenExtern => False)
      is
         when True =>
            Set_Index (File => DatenbankEinlesen,
                       To   => 1);
      
            Nullwert := EffekteDurchgehen (LadenPrüfenExtern => True);
            
         when False =>
            StandardEffekteDatenbank.StandardEffekteDatenbankLaden;
      end case;
            
      DateizugriffssystemHTSEB.SchließenStream (DateiartExtern => DatenbankEinlesen,
                                                 NameExtern     => VerzeichnisKonstanten.EffekteDatenbank);
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "EinlesenDatenbankenLogik.Effekte: Konnte nicht geladen werden: "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         StandardEffekteDatenbank.StandardEffekteDatenbankLaden;
            
         DateizugriffssystemHTSEB.SchließenStream (DateiartExtern => DatenbankEinlesen,
                                                    NameExtern     => VerzeichnisKonstanten.EffekteDatenbank);
      
   end Effekte;
   
   
   
   function EffekteDurchgehen
     (LadenPrüfenExtern : in Boolean)
      return Boolean
   is begin
      
      EffekteDatenbank.EffektelisteArray'Read (Stream (File => DatenbankEinlesen),
                                               Effekteliste);
   
      case
        LadenPrüfenExtern
      is
         when False =>
            null;
            
         when True =>
            EffekteDatenbank.Effekteliste := Effekteliste;
      end case;
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "EinlesenDatenbankenLogik.EffekteDurchgehen: Konnte nicht geladen werden: "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end EffekteDurchgehen;

end EinlesenDatenbankenLogik;
