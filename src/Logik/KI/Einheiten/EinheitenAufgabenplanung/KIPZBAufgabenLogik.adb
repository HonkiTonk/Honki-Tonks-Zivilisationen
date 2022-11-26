with StadtDatentypen;
with EinheitenDatentypen;

with LeseWichtiges;

with PZBEingesetztLogik;

with LeseKIVariablen;

with KIEinheitFestlegenNichtsLogik;

package body KIPZBAufgabenLogik is

   procedure PZBAufgaben
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      case
        LeseKIVariablen.Kriegszustand
      is
         when False =>
            NormaleAufgaben (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when True =>
            Kriegsaufgaben (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      end case;
      
   end PZBAufgaben;
   
   
   
   procedure NormaleAufgaben
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      KIEinheitFestlegenNichtsLogik.NichtsTun (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
   end NormaleAufgaben;
   
   
     
   procedure Kriegsaufgaben
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is
      use type StadtDatentypen.MaximaleStädteMitNullWert;
      use type EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   begin
      
      if
        LeseWichtiges.AnzahlStädte (RasseExtern => EinheitRasseNummerExtern.Rasse) = 0
        and
          LeseWichtiges.AnzahlArbeiter (RasseExtern => EinheitRasseNummerExtern.Rasse) = 0
      then
         case
           PZBEingesetztLogik.PZBEingesetzt (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
         is
            when others =>
               null;
         end case;
         
      else
         NormaleAufgaben (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      end if;
      
   end Kriegsaufgaben;

end KIPZBAufgabenLogik;
