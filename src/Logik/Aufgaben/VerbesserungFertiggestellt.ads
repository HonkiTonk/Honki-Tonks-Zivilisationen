pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with EinheitStadtRecords;
with SpielVariablen;
with SonstigeVariablen;
with AufgabenDatentypen;
with KartenVerbesserungDatentypen;

package VerbesserungFertiggestellt is

   procedure VerbesserungFertiggestellt;
   
private
   
   WelcheAufgabe : AufgabenDatentypen.Einheitenbefehle_Verbesserungen_Enum;
   
   type VerbesserungArray is array (AufgabenDatentypen.Einheitenbefehle_Gebäude_Enum'Range) of KartenVerbesserungDatentypen.Karten_Verbesserung_Gebilde_Enum;
   Verbesserung : constant VerbesserungArray := (
                                                 AufgabenDatentypen.Mine_Bauen_Enum    => KartenVerbesserungDatentypen.Mine_Enum,
                                                 AufgabenDatentypen.Farm_Bauen_Enum    => KartenVerbesserungDatentypen.Farm_Enum,
                                                 AufgabenDatentypen.Festung_Bauen_Enum => KartenVerbesserungDatentypen.Festung_Enum
                                                );
   
   procedure VerbesserungFertiggestelltPrüfen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum);
   
   procedure VerbesserungAngelegt
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum);
   
   procedure AufgabeNachfolgerVerschieben
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum);

end VerbesserungFertiggestellt;
