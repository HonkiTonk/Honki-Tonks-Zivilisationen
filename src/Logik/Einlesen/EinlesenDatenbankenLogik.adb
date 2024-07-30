with Ada.Exceptions; use Ada.Exceptions;

with VerzeichnisKonstanten;
with TextKonstanten;

with StandardVerbesserungenDatenbank;
with StandardSpeziesDatenbank;
with StandardKartenDatenbank;
with StandardGebaeudeDatenbank;
with StandardForschungenDatenbank;
with StandardEinheitenDatenbank;
with StandardEffekteDatenbank;

with Fehlermeldungssystem;
with VerzeichnisDateinamenTests;
with UmwandlungenAdaEigenes;

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
        VerzeichnisDateinamenTests.StandardwerteEinleseprüfung (LinuxTextExtern   => TextKonstanten.LeerString,
                                                                    WindowsTextExtern => UmwandlungenAdaEigenes.EigenesDecode (TextExtern => VerzeichnisKonstanten.EinheitenDatenbank))
      is
         when False =>
            StandardEinheitenDatenbank.StandardEinheitenDatenbankLaden;
            return;
            
         when True =>
            Open (File => DatenbankEinlesen,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.EinheitenDatenbank,
                  Form => "WCEM=8");
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
      
      Close (File => DatenbankEinlesen);
      
   exception
      when StandardAdaFehler : others =>
         Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenDatenbankenLogik.Einheiten: Konnte nicht geladen werden: "
                                     & UmwandlungenAdaEigenes.EigenesDecode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         StandardEinheitenDatenbank.StandardEinheitenDatenbankLaden;
         
         case
           Is_Open (File => DatenbankEinlesen)
         is
            when True =>
               Close (File => DatenbankEinlesen);
               
            when False =>
               null;
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
      when StandardAdaFehler : others =>
         Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenDatenbankenLogik.EinheitenDurchgehen: Konnte nicht geladen werden: "
                                     & UmwandlungenAdaEigenes.EigenesDecode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
         
   end EinheitenDurchgehen;
   
   
   
   procedure Forschungen
   is begin
      
      case
        VerzeichnisDateinamenTests.StandardwerteEinleseprüfung (LinuxTextExtern   => TextKonstanten.LeerString,
                                                                    WindowsTextExtern => UmwandlungenAdaEigenes.EigenesDecode (TextExtern => VerzeichnisKonstanten.ForschungenDatenbank))
      is
         when False =>
            StandardForschungenDatenbank.StandardForschungenDatenbankLaden;
            return;
            
         when True =>
            Open (File => DatenbankEinlesen,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.ForschungenDatenbank,
                  Form => "WCEM=8");
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
      
      Close (File => DatenbankEinlesen);
      
   exception
      when StandardAdaFehler : others =>
         Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenDatenbankenLogik.Forschungen: Konnte nicht geladen werden: "
                                     & UmwandlungenAdaEigenes.EigenesDecode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         StandardForschungenDatenbank.StandardForschungenDatenbankLaden;
         
         case
           Is_Open (File => DatenbankEinlesen)
         is
            when True =>
               Close (File => DatenbankEinlesen);
               
            when False =>
               null;
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
      when StandardAdaFehler : others =>
         Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenDatenbankenLogik.ForschungenDurchgehen: Konnte nicht geladen werden: "
                                     & UmwandlungenAdaEigenes.EigenesDecode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
         
   end ForschungenDurchgehen;
   
   
   
   procedure Gebäude
   is begin
      
      case
        VerzeichnisDateinamenTests.StandardwerteEinleseprüfung (LinuxTextExtern   => TextKonstanten.LeerString,
                                                                    WindowsTextExtern => UmwandlungenAdaEigenes.EigenesDecode (TextExtern => VerzeichnisKonstanten.GebaeudeDatenbank))
      is
         when False =>
            StandardGebaeudeDatenbank.StandardGebaeudeDatenbankLaden;
            return;
            
         when True =>
            Open (File => DatenbankEinlesen,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.GebaeudeDatenbank,
                  Form => "WCEM=8");
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
      
      Close (File => DatenbankEinlesen);
      
   exception
      when StandardAdaFehler : others =>
         Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenDatenbankenLogik.Gebäude: Konnte nicht geladen werden: "
                                     & UmwandlungenAdaEigenes.EigenesDecode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         StandardGebaeudeDatenbank.StandardGebaeudeDatenbankLaden;
         
         case
           Is_Open (File => DatenbankEinlesen)
         is
            when True =>
               Close (File => DatenbankEinlesen);
               
            when False =>
               null;
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
      when StandardAdaFehler : others =>
         Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenDatenbankenLogik.GebäudeDurchgehen: Konnte nicht geladen werden: "
                                     & UmwandlungenAdaEigenes.EigenesDecode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
         
   end GebäudeDurchgehen;


   
   procedure Karten
   is begin
      
      case
        VerzeichnisDateinamenTests.StandardwerteEinleseprüfung (LinuxTextExtern   => TextKonstanten.LeerString,
                                                                    WindowsTextExtern => UmwandlungenAdaEigenes.EigenesDecode (TextExtern => VerzeichnisKonstanten.KartenDatenbank))
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
      
      Close (File => DatenbankEinlesen);
      
   exception
      when StandardAdaFehler : others =>
         Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenDatenbankenLogik.Karten: Konnte nicht geladen werden: "
                                     & UmwandlungenAdaEigenes.EigenesDecode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         StandardKartenDatenbank.StandardBasisgrundDatenbankLaden;
         StandardKartenDatenbank.StandardZusatzgrundDatenbankLaden;
         StandardKartenDatenbank.StandardKartenflussDatenbankLaden;
         StandardKartenDatenbank.StandardKartenressourcenDatenbankLaden;
         
         case
           Is_Open (File => DatenbankEinlesen)
         is
            when True =>
               Close (File => DatenbankEinlesen);
               
            when False =>
               null;
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
      when StandardAdaFehler : others =>
         Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenDatenbankenLogik.KartenDurchgehen: Konnte nicht geladen werden: "
                                     & UmwandlungenAdaEigenes.EigenesDecode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
         
   end KartenDurchgehen;
   
   
   
   procedure Verbesserungen
   is begin
      
      case
        VerzeichnisDateinamenTests.StandardwerteEinleseprüfung (LinuxTextExtern   => TextKonstanten.LeerString,
                                                                    WindowsTextExtern => UmwandlungenAdaEigenes.EigenesDecode (TextExtern => VerzeichnisKonstanten.VerbesserungenDatenbank))
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
      
      Close (File => DatenbankEinlesen);
      
   exception
      when StandardAdaFehler : others =>
         Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenDatenbankenLogik.Verbesserungen: Konnte nicht geladen werden: "
                                     & UmwandlungenAdaEigenes.EigenesDecode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         StandardVerbesserungenDatenbank.StandardVerbesserungenDatenbankLaden;
         StandardVerbesserungenDatenbank.StandardWegeDatenbankLaden;
         
         case
           Is_Open (File => DatenbankEinlesen)
         is
            when True =>
               Close (File => DatenbankEinlesen);
               
            when False =>
               null;
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
      when StandardAdaFehler : others =>
         Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenDatenbankenLogik.VerbesserungenDurchgehen: Konnte nicht geladen werden: "
                                     & UmwandlungenAdaEigenes.EigenesDecode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end VerbesserungenDurchgehen;
   
   
   
   procedure Spezies
   is begin
      
      case
        VerzeichnisDateinamenTests.StandardwerteEinleseprüfung (LinuxTextExtern   => TextKonstanten.LeerString,
                                                                    WindowsTextExtern => UmwandlungenAdaEigenes.EigenesDecode (TextExtern => VerzeichnisKonstanten.SpeziesDatenbank))
      is
         when False =>
            StandardSpeziesDatenbank.StandardSpeziesDatenbankLaden;
            return;
            
         when True =>
            Open (File => DatenbankEinlesen,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.SpeziesDatenbank,
                  Form => "WCEM=8");
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
      
      Close (File => DatenbankEinlesen);
      
   exception
      when StandardAdaFehler : others =>
         Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenDatenbankenLogik.Spezies: Konnte nicht geladen werden: "
                                     & UmwandlungenAdaEigenes.EigenesDecode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         StandardSpeziesDatenbank.StandardSpeziesDatenbankLaden;
         
         case
           Is_Open (File => DatenbankEinlesen)
         is
            when True =>
               Close (File => DatenbankEinlesen);
               
            when False =>
               null;
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
      when StandardAdaFehler : others =>
         Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenDatenbankenLogik.SpeziesDurchgehen: Konnte nicht geladen werden: "
                                     & UmwandlungenAdaEigenes.EigenesDecode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
         
   end SpeziesDurchgehen;
   
   
   
   procedure Effekte
   is begin
      
      case
        VerzeichnisDateinamenTests.StandardwerteEinleseprüfung (LinuxTextExtern   => TextKonstanten.LeerString,
                                                                    WindowsTextExtern => UmwandlungenAdaEigenes.EigenesDecode (TextExtern => VerzeichnisKonstanten.EffekteDatenbank))
      is
         when False =>
            StandardEffekteDatenbank.StandardEffekteDatenbankLaden;
            return;
            
         when True =>
            Open (File => DatenbankEinlesen,
                  Mode => In_File,
                  Name => VerzeichnisKonstanten.EffekteDatenbank,
                  Form => "WCEM=8");
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
      
      Close (File => DatenbankEinlesen);
      
   exception
      when StandardAdaFehler : others =>
         Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenDatenbankenLogik.Effekte: Konnte nicht geladen werden: "
                                     & UmwandlungenAdaEigenes.EigenesDecode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         StandardEffekteDatenbank.StandardEffekteDatenbankLaden;
         
         case
           Is_Open (File => DatenbankEinlesen)
         is
            when True =>
               Close (File => DatenbankEinlesen);
               
            when False =>
               null;
         end case;
      
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
         Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenDatenbankenLogik.EffekteDurchgehen: Konnte nicht geladen werden: "
                                     & UmwandlungenAdaEigenes.EigenesDecode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end EffekteDurchgehen;

end EinlesenDatenbankenLogik;
