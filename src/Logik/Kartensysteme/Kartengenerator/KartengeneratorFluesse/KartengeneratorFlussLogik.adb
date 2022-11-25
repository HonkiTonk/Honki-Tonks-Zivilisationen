with KartengrundDatentypen;
with KartenKonstanten;
with LadezeitenDatentypen;

with LeseWeltkarte;

with ZufallsgeneratorenKartenLogik;
with KartengeneratorVariablenLogik;
with FlussplatzierungssystemLogik;
with LadezeitenLogik;

package body KartengeneratorFlussLogik is

   procedure GenerierungFlüsse
   is
   
      task Lavaflüsse;
      task UnterirdischeFlüsse;
      
      task body Lavaflüsse
      is begin
         
         FlussGenerierung (EbeneExtern => KartenKonstanten.PlaneteninneresKonstante);
         
      end Lavaflüsse;
      
      
      
      task body UnterirdischeFlüsse
      is begin
         
         FlussGenerierung (EbeneExtern => KartenKonstanten.UnterflächeKonstante);
         
      end UnterirdischeFlüsse;
      
   begin
      
      FlussGenerierung (EbeneExtern => KartenKonstanten.OberflächeKonstante);
      
   end GenerierungFlüsse;
   
   
   
   procedure FlussGenerierung
     (EbeneExtern : in KartenDatentypen.EbenePlanet)
   is begin
      
      Kartenzeitwert (EbeneExtern) := (KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.YAchse + (33 - 1)) / 33;
      
      YAchseSchleife:
      for YAchseSchleifenwert in KartengeneratorVariablenLogik.SchleifenanfangOhnePolbereich.YAchse .. KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.YAchse loop
         XAchseSchleife:
         for XAchseSchleifenwert in KartengeneratorVariablenLogik.SchleifenanfangOhnePolbereich.XAchse .. KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.XAchse loop
            
            case
              LeseWeltkarte.Basisgrund (KoordinatenExtern => (EbeneExtern, YAchseSchleifenwert, XAchseSchleifenwert))
            is
               when KartengrundDatentypen.Basisgrund_Oberfläche_Eiswasser_Enum'Range | KartengrundDatentypen.Basisgrund_Unterfläche_Eiswasser_Enum'Range
                  | KartengrundDatentypen.Basisgrund_Kernfläche_Flüssig_Enum'Range =>
                  null;
                  
               when others =>
                  if
                    FlussAnlegen (KoordinatenExtern => (EbeneExtern, YAchseSchleifenwert, XAchseSchleifenwert)) = True
                  then
                     FlussplatzierungssystemLogik.Flussplatzierung (KoordinatenExtern => (EbeneExtern, YAchseSchleifenwert, XAchseSchleifenwert));
                     
                  else
                     null;
                  end if;
            end case;
         
         end loop XAchseSchleife;
         
         case
           YAchseSchleifenwert mod Kartenzeitwert (EbeneExtern)
         is
            when 0 =>
               LadezeitenLogik.FortschrittSpielweltSchreiben (WelcheBerechnungenExtern => LadezeitenDatentypen.Generiere_Flüsse_Enum);
               
            when others =>
               null;
         end case;
         
      end loop YAchseSchleife;
      
   end FlussGenerierung;
   
   
   
   function FlussAnlegen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is
      use type SystemDatentypen.NullBisHundert;
   begin
         
      BeliebigerFlusswert (KoordinatenExtern.EAchse) := ZufallsgeneratorenKartenLogik.KartengeneratorZufallswerte;
      
      if
        BeliebigerFlusswert (KoordinatenExtern.EAchse) = 0
      then
         return False;
         
      elsif
        BeliebigerFlusswert (KoordinatenExtern.EAchse) > WahrscheinlichkeitFluss (KoordinatenExtern.EAchse)
      then
         return False;
         
      else
         return True;
      end if;
         
   end FlussAnlegen;

end KartengeneratorFlussLogik;
