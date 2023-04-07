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
      use type KartenDatentypen.Kartenfeld;
      use type SystemDatentypen.NullBisHundert;
   begin
      
      Kartenzeitwert := (KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.YAchse + (33 - 1)) / 33;
      
      EAchseSchleife:
      for EAchseSchleifenwert in KartenDatentypen.EbenePlanet'Range loop
         YAchseSchleife:
         for YAchseSchleifenwert in KartengeneratorVariablenLogik.SchleifenanfangOhnePolbereich.YAchse .. KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.YAchse loop
            XAchseSchleife:
            for XAchseSchleifenwert in KartengeneratorVariablenLogik.SchleifenanfangOhnePolbereich.XAchse .. KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.XAchse loop
            
               case
                 LeseWeltkarte.Basisgrund (KoordinatenExtern => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert))
               is
                  when KartengrundDatentypen.Basisgrund_Oberfläche_Eiswasser_Enum'Range | KartengrundDatentypen.Basisgrund_Unterfläche_Eiswasser_Enum'Range
                     | KartengrundDatentypen.Basisgrund_Kernfläche_Flüssig_Enum'Range =>
                     null;
                  
                  when others =>
                     if
                       ZufallsgeneratorenKartenLogik.KartengeneratorZufallswerte <= WahrscheinlichkeitFluss (EAchseSchleifenwert)
                     then
                        FlussplatzierungssystemLogik.Flussplatzierung (KoordinatenExtern => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert));
                     
                     else
                        null;
                     end if;
               end case;
         
            end loop XAchseSchleife;
         
            case
              YAchseSchleifenwert mod Kartenzeitwert
            is
               when 0 =>
                  LadezeitenLogik.FortschrittSpielweltSchreiben (WelcheBerechnungenExtern => LadezeitenDatentypen.Generiere_Flüsse_Enum);
               
               when others =>
                  null;
            end case;
         
         end loop YAchseSchleife;
      end loop EAchseSchleife;
      
   end GenerierungFlüsse;

end KartengeneratorFlussLogik;
