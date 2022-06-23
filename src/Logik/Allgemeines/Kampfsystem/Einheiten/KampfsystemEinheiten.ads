pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with EinheitenRecords;
with SonstigeVariablen;
with SpielVariablen;
with KampfRecords;
with KampfDatentypen;
with StadtDatentypen;

package KampfsystemEinheiten is

   function KampfsystemNahkampf
     (AngreiferExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      VerteidigerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
     with
       Pre => (
                 AngreiferExtern.Rasse /= VerteidigerExtern.Rasse
               and
                 SonstigeVariablen.RassenImSpiel (AngreiferExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 SonstigeVariablen.RassenImSpiel (VerteidigerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 VerteidigerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (VerteidigerExtern.Rasse).Einheitengrenze
               and
                 AngreiferExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (AngreiferExtern.Rasse).Einheitengrenze
              );

   procedure KampfBerechnung
     (VerteidigerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      AngriffExtern : in KampfDatentypen.Kampfwerte;
      VerteidigungExtern : in KampfDatentypen.Kampfwerte)
     with
       Pre => (
                 VerteidigerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (VerteidigerExtern.Rasse).Einheitengrenze
               and
                 SonstigeVariablen.RassenImSpiel (VerteidigerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
              );

private

   AngerichteterSchaden : StadtDatentypen.MaximaleStädteMitNullWert;

   KampfwerteVerteidiger : KampfRecords.KampfwerteRecord;
   KampfwerteAngreifer : KampfRecords.KampfwerteRecord;

   Kampfglück : Float;

   -- Die Werte gelten immer aus Sicht des Angreifers
   ----------------------- Mal auslagern und mit KampfsystemStadt zusammenführen.
   type Kampf_Unterschiede_Enum is (
                                    Gleich_Enum, Stärker_Enum, Extrem_Stärker_Enum, Schwächer_Enum, Extrem_Schwächer_Enum
                                   );

   WelcherFall : Kampf_Unterschiede_Enum;

   type SchadenAngerichtetArray is array (Kampf_Unterschiede_Enum'Range, StadtDatentypen.MaximaleStädte'First .. 3) of Float;
   SchadenAngerichtet : constant SchadenAngerichtetArray := (
                                                             Gleich_Enum =>
                                                               (
                                                                1 => 0.40,
                                                                2 => 0.75,
                                                                3 => 0.90
                                                               ),

                                                             Stärker_Enum =>
                                                               (
                                                                1 => 0.30,
                                                                2 => 0.65,
                                                                3 => 0.80
                                                               ),

                                                             Extrem_Stärker_Enum =>
                                                               (
                                                                1 => 0.20,
                                                                2 => 0.50,
                                                                3 => 0.70
                                                               ),

                                                             Schwächer_Enum =>
                                                               (
                                                                1 => 0.55,
                                                                2 => 0.85,
                                                                3 => 0.95
                                                               ),

                                                             Extrem_Schwächer_Enum =>
                                                               (
                                                                1 => 0.70,
                                                                2 => 0.90,
                                                                3 => 0.98
                                                               )
                                                            );

   function Kampf
     (VerteidigerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      AngreiferExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
     with
       Pre => (
                 AngreiferExtern.Rasse /= VerteidigerExtern.Rasse
               and
                 SonstigeVariablen.RassenImSpiel (AngreiferExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 SonstigeVariablen.RassenImSpiel (VerteidigerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
               and
                 VerteidigerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (VerteidigerExtern.Rasse).Einheitengrenze
               and
                 AngreiferExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (AngreiferExtern.Rasse).Einheitengrenze
              );

end KampfsystemEinheiten;
