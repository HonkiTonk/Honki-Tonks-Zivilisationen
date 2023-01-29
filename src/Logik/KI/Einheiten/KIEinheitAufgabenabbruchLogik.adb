with EinheitenDatentypen;

with LeseEinheitenGebaut;
with SchreibeEinheitenGebaut;

with KIDatentypen;

with KIGefahrErmittelnLogik;

package body KIEinheitAufgabenabbruchLogik is

   procedure Friedenshandlung
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
   is
      use type EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   begin
      
      if
        LeseEinheitenGebaut.KIBeschäftigt (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern) not in KIDatentypen.Einheit_Aufgabe_Frieden_Enum'Range
        or
          KIGefahrErmittelnLogik.GefahrSuchen (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern).Nummer = EinheitenKonstanten.LeerNummer
      then
         null;
            
      else
         SchreibeEinheitenGebaut.KIBeschäftigt (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                 AufgabeExtern              => KIDatentypen.Leer_Aufgabe_Enum);
      end if;
      
   end Friedenshandlung;

end KIEinheitAufgabenabbruchLogik;
