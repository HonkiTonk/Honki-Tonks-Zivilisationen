with KartenDatentypen;

with KartengeneratorVariablenLogik;
with KartentestsLogik;

-- Prinzipiell eine gute Idee, aber da ich nicht immer die Ebene kenne müsste ich die mitübergeben, sonst funktioniert das nur bei den Rohstoffgeneratoren.
-- Nochmal überarbeiten. äöü
package body LadezeitenAllgemeinesLogik is

   function ZeiteinheitBerechnen
     return SystemDatentypenHTSEB.LadezeitBasis
   is
      use type KartenDatentypen.SenkrechtePositiv;
   begin
      
      return 100.00 / Float (KartentestsLogik.VorhandeneEbenen (EbenenExtern => KartengeneratorVariablenLogik.KartenebenenLesen) * KartengeneratorVariablenLogik.KartengrößeLesen.Senkrechte);
      
   end ZeiteinheitBerechnen;
   
   

   function ZeiteinheitPlanetBerechnen
     return SystemDatentypenHTSEB.LadezeitBasis
   is
      use type KartenDatentypen.SenkrechtePositiv;
   begin
      
      return 100.00 / Float (KartentestsLogik.PlanetenEbenen (EbenenExtern => KartengeneratorVariablenLogik.KartenebenenLesen) * KartengeneratorVariablenLogik.KartengrößeLesen.Senkrechte);
      
   end ZeiteinheitPlanetBerechnen;

end LadezeitenAllgemeinesLogik;
