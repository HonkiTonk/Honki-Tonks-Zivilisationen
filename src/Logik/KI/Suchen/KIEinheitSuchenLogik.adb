pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with KartenKonstanten;
with EinheitenKonstanten;
with KartenRecordKonstanten;

with LeseWeltkarte;
with LeseEinheitenGebaut;

with KartenkoordinatenberechnungssystemLogik;
with EinheitSuchenLogik;

package body KIEinheitSuchenLogik is

   function FeindlicheEinheitInUmgebungSuchen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      FeindExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KartenRecords.AchsenKartenfeldNaturalRecord
   is begin
      
      YAchseSchleife:
      for YAchseSchleifenwert in KartenDatentypen.UmgebungsbereichDrei'Range loop
         XAchseSchleife:
         for XAchseSchleifenwert in KartenDatentypen.UmgebungsbereichDrei'Range loop
            
            KartenWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                                                                 ÄnderungExtern    => (0, YAchseSchleifenwert, XAchseSchleifenwert),
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
      
      return KartenRecordKonstanten.LeerKoordinate;
      
   end FeindlicheEinheitInUmgebungSuchen;
   
   
   
   function TransporterSuchen
     return Integer
   is begin
      
      return 0;
      
   end TransporterSuchen;

end KIEinheitSuchenLogik;
