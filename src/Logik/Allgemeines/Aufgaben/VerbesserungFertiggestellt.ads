pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;

private with EinheitenRecords;
private with SpielVariablen;
private with AufgabenDatentypen;
private with KartenVerbesserungDatentypen;
private with KartenRecords;

package VerbesserungFertiggestellt is

   procedure VerbesserungFertiggestellt;
   
private
   
   WelcheAufgabe : AufgabenDatentypen.Einheitenbefehle_Verbesserungen_Enum;
   
   Koordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;
   
   type VerbesserungArray is array (AufgabenDatentypen.Einheitenbefehle_Gebilde_Enum'Range) of KartenVerbesserungDatentypen.Karten_Verbesserung_Gebilde_Enum;
   Verbesserung : constant VerbesserungArray := (
                                                 AufgabenDatentypen.Mine_Bauen_Enum    => KartenVerbesserungDatentypen.Mine_Enum,
                                                 AufgabenDatentypen.Farm_Bauen_Enum    => KartenVerbesserungDatentypen.Farm_Enum,
                                                 AufgabenDatentypen.Festung_Bauen_Enum => KartenVerbesserungDatentypen.Festung_Enum
                                                );
   
   procedure VerbesserungFertiggestelltPrüfen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   procedure VerbesserungAngelegt
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   procedure AufgabeNachfolgerVerschieben
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
              );

end VerbesserungFertiggestellt;
