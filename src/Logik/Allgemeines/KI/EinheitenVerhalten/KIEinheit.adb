pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitenKonstanten;

with KIGefahrErmitteln;
with KIEinheitStandardverhalten;
with KIEinheitGefahrenverhalten;
with KIEinheitHandlungen;

package body KIEinheit is

   procedure Einheit
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      FeindlicheEinheit := KIGefahrErmitteln.GefahrErmitteln (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      ------------------------------------ Kriegshandlungen einbauen oder die bei den entsprechenden Punkten mit berücksichtigen?
      case
        FeindlicheEinheit.Rasse
      is
         when EinheitenKonstanten.LeerRasse =>
            -- Nicht weiter vorne einbauen, da sonst bei Gefahren/Kriegssituationen keine Berechnungen für befestigte Einheiten durchgeführt werden kann.
            if
              KIEinheitHandlungen.HandlungBeendet (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = True
            then
               return;
               
            else
               KIEinheitStandardverhalten.NormaleHandlungen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            end if;
            
         when others =>
            KIEinheitGefahrenverhalten.GefahrenHandlungen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                           FeindlicheEinheitExtern  => FeindlicheEinheit);
      end case;
      
   end Einheit;

end KIEinheit;
