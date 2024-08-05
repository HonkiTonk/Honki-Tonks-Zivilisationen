with Ada.Exceptions; use Ada.Exceptions;

with EinheitenDatenbank;
with ForschungenDatenbank;
with GebaeudeDatenbank;
with KartenDatenbank;
with VerbesserungenDatenbank;
with SpeziesDatenbank;
with VerzeichnisKonstanten;
with ForschungRecordKonstanten;
with EffekteDatenbank;

with Fehlermeldungssystem;
with UmwandlungenAdaEigenes;
with DateiLogik;

-- Das Schreiben/Einlesen der Datenbanken auch so aufteilen wie das Schreiben/Einlesen der Einstellungen. äöü
package body SchreibenDatenbankenLogik is
   
   procedure SchreibenAlleDatenbanken
   is begin
      
      SchreibenEinheitenDatenbank;
      SchreibenForschungenDatenbank;
      SchreibenGebäudeDatenbank;
      SchreibenKartenDatenbanken;
      SchreibenVerbesserungenDatenbank;
      SchreibenSpeziesDatenbank;
      SchreibenEffekteDatenbank;
      
   end SchreibenAlleDatenbanken;
   
   
   
   procedure SchreibenEinheitenDatenbank
   is begin
      
      DateiLogik.ErstellenStream (DateiartExtern => DatenbankSpeichern,
                                  NameExtern     => VerzeichnisKonstanten.EinheitenDatenbank);
      
      EinheitenDatenbank.EinheitenlisteArray'Write (Stream (File => DatenbankSpeichern),
                                                    EinheitenDatenbank.Einheitenliste);
      
      Close (File => DatenbankSpeichern);
      
   exception
      when StandardAdaFehler : others =>
         Fehlermeldungssystem.Logik (FehlermeldungExtern => "SchreibenDatenbankenLogik.SchreibenEinheitenDatenbank: Konnte nicht gespeichert werden: "
                                     & UmwandlungenAdaEigenes.EigenesDecode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         
         case
           Is_Open (File => DatenbankSpeichern)
         is
            when True =>
               Close (File => DatenbankSpeichern);
               
            when False =>
               null;
         end case;
      
   end SchreibenEinheitenDatenbank;
   
   
   
   -- Das hier auch noch in einzelne Datenbanken aufteilen? äöü
   procedure SchreibenForschungenDatenbank
   is begin
      
      DateiLogik.ErstellenStream (DateiartExtern => DatenbankSpeichern,
                                  NameExtern     => VerzeichnisKonstanten.ForschungenDatenbank);
      
      ForschungenDatenbank.ForschungslisteArray'Write (Stream (File => DatenbankSpeichern),
                                                       ForschungenDatenbank.Forschungsliste);
      
      ForschungRecordKonstanten.TechnologieVerbesserungenArray'Write (Stream (File => DatenbankSpeichern),
                                                                      ForschungenDatenbank.TechnologieVerbesserungen);
      
      ForschungRecordKonstanten.TechnologieWegeArray'Write (Stream (File => DatenbankSpeichern),
                                                            ForschungenDatenbank.TechnologieWege);
      
      ForschungRecordKonstanten.TechnologieUmgebungsgrößeArray'Write (Stream (File => DatenbankSpeichern),
                                                                        ForschungenDatenbank.TechnologieUmgebungsgröße);
      
      Close (File => DatenbankSpeichern);
      
   exception
      when StandardAdaFehler : others =>
         Fehlermeldungssystem.Logik (FehlermeldungExtern => "SchreibenDatenbankenLogik.SchreibenForschungenDatenbank: Konnte nicht gespeichert werden: "
                                     & UmwandlungenAdaEigenes.EigenesDecode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         
         case
           Is_Open (File => DatenbankSpeichern)
         is
            when True =>
               Close (File => DatenbankSpeichern);
               
            when False =>
               null;
         end case;
      
   end SchreibenForschungenDatenbank;
   
   
   
   procedure SchreibenGebäudeDatenbank
   is begin
      
      DateiLogik.ErstellenStream (DateiartExtern => DatenbankSpeichern,
                                  NameExtern     => VerzeichnisKonstanten.GebaeudeDatenbank);
      
      GebaeudeDatenbank.GebäudelisteArray'Write (Stream (File => DatenbankSpeichern),
                                                  GebaeudeDatenbank.Gebäudeliste);
      
      Close (File => DatenbankSpeichern);
      
   exception
      when StandardAdaFehler : others =>
         Fehlermeldungssystem.Logik (FehlermeldungExtern => "SchreibenDatenbankenLogik.SchreibenGebäudeDatenbank: Konnte nicht gespeichert werden: "
                                     & UmwandlungenAdaEigenes.EigenesDecode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         
         case
           Is_Open (File => DatenbankSpeichern)
         is
            when True =>
               Close (File => DatenbankSpeichern);
               
            when False =>
               null;
         end case;
      
   end SchreibenGebäudeDatenbank;
   
   
   
   procedure SchreibenKartenDatenbanken
   is begin
      
      DateiLogik.ErstellenStream (DateiartExtern => DatenbankSpeichern,
                                  NameExtern     => VerzeichnisKonstanten.KartenDatenbank);
            
      KartenDatenbank.BasisgrundlisteArray'Write (Stream (File => DatenbankSpeichern),
                                                  KartenDatenbank.Basisgrundliste);
      
      KartenDatenbank.ZusatzgrundlisteArray'Write (Stream (File => DatenbankSpeichern),
                                                   KartenDatenbank.Zusatzgrundliste);
      
      KartenDatenbank.KartenflusslisteArray'Write (Stream (File => DatenbankSpeichern),
                                                   KartenDatenbank.Kartenflussliste);
      
      KartenDatenbank.KartenressourcenlisteArray'Write (Stream (File => DatenbankSpeichern),
                                                        KartenDatenbank.Kartenressourcenliste);
      
      Close (File => DatenbankSpeichern);
      
   exception
      when StandardAdaFehler : others =>
         Fehlermeldungssystem.Logik (FehlermeldungExtern => "SchreibenDatenbankenLogik.SchreibenKartenDatenbanken: Konnte nicht gespeichert werden: " &
                                       UmwandlungenAdaEigenes.EigenesDecode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         
         case
           Is_Open (File => DatenbankSpeichern)
         is
            when True =>
               Close (File => DatenbankSpeichern);
               
            when False =>
               null;
         end case;
      
   end SchreibenKartenDatenbanken;
   
   
   
   procedure SchreibenVerbesserungenDatenbank
   is begin
      
      DateiLogik.ErstellenStream (DateiartExtern => DatenbankSpeichern,
                                  NameExtern     => VerzeichnisKonstanten.VerbesserungenDatenbank);
      
      VerbesserungenDatenbank.VerbesserungenlisteArray'Write (Stream (File => DatenbankSpeichern),
                                                              VerbesserungenDatenbank.Verbesserungenliste);
      
      VerbesserungenDatenbank.WegelisteArray'Write (Stream (File => DatenbankSpeichern),
                                                    VerbesserungenDatenbank.Wegeliste);
      
      Close (File => DatenbankSpeichern);
      
   exception
      when StandardAdaFehler : others =>
         Fehlermeldungssystem.Logik (FehlermeldungExtern => "SchreibenDatenbankenLogik.SchreibenVerbesserungenDatenbank: Konnte nicht gespeichert werden: "
                                     & UmwandlungenAdaEigenes.EigenesDecode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         
         case
           Is_Open (File => DatenbankSpeichern)
         is
            when True =>
               Close (File => DatenbankSpeichern);
               
            when False =>
               null;
         end case;
      
   end SchreibenVerbesserungenDatenbank;
      
         
   
   procedure SchreibenSpeziesDatenbank
   is begin
      
      DateiLogik.ErstellenStream (DateiartExtern => DatenbankSpeichern,
                                  NameExtern     => VerzeichnisKonstanten.SpeziesDatenbank);
      
      SpeziesDatenbank.SpezieslisteArray'Write (Stream (File => DatenbankSpeichern),
                                                SpeziesDatenbank.Speziesliste);
      
      Close (File => DatenbankSpeichern);
      
   exception
      when StandardAdaFehler : others =>
         Fehlermeldungssystem.Logik (FehlermeldungExtern => "SchreibenDatenbankenLogik.SchreibenSpeziesDatenbank: Konnte nicht gespeichert werden: " &
                                       UmwandlungenAdaEigenes.EigenesDecode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         
         case
           Is_Open (File => DatenbankSpeichern)
         is
            when True =>
               Close (File => DatenbankSpeichern);
               
            when False =>
               null;
         end case;
      
   end SchreibenSpeziesDatenbank;
   
   
   
   procedure SchreibenEffekteDatenbank
   is begin
      
      DateiLogik.ErstellenStream (DateiartExtern => DatenbankSpeichern,
                                  NameExtern     => VerzeichnisKonstanten.EffekteDatenbank);
      
      EffekteDatenbank.EffektelisteArray'Write (Stream (File => DatenbankSpeichern),
                                                EffekteDatenbank.Effekteliste);
      
      Close (File => DatenbankSpeichern);
      
   exception
      when StandardAdaFehler : others =>
         Fehlermeldungssystem.Logik (FehlermeldungExtern => "SchreibenDatenbankenLogik.SchreibenEffekteDatenbank: Konnte nicht gespeichert werden: "
                                     & UmwandlungenAdaEigenes.EigenesDecode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         
         case
           Is_Open (File => DatenbankSpeichern)
         is
            when True =>
               Close (File => DatenbankSpeichern);
               
            when False =>
               null;
         end case;
      
   end SchreibenEffekteDatenbank;

end SchreibenDatenbankenLogik;
