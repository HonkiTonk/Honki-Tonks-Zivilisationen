with StadtDatentypen;
with EinheitenDatentypen;

with LeseWichtiges;

-- with PZBEingesetztLogik;

with LeseKIVariablen;

with KIEinheitFestlegenNichtsLogik;

package body KIPZBAufgabenLogik is

   procedure PZBAufgaben
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
   is begin
      
      case
        LeseKIVariablen.Kriegszustand
      is
         when False =>
            NormaleAufgaben (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
            
         when True =>
            Kriegsaufgaben (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      end case;
      
   end PZBAufgaben;
   
   
   
   procedure NormaleAufgaben
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
   is begin
      
      KIEinheitFestlegenNichtsLogik.NichtsTun (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      
   end NormaleAufgaben;
   
   
     
   procedure Kriegsaufgaben
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
   is
      use type StadtDatentypen.MaximaleStädteMitNullWert;
      use type EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   begin
      
      if
        LeseWichtiges.AnzahlStädte (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) = 0
        and
          LeseWichtiges.AnzahlArbeiter (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies) = 0
      then
         -- case
         --   PZBEingesetztLogik.PZBEingesetzt (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern)
         --  is
         --    when others =>
         null;
         --  end case;
         
      else
         NormaleAufgaben (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      end if;
      
   end Kriegsaufgaben;

end KIPZBAufgabenLogik;
