pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitenKonstanten;

with KIGefahrErmitteln;
with KIEinheitStandardverhalten;
with KIEinheitGefahrenverhalten;

package body KIEinheit is

   procedure Einheit
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      FeindlicheEinheit := KIGefahrErmitteln.GefahrErmitteln (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
      case
        FeindlicheEinheit.Rasse
      is
         when EinheitenKonstanten.LeerRasse =>
            KIEinheitStandardverhalten.NormaleHandlungen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when others =>
            KIEinheitGefahrenverhalten.GefahrenHandlungen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                           FeindlicheEinheitExtern  => FeindlicheEinheit);
      end case;
      
   end Einheit;

end KIEinheit;
