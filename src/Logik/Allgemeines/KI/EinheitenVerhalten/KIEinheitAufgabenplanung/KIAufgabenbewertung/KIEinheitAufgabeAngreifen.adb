pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SystemDatentypen; use SystemDatentypen;

with DiplomatischerZustand;

package body KIEinheitAufgabeAngreifen is

   function Angreifen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KIDatentypen.AufgabenWichtigkeitKlein
   is begin
      
      RassenSchleife:
      for RasseSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
         
         if
           SpielVariablen.RassenImSpiel (RasseSchleifenwert) = RassenDatentypen.Leer_Spieler_Enum
           or
             RasseSchleifenwert = EinheitRasseNummerExtern.Rasse
         then
            null;
            
         elsif
           DiplomatischerZustand.DiplomatischenStatusPrüfen (EigeneRasseExtern => EinheitRasseNummerExtern.Rasse,
                                                              FremdeRasseExtern => RasseSchleifenwert)
           = SystemDatentypen.Krieg_Enum
         then
            return 5;
            
         else
            null;
         end if;
         
      end loop RassenSchleife;
      
      return 0;
      
   end Angreifen;

end KIEinheitAufgabeAngreifen;
