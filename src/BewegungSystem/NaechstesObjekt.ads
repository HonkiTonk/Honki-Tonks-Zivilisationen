with GlobaleVariablen;

package NaechstesObjekt is

   procedure NächsteEinheitMitBewegungspunkten;
   procedure NächsteEinheit;
   procedure NächsteEinheitOhneBewegungspunkte;
   procedure NächsteStadt;
   
private
   
   AktuelleEinheit : Integer := 1;
   Endwert : Integer;
   Startwert : Integer;
   AktuelleStadt : Integer := 1;

end NaechstesObjekt;
