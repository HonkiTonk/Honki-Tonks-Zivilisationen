pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with TextnummernKonstanten;

with EinheitenErzeugenEntfernen;
with JaNeinLogik;

package body EinheitAufloesenLogik is

   function EinheitAuflösen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      case
        SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung
      is
         when RassenDatentypen.KI_Spieler_Enum =>
            EinheitenErzeugenEntfernen.EinheitEntfernen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when others =>
            if
              JaNeinLogik.JaNein (FrageZeileExtern => TextnummernKonstanten.FrageEinheitAuflösen) = True
            then
               EinheitenErzeugenEntfernen.EinheitEntfernen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         
            else
               return False;
            end if;
      end case;
      
      return True;
      
   end EinheitAuflösen;

end EinheitAufloesenLogik;
