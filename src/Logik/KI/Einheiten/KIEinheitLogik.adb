pragma Warnings (Off, "*array aggregate*");

with EinheitenKonstanten;

with KIGefahrErmittelnLogik;
with KIEinheitStandardverhaltenLogik;
with KIEinheitGefahrenverhaltenLogik;
with KIEinheitHandlungenLogik;

package body KIEinheitLogik is

   procedure Einheit
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      FeindlicheEinheit := KIGefahrErmittelnLogik.GefahrErmitteln (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      -- Kriegshandlungen einbauen oder die bei den entsprechenden Punkten mit berücksichtigen? äöü
      case
        FeindlicheEinheit.Rasse
      is
         when EinheitenKonstanten.LeerRasse =>
            -- Nicht weiter vorne einbauen, da sonst bei Gefahren/Kriegssituationen keine Berechnungen für befestigte Einheiten durchgeführt werden kann.
            if
              KIEinheitHandlungenLogik.HandlungBeendet (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = True
            then
               return;
               
            else
               KIEinheitStandardverhaltenLogik.NormaleHandlungen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            end if;
            
         when others =>
            KIEinheitGefahrenverhaltenLogik.GefahrenHandlungen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                FeindlicheEinheitExtern  => FeindlicheEinheit);
      end case;
      
   end Einheit;

end KIEinheitLogik;
