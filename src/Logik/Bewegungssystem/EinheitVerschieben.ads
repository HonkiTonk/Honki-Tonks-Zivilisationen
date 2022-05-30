pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SystemDatentypen;
with EinheitenRecords;
with KartenRecords;
with KartenDatentypen;
with EinheitenDatentypen;

package EinheitVerschieben is

   procedure VonEigenemLandWerfen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KontaktierteRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (SonstigeVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
          and
            SonstigeVariablen.RassenImSpiel (KontaktierteRasseExtern) /= RassenDatentypen.Leer_Spieler_Enum);
   
   procedure EinheitVerschieben
     (RasseLandExtern : in RueckgabeDatentypen.Rassen_Verwendet_Enum;
      EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
     with
       Pre =>
         (EinheitRasseNummerExtern.Nummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
          and
            SonstigeVariablen.RassenImSpiel (RasseLandExtern) /= RassenDatentypen.Leer_Spieler_Enum);
   
private
   
   UmgebungPrüfen : KartenDatentypen.Sichtweite;
   BereitsGeprüft : KartenDatentypen.SichtweiteNatural;
   
   EinheitNummer : EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   
   KartenWert : KartenRecords.AchsenKartenfeldNaturalRecord;
   KartenWertVerschieben : KartenRecords.AchsenKartenfeldNaturalRecord;
   
   procedure EinheitenErmitteln
     (StadtRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      KontaktierteRasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (StadtRasseNummerExtern.Nummer in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            SonstigeVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
          and
            SonstigeVariablen.RassenImSpiel (KontaktierteRasseExtern) /= RassenDatentypen.Leer_Spieler_Enum);

end EinheitVerschieben;
