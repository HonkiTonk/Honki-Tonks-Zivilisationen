pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with EinheitenRecords;
with SpielVariablen;

private with StadtDatentypen;
private with EinheitenDatentypen;

with KIDatentypen;

package KIEinheitAufgabeAufloesen is

   function EinheitAuflösen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KIDatentypen.AufgabenWichtigkeitKlein
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = RassenDatentypen.KI_Spieler_Enum
              );
   
private
   
   EinheitID : EinheitenDatentypen.EinheitenID;
   
   Heimatstadt : StadtDatentypen.MaximaleStädteMitNullWert;
   
   Aufgabenwert : KIDatentypen.AufgabenWichtigkeitKlein;
   Zwischenwert : KIDatentypen.AufgabenWichtigkeitKlein;
   
   ------------------------------- Sinnvolle Werte finden
   type MaximaleEinheitenArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range) of EinheitenDatentypen.MaximaleEinheiten;
   MaximaleEinheiten : constant MaximaleEinheitenArray := (
                                                           RassenDatentypen.Menschen_Enum         => 18,
                                                           RassenDatentypen.Kasrodiah_Enum        => 18,
                                                           RassenDatentypen.Lasupin_Enum          => 18,
                                                           RassenDatentypen.Lamustra_Enum         => 18,
                                                           RassenDatentypen.Manuky_Enum           => 18,
                                                           RassenDatentypen.Suroka_Enum           => 18,
                                                           RassenDatentypen.Pryolon_Enum          => 18,
                                                           RassenDatentypen.Moru_Phisihl_Enum     => 18,
                                                           RassenDatentypen.Larinos_Lotaris_Enum  => 18,
                                                           RassenDatentypen.Carupex_Enum          => 18,
                                                           RassenDatentypen.Alary_Enum            => 18,
                                                           RassenDatentypen.Natries_Zermanis_Enum => 18,
                                                           RassenDatentypen.Tridatus_Enum         => 18,
                                                           RassenDatentypen.Senelari_Enum         => 18,
                                                           RassenDatentypen.Aspari_2_Enum         => 18,
                                                           RassenDatentypen.Ekropa_Enum           => 18,
                                                           RassenDatentypen.Tesorahn_Enum         => 18,
                                                           RassenDatentypen.Talbidahr_Enum        => 18
                                                          );
   
   
   
   function Stadtzustand
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KIDatentypen.AufgabenWichtigkeitKlein
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = RassenDatentypen.KI_Spieler_Enum
              );
   
   function GlobalerZustand
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KIDatentypen.AufgabenWichtigkeitKlein
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = RassenDatentypen.KI_Spieler_Enum
              );
   
   function StadtzustandKrieg
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return KIDatentypen.AufgabenWichtigkeitKlein
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) = RassenDatentypen.KI_Spieler_Enum
              );

end KIEinheitAufgabeAufloesen;
