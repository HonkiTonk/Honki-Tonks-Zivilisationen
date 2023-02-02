with EinheitenDatentypen;
with TextnummernKonstanten;

with LeseEinheitenGebaut;
with LeseEinheitenDatenbank;

with MeldungFestlegenLogik;

package body EinheitenSpielmeldungenLogik is

   function BewegungspunkteMeldung
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
   is
      use type EinheitenDatentypen.Bewegungspunkte;
   begin
      
      if
        LeseEinheitenGebaut.Bewegungspunkte (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern) = EinheitenKonstanten.LeerBewegungspunkte
      then
         MeldungFestlegenLogik.MeldungFestlegen (MeldungExtern => TextnummernKonstanten.MeldungBewegungspunkte);
         return False;
                     
      else
         return True;
      end if;
      
   end BewegungspunkteMeldung;
   
   
   
   function ArbeiteraufgabeMeldung
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
   is begin
      
      case
        LeseEinheitenDatenbank.Einheitenart (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies,
                                             IDExtern      => LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern))
      is
         when EinheitenDatentypen.Arbeiter_Enum =>
            return True;
         
         when others =>
            MeldungFestlegenLogik.MeldungFestlegen (MeldungExtern => TextnummernKonstanten.MeldungBefehl);
            return False;
      end case;
      
   end ArbeiteraufgabeMeldung;
   
end EinheitenSpielmeldungenLogik;
