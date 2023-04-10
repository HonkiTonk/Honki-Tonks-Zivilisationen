with AufgabenDatentypen;

with LeseEinheitenGebaut;
with LeseEinheitenDatenbank;

with Fehlermeldungssystem;
with FehlermeldungssystemZusatzinformationen;

with KIDatentypen;

with KISiedleraufgabenLogik;
with KIKampfaufgabenLogik;
with KIPZBAufgabenLogik;
with KIEinheitHandlungstestsLogik;

package body KIEinheitenAufgabenplanungLogik is

   function Aufgabenplanung
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
   is
      use type KIDatentypen.Einheit_Aufgabe_Enum;
      use type AufgabenDatentypen.Einheiten_Aufgaben_Enum;
   begin
      
      if
        LeseEinheitenGebaut.Beschäftigung (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern) /= EinheitenKonstanten.LeerBeschäftigung
        or
          LeseEinheitenGebaut.KIBeschäftigt (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern) /= KIDatentypen.Leer_Aufgabe_Enum
      then
         return False;
         
      else
         EinheitID := LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      end if;
         
      case
        LeseEinheitenDatenbank.Einheitenart (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies,
                                             IDExtern      => EinheitID)
      is
         when EinheitenDatentypen.Arbeiter_Enum =>
            KISiedleraufgabenLogik.Siedleraufgaben (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
            
         when EinheitenDatentypen.Einheitenart_Kampf_Enum'Range | EinheitenDatentypen.Cheat_Enum =>
            KIKampfaufgabenLogik.Nahkämpferaufgaben (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
            
         when EinheitenDatentypen.Einmalig_Enum =>
            KIPZBAufgabenLogik.PZBAufgaben (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
                           
         when EinheitenDatentypen.Leer_Einheitart_Enum =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "KIEinheitenAufgabenplanungLogik.Aufgabenplanung: Leere Einheitenart: "
                                        & FehlermeldungssystemZusatzinformationen.SpeziesID (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies,
                                                                                             IDExtern      => EinheitID));
            return False;
      end case;
      
      return KIEinheitHandlungstestsLogik.HandlungBeendet (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      
   end Aufgabenplanung;

end KIEinheitenAufgabenplanungLogik;
