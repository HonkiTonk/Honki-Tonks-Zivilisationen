with AufgabenDatentypen; use AufgabenDatentypen;
with KartenRecords; use KartenRecords;
with EinheitenKonstanten;
with KartenRecordKonstanten;

with LeseEinheitenDatenbank;
with LeseEinheitenGebaut;

with Vergleiche;
with EinheitenbewegungLogik;

with Fehler;

with KIDatentypen; use KIDatentypen;

with KIBewegungDurchfuehrenLogik;
with KIEinheitAufgabenumsetzungLogik;
with KISiedleraufgabenLogik;
with KINahkampfaufgabenLogik;
with KIPZBAufgabenLogik;

package body KIEinheitHandlungenLogik is

   function HandlungBeendet
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      if
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
   
      
   
   function Aufgabenplanung
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      if
        LeseEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern) /= EinheitenKonstanten.LeerBeschäftigung
        or
          LeseEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern) /= KIDatentypen.Leer_Aufgabe_Enum
      then
         return False;
         
      else
         EinheitID := LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      end if;
         
      case
        LeseEinheitenDatenbank.Einheitenart (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                             IDExtern    => EinheitID)
      is
         when EinheitenDatentypen.Arbeiter_Enum =>
            KISiedleraufgabenLogik.KISiedleraufgabenLogik (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when EinheitenDatentypen.Nahkämpfer_Enum | EinheitenDatentypen.Cheat_Enum =>
            KINahkampfaufgabenLogik.Nahkämpferaufgaben (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when EinheitenDatentypen.Fernkämpfer_Enum =>
            -- Vorübergehend gibt es nur Nahkämpfer, später entsprechend erweitern. äöü
            KINahkampfaufgabenLogik.Nahkämpferaufgaben (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when EinheitenDatentypen.Beides_Enum =>
            -- Vorübergehend gibt es nur Nahkämpfer, später entsprechend erweitern. äöü
            KINahkampfaufgabenLogik.Nahkämpferaufgaben (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when EinheitenDatentypen.PZB_Enum'Range =>
            KIPZBAufgabenLogik.PZBAufgaben (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
                           
         when EinheitenDatentypen.Leer_Einheitart_Enum =>
            Fehler.LogikFehler (FehlermeldungExtern => "KIEinheitHandlungenLogik.Aufgabenplanung - KI nutzt leere Einheitenart: " & EinheitRasseNummerExtern.Rasse'Wide_Wide_Image & " " & EinheitID'Wide_Wide_Image);
      end case;
         
      return HandlungBeendet (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
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
      
      if
        LeseEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern) /= KIDatentypen.Leer_Aufgabe_Enum
        and
          LeseEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = EinheitenKonstanten.LeerBeschäftigung
        and
          Vergleiche.KoordinateLeervergleich (KoordinateExtern => LeseEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern)) = True
      then
         KIEinheitAufgabenumsetzungLogik.AufgabeUmsetzen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         return HandlungBeendet (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         
      else
         return False;
      end if;
      
   end Aufgabenumsetzung;

end KIEinheitHandlungenLogik;
