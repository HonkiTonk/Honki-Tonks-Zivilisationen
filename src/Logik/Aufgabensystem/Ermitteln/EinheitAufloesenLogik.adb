with TextnummernKonstanten;

with EinheitenErzeugenEntfernenLogik;
with JaNeinLogik;

package body EinheitAufloesenLogik is

   function EinheitAuflösen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
   is begin
      
      case
        LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
      is
         when SpeziesDatentypen.KI_Spieler_Enum =>
            EinheitenErzeugenEntfernenLogik.EinheitEntfernen (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
            
         when others =>
            if
              JaNeinLogik.JaNein (FrageZeileExtern => TextnummernKonstanten.FrageEinheitAuflösen) = True
            then
               EinheitenErzeugenEntfernenLogik.EinheitEntfernen (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
         
            else
               return False;
            end if;
      end case;
      
      return True;
      
   end EinheitAuflösen;

end EinheitAufloesenLogik;
