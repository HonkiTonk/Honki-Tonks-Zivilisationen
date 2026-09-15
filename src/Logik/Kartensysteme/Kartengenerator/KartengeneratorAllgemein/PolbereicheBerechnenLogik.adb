with KartenartDatentypen;
with KartenKonstanten;
with KartenDatentypen;

with LeseWeltkarteneinstellungen;

with KartengeneratorVariablenLogik;

package body PolbereicheBerechnenLogik is

   procedure PolbereicheBerechnen
   is
      use type KartenDatentypen.SenkrechteBasis;
      use type KartenDatentypen.WaagerechteBasis;
   begin
      
      Schleifenbereiche.MinimaleSenkrechte := KartenKonstanten.AnfangSenkrechte + KartengeneratorVariablenLogik.SenkrechterPolLesen (HimmelsrichtungExtern => KartenartDatentypen.Norden_Enum);
      
      Schleifenbereiche.MaximaleSenkrechte := LeseWeltkarteneinstellungen.Senkrechte - KartengeneratorVariablenLogik.SenkrechterPolLesen (HimmelsrichtungExtern => KartenartDatentypen.Süden_Enum);
      
      
      
      Schleifenbereiche.MinimaleWaagerechte := KartenKonstanten.AnfangWaagerechte + KartengeneratorVariablenLogik.WaagerechterPolLesen (HimmelsrichtungExtern => KartenartDatentypen.Westen_Enum);
      
      
      Schleifenbereiche.MaximaleWaagerechte := LeseWeltkarteneinstellungen.Waagerechte - KartengeneratorVariablenLogik.WaagerechterPolLesen (HimmelsrichtungExtern => KartenartDatentypen.Osten_Enum);
      
      KartengeneratorVariablenLogik.PolfreierBereichSchreiben (BereichExtern => Schleifenbereiche);

   end PolbereicheBerechnen;

end PolbereicheBerechnenLogik;
