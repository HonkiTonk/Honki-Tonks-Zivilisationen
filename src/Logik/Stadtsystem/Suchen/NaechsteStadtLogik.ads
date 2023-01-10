with SpeziesDatentypen;

private with StadtDatentypen;

with LeseSpeziesbelegung;

package NaechsteStadtLogik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;

   procedure NächsteStadt
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.Mensch_Spieler_Enum
              );
   
   procedure NächsteStadtMeldung
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.Mensch_Spieler_Enum
              );
   
private

   StadtSchleifenbegrenzung : StadtDatentypen.MaximaleStädteMitNullWert;
   MeldungSchleifenbegrenzung : StadtDatentypen.MaximaleStädteMitNullWert;

   type AktuelleStadtArray is array (SpeziesDatentypen.Spezies_Verwendet_Enum'Range) of StadtDatentypen.MaximaleStädteMitNullWert;
   AktuelleStadt : AktuelleStadtArray := (others => 0);
   AktuelleStadtMeldung : AktuelleStadtArray := (others => 0);

end NaechsteStadtLogik;
