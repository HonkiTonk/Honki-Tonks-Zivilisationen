with KartengrundDatentypen;
with LadezeitenDatentypen;
with KartenKonstanten;

with LeseWeltkarte;

with KartengeneratorVariablenLogik;
with KartengeneratorErdweltLogik;
with KartengeneratorWasserweltLogik;
with Fehlermeldungssystem;
with LadezeitenLogik;

package body KartengeneratorUnterflaecheLogik is

   procedure GenerierungLandschaft
   is
      use type KartenDatentypen.Senkrechte;
   begin
      
      Kartenzeitwert := Basiszeitwert (ZusatzwertExtern => KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.Senkrechte,
                                       TeilerExtern     => 100);
               
      SenkrechteSchleife:
      for SenkrechteSchleifenwert in KartengeneratorVariablenLogik.SchleifenanfangOhnePolbereich.Senkrechte .. KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.Senkrechte loop
         WaagerechteSchleife:
         for WaagerechteSchleifenwert in KartengeneratorVariablenLogik.SchleifenanfangOhnePolbereich.Waagerechte .. KartengeneratorVariablenLogik.SchleifenendeOhnePolbereich.Waagerechte loop
            
            case
              LeseWeltkarte.Basisgrund (KoordinatenExtern => (KartenKonstanten.OberflächeKonstante, SenkrechteSchleifenwert, WaagerechteSchleifenwert))
            is
               when KartengrundDatentypen.Küstengewässer_Enum | KartengrundDatentypen.Wasser_Enum =>
                  KartengeneratorWasserweltLogik.KartengeneratorWasserwelt (KoordinatenExtern => (KartenKonstanten.UnterflächeKonstante, SenkrechteSchleifenwert, WaagerechteSchleifenwert));
                  
               when KartengrundDatentypen.Basisgrund_Oberfläche_Land_Enum'Range =>
                  KartengeneratorErdweltLogik.KartengeneratorErdwelt (KoordinatenExtern => (KartenKonstanten.UnterflächeKonstante, SenkrechteSchleifenwert, WaagerechteSchleifenwert));
                  
               when others =>
                  Fehlermeldungssystem.Logik (FehlermeldungExtern => "KartengeneratorUnterflaecheLogik.GenerierungLandschaft: Weder Wasser noch Erde");
            end case;
                              
         end loop WaagerechteSchleife;
            
         case
           SenkrechteSchleifenwert mod Kartenzeitwert
         is
            when 0 =>
               LadezeitenLogik.FortschrittSpielweltSchreiben (WelcheBerechnungenExtern => LadezeitenDatentypen.Generiere_Unterfläche_Enum);
               
            when others =>
               null;
         end case;
         
      end loop SenkrechteSchleife;
      
   end GenerierungLandschaft;

end KartengeneratorUnterflaecheLogik;
