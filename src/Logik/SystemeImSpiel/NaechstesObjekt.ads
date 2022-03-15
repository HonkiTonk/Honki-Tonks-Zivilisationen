pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SystemDatentypen; use SystemDatentypen;
with GlobaleVariablen;
with EinheitStadtDatentypen;
with SystemKonstanten;

package NaechstesObjekt is

   type Bewegungspunkte is (Hat_Bewegungspunkte, Keine_Bewegungspunkte, Egal_Bewegeungspunkte);

   procedure NächsteEinheit
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      BewegungspunkteExtern : in Bewegungspunkte)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = SystemKonstanten.SpielerMenschKonstante);

   procedure NächsteStadt
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = SystemKonstanten.SpielerMenschKonstante);
   
   procedure NächsteStadtMeldung
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = SystemKonstanten.SpielerMenschKonstante);
   
   procedure NächsteEinheitMeldung
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = SystemKonstanten.SpielerMenschKonstante);
   
private

   SchleifenBegrenzung : EinheitStadtDatentypen.MaximaleEinheitenMitNullWert;
   
   type AktuelleEinheitArray is array (SystemDatentypen.Rassen_Verwendet_Enum'Range) of EinheitStadtDatentypen.MaximaleEinheitenMitNullWert;
   AktuelleEinheit : AktuelleEinheitArray := (others => 0);
   AktuelleEinheitMeldung : AktuelleEinheitArray := (others => 0);

   type AktuelleStadtArray is array (SystemDatentypen.Rassen_Verwendet_Enum'Range) of EinheitStadtDatentypen.MaximaleStädteMitNullWert;
   AktuelleStadt : AktuelleStadtArray := (others => 0);
   AktuelleStadtMeldung : AktuelleStadtArray := (others => 0);

end NaechstesObjekt;
