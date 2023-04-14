with EinheitenDatentypen;
with StadtDatentypen;
with ProduktionDatentypen;

with SchreibeStadtGebaut;
with LeseEinheitenDatenbank;
with LeseStadtGebaut;
with LeseGebaeudeDatenbank;

with StadtEinheitenBauenLogik;
with StadtGebaeudeBauenLogik;

package body StadtmaterialwachstumLogik is
   
   procedure Material
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
   is
      use type StadtDatentypen.GebäudeIDMitNullwert;
      use type EinheitenDatentypen.EinheitenIDMitNullWert;
      use type ProduktionDatentypen.Produktion;
   begin
      
      SchreibeStadtGebaut.Material (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                    MaterialExtern           => LeseStadtGebaut.Produktionrate (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern),
                                    ÄndernSetzenExtern       => True);
      
      Bauprojekt := LeseStadtGebaut.Bauprojekt (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
        
      if
        Bauprojekt.Gebäude = 0
        and
          Bauprojekt.Einheit = 0
      then
         SchreibeStadtGebaut.Material (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                       MaterialExtern           => StadtKonstanten.LeerMaterial,
                                       ÄndernSetzenExtern       => False);
         
      elsif
        Bauprojekt.Gebäude /= 0
      then
         if
           LeseStadtGebaut.Material (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern) >= LeseGebaeudeDatenbank.Produktionskosten (SpeziesExtern => StadtSpeziesNummerExtern.Spezies,
                                                                                                                                       IDExtern      => StadtDatentypen.GebäudeID (Bauprojekt.Gebäude))
         then
            StadtGebaeudeBauenLogik.GebäudeFertiggestellt (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
            
         else
            null;
         end if;
         
      else
         if
           LeseStadtGebaut.Material (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern) >= LeseEinheitenDatenbank.Produktionskosten (SpeziesExtern => StadtSpeziesNummerExtern.Spezies,
                                                                                                                                        IDExtern      => EinheitenDatentypen.EinheitenID (Bauprojekt.Einheit))
         then
            StadtEinheitenBauenLogik.EinheitFertiggestellt (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);

         else
            null;
         end if;
      end if;
      
   end Material;

end StadtmaterialwachstumLogik;
