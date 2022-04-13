pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with KartenKonstanten;
with EinheitenKonstanten;
with KartenRecordKonstanten;

with LeseKarten;
with LeseEinheitenGebaut;

with KarteKoordinatenPruefen;
with EinheitSuchen;

package body KIFeindlicheEinheitSuchen is

   function FeindlicheEinheitInUmgebungSuchen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      FeindExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return KartenRecords.AchsenKartenfeldPositivRecord
   is begin
      
      YAchseSchleife:
      for YAchseSchleifenwert in KartenDatentypen.UmgebungsbereichDrei'Range loop
         XAchseSchleife:
         for XAchseSchleifenwert in KartenDatentypen.UmgebungsbereichDrei'Range loop
            
            KartenWert := KarteKoordinatenPruefen.KarteKoordinatenPrüfen (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                                           ÄnderungExtern    => (0, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                           LogikGrafikExtern => True);
            
            if
              KartenWert.XAchse = KartenKonstanten.LeerXAchse
            then
               null;
               
            elsif
              LeseKarten.Sichtbar (KoordinatenExtern => KartenWert,
                                   RasseExtern       => EinheitRasseNummerExtern.Rasse)
              = False
            then
               null;
                  
            else
               FeindlicheEinheit := EinheitSuchen.KoordinatenEinheitMitRasseSuchen (RasseExtern       => FeindExtern,
                                                                                    KoordinatenExtern => KartenWert);
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
      
      return KartenRecordKonstanten.LeerKartenKoordinaten;
      
   end FeindlicheEinheitInUmgebungSuchen;

end KIFeindlicheEinheitSuchen;
