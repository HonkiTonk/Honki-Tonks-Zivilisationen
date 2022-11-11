with PZBEingesetztLogik;

with KIKriegErmittelnLogik;
with KIEinheitFestlegenNichtsLogik;

package body KIPZBAufgabenLogik is

   procedure PZBAufgaben
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      if
        KIKriegErmittelnLogik.IstImKrieg (RasseExtern => EinheitRasseNummerExtern.Rasse) = True
      then
         case
           PZBEingesetztLogik.PZBEingesetzt (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
         is
            when others =>
               null;
         end case;
         
      else
         KIEinheitFestlegenNichtsLogik.NichtsTun (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      end if;
      
   end PZBAufgaben;

end KIPZBAufgabenLogik;
