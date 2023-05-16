with WeltkarteRecords;
with KartenKonstanten;
with EinheitenKonstanten;
with StadtKonstanten;
with KartenRecordKonstanten;

with LeseWeltkarte;
with LeseWeltkarteneinstellungen;

with SpielstandAllgemeinesLogik;

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
               
               WeltkarteRecords.ImmerVorhanden'Write (Stream (File => DateiSpeichernExtern),
                                                      LeseWeltkarte.ImmerVorhanden (KoordinatenExtern => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert)));
               
               Zusatzgrund := LeseWeltkarte.Zusatzgrund (KoordinatenExtern => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert));
               
               case
                 Zusatzgrund
               is
                  when KartengrundDatentypen.Leer_Zusatzgrund_Enum =>
                     null;
                     
                  when others =>
                     KartengrundDatentypen.Zusatzgrund_Vorhanden_Enum'Write (Stream (File => DateiSpeichernExtern),
                                                                             Zusatzgrund);
               end case;
               
               Feldeffekte := LeseWeltkarte.Feldeffekte (KoordinatenExtern => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert));
               
               if
                 Feldeffekte = KartenRecordKonstanten.LeerEffekte
               then
                  null;
                  
               else
                  KartenRecords.FeldeffektArray'Write (Stream (File => DateiSpeichernExtern),
                                                       Feldeffekte);
               end if;
               
               Fluss := LeseWeltkarte.Fluss (KoordinatenExtern => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert));
               
               case
                 Fluss
               is
                  when KartenextraDatentypen.Leer_Fluss_Enum =>
                     null;
                     
                  when others =>
                     KartenextraDatentypen.Fluss_Vorhanden_Enum'Write (Stream (File => DateiSpeichernExtern),
                                                                       Fluss);
               end case;
               
               Ressource := LeseWeltkarte.Ressource (KoordinatenExtern => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert));
               
               case
                 Ressource
               is
                  when KartenextraDatentypen.Leer_Ressource_Enum =>
                     null;
                     
                  when others =>
                     KartenextraDatentypen.Ressourcen_Vorhanden_Enum'Write (Stream (File => DateiSpeichernExtern),
                                                                            Ressource);
               end case;
               
               Weg := LeseWeltkarte.Weg (KoordinatenExtern => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert));
               
               case
                 Weg
               is
                  when KartenverbesserungDatentypen.Leer_Weg_Enum =>
                     null;
                     
                  when others =>
                     KartenverbesserungDatentypen.Weg_Vorhanden_Enum'Write (Stream (File => DateiSpeichernExtern),
                                                                            Weg);
               end case;
               
               Verbesserung := LeseWeltkarte.Verbesserung (KoordinatenExtern => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert));
               
               case
                 Verbesserung
               is
                  when KartenverbesserungDatentypen.Leer_Verbesserung_Enum =>
                     null;
                     
                  when others =>
                     KartenverbesserungDatentypen.Verbesserung_Vorhanden_Enum'Write (Stream (File => DateiSpeichernExtern),
                                                                                     Verbesserung);
               end case;
               
               Einheit := LeseWeltkarte.EinheitenbelegungGrund (KoordinatenExtern => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert));
               
               if
                 Einheit = EinheitenKonstanten.LeerEinheit
               then
                  null;
                  
               else
                  EinheitenRecords.SpeziesEinheitnummerRecord'Write (Stream (File => DateiSpeichernExtern),
                                                                     Einheit);
               end if;
               
               Stadt := LeseWeltkarte.StadtbelegungGrund (KoordinatenExtern => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert));
               
               if
                 Stadt = StadtKonstanten.LeerStadt
               then
                  null;
                  
               else
                  StadtRecords.SpeziesStadtnummerRecord'Write (Stream (File => DateiSpeichernExtern),
                                                               Stadt);
               end if;
               
            end loop XAchseSchleife;
         end loop YAchseSchleife;
                  
         SpielstandAllgemeinesLogik.FortschrittErhöhen (AutospeichernExtern => AutospeichernExtern);
         
      end loop EAchseSchleife;
      
   end Karte;

end SpeichernKarteLogik;
