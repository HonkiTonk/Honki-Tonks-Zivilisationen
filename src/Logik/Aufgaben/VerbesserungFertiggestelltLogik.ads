pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;

private with EinheitenRecords;
private with SpielVariablen;
private with AufgabenDatentypen;
private with KartenverbesserungDatentypen;
private with KartenRecords;

package VerbesserungFertiggestelltLogik is

   procedure VerbesserungFertiggestellt;
   
private
   
   WelcheAufgabe : AufgabenDatentypen.Einheitenbefehle_Verbesserungen_Enum;
   
   Koordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;
   
   type VerbesserungArray is array (AufgabenDatentypen.Einheitenbefehle_Gebilde_Enum'Range) of KartenverbesserungDatentypen.Karten_Verbesserung_Gebilde_Enum;
   Verbesserung : constant VerbesserungArray := (
                                                 AufgabenDatentypen.Mine_Bauen_Enum    => KartenverbesserungDatentypen.Mine_Enum,
                                                 AufgabenDatentypen.Farm_Bauen_Enum    => KartenverbesserungDatentypen.Farm_Enum,
                                                 AufgabenDatentypen.Festung_Bauen_Enum => KartenverbesserungDatentypen.Festung_Enum
                                                );
   
   procedure VerbesserungFertiggestelltPrüfen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   procedure VerbesserungAngelegt
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );
   
   procedure AufgabeNachfolgerVerschieben
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
     with
       Pre => (
                 EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
               and
                 SpielVariablen.Rassenbelegung (EinheitRasseNummerExtern.Rasse).Belegung /= RassenDatentypen.Leer_Spieler_Enum
              );

end VerbesserungFertiggestelltLogik;
