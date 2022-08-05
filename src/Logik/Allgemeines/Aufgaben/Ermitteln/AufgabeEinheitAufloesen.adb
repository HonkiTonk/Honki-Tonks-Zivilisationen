pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with TextnummernKonstanten;

with EinheitenErzeugenEntfernen;
with Auswahl;

package body AufgabeEinheitAufloesen is

   function EinheitAuflösen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      case
        SpielVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse)
      is
         when RassenDatentypen.KI_Spieler_Enum =>
            EinheitenErzeugenEntfernen.EinheitEntfernen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when others =>
            if
              Auswahl.AuswahlJaNein (FrageZeileExtern => TextnummernKonstanten.FrageEinheitAuflösen) = True
            then
               EinheitenErzeugenEntfernen.EinheitEntfernen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         
            else
               return False;
            end if;
      end case;
      
      return True;
      
   end EinheitAuflösen;

end AufgabeEinheitAufloesen;
