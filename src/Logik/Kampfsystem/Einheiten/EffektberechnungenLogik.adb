with KartengrundDatentypen;

with LeseEinheitenGebaut;
with LeseEinheitenDatenbank;

with PZBEingesetztLogik;

package body EffektberechnungenLogik is

   procedure Effektberechnungen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
   is begin
      
      EinheitID := LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      
      case
        LeseEinheitenDatenbank.Zusatzeffekt (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies,
                                             IDExtern      => EinheitID,
                                             EffektExtern  => KartengrundDatentypen.Vernichtet_Enum)
      is
         when True =>
            Leerwert := PZBEingesetztLogik.PZBEingesetzt (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
            return;
            
         when False =>
            null;
      end case;
      
      EffekteSchleife:
      for EffektSchleifenwert in KartengrundDatentypen.Effekt_Kartenfeld_Enum'Range loop
         
         if
           True = LeseEinheitenDatenbank.Zusatzeffekt (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies,
                                                       IDExtern      => EinheitID,
                                                       EffektExtern  => EffektSchleifenwert)
         then
            case
              EffektSchleifenwert
            is
               when KartengrundDatentypen.Atomar_Enum =>
                  AtomareZusatzberechnungen (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                             IDExtern                   => EinheitID);
                  
               when KartengrundDatentypen.Biologisch_Enum =>
                  BiologischeZusatzberechnungen (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                 IDExtern                   => EinheitID);
                  
               when KartengrundDatentypen.Chemisch_Enum =>
                  ChemischeZusatzberechnungen (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                               IDExtern                   => EinheitID);
                  
               when KartengrundDatentypen.Verschmutzt_Enum =>
                  VerschmutzungsZusatzberechnungen (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                    IDExtern                   => EinheitID);
            end case;
            
         else
            null;
         end if;
         
      end loop EffekteSchleife;
      
   end Effektberechnungen;
   
   
   
   procedure AtomareZusatzberechnungen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      IDExtern : in EinheitenDatentypen.EinheitenID)
   is begin
      
      null;
      
   end AtomareZusatzberechnungen;
   
   
   
   procedure BiologischeZusatzberechnungen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      IDExtern : in EinheitenDatentypen.EinheitenID)
   is begin
      
      null;
      
   end BiologischeZusatzberechnungen;
   
   
   
   procedure ChemischeZusatzberechnungen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      IDExtern : in EinheitenDatentypen.EinheitenID)
   is begin
      
      null;
      
   end ChemischeZusatzberechnungen;
   
   
   
   procedure VerschmutzungsZusatzberechnungen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      IDExtern : in EinheitenDatentypen.EinheitenID)
   is begin
      
      null;
      
   end VerschmutzungsZusatzberechnungen;

end EffektberechnungenLogik;
