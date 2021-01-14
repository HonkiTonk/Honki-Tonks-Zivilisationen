with GlobaleVariablen, GlobaleDatentypen;
use GlobaleDatentypen;

package NaechstesObjekt is

   procedure NächsteEinheitMitBewegungspunkten (RasseExtern : in Integer)
     with Pre => RasseExtern in GlobaleDatentypen.RassenImSpielArray'Range;
   procedure NächsteEinheit (RasseExtern : in Integer)
     with Pre => RasseExtern in GlobaleDatentypen.RassenImSpielArray'Range;
   procedure NächsteEinheitOhneBewegungspunkte (RasseExtern : in Integer)
     with Pre => RasseExtern in GlobaleDatentypen.RassenImSpielArray'Range;
   procedure NächsteStadt (RasseExtern : in Integer)
     with Pre => RasseExtern in GlobaleDatentypen.RassenImSpielArray'Range;
   
private
   
   AktuelleEinheit : Integer := 1;
   Endwert : Integer;
   Startwert : Integer;
   AktuelleStadt : Integer := 1;

end NaechstesObjekt;
