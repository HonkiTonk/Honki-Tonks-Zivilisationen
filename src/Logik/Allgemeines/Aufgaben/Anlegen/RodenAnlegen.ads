pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with SpielVariablen;
with EinheitStadtRecords;
with SonstigeVariablen;
with KartengrundDatentypen;
with KartenRecords;

package RodenAnlegen is

   procedure RodenAnlegen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum);
   
private
   
   NeuerGrund : KartengrundDatentypen.Kartengrund_Vorhanden_Enum;
   
   Koordinaten : KartenRecords.AchsenKartenfeldPositivRecord;
   
   type HügelSetzenArray is array (Boolean'Range) of KartengrundDatentypen.Kartengrund_Vorhanden_Enum;
   HügelSetzen : constant HügelSetzenArray := (
                                                 True  => KartengrundDatentypen.Hügel_Enum,
                                                 False => KartengrundDatentypen.Flachland_Enum
                                                );

end RodenAnlegen;
