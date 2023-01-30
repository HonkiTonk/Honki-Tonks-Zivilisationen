with KartengrundDatentypen;

with LeseEinheitenGebaut;
with LeseEinheitenDatenbank;

with PZBEingesetztLogik;
with StrahlungswaffeEingesetztLogik;
with BiologischeWaffeEingesetztLogik;
with ChemischeWaffeEingesetztLogik;
with EinheitenErzeugenEntfernenLogik;
with VerschmutzendeWaffeEingesetztLogik;

-- Sollten Einmalwaffen Städte direkt zerstören oder wäre ein eigenes System dafür besser? äöü
-- Die Meinungsänderung der Anderen wird in den einzelnen Unterprozeduren geregelt, aber es muss eventuell noch eine Anpassung am Zustand irgendwo rein, am besten hier? äöü
-- Die Meinungsänderung später noch Effekt- und Speziesspezifisch gestalten. äöü
package body EffektberechnungenLogik is

   -- Aktuell kann eine Einheit mehrere Effekte aber nur eine Reichweite haben, das später mal erweitern. äöü
   procedure Effektberechnungen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
   is
      use type EinheitenDatentypen.Einheitart_Enum;
      use type EinheitenDatentypen.Lebenspunkte;
   begin
      
      EinheitID := LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      
      EffekteSchleife:
      for EffektSchleifenwert in reverse KartengrundDatentypen.Effekt_Vorhanden_Enum'Range loop
         
         if
           True = LeseEinheitenDatenbank.Zusatzeffekt (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies,
                                                       IDExtern      => EinheitID,
                                                       EffektExtern  => EffektSchleifenwert)
         then
            case
              EffektSchleifenwert
            is
               when KartengrundDatentypen.Strahlung_Enum =>
                  StrahlungswaffeEingesetztLogik.StrahlungswaffeEingesetzt (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
                  
               when KartengrundDatentypen.Biologisch_Enum =>
                  BiologischeWaffeEingesetztLogik.BiologischeWaffeEingesetzt (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
                  
               when KartengrundDatentypen.Chemisch_Enum =>
                  ChemischeWaffeEingesetztLogik.ChemischeWaffeEingesetzt (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
                  
               when KartengrundDatentypen.Verschmutzt_Enum =>
                  VerschmutzendeWaffeEingesetztLogik.VerschmutzendeWaffeEingesetzt (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
                  
               when KartengrundDatentypen.Vernichtet_Enum =>
                  PZBEingesetztLogik.PZBEingesetzt (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
                  exit EffekteSchleife;
            end case;
            
         else
            null;
         end if;
         
      end loop EffekteSchleife;
      
      if
        EinheitenDatentypen.Einmalig_Enum = LeseEinheitenDatenbank.Einheitenart (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies,
                                                                                 IDExtern      => EinheitID)
        and
          LeseEinheitenGebaut.Lebenspunkte (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern) > EinheitenKonstanten.LeerLebenspunkte
      then
         EinheitenErzeugenEntfernenLogik.EinheitEntfernen (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
         
      else
         null;
      end if;
      
   end Effektberechnungen;

end EffektberechnungenLogik;
