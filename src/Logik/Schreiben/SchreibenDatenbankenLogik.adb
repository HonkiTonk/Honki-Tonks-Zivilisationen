with Ada.Exceptions; use Ada.Exceptions;

with DateizugriffssystemHTB5;

with EinheitenDatenbank;
with ForschungenDatenbank;
with GebaeudeDatenbank;
with KartenDatenbank;
with VerbesserungenDatenbank;
with SpeziesDatenbank;
with VerzeichnisKonstanten;
with ForschungRecordKonstanten;
with EffekteDatenbank;

with MeldungssystemHTB1;
with UmwandlungssystemHTB3;

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
      
      DateizugriffssystemHTB5.ErstellenStream (DateiartExtern => DateiEinheitendatenbank,
                                  NameExtern     => VerzeichnisKonstanten.EinheitenDatenbank);
      
      EinheitenDatenbank.EinheitenlisteArray'Write (Stream (File => DateiEinheitendatenbank),
                                                    EinheitenDatenbank.Einheitenliste);
      
      Close (File => DateiEinheitendatenbank);
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTB1.Logik (MeldungExtern => "SchreibenDatenbankenLogik.SchreibenEinheitenDatenbank: Konnte nicht gespeichert werden: "
                                     & UmwandlungssystemHTB3.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         
         case
           Is_Open (File => DateiEinheitendatenbank)
         is
            when True =>
               Close (File => DateiEinheitendatenbank);
               
            when False =>
               null;
         end case;
      
   end SchreibenEinheitenDatenbank;
   
   
   
   -- Das hier auch noch in einzelne Datenbanken aufteilen? äöü
   procedure SchreibenForschungenDatenbank
   is begin
      
      DateizugriffssystemHTB5.ErstellenStream (DateiartExtern => DateiForschungendatenbank,
                                  NameExtern     => VerzeichnisKonstanten.ForschungenDatenbank);
      
      ForschungenDatenbank.ForschungslisteArray'Write (Stream (File => DateiForschungendatenbank),
                                                       ForschungenDatenbank.Forschungsliste);
      
      ForschungRecordKonstanten.TechnologieVerbesserungenArray'Write (Stream (File => DateiForschungendatenbank),
                                                                      ForschungenDatenbank.TechnologieVerbesserungen);
      
      ForschungRecordKonstanten.TechnologieWegeArray'Write (Stream (File => DateiForschungendatenbank),
                                                            ForschungenDatenbank.TechnologieWege);
      
      ForschungRecordKonstanten.TechnologieUmgebungsgrößeArray'Write (Stream (File => DateiForschungendatenbank),
                                                                        ForschungenDatenbank.TechnologieUmgebungsgröße);
      
      Close (File => DateiForschungendatenbank);
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTB1.Logik (MeldungExtern => "SchreibenDatenbankenLogik.SchreibenForschungenDatenbank: Konnte nicht gespeichert werden: "
                                     & UmwandlungssystemHTB3.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         
         case
           Is_Open (File => DateiForschungendatenbank)
         is
            when True =>
               Close (File => DateiForschungendatenbank);
               
            when False =>
               null;
         end case;
      
   end SchreibenForschungenDatenbank;
   
   
   
   procedure SchreibenGebäudeDatenbank
   is begin
      
      DateizugriffssystemHTB5.ErstellenStream (DateiartExtern => DateiGebäudedatenbank,
                                  NameExtern     => VerzeichnisKonstanten.GebaeudeDatenbank);
      
      GebaeudeDatenbank.GebäudelisteArray'Write (Stream (File => DateiGebäudedatenbank),
                                                  GebaeudeDatenbank.Gebäudeliste);
      
      Close (File => DateiGebäudedatenbank);
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTB1.Logik (MeldungExtern => "SchreibenDatenbankenLogik.SchreibenGebäudeDatenbank: Konnte nicht gespeichert werden: "
                                     & UmwandlungssystemHTB3.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         
         case
           Is_Open (File => DateiGebäudedatenbank)
         is
            when True =>
               Close (File => DateiGebäudedatenbank);
               
            when False =>
               null;
         end case;
      
   end SchreibenGebäudeDatenbank;
   
   
   
   procedure SchreibenKartenDatenbanken
   is begin
      
      DateizugriffssystemHTB5.ErstellenStream (DateiartExtern => DateiKartendatenbank,
                                  NameExtern     => VerzeichnisKonstanten.KartenDatenbank);
            
      KartenDatenbank.BasisgrundlisteArray'Write (Stream (File => DateiKartendatenbank),
                                                  KartenDatenbank.Basisgrundliste);
      
      KartenDatenbank.ZusatzgrundlisteArray'Write (Stream (File => DateiKartendatenbank),
                                                   KartenDatenbank.Zusatzgrundliste);
      
      KartenDatenbank.KartenflusslisteArray'Write (Stream (File => DateiKartendatenbank),
                                                   KartenDatenbank.Kartenflussliste);
      
      KartenDatenbank.KartenressourcenlisteArray'Write (Stream (File => DateiKartendatenbank),
                                                        KartenDatenbank.Kartenressourcenliste);
      
      Close (File => DateiKartendatenbank);
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTB1.Logik (MeldungExtern => "SchreibenDatenbankenLogik.SchreibenKartenDatenbanken: Konnte nicht gespeichert werden: " &
                                       UmwandlungssystemHTB3.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         
         case
           Is_Open (File => DateiKartendatenbank)
         is
            when True =>
               Close (File => DateiKartendatenbank);
               
            when False =>
               null;
         end case;
      
   end SchreibenKartenDatenbanken;
   
   
   
   procedure SchreibenVerbesserungenDatenbank
   is begin
      
      DateizugriffssystemHTB5.ErstellenStream (DateiartExtern => DateiVerbesserungendatenbank,
                                  NameExtern     => VerzeichnisKonstanten.VerbesserungenDatenbank);
      
      VerbesserungenDatenbank.VerbesserungenlisteArray'Write (Stream (File => DateiVerbesserungendatenbank),
                                                              VerbesserungenDatenbank.Verbesserungenliste);
      
      VerbesserungenDatenbank.WegelisteArray'Write (Stream (File => DateiVerbesserungendatenbank),
                                                    VerbesserungenDatenbank.Wegeliste);
      
      Close (File => DateiVerbesserungendatenbank);
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTB1.Logik (MeldungExtern => "SchreibenDatenbankenLogik.SchreibenVerbesserungenDatenbank: Konnte nicht gespeichert werden: "
                                     & UmwandlungssystemHTB3.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         
         case
           Is_Open (File => DateiVerbesserungendatenbank)
         is
            when True =>
               Close (File => DateiVerbesserungendatenbank);
               
            when False =>
               null;
         end case;
      
   end SchreibenVerbesserungenDatenbank;
      
         
   
   procedure SchreibenSpeziesDatenbank
   is begin
      
      DateizugriffssystemHTB5.ErstellenStream (DateiartExtern => DateiSpeziesdatenbank,
                                  NameExtern     => VerzeichnisKonstanten.SpeziesDatenbank);
      
      SpeziesDatenbank.SpezieslisteArray'Write (Stream (File => DateiSpeziesdatenbank),
                                                SpeziesDatenbank.Speziesliste);
      
      Close (File => DateiSpeziesdatenbank);
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTB1.Logik (MeldungExtern => "SchreibenDatenbankenLogik.SchreibenSpeziesDatenbank: Konnte nicht gespeichert werden: " &
                                       UmwandlungssystemHTB3.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         
         case
           Is_Open (File => DateiSpeziesdatenbank)
         is
            when True =>
               Close (File => DateiSpeziesdatenbank);
               
            when False =>
               null;
         end case;
      
   end SchreibenSpeziesDatenbank;
   
   
   
   procedure SchreibenEffekteDatenbank
   is begin
      
      DateizugriffssystemHTB5.ErstellenStream (DateiartExtern => DateiEffektedatenbank,
                                  NameExtern     => VerzeichnisKonstanten.EffekteDatenbank);
      
      EffekteDatenbank.EffektelisteArray'Write (Stream (File => DateiEffektedatenbank),
                                                EffekteDatenbank.Effekteliste);
      
      Close (File => DateiEffektedatenbank);
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTB1.Logik (MeldungExtern => "SchreibenDatenbankenLogik.SchreibenEffekteDatenbank: Konnte nicht gespeichert werden: "
                                     & UmwandlungssystemHTB3.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         
         case
           Is_Open (File => DateiEffektedatenbank)
         is
            when True =>
               Close (File => DateiEffektedatenbank);
               
            when False =>
               null;
         end case;
      
   end SchreibenEffekteDatenbank;

end SchreibenDatenbankenLogik;
