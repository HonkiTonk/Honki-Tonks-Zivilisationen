pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with SpielVariablen;

private with EinheitenDatentypen;

package NaechsteEinheitLogik is

   -- Das hier auch mal austauschen? äöü
   -- Alternativ könnte man den erweiterten Boolean aus SystemDatentypen verwenden, aber es dann linke ich halt die SystemDatentypen mir ein, ob das sinnvoll ist? äöü
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
   
   procedure NächsteEinheitMeldung
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung = RassenDatentypen.Mensch_Spieler_Enum
              );
   
private
   
   EinheitSchleifenbegrenzung : EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   MeldungSchleifenbegrenzung : EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   
   Bewegungspunkte : EinheitenDatentypen.BewegungFloat;
   
   type AktuelleEinheitArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range) of EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   AktuelleEinheit : AktuelleEinheitArray := (others => 0);
   AktuelleEinheitMeldung : AktuelleEinheitArray := (others => 0);

end NaechsteEinheitLogik;
