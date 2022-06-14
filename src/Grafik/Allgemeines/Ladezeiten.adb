pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with LadezeitenDatentypen; use LadezeitenDatentypen;

with Warnung;

package body Ladezeiten is
   
   procedure Nullsetzen
   is begin
      
      SpielweltErstellen := (others => (others => Clock));
      FortschrittSpielwelt := (others => 0);
      
   end Nullsetzen;
   
   
   
   procedure FortschrittSpielweltSchreiben
     (WelcheBerechnungenExtern : in LadezeitenDatentypen.Spielwelt_Erstellen_Enum)
   is begin
      
      if
        FortschrittSpielwelt (WelcheBerechnungenExtern) + 1 > LadezeitenDatentypen.Ladefortschritt'Last
      then
         Warnung.LogikWarnung (WarnmeldungExtern => "Ladezeiten.FortschrittSpielweltSchreiben - Ladezeit liegt bei über 100.");
         
      else
         FortschrittSpielwelt (WelcheBerechnungenExtern) := FortschrittSpielwelt (WelcheBerechnungenExtern) + 1;
      end if;
      
   end FortschrittSpielweltSchreiben;

end Ladezeiten;
