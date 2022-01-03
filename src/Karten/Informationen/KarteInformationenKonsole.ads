pragma SPARK_Mode (On);

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with SystemDatentypen; use SystemDatentypen;
with GlobaleVariablen;
with EinheitStadtRecords;
with KartenDatentypen;

with UmwandlungenAdaNachEigenes;

package KarteInformationenKonsole is

   procedure KarteInformationenKonsole
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = SystemDatentypen.Spieler_Mensch);
   
private
   
   Sichtbar : Boolean;
   
   EinheitRasseNummer : EinheitStadtRecords.RassePlatznummerRecord;
   StadtRasseNummer : EinheitStadtRecords.RassePlatznummerRecord;

   WertOhneTrennzeichen : Unbounded_Wide_Wide_String;
   YAchsenWert : Unbounded_Wide_Wide_String;
   XAchsenWert : Unbounded_Wide_Wide_String;
   
   procedure InformationenStadt
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
     with
       Pre =>
         (StadtRasseNummerExtern.Platznummer in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze
          and
            GlobaleVariablen.RassenImSpiel (StadtRasseNummerExtern.Rasse) /= SystemDatentypen.Leer
          and
            GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemDatentypen.Leer);
   
   procedure InformationenAllgemein
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) /= SystemDatentypen.Leer);
   
   procedure InformationenSichtbar
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum);
   
   procedure Kartenposition
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum);
   
   procedure Gecheatet
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum);
   
   procedure FeldWissen
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum);
   
   procedure FeldGeld
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum);
   
   procedure FeldProduktion
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum);
   
   procedure FeldNahrung
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum);
   
   procedure FeldAngriff
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum);
   
   procedure FeldVerteidigung
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum);
   
   procedure Hügel
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum);
   
   

   function ZahlAlsStringEbeneVorhanden is new UmwandlungenAdaNachEigenes.ZahlAlsStringLeerzeichenEntfernen (GanzeZahl => KartenDatentypen.EbeneVorhanden);

   function ZahlAlsStringKartenfeldPositivMitNullwert is new UmwandlungenAdaNachEigenes.ZahlAlsStringLeerzeichenEntfernen (GanzeZahl => KartenDatentypen.KartenfeldPositivMitNullwert);

end KarteInformationenKonsole;
