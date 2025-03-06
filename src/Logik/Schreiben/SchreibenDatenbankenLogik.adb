with Ada.Exceptions; use Ada.Exceptions;

with DateizugriffssystemHTSEB;

with EinheitenDatenbank;
with ForschungenDatenbank;
with GebaeudeDatenbank;
with KartenDatenbank;
with VerbesserungenDatenbank;
with SpeziesDatenbank;
with VerzeichnisKonstanten;
with ForschungRecordKonstanten;
with EffekteDatenbank;

with MeldungssystemHTSEB;
with UmwandlungssystemHTSEB;

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
      
      DateizugriffssystemHTSEB.ErstellenStream (DateiartExtern => DateiEinheitendatenbank,
                                                NameExtern     => VerzeichnisKonstanten.EinheitenDatenbank);
      
      EinheitenDatenbank.EinheitenlisteArray'Write (Stream (File => DateiEinheitendatenbank),
                                                    EinheitenDatenbank.Einheitenliste);
      
      DateizugriffssystemHTSEB.SchließenStream (DateiartExtern => DateiEinheitendatenbank,
                                                 NameExtern     => VerzeichnisKonstanten.EinheitenDatenbank);
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "SchreibenDatenbankenLogik.SchreibenEinheitenDatenbank: Konnte nicht gespeichert werden: "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         
         DateizugriffssystemHTSEB.SchließenStream (DateiartExtern => DateiEinheitendatenbank,
                                                    NameExtern     => VerzeichnisKonstanten.EinheitenDatenbank);
      
   end SchreibenEinheitenDatenbank;
   
   
   
   -- Das hier auch noch in einzelne Datenbanken aufteilen? äöü
   procedure SchreibenForschungenDatenbank
   is begin
      
      DateizugriffssystemHTSEB.ErstellenStream (DateiartExtern => DateiForschungendatenbank,
                                  NameExtern     => VerzeichnisKonstanten.ForschungenDatenbank);
      
      ForschungenDatenbank.ForschungslisteArray'Write (Stream (File => DateiForschungendatenbank),
                                                       ForschungenDatenbank.Forschungsliste);
      
      ForschungRecordKonstanten.TechnologieVerbesserungenArray'Write (Stream (File => DateiForschungendatenbank),
                                                                      ForschungenDatenbank.TechnologieVerbesserungen);
      
      ForschungRecordKonstanten.TechnologieWegeArray'Write (Stream (File => DateiForschungendatenbank),
                                                            ForschungenDatenbank.TechnologieWege);
      
      ForschungRecordKonstanten.TechnologieUmgebungsgrößeArray'Write (Stream (File => DateiForschungendatenbank),
                                                                        ForschungenDatenbank.TechnologieUmgebungsgröße);
      
      DateizugriffssystemHTSEB.SchließenStream (DateiartExtern => DateiForschungendatenbank,
                                                 NameExtern     => VerzeichnisKonstanten.ForschungenDatenbank);
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "SchreibenDatenbankenLogik.SchreibenForschungenDatenbank: Konnte nicht gespeichert werden: "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         
         DateizugriffssystemHTSEB.SchließenStream (DateiartExtern => DateiForschungendatenbank,
                                                    NameExtern     => VerzeichnisKonstanten.ForschungenDatenbank);
         
   end SchreibenForschungenDatenbank;
   
   
   
   procedure SchreibenGebäudeDatenbank
   is begin
      
      DateizugriffssystemHTSEB.ErstellenStream (DateiartExtern => DateiGebäudedatenbank,
                                  NameExtern     => VerzeichnisKonstanten.GebaeudeDatenbank);
      
      GebaeudeDatenbank.GebäudelisteArray'Write (Stream (File => DateiGebäudedatenbank),
                                                  GebaeudeDatenbank.Gebäudeliste);
      
      DateizugriffssystemHTSEB.SchließenStream (DateiartExtern => DateiGebäudedatenbank,
                                                 NameExtern     => VerzeichnisKonstanten.GebaeudeDatenbank);
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "SchreibenDatenbankenLogik.SchreibenGebäudeDatenbank: Konnte nicht gespeichert werden: "
                                     & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
      
      DateizugriffssystemHTSEB.SchließenStream (DateiartExtern => DateiGebäudedatenbank,
                                                 NameExtern     => VerzeichnisKonstanten.GebaeudeDatenbank);
      
   end SchreibenGebäudeDatenbank;
   
   
   
   procedure SchreibenKartenDatenbanken
   is begin
      
      DateizugriffssystemHTSEB.ErstellenStream (DateiartExtern => DateiKartendatenbank,
                                  NameExtern     => VerzeichnisKonstanten.KartenDatenbank);
            
      KartenDatenbank.BasisgrundlisteArray'Write (Stream (File => DateiKartendatenbank),
                                                  KartenDatenbank.Basisgrundliste);
      
      KartenDatenbank.ZusatzgrundlisteArray'Write (Stream (File => DateiKartendatenbank),
                                                   KartenDatenbank.Zusatzgrundliste);
      
      KartenDatenbank.KartenflusslisteArray'Write (Stream (File => DateiKartendatenbank),
                                                   KartenDatenbank.Kartenflussliste);
      
      KartenDatenbank.KartenressourcenlisteArray'Write (Stream (File => DateiKartendatenbank),
                                                        KartenDatenbank.Kartenressourcenliste);
      
      DateizugriffssystemHTSEB.SchließenStream (DateiartExtern => DateiKartendatenbank,
                                                 NameExtern     => VerzeichnisKonstanten.KartenDatenbank);
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "SchreibenDatenbankenLogik.SchreibenKartenDatenbanken: Konnte nicht gespeichert werden: " &
                                       UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
      
      DateizugriffssystemHTSEB.SchließenStream (DateiartExtern => DateiKartendatenbank,
                                                 NameExtern     => VerzeichnisKonstanten.KartenDatenbank);
      
   end SchreibenKartenDatenbanken;
   
   
   
   procedure SchreibenVerbesserungenDatenbank
   is begin
      
      DateizugriffssystemHTSEB.ErstellenStream (DateiartExtern => DateiVerbesserungendatenbank,
                                  NameExtern     => VerzeichnisKonstanten.VerbesserungenDatenbank);
      
      VerbesserungenDatenbank.VerbesserungenlisteArray'Write (Stream (File => DateiVerbesserungendatenbank),
                                                              VerbesserungenDatenbank.Verbesserungenliste);
      
      VerbesserungenDatenbank.WegelisteArray'Write (Stream (File => DateiVerbesserungendatenbank),
                                                    VerbesserungenDatenbank.Wegeliste);
      
      DateizugriffssystemHTSEB.SchließenStream (DateiartExtern => DateiVerbesserungendatenbank,
                                                 NameExtern     => VerzeichnisKonstanten.VerbesserungenDatenbank);
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "SchreibenDatenbankenLogik.SchreibenVerbesserungenDatenbank: Konnte nicht gespeichert werden: "
                                     & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
      
      DateizugriffssystemHTSEB.SchließenStream (DateiartExtern => DateiVerbesserungendatenbank,
                                                 NameExtern     => VerzeichnisKonstanten.VerbesserungenDatenbank);
      
   end SchreibenVerbesserungenDatenbank;
      
         
   
   procedure SchreibenSpeziesDatenbank
   is begin
      
      DateizugriffssystemHTSEB.ErstellenStream (DateiartExtern => DateiSpeziesdatenbank,
                                  NameExtern     => VerzeichnisKonstanten.SpeziesDatenbank);
      
      SpeziesDatenbank.SpezieslisteArray'Write (Stream (File => DateiSpeziesdatenbank),
                                                SpeziesDatenbank.Speziesliste);
      
      DateizugriffssystemHTSEB.SchließenStream (DateiartExtern => DateiSpeziesdatenbank,
                                                 NameExtern     => VerzeichnisKonstanten.SpeziesDatenbank);
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "SchreibenDatenbankenLogik.SchreibenSpeziesDatenbank: Konnte nicht gespeichert werden: " &
                                       UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
      
      DateizugriffssystemHTSEB.SchließenStream (DateiartExtern => DateiSpeziesdatenbank,
                                                 NameExtern     => VerzeichnisKonstanten.SpeziesDatenbank);
      
   end SchreibenSpeziesDatenbank;
   
   
   
   procedure SchreibenEffekteDatenbank
   is begin
      
      DateizugriffssystemHTSEB.ErstellenStream (DateiartExtern => DateiEffektedatenbank,
                                  NameExtern     => VerzeichnisKonstanten.EffekteDatenbank);
      
      EffekteDatenbank.EffektelisteArray'Write (Stream (File => DateiEffektedatenbank),
                                                EffekteDatenbank.Effekteliste);
      
      DateizugriffssystemHTSEB.SchließenStream (DateiartExtern => DateiEffektedatenbank,
                                                 NameExtern     => VerzeichnisKonstanten.EffekteDatenbank);
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "SchreibenDatenbankenLogik.SchreibenEffekteDatenbank: Konnte nicht gespeichert werden: "
                                     & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
      
      DateizugriffssystemHTSEB.SchließenStream (DateiartExtern => DateiEffektedatenbank,
                                                 NameExtern     => VerzeichnisKonstanten.EffekteDatenbank);
      
   end SchreibenEffekteDatenbank;

end SchreibenDatenbankenLogik;
