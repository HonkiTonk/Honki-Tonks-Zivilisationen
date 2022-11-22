with KartenKonstanten;
with EinheitenKonstanten;
with KartenRecordKonstanten;

with LeseWeltkarte;
with LeseEinheitenGebaut;
with LeseAllgemeines;

with KartenkoordinatenberechnungssystemLogik;
with EinheitSuchenLogik;

with KIKonstanten;

package body KIEinheitSuchenLogik is

   function FeindlicheEinheitInUmgebungSuchen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      FeindExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KartenRecords.AchsenKartenfeldNaturalRecord
   is
      use type KartenDatentypen.Kartenfeld;
   begin
      
      Einheitenkoordinaten := LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      UmgebungPrüfen := 1;
      BereitsGeprüft := UmgebungPrüfen - 1;
      
      FeindSuchenSchleife:
      while UmgebungPrüfen <= KIKonstanten.Felderreichweite (LeseAllgemeines.Schwierigkeitsgrad) loop
         YAchseSchleife:
         for YAchseSchleifenwert in -UmgebungPrüfen .. UmgebungPrüfen loop
            XAchseSchleife:
            for XAchseSchleifenwert in -UmgebungPrüfen .. UmgebungPrüfen loop
            
               KartenWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => Einheitenkoordinaten,
                                                                                                         ÄnderungExtern    => (KartenKonstanten.LeerEAchseÄnderung, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                         LogikGrafikExtern => True);
            
               if
                 KartenWert.XAchse = KartenKonstanten.LeerXAchse
               then
                  null;
               
               elsif
                 False = LeseWeltkarte.Sichtbar (KoordinatenExtern => KartenWert,
                                                 RasseExtern       => EinheitRasseNummerExtern.Rasse)
               then
                  null;
                  
               else
                  FeindlicheEinheit := EinheitSuchenLogik.KoordinatenEinheitMitRasseSuchen (RasseExtern       => FeindExtern,
                                                                                            KoordinatenExtern => KartenWert,
                                                                                            LogikGrafikExtern => True);
                  case
                    FeindlicheEinheit
                  is
                     when EinheitenKonstanten.LeerNummer =>
                        null;
                     
                     when others =>
                        return KartenWert;
                  end case;
               end if;
               
            end loop XAchseSchleife;
         end loop YAchseSchleife;
         
         UmgebungPrüfen := UmgebungPrüfen + 1;
         BereitsGeprüft := UmgebungPrüfen - 1;
         
      end loop FeindSuchenSchleife;
      
      return KartenRecordKonstanten.LeerKoordinate;
      
   end FeindlicheEinheitInUmgebungSuchen;
   
   
   
   function TransporterSuchen
     return Integer
   is begin
      
      return 0;
      
   end TransporterSuchen;

end KIEinheitSuchenLogik;
