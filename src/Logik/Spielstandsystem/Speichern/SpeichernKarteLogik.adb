with Ada.Exceptions; use Ada.Exceptions;

with KartenKonstanten;
with EinheitenKonstanten;
with StadtKonstanten;
with KartenRecordKonstanten;
with SystemKonstanten;
with SpeziesKonstanten;
with SpeziesDatentypen;

with LeseWeltkarte;

with SpielstandAllgemeinesLogik;
with MeldungssystemHTSEB;
with UmwandlungssystemHTSEB;

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
                 False = SichtbarkeitSchreiben (KoordinatenExtern    => (EbeneSchleifenwert, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                                DateiSpeichernExtern => DateiSpeichernExtern)
               then
                  return False;
                     
               elsif
                 False = BasisgrundSchreiben (KoordinatenExtern    => (EbeneSchleifenwert, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
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
                 False = VorhandeneFeldelementeSchreiben (ZusatzgrundExtern    => Zusatzgrund,
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
                 False = FeldelementeSchreiben (ZusatzgrundExtern    => Zusatzgrund,
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
   
   
   
   function SichtbarkeitSchreiben
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      DateiSpeichernExtern : in File_Type)
      return Boolean
   is
      use type SystemDatentypen.Sichtbarkeitszahl;
   begin
      
      GesamteSichtbarkeit := LeseWeltkarte.GesamteSichtbarkeit (KoordinatenExtern => KoordinatenExtern);
      
      BereichSchleife:
      for BereichSchleifenwert in SpeziesKonstanten.SpeziesanfangLadenSpeichernArray'Range loop
         
         Sichtbarkeit := 0;
      
         SichtbarkeitSchleife:
         for SichtbarkeitSchleifenwert in SpeziesKonstanten.SpeziesanfangSpeichernLaden (BereichSchleifenwert) .. SpeziesKonstanten.SpeziesendeSpeichernLaden (BereichSchleifenwert) loop
         
            case
              GesamteSichtbarkeit (SichtbarkeitSchleifenwert)
            is
               when True =>
                  Sichtbarkeit := Sichtbarkeit + 2**(SpeziesDatentypen.Spezies_Vorhanden_Enum'Pos (SichtbarkeitSchleifenwert)
                                                     - SpeziesDatentypen.Spezies_Vorhanden_Enum'Pos (SpeziesKonstanten.SpeziesanfangSpeichernLaden (BereichSchleifenwert)));
               
               when False =>
                  null;
            end case;
         
         end loop SichtbarkeitSchleife;
      
         SystemDatentypen.Sichtbarkeitszahl'Write (Stream (File => DateiSpeichernExtern),
                                                   Sichtbarkeit);
         
      end loop BereichSchleife;
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "SpeichernKarteLogik.SichtbarkeitSchreiben: Konnte nicht gespeichert werden: "
                                     & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end SichtbarkeitSchreiben;
   
   
   
   function BasisgrundSchreiben
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
         MeldungssystemHTSEB.Logik (MeldungExtern => "SpeichernKarteLogik.BasisgrundSchreiben: Konnte nicht gespeichert werden: "
                                     & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end BasisgrundSchreiben;
   
   
   
   function VorhandeneFeldelementeSchreiben
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
      use type SystemDatentypen.FeldelementVorhanden;
   begin
      
      case
        ZusatzgrundExtern
      is
         when KartengrundDatentypen.Leer_Zusatzgrund_Enum =>
            VorhandeneFeldelemente := SystemKonstanten.NichtsVorhanden;
                     
         when others =>
            VorhandeneFeldelemente := SystemKonstanten.ZusatzgrundVorhanden;
      end case;
               
      if
        FeldeffekteExtern = KartenRecordKonstanten.LeerEffekte
      then
         null;
                  
      else
         VorhandeneFeldelemente := VorhandeneFeldelemente + SystemKonstanten.FeldeffekteVorhanden;
      end if;
               
      case
        FlussExtern
      is
         when KartenextraDatentypen.Leer_Fluss_Enum =>
            null;
                     
         when others =>
            VorhandeneFeldelemente := VorhandeneFeldelemente + SystemKonstanten.FlussVorhanden;
      end case;
               
      case
        RessourceExtern
      is
         when KartenextraDatentypen.Leer_Ressource_Enum =>
            null;
                     
         when others =>
            VorhandeneFeldelemente := VorhandeneFeldelemente + SystemKonstanten.RessourcenVorhanden;
      end case;
               
      case
        WegExtern
      is
         when KartenverbesserungDatentypen.Leer_Weg_Enum =>
            null;
                     
         when others =>
            VorhandeneFeldelemente := VorhandeneFeldelemente + SystemKonstanten.WegVorhanden;
      end case;
               
      case
        VerbesserungExtern
      is
         when KartenverbesserungDatentypen.Leer_Verbesserung_Enum =>
            null;
                     
         when others =>
            VorhandeneFeldelemente := VorhandeneFeldelemente + SystemKonstanten.VerbesserungVorhanden;
      end case;
               
      if
        EinheitExtern = EinheitenKonstanten.LeerEinheit
      then
         null;
                  
      else
         VorhandeneFeldelemente := VorhandeneFeldelemente + SystemKonstanten.EinheitVorhanden;
      end if;
                             
      if
        StadtExtern = StadtKonstanten.LeerStadt
      then
         null;
                  
      else
         VorhandeneFeldelemente := VorhandeneFeldelemente + SystemKonstanten.StadtVorhanden;
      end if;
      
      SystemDatentypen.FeldelementVorhanden'Write (Stream (File => DateiSpeichernExtern),
                                                   VorhandeneFeldelemente);
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "SpeichernKarteLogik.VorhandeneFeldelementeSchreiben: Konnte nicht gespeichert werden: "
                                     & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end VorhandeneFeldelementeSchreiben;
   
   
   
   function FeldelementeSchreiben
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
         KartenRecords.FeldeffektArray'Write (Stream (File => DateiSpeichernExtern),
                                              FeldeffekteExtern);
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
         MeldungssystemHTSEB.Logik (MeldungExtern => "SpeichernKarteLogik.FeldelementeSchreiben: Konnte nicht gespeichert werden: "
                                     & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end FeldelementeSchreiben;

end SpeichernKarteLogik;
