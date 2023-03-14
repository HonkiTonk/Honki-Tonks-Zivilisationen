with TonRecords;
with TonKonstanten;

package SchreibeEinstellungenMusik is
   pragma Preelaborate;

   procedure Lautstärke
     (LautstärkeExtern : in Float)
     with
       Pre => (
                 LautstärkeExtern in TonKonstanten.MinimaleLautstärke .. TonKonstanten.MaximaleLautstärke
              );
   pragma Inline (Lautstärke);
   
   procedure GanzerEintrag
     (EintrageExtern : in TonRecords.MusikeinstellungenRecord);
   pragma Inline (GanzerEintrag);

end SchreibeEinstellungenMusik;
