private with Ada.Strings.Wide_Wide_Unbounded;

with Sf.System.Vector2;

private with ArraysHTSEB;

with SpeziesDatentypen;
with EinheitenRecords;
with EinheitenKonstanten;

private with EinheitenDatentypen;
private with ProduktionDatentypen;
private with KampfDatentypen;
private with TextaccessVariablen;
private with StadtDatentypen;
private with AufgabenDatentypen;

with LeseGrenzen;
with LeseSpeziesbelegung;

private with UmwandlungssystemHTSEB;

package EinheitenseitenleisteGrafik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;
   
   function Einheiten
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Enum;
      EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      TextpositionExtern : in Sf.System.Vector2.sfVector2f;
      MaximaleTextbreiteExtern : in Float)
      return Float
     with
       Pre => (
                 TextpositionExtern.x > 0.00
               and
                 TextpositionExtern.y > 0.00
   --            EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
   --         and
   --           LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
   --         and
   --           LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
           ),
         
     Post => (
                Einheiten'Result > 0.00
             );
   
                   
private
   use Ada.Strings.Wide_Wide_Unbounded;
   
   MaximaleLadung : EinheitenDatentypen.TransportplätzeBasis;
   VorhandeneLadung : EinheitenDatentypen.TransportplätzeBasis;
   
   Arbeit : constant Positive := 6;
   Herkunft : constant Positive := 8;
   
   Beschäftigung : AufgabenDatentypen.Einheiten_Aufgaben_Enum;
   
   IDEinheit : EinheitenDatentypen.EinheitenIDBasis;
   
   Stadtnummer : StadtDatentypen.StädtebereichBasis;
   
   Angriffsbonus : KampfDatentypen.KampfwerteBasis;
   Verteidigungsbonus : KampfDatentypen.KampfwerteBasis;
   
   Leerzeilen : Natural;
   
   YTextposition : Float;
   YTextpositionZwei : Float;
      
   Kampftext : Unbounded_Wide_Wide_String;
      
   EinheitSpeziesNummer : EinheitenRecords.SpeziesEinheitnummerRecord;
   
   AnzuzeigenderText : ArraysHTSEB.AllgemeinesTextArray (TextaccessVariablen.EinheitenInformationenAccess'Range);
   
   
   
   function Lebenspunkte
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      IDExtern : in EinheitenDatentypen.EinheitenIDVorhanden)
      return Unbounded_Wide_Wide_String
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              ),
         
       Post => (
                  To_Wide_Wide_String (Source => Lebenspunkte'Result)'Length > 0 
               );
   
   function Bewegungspunkte
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      IDExtern : in EinheitenDatentypen.EinheitenIDVorhanden)
      return Unbounded_Wide_Wide_String
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              ),
         
       Post => (
                  To_Wide_Wide_String (Source => Bewegungspunkte'Result)'Length > 0 
               );
     
   function Erfahrungspunkte
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      IDExtern : in EinheitenDatentypen.EinheitenIDVorhanden)
      return Unbounded_Wide_Wide_String
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              ),
         
       Post => (
                  To_Wide_Wide_String (Source => Erfahrungspunkte'Result)'Length > 0 
               );
     
   function Rang
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      IDExtern : in EinheitenDatentypen.EinheitenIDVorhanden)
      return Unbounded_Wide_Wide_String
     with
       Pre => (
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
              ),
         
       Post => (
                  To_Wide_Wide_String (Source => Rang'Result)'Length > 0 
               );
   
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
   
   function Einheitenanzeige
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Enum;
      IDExtern : in EinheitenDatentypen.EinheitenIDVorhanden;
      EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      TextpositionExtern : in Sf.System.Vector2.sfVector2f;
      MaximaleTextbreiteExtern : in Float)
      return Float
     with
       Pre => (
                 TextpositionExtern.x > 0.00
               and
                 TextpositionExtern.y > 0.00
               and
                 EinheitSpeziesNummerExtern.Nummer in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies)
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) /= SpeziesDatentypen.Leer_Spieler_Enum
               and
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) /= SpeziesDatentypen.Leer_Spieler_Enum
              ),
         
       Post => (
                  Einheitenanzeige'Result > 0.00
               );
   
   
   
   function ZahlAlsStringMaximaleEinheitenMitNullWert is new UmwandlungssystemHTSEB.Zahlenstring (GanzeZahl => EinheitenDatentypen.EinheitenbereichBasis);
   
   function ZahlAlsStringProduktionFeld is new UmwandlungssystemHTSEB.Zahlenstring (GanzeZahl => ProduktionDatentypen.Feldproduktion);
   
   function ZahlAlsStringGesamtproduktionStadt is new UmwandlungssystemHTSEB.Zahlenstring (GanzeZahl => ProduktionDatentypen.Stadtproduktion);
   
   function ZahlAlsStringLebenspunkte is new UmwandlungssystemHTSEB.Zahlenstring (GanzeZahl => KampfDatentypen.LebenspunkteBasis);
   
   function ZahlAlsStringBewegungspunkte is new UmwandlungssystemHTSEB.Zahlenstring (GanzeZahl => EinheitenDatentypen.BewegungspunkteBasis);
   
   function ZahlAlsStringKampfwerte is new UmwandlungssystemHTSEB.Zahlenstring (GanzeZahl => KampfDatentypen.KampfwerteBasis);
   
   function ZahlAlsStringArbeitszeit is new UmwandlungssystemHTSEB.Zahlenstring (GanzeZahl => ProduktionDatentypen.ArbeitszeitBasis);
   
   function ZahlAlsStringErfahrungspunkte is new UmwandlungssystemHTSEB.Zahlenstring (GanzeZahl => KampfDatentypen.ErfahrungspunkteBasis);
   
   function ZahlAlsStringRang is new UmwandlungssystemHTSEB.Zahlenstring (GanzeZahl => KampfDatentypen.Rang);
   
   function ZahlAlsStringTransportplätze is new UmwandlungssystemHTSEB.Zahlenstring (GanzeZahl => EinheitenDatentypen.TransportplätzeBasis);

end EinheitenseitenleisteGrafik;
