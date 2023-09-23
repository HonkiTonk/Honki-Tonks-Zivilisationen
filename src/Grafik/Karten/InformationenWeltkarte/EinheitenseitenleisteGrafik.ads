with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf.System.Vector3;

private with Sf.System.Vector2;

with SpeziesDatentypen;
with EinheitenRecords;
with EinheitenKonstanten;

private with EinheitenDatentypen;
private with ProduktionDatentypen;
private with KampfDatentypen;
private with TextaccessVariablen;
private with StadtDatentypen;
private with AufgabenDatentypen;
private with KartenRecords;
private with TextArrays;

with LeseGrenzen;
with LeseSpeziesbelegung;

private with UmwandlungenAdaEigenes;

package EinheitenseitenleisteGrafik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;
   
   function Einheiten
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Enum;
      EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      TextpositionsinformationenExtern : in Sf.System.Vector3.sfVector3f)
      return Sf.System.Vector3.sfVector3f
     with
       Pre => (
                 TextpositionsinformationenExtern.x > 0.00
               and
                 TextpositionsinformationenExtern.y > 0.00
               and
                 TextpositionsinformationenExtern.z >= 0.00
              ),
   --            EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
   --         and
   --           LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
   --         and
   --           LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
   --        ),
         
     Post => (
                Einheiten'Result.x > 0.00
              and
                Einheiten'Result.y > 0.00
              and
                Einheiten'Result.z >= 0.00
             );
   
                   
private
   
   VolleInformation : Boolean;
   Beladen : Boolean;
   NichtsZeichnen : Boolean;
   
   Beschäftigung : AufgabenDatentypen.Einheiten_Aufgaben_Enum;
   
   IDEinheit : EinheitenDatentypen.EinheitenID;
   
   Stadtnummer : StadtDatentypen.Städtebereich;
   
   Ladungsnummer : EinheitenDatentypen.Einheitenbereich;
   
   Angriffsbonus : KampfDatentypen.Kampfwerte;
   Verteidigungsbonus : KampfDatentypen.Kampfwerte;
   
   Informationsgrenze : constant Positive := 3;
   
   Textbreite : Float;
   TextbreiteDebug : Float;
      
   Ladungstext : Unbounded_Wide_Wide_String;
   Kampftext : Unbounded_Wide_Wide_String;
      
   EinheitSpeziesNummer : EinheitenRecords.SpeziesEinheitnummerRecord;
   
   Leerwert : Sf.System.Vector2.sfVector2f;
   Textposition : Sf.System.Vector2.sfVector2f;
   TextpositionDebug : Sf.System.Vector2.sfVector2f;
   Skalierung : Sf.System.Vector2.sfVector2f;
   
   Koordinaten : KartenRecords.AchsenKartenfeldNaturalRecord;
   
   FestzulegenderText : TextArrays.AllgemeinesTextArray (TextaccessVariablen.EinheitenInformationenAccess'Range);
   
   procedure TextZeichnen;
   
   
   
   function Aufgabe
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Unbounded_Wide_Wide_String
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function Kampfwerte
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Unbounded_Wide_Wide_String
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              ),
         
       Post => (
                  To_Wide_Wide_String (Source => Kampfwerte'Result)'Length > 0 
               );
   
   function Heimatstadt
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Unbounded_Wide_Wide_String
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function Ladung
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      IDExtern : in EinheitenDatentypen.EinheitenIDVorhanden)
      return Unbounded_Wide_Wide_String
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              );
   
   function PlanZielKoordinaten
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      TextwerteExtern : in Sf.System.Vector2.sfVector2f)
      return Sf.System.Vector2.sfVector2f
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              ),
         
       Post => (
                  PlanZielKoordinaten'Result.x >= 0.00
                and
                  PlanZielKoordinaten'Result.y >= 0.00
               );
      
   function ZahlAlsStringMaximaleEinheitenMitNullWert is new UmwandlungenAdaEigenes.ZahlAlsString (GanzeZahl => EinheitenDatentypen.Einheitenbereich);
   
   function ZahlAlsStringProduktionFeld is new UmwandlungenAdaEigenes.ZahlAlsString (GanzeZahl => ProduktionDatentypen.Feldproduktion);
   
   function ZahlAlsStringGesamtproduktionStadt is new UmwandlungenAdaEigenes.ZahlAlsString (GanzeZahl => ProduktionDatentypen.Stadtproduktion);
   
   function ZahlAlsStringLebenspunkte is new UmwandlungenAdaEigenes.ZahlAlsString (GanzeZahl => KampfDatentypen.Lebenspunkte);
   
   function ZahlAlsStringBewegungspunkte is new UmwandlungenAdaEigenes.ZahlAlsString (GanzeZahl => EinheitenDatentypen.Bewegungspunkte);
   
   function ZahlAlsStringKampfwerte is new UmwandlungenAdaEigenes.ZahlAlsString (GanzeZahl => KampfDatentypen.Kampfwerte);
   
   function ZahlAlsStringArbeitszeit is new UmwandlungenAdaEigenes.ZahlAlsString (GanzeZahl => ProduktionDatentypen.Arbeitszeit);
   
   function ZahlAlsStringErfahrungspunkte is new UmwandlungenAdaEigenes.ZahlAlsString (GanzeZahl => KampfDatentypen.Erfahrungspunkte);
   
   function ZahlAlsStringRang is new UmwandlungenAdaEigenes.ZahlAlsString (GanzeZahl => KampfDatentypen.Rang);

end EinheitenseitenleisteGrafik;
