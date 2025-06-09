with KartengrundDatentypen;
with LadezeitenDatentypen;

with LeseWeltkarte;

with ZufallsgeneratorenKartenLogik;
with KartengeneratorVariablenLogik;
with FlussplatzierungssystemLogik;
with LadezeitenLogik;

package body KartengeneratorFlussLogik is

   procedure GenerierungFlüsse
   is
      use type KartenDatentypen.Senkrechte;
      use type SystemDatentypenHTSEB.NullBisHundert;
   begin
      
      Kartenzeitwert := Basiszeitwert (ZusatzwertExtern => KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.Senkrechte,
                                       TeilerExtern     => 33);
      
      EbeneSchleife:
      for EbeneSchleifenwert in KartenDatentypen.EbenePlanet'Range loop
         SenkrechteSchleife:
         for SenkrechteSchleifenwert in KartengeneratorVariablenLogik.SchleifenanfangOhnePolbereich.Senkrechte .. KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.Senkrechte loop
            WaagerechteSchleife:
            for WaagerechteSchleifenwert in KartengeneratorVariablenLogik.SchleifenanfangOhnePolbereich.Waagerechte .. KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.Waagerechte loop
            
               case
                 LeseWeltkarte.Basisgrund (KoordinatenExtern => (EbeneSchleifenwert, SenkrechteSchleifenwert, WaagerechteSchleifenwert))
               is
                  when KartengrundDatentypen.Basisgrund_Oberfläche_Eiswasser_Enum'Range | KartengrundDatentypen.Basisgrund_Unterfläche_Eiswasser_Enum'Range
                     | KartengrundDatentypen.Basisgrund_Kernfläche_Flüssig_Enum'Range =>
                     null;
                  
                  when others =>
                     if
                       ZufallsgeneratorenKartenLogik.KartengeneratorZufallswerte <= WahrscheinlichkeitFluss (EbeneSchleifenwert)
                     then
                        FlussplatzierungssystemLogik.Flussplatzierung (KoordinatenExtern => (EbeneSchleifenwert, SenkrechteSchleifenwert, WaagerechteSchleifenwert));
                     
                     else
                        null;
                     end if;
               end case;
         
            end loop WaagerechteSchleife;
         
            case
              SenkrechteSchleifenwert mod Kartenzeitwert
            is
               when 0 =>
                  LadezeitenLogik.FortschrittSpielweltSchreiben (WelcheBerechnungenExtern => LadezeitenDatentypen.Generiere_Flüsse_Enum);
               
               when others =>
                  null;
            end case;
         
         end loop SenkrechteSchleife;
      end loop EbeneSchleife;
      
   end GenerierungFlüsse;

end KartengeneratorFlussLogik;
