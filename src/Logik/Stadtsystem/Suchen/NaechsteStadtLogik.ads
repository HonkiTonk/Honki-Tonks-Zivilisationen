with RassenDatentypen;
with SpielVariablen;

private with StadtDatentypen;

package NaechsteStadtLogik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;

   procedure NächsteStadt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung = RassenDatentypen.Mensch_Spieler_Enum
              );
   
   procedure NächsteStadtMeldung
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung = RassenDatentypen.Mensch_Spieler_Enum
              );
   
private

   StadtSchleifenbegrenzung : StadtDatentypen.MaximaleStädteMitNullWert;
   MeldungSchleifenbegrenzung : StadtDatentypen.MaximaleStädteMitNullWert;

   type AktuelleStadtArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range) of StadtDatentypen.MaximaleStädteMitNullWert;
   AktuelleStadt : AktuelleStadtArray := (others => 0);
   AktuelleStadtMeldung : AktuelleStadtArray := (others => 0);

end NaechsteStadtLogik;
