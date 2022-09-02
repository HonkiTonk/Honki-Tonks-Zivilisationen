pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with KartenKonstanten;
with EinheitenKonstanten;
with KartenRecordKonstanten;

with LeseKarten;
with LeseEinheitenGebaut;

with Kartenkoordinatenberechnungssystem;
with EinheitSuchen;

package body KIEinheitSuchen is

   function FeindlicheEinheitInUmgebungSuchen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      FeindExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return KartenRecords.AchsenKartenfeldNaturalRecord
   is begin
      
      YAchseSchleife:
      for YAchseSchleifenwert in KartenDatentypen.UmgebungsbereichDrei'Range loop
         XAchseSchleife:
         for XAchseSchleifenwert in KartenDatentypen.UmgebungsbereichDrei'Range loop
            
            KartenWert := Kartenkoordinatenberechnungssystem.Kartenkoordinatenberechnungssystem (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                                                                 ÄnderungExtern    => (0, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                 LogikGrafikExtern => True);
            
            if
              KartenWert.XAchse = KartenKonstanten.LeerXAchse
            then
               null;
               
            elsif
              False = LeseKarten.Sichtbar (KoordinatenExtern => KartenWert,
                                           RasseExtern       => EinheitRasseNummerExtern.Rasse)
            then
               null;
                  
            else
               FeindlicheEinheit := EinheitSuchen.KoordinatenEinheitMitRasseSuchen (RasseExtern       => FeindExtern,
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

end KIEinheitSuchen;
