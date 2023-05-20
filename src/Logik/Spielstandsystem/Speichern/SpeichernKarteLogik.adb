with KartenKonstanten;
with EinheitenKonstanten;
with StadtKonstanten;
with KartenRecordKonstanten;

with LeseWeltkarte;

with SpielstandAllgemeinesLogik;
with Fehlermeldungssystem;
with FehlermeldungssystemZusatzinformationen;

-- Bei Änderungen am Speichersystem auch immer das Ladesystem anpassen!
package body SpeichernKarteLogik is

   procedure Karte
     (DateiSpeichernExtern : in File_Type;
      AutospeichernExtern : in Boolean)
   is
      use type EinheitenRecords.SpeziesEinheitnummerRecord;
      use type StadtRecords.SpeziesStadtnummerRecord;
      use type KartenRecords.FeldeffektArray;
   begin
      
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
               
               ZusatzgrundSchreiben (KoordinatenExtern    => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert),
                                     DateiSpeichernExtern => DateiSpeichernExtern);
               
               Feldeffekte := LeseWeltkarte.Feldeffekte (KoordinatenExtern => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert));
                                             
               if
                 Feldeffekte = KartenRecordKonstanten.LeerEffekte
               then
                  Boolean'Write (Stream (File => DateiSpeichernExtern),
                                 False);
                  
               else
                  Boolean'Write (Stream (File => DateiSpeichernExtern),
                                 True);
                  KartenRecords.FeldeffektArray'Write (Stream (File => DateiSpeichernExtern),
                                                       Feldeffekte);
               end if;
               
               FlussSchreiben (KoordinatenExtern    => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert),
                               DateiSpeichernExtern => DateiSpeichernExtern);
               
               RessourcenSchreiben (KoordinatenExtern    => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert),
                                    DateiSpeichernExtern => DateiSpeichernExtern);
               
               WegSchreiben (KoordinatenExtern    => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert),
                             DateiSpeichernExtern => DateiSpeichernExtern);
               
               Verbesserung := LeseWeltkarte.Verbesserung (KoordinatenExtern => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert));
               
               case
                 Verbesserung
               is
                  when KartenverbesserungDatentypen.Leer_Verbesserung_Enum =>
                     Boolean'Write (Stream (File => DateiSpeichernExtern),
                                    False);
                     
                  when others =>
                     Boolean'Write (Stream (File => DateiSpeichernExtern),
                                    True);
                     KartenverbesserungDatentypen.Verbesserung_Vorhanden_Enum'Write (Stream (File => DateiSpeichernExtern),
                                                                                     Verbesserung);
               end case;
               
               Einheit := LeseWeltkarte.EinheitenbelegungGrund (KoordinatenExtern => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert));
               
               if
                 Einheit = EinheitenKonstanten.LeerEinheit
               then
                  Boolean'Write (Stream (File => DateiSpeichernExtern),
                                 False);
                  
               else
                  Boolean'Write (Stream (File => DateiSpeichernExtern),
                                 True);
                  EinheitenRecords.SpeziesEinheitnummerVorhandenRecord'Write (Stream (File => DateiSpeichernExtern),
                                                                              (Einheit.Spezies, Einheit.Nummer));
               end if;
               
               Stadt := LeseWeltkarte.StadtbelegungGrund (KoordinatenExtern => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert));
               
               if
                 Stadt = StadtKonstanten.LeerStadt
               then
                  Boolean'Write (Stream (File => DateiSpeichernExtern),
                                 False);
                  
               else
                  Boolean'Write (Stream (File => DateiSpeichernExtern),
                                 True);
                  StadtRecords.SpeziesStadtnummerVorhandenRecord'Write (Stream (File => DateiSpeichernExtern),
                                                                        (Stadt.Spezies, Stadt.Nummer));
               end if;
               
            end loop XAchseSchleife;
         end loop YAchseSchleife;
                  
         SpielstandAllgemeinesLogik.FortschrittErhöhen (AutospeichernExtern => AutospeichernExtern);
         
      end loop EAchseSchleife;
      
   end Karte;
   
   
   
   procedure SichtbarkeitSchreiben
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      DateiSpeichernExtern : in File_Type)
   is
      use type KartenRecords.Sichtbarkeitszahl;
   begin
      
      GesamteSichtbarkeit := LeseWeltkarte.GesamteSichtbarkeit (KoordinatenExtern => KoordinatenExtern);
      
      BereichSchleife:
      for BereichSchleifenwert in 1 .. 3 loop
         
         Sichtbarkeit := 0;
         
         case
           BereichSchleifenwert
         is
            when 1 =>
               SichtbarkeitAnfang := SpeziesDatentypen.Speichern_Laden_Eins_Enum'First;
               SichtbarkeitEnde := SpeziesDatentypen.Speichern_Laden_Eins_Enum'Last;
               
            when 2 =>
               SichtbarkeitAnfang := SpeziesDatentypen.Speichern_Laden_Zwei_Enum'First;
               SichtbarkeitEnde := SpeziesDatentypen.Speichern_Laden_Zwei_Enum'Last;
               
            when 3 =>
               SichtbarkeitAnfang := SpeziesDatentypen.Speichern_Laden_Drei_Enum'First;
               SichtbarkeitEnde := SpeziesDatentypen.Speichern_Laden_Drei_Enum'Last;
         end case;
      
         SichtbarkeitSchleife:
         for SichtbarkeitSchleifenwert in SichtbarkeitAnfang .. SichtbarkeitEnde loop
         
            case
              GesamteSichtbarkeit (SichtbarkeitSchleifenwert)
            is
               when True =>
                  Sichtbarkeit := Sichtbarkeit + 2**(SpeziesDatentypen.Spezies_Verwendet_Enum'Pos (SichtbarkeitSchleifenwert) - SpeziesDatentypen.Spezies_Verwendet_Enum'Pos (SichtbarkeitAnfang));
               
               when False =>
                  null;
            end case;
         
         end loop SichtbarkeitSchleife;
      
         KartenRecords.Sichtbarkeitszahl'Write (Stream (File => DateiSpeichernExtern),
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
   
   
   
   procedure ZusatzgrundSchreiben
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      DateiSpeichernExtern : in File_Type)
   is begin
            
      case
        KoordinatenExtern.EAchse
      is
         when KartenKonstanten.UnterflächeKonstante | KartenKonstanten.OberflächeKonstante =>
            Zusatzgrund := LeseWeltkarte.Zusatzgrund (KoordinatenExtern => KoordinatenExtern);
            
            if
              Zusatzgrund not in KartengrundDatentypen.Zusatzgrund_Vorhanden_Enum'Range
            then
               Boolean'Write (Stream (File => DateiSpeichernExtern),
                              False);
               
            else
               Boolean'Write (Stream (File => DateiSpeichernExtern),
                              True);
               KartengrundDatentypen.Zusatzgrund_Vorhanden_Enum'Write (Stream (File => DateiSpeichernExtern),
                                                                       Zusatzgrund);
            end if;
            
         when others =>
            null;
      end case;
      
   end ZusatzgrundSchreiben;
   
   
   
   procedure FlussSchreiben
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      DateiSpeichernExtern : in File_Type)
   is begin
      
      case
        KoordinatenExtern.EAchse
      is
         when KartenKonstanten.PlaneteninneresKonstante .. KartenKonstanten.OberflächeKonstante =>
            Fluss := LeseWeltkarte.Fluss (KoordinatenExtern => KoordinatenExtern);
               
            if
              Fluss not in KartenextraDatentypen.Fluss_Vorhanden_Enum'Range
            then
               Boolean'Write (Stream (File => DateiSpeichernExtern),
                              False);
               
            else
               Boolean'Write (Stream (File => DateiSpeichernExtern),
                              True);
               KartenextraDatentypen.Fluss_Vorhanden_Enum'Write (Stream (File => DateiSpeichernExtern),
                                                                 Fluss);
            end if;
            
         when others =>
            null;
      end case;
      
   end FlussSchreiben;
   
   
   
   procedure RessourcenSchreiben
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      DateiSpeichernExtern : in File_Type)
   is begin
      
      case
        KoordinatenExtern.EAchse
      is
         when KartenKonstanten.PlaneteninneresKonstante .. KartenKonstanten.OberflächeKonstante =>
            Ressource := LeseWeltkarte.Ressource (KoordinatenExtern => KoordinatenExtern);
               
            if
              Ressource not in KartenextraDatentypen.Ressourcen_Vorhanden_Enum'Range
            then
               Boolean'Write (Stream (File => DateiSpeichernExtern),
                              False);
            
            else
               Boolean'Write (Stream (File => DateiSpeichernExtern),
                              True);
               KartenextraDatentypen.Ressourcen_Vorhanden_Enum'Write (Stream (File => DateiSpeichernExtern),
                                                                      Ressource);
            end if;
         
         when others =>
            null;
      end case;
      
   end RessourcenSchreiben;
   
   
   
   procedure WegSchreiben
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      DateiSpeichernExtern : in File_Type)
   is begin
      
      case
        KoordinatenExtern.EAchse
      is
         when KartenKonstanten.PlaneteninneresKonstante .. KartenKonstanten.OberflächeKonstante =>
            Weg := LeseWeltkarte.Weg (KoordinatenExtern => KoordinatenExtern);
               
            if
              Weg not in KartenverbesserungDatentypen.Weg_Vorhanden_Enum'Range
            then
               Boolean'Write (Stream (File => DateiSpeichernExtern),
                              False);
               
            else
               Boolean'Write (Stream (File => DateiSpeichernExtern),
                              True);
               KartenverbesserungDatentypen.Weg_Vorhanden_Enum'Write (Stream (File => DateiSpeichernExtern),
                                                                      Weg);
            end if;
            
         when others =>
            null;
      end case;
      
   end WegSchreiben;

end SpeichernKarteLogik;
