pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with RassenDatentypen; use RassenDatentypen;
with KartenDatentypen; use KartenDatentypen;
with SpielVariablen;
with EinheitStadtDatentypen;
with EinheitStadtRecords;
with SonstigeVariablen;

package GebaeudeAllgemein is
   
   procedure GebäudeProduktionBeenden
     (StadtRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord;
      IDExtern : in EinheitStadtDatentypen.GebäudeID)
     with
       Pre =>
         (StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            SonstigeVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum);
   
   procedure GebäudeEntfernen
     (StadtRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord;
      WelchesGebäudeExtern : in EinheitStadtDatentypen.GebäudeID)
     with
       Pre =>
         (StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            SonstigeVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum);
   
   

   function BeschreibungKurz
     (IDExtern : in EinheitStadtDatentypen.GebäudeIDMitNullwert)
      return Wide_Wide_String;
   
   function BeschreibungLang
     (IDExtern : in EinheitStadtDatentypen.GebäudeIDMitNullwert)
      return Wide_Wide_String;
   
   function GebäudeAnforderungenErfüllt
     (StadtRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord;
      IDExtern : in EinheitStadtDatentypen.GebäudeID)
      return Boolean
     with
       Pre =>
         (StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            SonstigeVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum);
   
private
   
   AktuellerText : Positive;
   
   BeschreibungText : Unbounded_Wide_Wide_String;
   
   procedure PermanenteKostenDurchGebäudeÄndern
     (StadtRasseNummerExtern : in EinheitStadtRecords.RasseEinheitnummerRecord;
      IDExtern : in EinheitStadtDatentypen.GebäudeID;
      VorzeichenWechselExtern : in KartenDatentypen.UmgebungsbereichEins)
     with
       Pre =>
         (VorzeichenWechselExtern /= 0
          and
            StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            SonstigeVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum);

end GebaeudeAllgemein;
