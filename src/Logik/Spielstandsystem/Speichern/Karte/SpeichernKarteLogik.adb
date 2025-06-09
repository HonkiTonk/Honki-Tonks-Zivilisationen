with Ada.Exceptions; use Ada.Exceptions;

with MeldungssystemHTSEB;
with UmwandlungssystemHTSEB;

with KartenKonstanten;
with StadtKonstanten;
with KartenRecordKonstanten;
with LadezeitenDatentypen;

with LeseWeltkarte;

with SpielstandAllgemeinesLogik;
with SpeichernSichtbarkeitLogik;
with LadezeitenLogik;

-- Bei Änderungen am Speichersystem auch immer das Ladesystem anpassen!
package body SpeichernKarteLogik is

   function Karte
     (DateiSpeichernExtern : in File_Type;
      AutospeichernExtern : in Boolean)
      return Boolean
   is begin
      
      KartenRecords.PermanenteKartenparameterRecord'Write (Stream (File => DateiSpeichernExtern),
                                                           LeseWeltkarteneinstellungen.GesamteEinstellungen);
      
      VorhandeneSpezies := SpielstandAllgemeinesLogik.VorhandeneSpeziesanzahl (SpeichernLadenExtern => True);
      
      EbeneSchleife:
      for EbeneSchleifenwert in KartenKonstanten.AnfangEbene .. KartenKonstanten.EndeEbene loop
         SenkrechteSchleife:
         for SenkrechteSchleifenwert in KartenKonstanten.AnfangSenkrechte .. LeseWeltkarteneinstellungen.Senkrechte loop
            WaagerechteSchleife:
            for WaagerechteSchleifenwert in KartenKonstanten.AnfangWaagerechte .. LeseWeltkarteneinstellungen.Waagerechte loop
               
               if
                 False = SpeichernSichtbarkeitLogik.Aufteilung (KoordinatenExtern       => (EbeneSchleifenwert, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                                                VorhandeneSpeziesExtern => VorhandeneSpezies,
                                                                DateiSpeichernExtern    => DateiSpeichernExtern)
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
                  
                  -- Stadt wird weiterhin gebraucht, da die Stadtbvelegung damit auch gespeichert wird.
                  -- Aber eventuell könnte man das mit der Stadt speichern? äöü
                  -- Wäre dann kleiner als wenn man das in der Karte speichert. äöü
                  -- Aber dann müsste man wieder durch alle Städte gehen um zu prüfen ob das Feld von einer Stadt belegt ist. äöü
                  -- Man könnte natürlich beides haben und nur den Stadtteil speichern. äöü
                  -- Erhöht natürlich den AS Verbrauch, mal drüber nachdenken. äöü
                  Stadt := LeseWeltkarte.StadtbelegungGrund (KoordinatenExtern => (EbeneSchleifenwert, SenkrechteSchleifenwert, WaagerechteSchleifenwert));
               end if;
               
               if
                 False = VorhandeneFeldelemente (ZusatzgrundExtern    => Zusatzgrund,
                                                 FeldeffekteExtern    => Feldeffekte,
                                                 FlussExtern          => Fluss,
                                                 RessourceExtern      => Ressource,
                                                 WegExtern            => Weg,
                                                 VerbesserungExtern   => Verbesserung,
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
                                       StadtExtern          => Stadt,
                                       DateiSpeichernExtern => DateiSpeichernExtern)
               then
                  return False;
                  
               else
                  null;
               end if;
               
            end loop WaagerechteSchleife;
         end loop SenkrechteSchleife;
         
         case
           AutospeichernExtern
         is
            when False =>
               null;
               
            when True =>
               LadezeitenLogik.Speichern (WelcheBerechnungszeitExtern => LadezeitenDatentypen.Karte_Enum,
                                          ErhöhungExtern              => 20);
         end case;
         -- SpielstandAllgemeinesLogik.FortschrittErhöhen (AutospeichernExtern => AutospeichernExtern);
         
      end loop EbeneSchleife;
      
      LadezeitenLogik.SpeichernMaximum (WelcheBerechnungszeitExtern => LadezeitenDatentypen.Karte_Enum);
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "SpeichernKarteLogik.Karte: Konnte nicht gespeichert werden: "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
         
   end Karte;
   
   
   
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
      StadtExtern : in StadtRecords.SpeziesStadtnummerRecord;
      DateiSpeichernExtern : in File_Type)
      return Boolean
   is
      use type StadtRecords.SpeziesStadtnummerRecord;
      use type KartenRecords.FeldeffektArray;
      use type SystemDatentypenHTSEB.EinByte;
   begin
      
      AktuellesFeldelement := 1;
      
      case
        ZusatzgrundExtern
      is
         when KartengrundDatentypen.Leer_Zusatzgrund_Enum =>
            FeldelementeVorhanden := 0;
                     
         when others =>
            FeldelementeVorhanden := AktuellesFeldelement;
      end case;
      
      AktuellesFeldelement := AktuellesFeldelement * 2;
               
      if
        FeldeffekteExtern = KartenRecordKonstanten.LeerEffekte
      then
         null;
                  
      else
         FeldelementeVorhanden := FeldelementeVorhanden + AktuellesFeldelement;
      end if;
      
      AktuellesFeldelement := AktuellesFeldelement * 2;
               
      case
        FlussExtern
      is
         when KartenextraDatentypen.Leer_Fluss_Enum =>
            null;
                     
         when others =>
            FeldelementeVorhanden := FeldelementeVorhanden + AktuellesFeldelement;
      end case;
      
      AktuellesFeldelement := AktuellesFeldelement * 2;
               
      case
        RessourceExtern
      is
         when KartenextraDatentypen.Leer_Ressource_Enum =>
            null;
                     
         when others =>
            FeldelementeVorhanden := FeldelementeVorhanden + AktuellesFeldelement;
      end case;
      
      AktuellesFeldelement := AktuellesFeldelement * 2;
               
      case
        WegExtern
      is
         when KartenverbesserungDatentypen.Leer_Weg_Enum =>
            null;
                     
         when others =>
            FeldelementeVorhanden := FeldelementeVorhanden + AktuellesFeldelement;
      end case;
      
      AktuellesFeldelement := AktuellesFeldelement * 2;
               
      case
        VerbesserungExtern
      is
         when KartenverbesserungDatentypen.Leer_Verbesserung_Enum =>
            null;
                     
         when others =>
            FeldelementeVorhanden := FeldelementeVorhanden + AktuellesFeldelement;
      end case;
      
      AktuellesFeldelement := AktuellesFeldelement * 2;
                             
      if
        StadtExtern = StadtKonstanten.LeerStadt
      then
         null;
                  
      else
         FeldelementeVorhanden := FeldelementeVorhanden + AktuellesFeldelement;
      end if;
      
      SystemDatentypenHTSEB.EinByte'Write (Stream (File => DateiSpeichernExtern),
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
      StadtExtern : in StadtRecords.SpeziesStadtnummerRecord;
      DateiSpeichernExtern : in File_Type)
      return Boolean
   is
      use type StadtRecords.SpeziesStadtnummerRecord;
      use type KartenRecords.FeldeffektArray;
      use type SystemDatentypenHTSEB.EinByte;
   begin
      
      if
        StadtExtern = StadtKonstanten.LeerStadt
      then
         null;
                  
      else
         StadtRecords.SpeziesStadtnummerVorhandenRecord'Write (Stream (File => DateiSpeichernExtern),
                                                               (StadtExtern.Spezies, StadtExtern.Nummer));
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
         
         SystemDatentypenHTSEB.EinByte'Write (Stream (File => DateiSpeichernExtern),
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
