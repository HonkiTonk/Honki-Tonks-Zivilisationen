with EinheitenDatentypen;

with LeseEinheitenGebaut;
with SchreibeEinheitenGebaut;

with KIDatentypen;

with KIGefahrErmittelnLogik;

package body KIEinheitAufgabenabbruchLogik is

   procedure Friedenshandlung
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is
      use type EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   begin
      
      if
        LeseEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern) not in KIDatentypen.Einheit_Aufgabe_Frieden_Enum'Range
        or
          KIGefahrErmittelnLogik.GefahrSuchen (EinheitRasseNummerExtern => EinheitRasseNummerExtern).Nummer = EinheitenKonstanten.LeerNummer
      then
         null;
            
      else
         SchreibeEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                 AufgabeExtern            => KIDatentypen.Leer_Aufgabe_Enum);
      end if;
      
   end Friedenshandlung;

end KIEinheitAufgabenabbruchLogik;
