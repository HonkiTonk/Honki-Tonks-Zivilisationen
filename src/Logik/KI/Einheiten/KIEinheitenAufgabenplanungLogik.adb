with AufgabenDatentypen;

with LeseEinheitenGebaut;
with LeseEinheitenDatenbank;

with Fehlermeldungssystem;

with KIDatentypen;

with KISiedleraufgabenLogik;
with KIKampfaufgabenLogik;
with KIPZBAufgabenLogik;
with KIEinheitHandlungstestsLogik;

package body KIEinheitenAufgabenplanungLogik is

   function Aufgabenplanung
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is
      use type KIDatentypen.Einheit_Aufgabe_Enum;
      use type AufgabenDatentypen.Einheiten_Aufgaben_Enum;
   begin
      
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
            KISiedleraufgabenLogik.Siedleraufgaben (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when EinheitenDatentypen.Einheitenart_Kampf_Enum'Range | EinheitenDatentypen.Cheat_Enum =>
            KIKampfaufgabenLogik.Nahkämpferaufgaben (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when EinheitenDatentypen.PZB_Enum'Range =>
            KIPZBAufgabenLogik.PZBAufgaben (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
                           
         when EinheitenDatentypen.Leer_Einheitart_Enum =>
            Fehlermeldungssystem.Logik
              (FehlermeldungExtern => "KIEinheitenAufgabenplanungLogik.Aufgabenplanung: KI nutzt leere Einheitenart: " & EinheitRasseNummerExtern.Rasse'Wide_Wide_Image & " " & EinheitID'Wide_Wide_Image);
      end case;
         
      return KIEinheitHandlungstestsLogik.HandlungBeendet (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
   end Aufgabenplanung;

end KIEinheitenAufgabenplanungLogik;
