pragma SPARK_Mode (On);

with GlobaleVariablen, SonstigeDatentypen, EinheitStadtDatentypen;
use SonstigeDatentypen;

package NaechstesObjekt is

   type Bewegungspunkte is (Hat_Bewegungspunkte, Keine_Bewegungspunkte, Egal_Bewegeungspunkte);

   procedure NächsteEinheit
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum;
      BewegungspunkteExtern : in Bewegungspunkte)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = SonstigeDatentypen.Spieler_Mensch);

   procedure NächsteStadt
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = SonstigeDatentypen.Spieler_Mensch);
   
   procedure NächsteStadtMeldung
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = SonstigeDatentypen.Spieler_Mensch);
   
   procedure NächsteEinheitMeldung
     (RasseExtern : in SonstigeDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = SonstigeDatentypen.Spieler_Mensch);
   
private

   SchleifenBegrenzung : EinheitStadtDatentypen.MaximaleEinheitenMitNullWert;
   
   type AktuelleEinheitArray is array (SonstigeDatentypen.Rassen_Verwendet_Enum'Range) of EinheitStadtDatentypen.MaximaleEinheitenMitNullWert;
   AktuelleEinheit : AktuelleEinheitArray := (others => 0);
   AktuelleEinheitMeldung : AktuelleEinheitArray := (others => 0);

   type AktuelleStadtArray is array (SonstigeDatentypen.Rassen_Verwendet_Enum'Range) of EinheitStadtDatentypen.MaximaleStädteMitNullWert;
   AktuelleStadt : AktuelleStadtArray := (others => 0);
   AktuelleStadtMeldung : AktuelleStadtArray := (others => 0);

end NaechstesObjekt;
