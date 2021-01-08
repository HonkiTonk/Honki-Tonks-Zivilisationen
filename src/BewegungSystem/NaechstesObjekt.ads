with GlobaleVariablen, GlobaleDatentypen;
use GlobaleDatentypen;

package NaechstesObjekt is

   procedure NächsteEinheitMitBewegungspunkten (RasseExtern : in Integer);
   procedure NächsteEinheit (RasseExtern : in Integer);
   procedure NächsteEinheitOhneBewegungspunkte (RasseExtern : in Integer);
   procedure NächsteStadt (RasseExtern : in Integer);
   
private
   
   AktuelleEinheit : Integer := 1;
   Endwert : Integer;
   Startwert : Integer;
   AktuelleStadt : Integer := 1;

end NaechstesObjekt;
