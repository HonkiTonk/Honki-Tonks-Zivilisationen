pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with EinheitStadtRecords;
with GlobaleVariablen;
with EinheitStadtDatentypen;

package KampfsystemEinheiten is

   function KampfsystemNahkampf
     (AngreiferExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      VerteidigerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return Boolean
     with
       Pre =>
         (AngreiferExtern.Rasse /= VerteidigerExtern.Rasse
          and
            GlobaleVariablen.RassenImSpiel (AngreiferExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
          and
            GlobaleVariablen.RassenImSpiel (VerteidigerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
          and
            VerteidigerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (VerteidigerExtern.Rasse).Einheitengrenze
          and
            AngreiferExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (AngreiferExtern.Rasse).Einheitengrenze);

   procedure KampfBerechnung
     (VerteidigerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      AngriffExtern : in EinheitStadtDatentypen.Kampfwerte;
      VerteidigungExtern : in EinheitStadtDatentypen.Kampfwerte)
     with
       Pre =>
         (VerteidigerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (VerteidigerExtern.Rasse).Einheitengrenze
          and
            GlobaleVariablen.RassenImSpiel (VerteidigerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum);

private

   AngerichteterSchaden : EinheitStadtDatentypen.MaximaleStädteMitNullWert;

   KampfwerteVerteidiger : EinheitStadtRecords.KampfwerteRecord;
   KampfwerteAngreifer : EinheitStadtRecords.KampfwerteRecord;

   Kampfglück : Float;

   -- Die Werte gelten immer aus Sicht des Angreifers
   ----------------------- Mal auslagern und mit KampfsystemStadt zusammenführen.
   type Kampf_Unterschiede_Enum is (
                                    Gleich_Enum, Stärker_Enum, Extrem_Stärker_Enum, Schwächer_Enum, Extrem_Schwächer_Enum
                                   );

   WelcherFall : Kampf_Unterschiede_Enum;

   type SchadenAngerichtetArray is array (Kampf_Unterschiede_Enum'Range, EinheitStadtDatentypen.MaximaleStädte'First .. 3) of Float;
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
     (VerteidigerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      AngreiferExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return Boolean
     with
       Pre =>
         (AngreiferExtern.Rasse /= VerteidigerExtern.Rasse
          and
            GlobaleVariablen.RassenImSpiel (AngreiferExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
          and
            GlobaleVariablen.RassenImSpiel (VerteidigerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
          and
            VerteidigerExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (VerteidigerExtern.Rasse).Einheitengrenze
          and
            AngreiferExtern.Platznummer in GlobaleVariablen.EinheitenGebautArray'First (2) .. GlobaleVariablen.Grenzen (AngreiferExtern.Rasse).Einheitengrenze);

end KampfsystemEinheiten;
