with KartenKonstanten;
with EinheitenKonstanten;
with StadtKonstanten;
with KartenRecordKonstanten;
with SystemKonstanten;
with SpeziesKonstanten;
with SpeziesDatentypen;

with LeseWeltkarte;

with SpielstandAllgemeinesLogik;
with Fehlermeldungssystem;
with FehlermeldungssystemZusatzinformationen;

-- Bei Änderungen am Speichersystem auch immer das Ladesystem anpassen!
package body SpeichernKarteLogik is

   procedure Karte
     (DateiSpeichernExtern : in File_Type;
      AutospeichernExtern : in Boolean)
   is begin
      
      KartenRecords.PermanenteKartenparameterRecord'Write (Stream (File => DateiSpeichernExtern),
                                                           LeseWeltkarteneinstellungen.GesamteEinstellungen);
      
      EAchseSchleife:
      for EAchseSchleifenwert in KartenKonstanten.AnfangEAchse .. KartenKonstanten.EndeEAchse loop
         YAchseSchleife:
         for YAchseSchleifenwert in KartenKonstanten.AnfangYAchse .. LeseWeltkarteneinstellungen.YAchse loop
            XAchseSchleife:
            for XAchseSchleifenwert in KartenKonstanten.AnfangXAchse .. LeseWeltkarteneinstellungen.XAchse loop
               
               SichtbarkeitSchreiben (KoordinatenExtern    => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert),
                                      DateiSpeichernExtern => DateiSpeichernExtern);
               BasisgrundSchreiben (KoordinatenExtern    => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert),
                                    DateiSpeichernExtern => DateiSpeichernExtern);
               
               Zusatzgrund := LeseWeltkarte.Zusatzgrund (KoordinatenExtern => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert));
               Feldeffekte := LeseWeltkarte.Feldeffekte (KoordinatenExtern => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert));
               Fluss := LeseWeltkarte.Fluss (KoordinatenExtern => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert));
               Ressource := LeseWeltkarte.Ressource (KoordinatenExtern => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert));
               Weg := LeseWeltkarte.Weg (KoordinatenExtern => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert));
               Verbesserung := LeseWeltkarte.Verbesserung (KoordinatenExtern => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert));
               Einheit := LeseWeltkarte.EinheitenbelegungGrund (KoordinatenExtern => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert));
               Stadt := LeseWeltkarte.StadtbelegungGrund (KoordinatenExtern => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert));
               
               VorhandeneFeldelementeSchreiben (ZusatzgrundExtern    => Zusatzgrund,
                                                FeldeffekteExtern    => Feldeffekte,
                                                FlussExtern          => Fluss,
                                                RessourceExtern      => Ressource,
                                                WegExtern            => Weg,
                                                VerbesserungExtern   => Verbesserung,
                                                EinheitExtern        => Einheit,
                                                StadtExtern          => Stadt,
                                                DateiSpeichernExtern => DateiSpeichernExtern);
               
               FeldelementeSchreiben (ZusatzgrundExtern    => Zusatzgrund,
                                      FeldeffekteExtern    => Feldeffekte,
                                      FlussExtern          => Fluss,
                                      RessourceExtern      => Ressource,
                                      WegExtern            => Weg,
                                      VerbesserungExtern   => Verbesserung,
                                      EinheitExtern        => Einheit,
                                      StadtExtern          => Stadt,
                                      DateiSpeichernExtern => DateiSpeichernExtern);
               
            end loop XAchseSchleife;
         end loop YAchseSchleife;
                  
         SpielstandAllgemeinesLogik.FortschrittErhöhen (AutospeichernExtern => AutospeichernExtern);
         
      end loop EAchseSchleife;
      
   end Karte;
   
   
   
   procedure SichtbarkeitSchreiben
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      DateiSpeichernExtern : in File_Type)
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
                  Sichtbarkeit := Sichtbarkeit + 2**(SpeziesDatentypen.Spezies_Verwendet_Enum'Pos (SichtbarkeitSchleifenwert)
                                                     - SpeziesDatentypen.Spezies_Verwendet_Enum'Pos (SpeziesKonstanten.SpeziesanfangSpeichernLaden (BereichSchleifenwert)));
               
               when False =>
                  null;
            end case;
         
         end loop SichtbarkeitSchleife;
      
         SystemDatentypen.Sichtbarkeitszahl'Write (Stream (File => DateiSpeichernExtern),
                                                   Sichtbarkeit);
         
      end loop BereichSchleife;
      
   end SichtbarkeitSchreiben;
   
   
   
   procedure BasisgrundSchreiben
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      DateiSpeichernExtern : in File_Type)
   is begin
            
      case
        KoordinatenExtern.EAchse
      is
         when KartenKonstanten.HimmelKonstante | KartenKonstanten.WeltraumKonstante =>
            null;
            
         when KartenKonstanten.PlaneteninneresKonstante .. KartenKonstanten.OberflächeKonstante =>
            KartengrundDatentypen.Basisgrund_Vorhanden_Enum'Write (Stream (File => DateiSpeichernExtern),
                                                                   LeseWeltkarte.Basisgrund (KoordinatenExtern => KoordinatenExtern));
            
         when others =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "SpeichernKarteLogik.BasisgrundSchreiben - Ungültige Ebene "
                                        & FehlermeldungssystemZusatzinformationen.Koordinaten (KoordinatenExtern => KoordinatenExtern));
      end case;
      
   end BasisgrundSchreiben;
   
   
   
   procedure VorhandeneFeldelementeSchreiben
     (ZusatzgrundExtern : in KartengrundDatentypen.Zusatzgrund_Enum;
      FeldeffekteExtern : in KartenRecords.FeldeffektArray;
      FlussExtern : in KartenextraDatentypen.Fluss_Enum;
      RessourceExtern : in KartenextraDatentypen.Ressourcen_Enum;
      WegExtern : in KartenverbesserungDatentypen.Weg_Enum;
      VerbesserungExtern : in KartenverbesserungDatentypen.Verbesserung_Enum;
      EinheitExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      StadtExtern : in StadtRecords.SpeziesStadtnummerRecord;
      DateiSpeichernExtern : in File_Type)
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
      
   end VorhandeneFeldelementeSchreiben;
   
   
   
   procedure FeldelementeSchreiben
     (ZusatzgrundExtern : in KartengrundDatentypen.Zusatzgrund_Enum;
      FeldeffekteExtern : in KartenRecords.FeldeffektArray;
      FlussExtern : in KartenextraDatentypen.Fluss_Enum;
      RessourceExtern : in KartenextraDatentypen.Ressourcen_Enum;
      WegExtern : in KartenverbesserungDatentypen.Weg_Enum;
      VerbesserungExtern : in KartenverbesserungDatentypen.Verbesserung_Enum;
      EinheitExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      StadtExtern : in StadtRecords.SpeziesStadtnummerRecord;
      DateiSpeichernExtern : in File_Type)
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
      
   end FeldelementeSchreiben;

end SpeichernKarteLogik;
