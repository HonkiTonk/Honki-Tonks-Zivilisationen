with TextnummernKonstanten;

with EinheitenErzeugenEntfernenLogik;
with JaNeinLogik;

package body EinheitAufloesenLogik is

   function EinheitAuflösen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      case
        LeseRassenbelegung.Belegung (RasseExtern => EinheitRasseNummerExtern.Rasse)
      is
         when RassenDatentypen.KI_Spieler_Enum =>
            EinheitenErzeugenEntfernenLogik.EinheitEntfernen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when others =>
            if
              JaNeinLogik.JaNein (FrageZeileExtern => TextnummernKonstanten.FrageEinheitAuflösen) = True
            then
               EinheitenErzeugenEntfernenLogik.EinheitEntfernen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         
            else
               return False;
            end if;
      end case;
      
      return True;
      
   end EinheitAuflösen;

end EinheitAufloesenLogik;
