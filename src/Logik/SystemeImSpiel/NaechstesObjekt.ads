pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with SpielVariablen;

private with EinheitenDatentypen;
private with StadtDatentypen;

package NaechstesObjekt is

   type Bewegungspunkte_Enum is (
                                 Hat_Bewegungspunkte_Enum, Keine_Bewegungspunkte_Enum, Egal_Bewegeungspunkte_Enum
                                );

   procedure NächsteEinheit
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      BewegungspunkteExtern : in Bewegungspunkte_Enum)
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung = RassenDatentypen.Mensch_Spieler_Enum
              );

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
   
   procedure NächsteEinheitMeldung
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung = RassenDatentypen.Mensch_Spieler_Enum
              );
   
private

   StadtSchleifenbegrenzung : StadtDatentypen.MaximaleStädteMitNullWert;
   
   EinheitSchleifenbegrenzung : EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   
   Bewegungspunkte : EinheitenDatentypen.BewegungFloat;
   
   type AktuelleEinheitArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range) of EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   AktuelleEinheit : AktuelleEinheitArray := (others => 0);
   AktuelleEinheitMeldung : AktuelleEinheitArray := (others => 0);

   type AktuelleStadtArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range) of StadtDatentypen.MaximaleStädteMitNullWert;
   AktuelleStadt : AktuelleStadtArray := (others => 0);
   AktuelleStadtMeldung : AktuelleStadtArray := (others => 0);

end NaechstesObjekt;
