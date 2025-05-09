with Ada.Exceptions; use Ada.Exceptions;

with MeldungssystemHTSEB;
with UmwandlungssystemHTSEB;

with KartenKonstanten;
with EinheitenKonstanten;
with StadtKonstanten;
with KartenRecordKonstanten;
with SystemKonstanten;
with SpeziesKonstanten;

with LeseWeltkarte;

with SpielstandAllgemeinesLogik;

-- Bei Änderungen am Speichersystem auch immer das Ladesystem anpassen!
package body SpeichernKarteLogik is

   function Karte
     (DateiSpeichernExtern : in File_Type;
      AutospeichernExtern : in Boolean)
      return Boolean
   is begin
      
      KartenRecords.PermanenteKartenparameterRecord'Write (Stream (File => DateiSpeichernExtern),
                                                           LeseWeltkarteneinstellungen.GesamteEinstellungen);
      
      EbeneSchleife:
      for EbeneSchleifenwert in KartenKonstanten.AnfangEbene .. KartenKonstanten.EndeEbene loop
         SenkrechteSchleife:
         for SenkrechteSchleifenwert in KartenKonstanten.AnfangSenkrechte .. LeseWeltkarteneinstellungen.Senkrechte loop
            WaagerechteSchleife:
            for WaagerechteSchleifenwert in KartenKonstanten.AnfangWaagerechte .. LeseWeltkarteneinstellungen.Waagerechte loop
               
               if
                 False = Sichtbarkeit (KoordinatenExtern    => (EbeneSchleifenwert, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                       DateiSpeichernExtern => DateiSpeichernExtern)
               then
                  return False;
                     
               elsif
                 False = Basisgrund (KoordinatenExtern    => (EbeneSchleifenwert, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                     DateiSpeichernExtern => DateiSpeichernExtern)
               then
                  return False;
                  
               else
                  Zusatzgrund := LeseWeltkarte.Zusatzgrund (KoordinatenExtern => (EbeneSchleifenwert, SenkrechteSchleifenwert, WaagerechteSchleifenwert));
                  Feldeffekte := LeseWeltkarte.Feldeffekte (KoordinatenExtern => (EbeneSchleifenwert, SenkrechteSchleifenwert, WaagerechteSchleifenwert));
                  Fluss := LeseWeltkarte.Fluss (KoordinatenExtern => (EbeneSchleifenwert, SenkrechteSchleifenwert, WaagerechteSchleifenwert));
                  Ressource := LeseWeltkarte.Ressource (KoordinatenExtern => (EbeneSchleifenwert, SenkrechteSchleifenwert, WaagerechteSchleifenwert));
                  Weg := LeseWeltkarte.Weg (KoordinatenExtern => (EbeneSchleifenwert, SenkrechteSchleifenwert, WaagerechteSchleifenwert));
                  Verbesserung := LeseWeltkarte.Verbesserung (KoordinatenExtern => (EbeneSchleifenwert, SenkrechteSchleifenwert, WaagerechteSchleifenwert));
                  Einheit := LeseWeltkarte.EinheitenbelegungGrund (KoordinatenExtern => (EbeneSchleifenwert, SenkrechteSchleifenwert, WaagerechteSchleifenwert));
                  Stadt := LeseWeltkarte.StadtbelegungGrund (KoordinatenExtern => (EbeneSchleifenwert, SenkrechteSchleifenwert, WaagerechteSchleifenwert));
               end if;
               
               if
                 False = VorhandeneFeldelemente (ZusatzgrundExtern    => Zusatzgrund,
                                                 FeldeffekteExtern    => Feldeffekte,
                                                 FlussExtern          => Fluss,
                                                 RessourceExtern      => Ressource,
                                                 WegExtern            => Weg,
                                                 VerbesserungExtern   => Verbesserung,
                                                 EinheitExtern        => Einheit,
                                                 StadtExtern          => Stadt,
                                                 DateiSpeichernExtern => DateiSpeichernExtern)
               then
                  return False;
               
               elsif
                 False = Feldelemente (ZusatzgrundExtern    => Zusatzgrund,
                                       FeldeffekteExtern    => Feldeffekte,
                                       FlussExtern          => Fluss,
                                       RessourceExtern      => Ressource,
                                       WegExtern            => Weg,
                                       VerbesserungExtern   => Verbesserung,
                                       EinheitExtern        => Einheit,
                                       StadtExtern          => Stadt,
                                       DateiSpeichernExtern => DateiSpeichernExtern)
               then
                  return False;
                  
               else
                  null;
               end if;
               
            end loop WaagerechteSchleife;
         end loop SenkrechteSchleife;
                  
         SpielstandAllgemeinesLogik.FortschrittErhöhen (AutospeichernExtern => AutospeichernExtern);
         
      end loop EbeneSchleife;
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "SpeichernKarteLogik.Karte: Konnte nicht gespeichert werden: "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
         
   end Karte;
   
   
   
   function Sichtbarkeit
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      DateiSpeichernExtern : in File_Type)
      return Boolean
   is
      use type SystemDatentypen.EinByte;
   begin
      
      GesamteSichtbarkeit := LeseWeltkarte.GesamteSichtbarkeit (KoordinatenExtern => KoordinatenExtern);
      
      BereichSchleife:
      for BereichSchleifenwert in SpeziesKonstanten.SpeziesanfangLadenSpeichernArray'Range loop
         
         SichtbarkeitVorhanden := 0;
         AktuelleSichtbarkeit := 1;
      
         SichtbarkeitSchleife:
         for SichtbarkeitSchleifenwert in SpeziesKonstanten.SpeziesanfangSpeichernLaden (BereichSchleifenwert) .. SpeziesKonstanten.SpeziesendeSpeichernLaden (BereichSchleifenwert) loop
         
            case
              GesamteSichtbarkeit (SichtbarkeitSchleifenwert)
            is
               when True =>
                  SichtbarkeitVorhanden := SichtbarkeitVorhanden + AktuelleSichtbarkeit;
               
               when False =>
                  null;
            end case;
            
            AktuelleSichtbarkeit := AktuelleSichtbarkeit * 2;
            
         end loop SichtbarkeitSchleife;
      
         SystemDatentypen.EinByte'Write (Stream (File => DateiSpeichernExtern),
                                         SichtbarkeitVorhanden);
         
      end loop BereichSchleife;
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "SpeichernKarteLogik.Sichtbarkeit: Konnte nicht gespeichert werden: "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end Sichtbarkeit;
   
   
   
   function Basisgrund
     (KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      DateiSpeichernExtern : in File_Type)
      return Boolean
   is begin
      
      case
        KoordinatenExtern.Ebene
      is
         when KartenKonstanten.HimmelKonstante | KartenKonstanten.WeltraumKonstante =>
            null;
            
         when KartenKonstanten.PlaneteninneresKonstante .. KartenKonstanten.OberflächeKonstante =>
            KartengrundDatentypen.Basisgrund_Vorhanden_Enum'Write (Stream (File => DateiSpeichernExtern),
                                                                   LeseWeltkarte.Basisgrund (KoordinatenExtern => (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte)));
      end case;
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "SpeichernKarteLogik.Basisgrund: Konnte nicht gespeichert werden: "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end Basisgrund;
   
   
   
   function VorhandeneFeldelemente
     (ZusatzgrundExtern : in KartengrundDatentypen.Zusatzgrund_Enum;
      FeldeffekteExtern : in KartenRecords.FeldeffektArray;
      FlussExtern : in KartenextraDatentypen.Fluss_Enum;
      RessourceExtern : in KartenextraDatentypen.Ressourcen_Enum;
      WegExtern : in KartenverbesserungDatentypen.Weg_Enum;
      VerbesserungExtern : in KartenverbesserungDatentypen.Verbesserung_Enum;
      EinheitExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      StadtExtern : in StadtRecords.SpeziesStadtnummerRecord;
      DateiSpeichernExtern : in File_Type)
      return Boolean
   is
      use type EinheitenRecords.SpeziesEinheitnummerRecord;
      use type StadtRecords.SpeziesStadtnummerRecord;
      use type KartenRecords.FeldeffektArray;
      use type SystemDatentypen.EinByte;
   begin
      
      case
        ZusatzgrundExtern
      is
         when KartengrundDatentypen.Leer_Zusatzgrund_Enum =>
            FeldelementeVorhanden := SystemKonstanten.NichtsVorhanden;
                     
         when others =>
            FeldelementeVorhanden := SystemKonstanten.ZusatzgrundVorhanden;
      end case;
               
      if
        FeldeffekteExtern = KartenRecordKonstanten.LeerEffekte
      then
         null;
                  
      else
         FeldelementeVorhanden := FeldelementeVorhanden + SystemKonstanten.FeldeffekteVorhanden;
      end if;
               
      case
        FlussExtern
      is
         when KartenextraDatentypen.Leer_Fluss_Enum =>
            null;
                     
         when others =>
            FeldelementeVorhanden := FeldelementeVorhanden + SystemKonstanten.FlussVorhanden;
      end case;
               
      case
        RessourceExtern
      is
         when KartenextraDatentypen.Leer_Ressource_Enum =>
            null;
                     
         when others =>
            FeldelementeVorhanden := FeldelementeVorhanden + SystemKonstanten.RessourcenVorhanden;
      end case;
               
      case
        WegExtern
      is
         when KartenverbesserungDatentypen.Leer_Weg_Enum =>
            null;
                     
         when others =>
            FeldelementeVorhanden := FeldelementeVorhanden + SystemKonstanten.WegVorhanden;
      end case;
               
      case
        VerbesserungExtern
      is
         when KartenverbesserungDatentypen.Leer_Verbesserung_Enum =>
            null;
                     
         when others =>
            FeldelementeVorhanden := FeldelementeVorhanden + SystemKonstanten.VerbesserungVorhanden;
      end case;
               
      if
        EinheitExtern = EinheitenKonstanten.LeerEinheit
      then
         null;
                  
      else
         FeldelementeVorhanden := FeldelementeVorhanden + SystemKonstanten.EinheitVorhanden;
      end if;
                             
      if
        StadtExtern = StadtKonstanten.LeerStadt
      then
         null;
                  
      else
         FeldelementeVorhanden := FeldelementeVorhanden + SystemKonstanten.StadtVorhanden;
      end if;
      
      SystemDatentypen.EinByte'Write (Stream (File => DateiSpeichernExtern),
                                      FeldelementeVorhanden);
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "SpeichernKarteLogik.VorhandeneFeldelemente: Konnte nicht gespeichert werden: "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end VorhandeneFeldelemente;
   
   
   
   function Feldelemente
     (ZusatzgrundExtern : in KartengrundDatentypen.Zusatzgrund_Enum;
      FeldeffekteExtern : in KartenRecords.FeldeffektArray;
      FlussExtern : in KartenextraDatentypen.Fluss_Enum;
      RessourceExtern : in KartenextraDatentypen.Ressourcen_Enum;
      WegExtern : in KartenverbesserungDatentypen.Weg_Enum;
      VerbesserungExtern : in KartenverbesserungDatentypen.Verbesserung_Enum;
      EinheitExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      StadtExtern : in StadtRecords.SpeziesStadtnummerRecord;
      DateiSpeichernExtern : in File_Type)
      return Boolean
   is
      use type EinheitenRecords.SpeziesEinheitnummerRecord;
      use type StadtRecords.SpeziesStadtnummerRecord;
      use type KartenRecords.FeldeffektArray;
      use type SystemDatentypen.EinByte;
   begin
      
      if
        StadtExtern = StadtKonstanten.LeerStadt
      then
         null;
                  
      else
         StadtRecords.SpeziesStadtnummerVorhandenRecord'Write (Stream (File => DateiSpeichernExtern),
                                                               (StadtExtern.Spezies, StadtExtern.Nummer));
      end if;
      
      if
        EinheitExtern = EinheitenKonstanten.LeerEinheit
      then
         null;
                  
      else
         EinheitenRecords.SpeziesEinheitnummerVorhandenRecord'Write (Stream (File => DateiSpeichernExtern),
                                                                     (EinheitExtern.Spezies, EinheitExtern.Nummer));
      end if;
      
      case
        VerbesserungExtern
      is
         when KartenverbesserungDatentypen.Leer_Verbesserung_Enum =>
            null;
                     
         when others =>
            KartenverbesserungDatentypen.Verbesserung_Vorhanden_Enum'Write (Stream (File => DateiSpeichernExtern),
                                                                            VerbesserungExtern);
      end case;
      
      case
        WegExtern
      is
         when KartenverbesserungDatentypen.Leer_Weg_Enum =>
            null;
                     
         when others =>
            KartenverbesserungDatentypen.Weg_Vorhanden_Enum'Write (Stream (File => DateiSpeichernExtern),
                                                                   WegExtern);
      end case;
      
      case
        RessourceExtern
      is
         when KartenextraDatentypen.Leer_Ressource_Enum =>
            null;
                     
         when others =>
            KartenextraDatentypen.Ressourcen_Vorhanden_Enum'Write (Stream (File => DateiSpeichernExtern),
                                                                   RessourceExtern);
      end case;
      
      case
        FlussExtern
      is
         when KartenextraDatentypen.Leer_Fluss_Enum =>
            null;
                     
         when others =>
            KartenextraDatentypen.Fluss_Vorhanden_Enum'Write (Stream (File => DateiSpeichernExtern),
                                                              FlussExtern);
      end case;
      
      if
        FeldeffekteExtern = KartenRecordKonstanten.LeerEffekte
      then
         null;
                  
      else
         FeldeffekteVorhanden := 0;
         AktuellerFeldeffekt := 1;
         
         FeldeffekteSchleife:
         for FeldeffekteSchleifenwert in KartenRecords.FeldeffektArray'Range loop
            
            case
              FeldeffekteExtern (FeldeffekteSchleifenwert)
            is
               when True =>
                  FeldeffekteVorhanden := FeldeffekteVorhanden + AktuellerFeldeffekt;
                  
               when False =>
                  null;
            end case;
            
            AktuellerFeldeffekt := AktuellerFeldeffekt * 2;
            
         end loop FeldeffekteSchleife;
         
         SystemDatentypen.EinByte'Write (Stream (File => DateiSpeichernExtern),
                                         FeldeffekteVorhanden);
      end if;
      
      case
        ZusatzgrundExtern
      is
         when KartengrundDatentypen.Leer_Zusatzgrund_Enum =>
            null;
                     
         when others =>
            KartengrundDatentypen.Zusatzgrund_Vorhanden_Enum'Write (Stream (File => DateiSpeichernExtern),
                                                                    ZusatzgrundExtern);
      end case;
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "SpeichernKarteLogik.Feldelemente: Konnte nicht gespeichert werden: "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end Feldelemente;

end SpeichernKarteLogik;
