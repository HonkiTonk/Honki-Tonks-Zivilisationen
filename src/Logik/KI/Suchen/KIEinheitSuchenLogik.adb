with KartenKonstanten;
with KartenRecordKonstanten;

with LeseWeltkarte;
with LeseEinheitenGebaut;
with LeseAllgemeines;

with KartenkoordinatenberechnungssystemLogik;
with EinheitSuchenLogik;

with KIKonstanten;

package body KIEinheitSuchenLogik is

   function FeindlicheEinheitInUmgebungSuchen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      FeindExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return KartenRecords.AchsenKartenfeldNaturalRecord
   is
      use type KartenDatentypen.Kartenfeld;
   begin
      
      Einheitenkoordinaten := LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      
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
                                                 SpeziesExtern     => EinheitSpeziesNummerExtern.Spezies)
               then
                  null;
                  
               else
                  FeindlicheEinheit := EinheitSuchenLogik.KoordinatenEinheitMitSpeziesSuchen (SpeziesExtern     => FeindExtern,
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
