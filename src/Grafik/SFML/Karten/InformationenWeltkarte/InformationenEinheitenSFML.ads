pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf.System.Vector2;
with Sf.Graphics;
with Sf.Graphics.Text;

with RassenDatentypen; use RassenDatentypen;
with EinheitStadtRecords;
with SpielVariablen;
with EinheitStadtDatentypen;
with SonstigeVariablen;

with UmwandlungenAdaNachEigenes;

package InformationenEinheitenSFML is

   function Einheiten
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      PositionTextExtern : in Sf.System.Vector2.sfVector2f)
      return Sf.System.Vector2.sfVector2f
     with
       Pre =>
         (EinheitRasseNummerExtern.Platznummer in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (EinheitRasseNummerExtern.Rasse).Einheitengrenze
          and
            SonstigeVariablen.RassenImSpiel (EinheitRasseNummerExtern.Rasse) /= RassenDatentypen.Leer_Spieler_Enum
          and
            SonstigeVariablen.RassenImSpiel (RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum);
   
private
      
   SchriftartFestgelegt : Boolean := False;
   SchriftfarbeFestgelegt : Boolean := False;
   SchriftgrößeFestgelegt : Boolean := False;
   ErsteAnzeige : Boolean;
   
   IDEinheit : EinheitStadtDatentypen.EinheitenID;
   
   EinheitNummer : EinheitStadtDatentypen.MaximaleEinheiten;
   
   Zeilenabstand : Float;
   
   Trennzeichen : constant Wide_Wide_String (1 .. 1) := "/";
   
   -- Alternativ auch aktueller Wert und maximaler Wert.
   WertLinksVomTrennzeichen : Unbounded_Wide_Wide_String;
   WertRechtsVomTrennzeichen : Unbounded_Wide_Wide_String;
   WertOhneTrennzeichen : Unbounded_Wide_Wide_String;
   
   type TextAccessArray is array (1 .. 14) of Sf.Graphics.sfText_Ptr;
   TextAccess : constant TextAccessArray := (others => Sf.Graphics.Text.create);
   
   EinheitRasseNummer : EinheitStadtRecords.RassePlatznummerRecord;
   
   PositionText : Sf.System.Vector2.sfVector2f;
   
   function Allgemeines
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return EinheitStadtRecords.RassePlatznummerRecord;
   
   procedure Lebenspunkte
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord);
   
   procedure Bewegungspunkte
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord);
   
   procedure Erfahrungspunkte
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord);
   
   procedure Beschäftigung
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord);
   
   procedure Beschäftigungszeit
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord);
   
   procedure Angriff
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord);
   
   procedure Verteidigung
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord);
   
   procedure Rang
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord);
   
   procedure Heimatstadt
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord);
   
   procedure AktuelleVerteidigung
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord);
   
   procedure AktuellerAngriff
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord);
   
   procedure Ladung
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord);
   
   procedure DebugInformationen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord);
   
   
   
   function SchriftartFestlegen
     return Boolean;

   function SchriftgrößenFestlegen
     return Boolean;

   function SchriftfarbenFestlegen
     return Boolean;
   
   function ZahlAlsStringMaximaleEinheitenMitNullWert is new UmwandlungenAdaNachEigenes.ZahlAlsStringLeerzeichenEntfernen (GanzeZahl => EinheitStadtDatentypen.MaximaleEinheitenMitNullWert);
   
   function ZahlAlsStringProduktionFeld is new UmwandlungenAdaNachEigenes.ZahlAlsStringLeerzeichenEntfernen (GanzeZahl => EinheitStadtDatentypen.ProduktionFeld);
   
   function ZahlAlsStringGesamtproduktionStadt is new UmwandlungenAdaNachEigenes.ZahlAlsStringLeerzeichenEntfernen (GanzeZahl => EinheitStadtDatentypen.GesamtproduktionStadt);
   
   function ZahlAlsStringLebenspunkte is new UmwandlungenAdaNachEigenes.ZahlAlsStringLeerzeichenEntfernen (GanzeZahl => EinheitStadtDatentypen.Lebenspunkte);
   
   function ZahlAlsStringKampfwerte is new UmwandlungenAdaNachEigenes.ZahlAlsStringLeerzeichenEntfernen (GanzeZahl => EinheitStadtDatentypen.Kampfwerte);

end InformationenEinheitenSFML;