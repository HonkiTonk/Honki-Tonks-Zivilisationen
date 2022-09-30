pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with AufgabenDatentypen; use AufgabenDatentypen;
with KartenRecords; use KartenRecords;
with EinheitenKonstanten;
with KartenRecordKonstanten;

with LeseEinheitenGebaut;

with Vergleiche;
with EinheitenbewegungLogik;

with KIDatentypen; use KIDatentypen;

with KIBewegungDurchfuehrenLogik;
with KIEinheitAufgabenplanungLogik;
with KIEinheitAufgabenumsetzungLogik;

package body KIEinheitHandlungenLogik is

   function HandlungBeendet
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      if
        LeseEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = KIDatentypen.Tut_Nichts_Enum
        or
          LeseEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern) /= EinheitenKonstanten.LeerBeschäftigung
      then
         return True;
         
      elsif
        LeseEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = KIDatentypen.Stadt_Bewachen_Enum
        and
          LeseEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = KartenRecordKonstanten.LeerKoordinate
      then
         return True;
            
      else
         -- Muss hier not sein wegen den Rückgabewerten in der Funktion selbst, die nicht geändert werden können wegen der Einbindung im Bewegungssystem.
         return not EinheitenbewegungLogik.NochBewegungspunkte (EinheitRasseNummerExtern  => EinheitRasseNummerExtern,
                                                                BewegungDurchführenExtern => False,
                                                                KoordinatenExtern         => KartenRecordKonstanten.LeerKoordinate);
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
         KIEinheitAufgabenplanungLogik.AufgabeErmitteln (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
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
            KIBewegungDurchfuehrenLogik.KIBewegung (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            return HandlungBeendet (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when True =>
            return False;
      end case;
      
   end Bewegen;
   
   
   
   function Aufgabenumsetzung
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      -- Hier sollte keine Prüfung auf Zielkoordinate nötig sein, da er sich so lange bewegen sollte bis er das Ziel erreicht hat oder keine Bewegungspunkte mehr hat.
      if
        LeseEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern) /= KIDatentypen.Tut_Nichts_Enum
        and
          LeseEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern) /= KIDatentypen.Leer_Aufgabe_Enum
        and
          LeseEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = EinheitenKonstanten.LeerBeschäftigung
      then
         KIEinheitAufgabenumsetzungLogik.AufgabeUmsetzen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         return HandlungBeendet (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         
      else
         return False;
      end if;
      
   end Aufgabenumsetzung;

end KIEinheitHandlungenLogik;
