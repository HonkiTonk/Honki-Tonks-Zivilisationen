with KartenKonstanten;
with KartenRecordKonstanten;
with SystemDatentypen;

with LeseWeltkarte;
with LeseEinheitenGebaut;
with LeseAllgemeines;

with KartenkoordinatenberechnungssystemLogik;
with EinheitSuchenLogik;

with KIKonstanten;

package body KIEinheitSuchenLogik is

   function FeindlicheEinheitInUmgebungSuchen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      FeindExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return KartenRecords.AchsenKartenfeldNaturalRecord
   is
      use type KartenDatentypen.Senkrechte;
      use type KartenDatentypen.Waagerechte;
   begin
      
      Einheitenkoordinaten := LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      
      SenkrechtePrüfen := 1;
      SenkrechteGeprüft := SenkrechtePrüfen - 1;
      
      WaagerechtePrüfen := 1;
      WaagerechteGeprüft := WaagerechtePrüfen - 1;
      
      FeindSuchenSchleife:
      while SenkrechtePrüfen <= KIKonstanten.YFelderreichweite (LeseAllgemeines.Schwierigkeitsgrad) loop
         YAchseSchleife:
         for YAchseSchleifenwert in -SenkrechtePrüfen .. SenkrechtePrüfen loop
            XAchseSchleife:
            for XAchseSchleifenwert in -WaagerechtePrüfen .. WaagerechtePrüfen loop
            
               KartenWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => Einheitenkoordinaten,
                                                                                                         ÄnderungExtern    => (KartenKonstanten.LeerEAchseÄnderung, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                         TaskExtern        => SystemDatentypen.Logik_Task_Enum);
            
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
                                                                                              TaskExtern        => SystemDatentypen.Logik_Task_Enum);
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
         
         SenkrechteGeprüft := SenkrechtePrüfen;
         SenkrechtePrüfen := SenkrechtePrüfen + 1;
         
         WaagerechteGeprüft := WaagerechtePrüfen;
         WaagerechtePrüfen := WaagerechtePrüfen + 1;
         
      end loop FeindSuchenSchleife;
      
      return KartenRecordKonstanten.LeerKoordinate;
      
   end FeindlicheEinheitInUmgebungSuchen;
   
   
   
   function TransporterSuchen
     return Integer
   is begin
      
      return 0;
      
   end TransporterSuchen;

end KIEinheitSuchenLogik;
