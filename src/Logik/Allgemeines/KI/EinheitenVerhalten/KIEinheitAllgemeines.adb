pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitenDatentypen; use EinheitenDatentypen;
with AufgabenDatentypen; use AufgabenDatentypen;
with KartenRecords; use KartenRecords;
with EinheitenKonstanten;

with LeseEinheitenGebaut;

with Vergleiche;

with KIDatentypen; use KIDatentypen;
with KIKonstanten;

with KIBewegungDurchfuehren;
with KIAufgabenPlanung;

---------------------------------- Besseren Namen geben.
package body KIEinheitAllgemeines is

   function HandlungBeendet
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      if
        LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = EinheitenKonstanten.LeerID
        or
          LeseEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = KIDatentypen.Tut_Nichts_Enum
        or
          LeseEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern) /= EinheitenKonstanten.LeerBeschäftigung
        or
          LeseEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern) <= EinheitenKonstanten.LeerBewegungspunkte
      then
         return True;
         
      elsif
        LeseEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = KIDatentypen.Stadt_Bewachen_Enum
        and
          LeseEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = KIKonstanten.LeerKoordinate
      then
         return True;
            
      else
         return False;
      end if;
      
   end HandlungBeendet;
           
      
   
   -- Muss auch eine Funktion sein, es könnte ja als Aufgabe Stadt_Bewachen_Enum festgelegt werden für den Ort an dem sich die Einheit gerade befindet.
   function Aufgabenplanung
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      if
        LeseEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = EinheitenKonstanten.LeerBeschäftigung
        and
          LeseEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = KIDatentypen.Leer_Aufgabe_Enum
      then
         KIAufgabenPlanung.AufgabeErmitteln (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         return HandlungBeendet (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         
      else
         return False;
      end if;
      
   end Aufgabenplanung;
   
   
   
   function Bewegen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      case
        Vergleiche.KoordinateLeervergleich (KoordinateExtern => LeseEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern))
      is
         when False =>
            KIBewegungDurchfuehren.KIBewegung (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            return HandlungBeendet (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when True =>
            return False;
      end case;
      
   end Bewegen;
   
   
   
   function Aufgabenumsetzung
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      if
        LeseEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern) /= KIDatentypen.Tut_Nichts_Enum
        and
          LeseEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern) /= KIDatentypen.Leer_Aufgabe_Enum
        and
          LeseEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = EinheitenKonstanten.LeerBeschäftigung
      then
         KIAufgabenPlanung.AufgabeUmsetzen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         return HandlungBeendet (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         
      else
         return False;
      end if;
      
   end Aufgabenumsetzung;

end KIEinheitAllgemeines;
